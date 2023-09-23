import 'CoreLibs/animation'
import 'CoreLibs/graphics'
import 'CoreLibs/object'
import 'CoreLibs/sprites'
import "CoreLibs/timer"
import 'CoreLibs/ui'
import 'CoreLibs/utilities/sampler'

-- import '../ball'
import '../characters/Kim/kim'
import '../collisionTypes'
import '../meter'
import '../stage'
import '../timer'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics
local ani <const> = gfx.animator
local img <const> = gfx.image
local rec <const> = geo.rect

local fightStates <const> = {
  ACTIVE = 1,
  IDLE = 2,
  OVER = 4,
}
local defaults <const> = {
  character1Class = Kim,
  character2Class = Kim,
  overState = nil,
  round = 1,
  rounds = 2,
  stageID = stages.LAWSON,
  state = fightStates.IDLE,
}
local overStates <const> = {
  KO = 1,
  TIMEOVER = 2,
}
-- local roundStates <const> = {
--   ACTIVE = 1,
--   IDLE = 2,
--   OVER = 4,
-- }
local strings <const> = {
  ko = 'KO',
  timeOver = 'TIME OVER'
}

class('FightScene', defaults).extends(Room)

function FightScene:draw()
  if (self.state == fightStates.OVER) then
    self.messageImage:clear(gfx.kColorClear)

    if (self.overState == overStates.KO) then
      self:UpdateKOImage()

      gfx.pushContext(self.messageImage)
        self.koImage:drawFaded(
          0,
          0,
          self.alphaAnimator:currentValue(),
          img.kDitherTypeBayer8x8
        )
      gfx.popContext()
    elseif (self.overState == overStates.TIMEOVER) then
      self:UpdateTimeOverImage()

      gfx.pushContext(self.messageImage)
        self.timeOverImage:drawFaded(
          0,
          0,
          self.alphaAnimator:currentValue(),
          img.kDitherTypeBayer8x8
        )
      gfx.popContext()
    end      

    self.messageImage:drawIgnoringOffset(0, 0)
  end
end

function FightScene:enter(previous, ...)
  self:Init(... or defaults)
end

function FightScene:Init(config)
  self.character1Class = config.character1Class or self.character1Class
  self.character2Class = config.character2Class or self.character2Class
  self.round = config.round or self.round
  self.rounds = config.rounds or self.rounds
  self.stageID = config.stageID or self.stageID
  -- self.state = config.state or self.state

  self:InitCharacters()
  self:InitLifebars()
  self:InitStage()
  self:InitTimer()
  self:InitImages()
  self:InitMenu()

  -- self.theBall = Ball({
  --   startingPosition = {
  --     x = 200,
  --     y = 30,
  --   },
  --   type = ballTypes.TENNISBALL,
  -- })

  self.character1:add()
  self.character2:add()
  -- self.theBall:add()

  pd.setMenuImage(img.new('images/Controls'))
end

function FightScene:InitCharacters()
  self.character1 = self.character1Class({
    controllable = true,
    debug = false,
    startingDirection = charDirections.RIGHT,
  })

  self.character2 = self.character2Class({
    controllable = false,
    debug = true,
    startingDirection = charDirections.LEFT,
  })

  self.character1.opponent = self.character2
  self.character2.opponent = self.character1
end

function FightScene:InitImages()
  local displayRect <const> = pd.display.getRect()

  self.koImage = img.new(
    displayRect.width,
    displayRect.height,
    gfx.kColorClear
  )
  self.koTextImage = img.new(
    fonts.SuperMonacoGP:getTextWidth(strings.ko),
    fonts.SuperMonacoGP:getHeight(),
    gfx.kColorClear
  )
  self.messageImage = img.new(
    displayRect.width,
    displayRect.height,
    gfx.kColorClear
  )
  self.timeOverImage = img.new(
    displayRect.width,
    displayRect.height,
    gfx.kColorClear
  )
  self.timeOverTextImage = img.new(
    fonts.SuperMonacoGP:getTextWidth(strings.timeOver),
    fonts.SuperMonacoGP:getHeight(),
    gfx.kColorClear
  )
end

function FightScene:InitLifebars()
  self.lifebar = Meter({
    amount = self.character1.health,
    direction = meterDirections.LEFT,
    label = self.character1.name:upper(),
    meterRect = rec.new(20, 10, 150, 16),
    total = self.character1.health,
  })
  self.lifebar2 = Meter({
    amount = self.character2.health,
    direction = meterDirections.RIGHT,
    label = self.character2.name:upper(),
    meterRect = rec.new(380, 10, 150, 16),
    total = self.character2.health,
  })

  self.character1.OnHealthChange = (function (health)
    self.lifebar:SetAmount(health)

    if (health <= 0) then
      self:Stop(overStates.KO)

      print('Setting Next State')
      self.character1:SetNextState(charStates.HURT | charStates.AIRBORNE | charStates.END)
      self.alphaAnimator = ani.new(200, 0, 1)
    end
  end)
  self.character2.OnHealthChange = (function (health)
    self.lifebar2:SetAmount(health)

    if (health <= 0) then
      self:Stop(overStates.KO)

      print('Setting Next State')
      self.character2:SetNextState(charStates.HURT | charStates.AIRBORNE | charStates.END)
      self.alphaAnimator = ani.new(200, 0, 1)
    end
  end)

  self.lifebar:Update()
  self.lifebar2:Update()
end

