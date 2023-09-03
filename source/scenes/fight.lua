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
local fon <const> = gfx.font
local img <const> = gfx.image
local rec <const> = geo.rect

fightStates = {
  ACTIVE = 1,
  IDLE = 2,
  KO = 4,
  TIMEOVER = 8,
}

local defaults <const> = {
  character1Class = Kim,
  character2Class = Kim,
}
local timeOverText <const> = 'TIME OVER'

class('FightScene', defaults).extends(Room)

function FightScene:draw()
  if (self.state == fightStates.TIMEOVER) then
    self:UpdateTimeOverImage()

    self.timeOverImage:drawFaded(0, 0, self.alphaAnimator:currentValue(), img.kDitherTypeBayer8x8)
  end
end

function FightScene:enter(previous, ...)
  self:Init(... or defaults)
end

function FightScene:Init(config)
  local displayRect <const> = pd.display.getRect()

  self.timeOverFont = fon.new("fonts/Super Monaco GP")
  self.timeOverFont:setTracking(-1)
  self.timeOverImage = img.new(
    displayRect.width,
    displayRect.height,
    gfx.kColorClear
  )
  self.timeOverTextImage = img.new(
    self.timeOverFont:getTextWidth(timeOverText),
    self.timeOverFont:getHeight(),
    gfx.kColorClear
  )

  local character1Class <const> = config.character1Class or self.character1Class

  self.character1 = character1Class({
    controllable = true,
    debug = true,
    startingDirection = charDirections.RIGHT,
    startingPosition = {
      x = 100,
      y = 220,
    }
  })

  local character2Class <const> = config.character2Class or self.character2Class

  self.character2 = character2Class({
    controllable = false,
    debug = false,
    startingDirection = charDirections.LEFT,
    startingPosition = {
      x = 300,
      y = 220,
    }
  })

  -- OPPONENTS
  self.character1.opponent = self.character2
  self.character2.opponent = self.character1

  -- THE BALL
  -- self.theBall = Ball({
  --   startingPosition = {
  --     x = 200,
  --     y = 30,
  --   },
  --   type = ballTypes.TENNISBALL,
  -- })

  -- STAGE
  self.stage = Stage({
    character = self.character1,
    id = stages.CLIFTON,
  })

  -- LIFEBARS
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
  end)
  self.character2.OnHealthChange = (function (health)
    self.lifebar2:SetAmount(health)
  end)

  self.timer = Timer({
    OnStop = function ()
      self.state = fightStates.TIMEOVER
      self.alphaAnimator = ani.new(200, 0, 1)
      self.character1:setUpdatesEnabled(false)
      self.character2:setUpdatesEnabled(false)
    end,
    time = {
      limit = 10,
    },
  })

  -- ADD SPRITES
  self.character1:add()
  self.character2:add()
  -- self.theBall:add()
  self.timer:Start()

  local menu <const> = pd.getSystemMenu()
        menu:addMenuItem("Reset", function ()
          self:Reset()
        end)
        menu:addMenuItem("Character Select", function ()
          sceneLoader:Start(function()
            sceneManager:resetAndEnter(CharacterSelectScene)
          end)
        end)

  pd.setMenuImage(img.new('images/Controls'))

  if (sceneLoader.state == loaderStates.ACTIVE) then
    sceneLoader:Stop()
  end
end

function FightScene:leave(next, ...)
  self:Teardown()
end

function FightScene:pause()
  self.character1:setUpdatesEnabled(false)
  self.character2:setUpdatesEnabled(false)
end

function FightScene:Reset()
  self.character1:Reset()
  self.character2:Reset()
  self.lifebar:Reset()
  self.lifebar2:Reset()
  -- self.theBall:Reset()
  self.timer:Reset()
  self.timer:Start()

  self.state = fightStates.ACTIVE
end

function FightScene:resume()
  self.character1:setUpdatesEnabled(true)
  self.character2:setUpdatesEnabled(true)
end

function FightScene:Teardown()
  -- TODO: Run "Cleanup()" on each sprite, if applicable.
  self.character1:remove()
  self.character1 = nil

  self.character2:remove()
  self.character2 = nil

  -- self.lifebar:Teardown()
  -- self.lifebar2:Teardown()
  -- self.theBall:remove()
  -- self.timer:Teardown()

  pd.getSystemMenu():removeAllMenuItems()
  pd.setMenuImage(nil)
end

function FightScene:update(dt)
  self.stage:update()
  self.timer:Update()
  self.lifebar:Update()
  self.lifebar2:Update()
end

function FightScene:UpdateTimeOverImage()
  gfx.pushContext(self.timeOverTextImage)
    self.timeOverFont:drawText(timeOverText, 0, 0)
  gfx.popContext()

  local scaledTimeOverImage <const> = self.timeOverTextImage:scaledImage(3)

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