function FightScene:InitMenu()
  local menu <const> = pd.getSystemMenu()
        menu:addMenuItem("Char. Select", function ()
          sceneLoader:Start(function()
            sceneManager:resetAndEnter(CharacterSelectScene)
          end)
        end)
        menu:addMenuItem("Reset", function ()
          self:Reset()
        end)
end

function FightScene:InitStage()
  self.stage = Stage({
    character = self.character1,
    id = self.stageID
  })

  local stageSprite <const> = self.stage:GetStageSprite()
  local stageCenter <const> = stageSprite.width / 2

  self.character1.startingPosition = {
    x = stageCenter - 100,
    y = stageSprite.height - 20,
  }
  self.character2.startingPosition = {
    x = stageCenter + 100,
    y = stageSprite.height - 20,
  }

  self.stage:update()
end

function FightScene:InitTimer()
  self.timer = Timer({
    OnStop = function ()
      self:Stop(overStates.TIMEOVER)

      self.alphaAnimator = ani.new(200, 0, 1)
    end,
    time = {
      limit = 90,
    },
  })

  self.timer:Update()
end

function FightScene:leave(next, ...)
  self:Teardown()
end

function FightScene:pause()
  self.character1:setUpdatesEnabled(false)
  self.character2:setUpdatesEnabled(false)
end

function FightScene:Reset()
  self:Stop()

  self.character1:Reset()
  self.character2:Reset()

  self.lifebar:Reset()
  self.lifebar2:Reset()

  -- self.theBall:Reset()

  self.timer:Stop()
  self.timer:Reset()
  self.timer:Start()

  self:Start()
end

function FightScene:resume()
  self.character1.controllable = true
  -- self.character2.controllable = true
  self.character1:setUpdatesEnabled(true)
  self.character2:setUpdatesEnabled(true)
end

function FightScene:Start()
  self.state = fightStates.ACTIVE
  self.overState = nil

  self.character1.controllable = true
  -- self.character2.controllable = true
  self.character1:setUpdatesEnabled(true)
  self.character2:setUpdatesEnabled(true)
  self.timer:Start()
end

function FightScene:Stop(overState)
  self.state = fightStates.OVER
  self.overState = overState

  self.character1.controllable = false
  self.character2.controllable = false
  -- self.character1:setUpdatesEnabled(false)
  -- self.character2:setUpdatesEnabled(false)
  self.timer:Stop()
end

function FightScene:Teardown()
  self.character1:remove()
  self.character1:Teardown()
  self.character1 = nil

  self.character2:remove()
  self.character2:Teardown()
  self.character2 = nil

  self.state = fightStates.IDLE
  self.stage:Teardown()

  -- self.lifebar:Teardown()
  -- self.lifebar2:Teardown()
  -- self.theBall:remove()
  -- self.timer:Teardown()

  pd.getSystemMenu():removeAllMenuItems()
  pd.setMenuImage(nil)
end

function FightScene:update(dt)
  if (self.state == fightStates.IDLE) then
    if (self.character1:IsLoaded()) then
      self.character1:ResetPosition()
    end

    if (self.character2:IsLoaded()) then
      self.character2:ResetPosition()
    end

    if (self.character1:IsActive() and self.character2:IsActive()) then
      if (sceneLoader.state == loaderStates.ACTIVE) then
        sceneLoader:Stop(function ()
          self:Start()
        end)
      end
    end
  end

  self.stage:update()
  self.timer:Update()
  self.lifebar:Update()
  self.lifebar2:Update()
end

function FightScene:UpdateKOImage()
  gfx.pushContext(self.koTextImage)
    fonts.SuperMonacoGP:drawText(strings.ko, 0, 0)
  gfx.popContext()

  local scaledKOImage <const> = self.koTextImage:scaledImage(6)

  gfx.pushContext(self.koImage)
    local imagePosition <const> = {
      x = (self.koImage.width - scaledKOImage.width) / 2,
      y = ((self.koImage.height - scaledKOImage.height) / 2),
    }

    -- Draw the text's stroke
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    scaledKOImage:draw(imagePosition.x - 1, imagePosition.y - 1)
    scaledKOImage:draw(imagePosition.x - 1, imagePosition.y + 1)
    scaledKOImage:draw(imagePosition.x + 1, imagePosition.y - 1)
    scaledKOImage:draw(imagePosition.x + 1, imagePosition.y + 1)

    -- Draw the text
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    scaledKOImage:draw(imagePosition.x, imagePosition.y)
  gfx.popContext()
end

function FightScene:UpdateTimeOverImage()
  gfx.pushContext(self.timeOverTextImage)
    fonts.SuperMonacoGP:drawText(strings.timeOver, 0, 0)
  gfx.popContext()

  local scaledTimeOverImage <const> = self.timeOverTextImage:scaledImage(4)

  gfx.pushContext(self.timeOverImage)
    local imagePosition <const> = {
      x = (self.timeOverImage.width - scaledTimeOverImage.width) / 2,
      y = ((self.timeOverImage.height - scaledTimeOverImage.height) / 2),
    }

    -- Draw the text's stroke
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    scaledTimeOverImage:draw(imagePosition.x - 1, imagePosition.y - 1)
    scaledTimeOverImage:draw(imagePosition.x - 1, imagePosition.y + 1)
    scaledTimeOverImage:draw(imagePosition.x + 1, imagePosition.y - 1)
    scaledTimeOverImage:draw(imagePosition.x + 1, imagePosition.y + 1)

    -- Draw the text
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    scaledTimeOverImage:draw(imagePosition.x, imagePosition.y)
  gfx.popContext()
end