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
local snd <const> = pd.sound
local tmr <const> = pd.timer

local fightStates <const> = {
  ACTIVE = 1,
  IDLE = 2,
  OVER = 4,
  STARTING = 8,
  MATCH_END = 16,
  MATCH_START = 32,
  ROUND_END = 64,
  ROUND_START = 128,
}
local defaults <const> = {
  character1Class = Kim,
  character1Wins = 0,
  character2Class = Kim,
  character2Wins = 0,
  overState = nil,
  round = 1,
  rounds = 2,
  stageID = stages.LAWSON,
  state = fightStates.IDLE,
  uiTextState = nil,
  winnerState = nil,
}
local overStates <const> = {
  KO = 1,
  TIME_OVER = 4,
}
local uiTextStates <const> = {
  DRAW = 1,
  FIGHT = 2,
  KO = 4,
  ROUND_START = 8,
  THANK_YOU_FOR_PLAYING = 16,
  TIME_OVER = 32,
  YOU_LOSE = 64,
  YOU_WIN = 128,
}
local winnerStates <const> = {
  CHAR_1 = 1,
  CHAR_2 = 2,
  DRAW = 4,
}
-- local roundStates <const> = {
--   ACTIVE = 1,
--   IDLE = 2,
--   OVER = 4,
-- }
-- local strings <const> = {
--   ko = 'KO',
--   matchStart = 'FIGHT',
--   roundStart = 'ROUND',
--   timeOver = 'TIME OVER'
-- }

class('FightScene', defaults).extends(Room)

function FightScene:ActivateRound()
  self.character1.controllable = true
  -- self.character2.controllable = true
  self.character1:setUpdatesEnabled(true)
  self.character2:setUpdatesEnabled(true)
  self.overState = nil
  self.state = fightStates.ACTIVE
  self.timer:Start()
end

function FightScene:DetermineWinner()
  if (
    self.lifebar1.amount == self.lifebar2.amount or
    (self.lifebar1.amount <= 0 and self.lifebar2.amount <= 0)
  ) then
    self.character1Wins += 1
    self.character2Wins += 1
    self.winnerState = winnerStates.DRAW
  elseif (self.lifebar1.amount > self.lifebar2.amount) then
    self.character1Wins += 1
    self.winnerState = winnerStates.CHAR_1
  elseif (self.lifebar1.amount < self.lifebar2.amount) then
    self.character2Wins += 1
    self.winnerState = winnerStates.CHAR_2
  else
    -- This should be an impossible state
  end
end

function FightScene:draw()
  self:DrawUITextImage()
  self:DrawBlackScreen()
end

function FightScene:DrawBlackScreen()
  local transparency <const> = self.blackScreenAlphaAnimator and self.blackScreenAlphaAnimator:currentValue() or 1

  if (transparency == 1) then
    return
  end

  if (transparency > 0) then
    self.blackScreenImage:clear(gfx.kColorClear)
  end

  gfx.pushContext(self.blackScreenImage)
    gfx.setDitherPattern(transparency, img.kDitherTypeBayer8x8)
    gfx.fillRect(0, 0, self.blackScreenImage:getSize())
  gfx.popContext()

  self.blackScreenImage:drawIgnoringOffset(0, 0)
end

function FightScene:DrawUITextImage()
  local opacity <const> = self.alphaAnimator and self.alphaAnimator:currentValue() or 0

  if (opacity == 0) then
    return
  end

  if (opacity < 1) then
    self.uiImage:clear(gfx.kColorClear)
  end

  self:UpdateUITextImage()

  gfx.pushContext(self.uiImage)
    -- gfx.setDitherPattern(opacity, img.kDitherTypeBayer8x8)
    self.uiTextImage:drawFaded(0, 0, opacity, img.kDitherTypeBayer8x8)
    -- self.uiTextImage:drawAnchored(200, 220, 0.5, 0.5)
  gfx.popContext()

  self.uiImage:drawIgnoringOffset(0, 0)
end

function FightScene:EndMatch()
  tmr.performAfterDelay(1000, function()
    self.uiTextState = uiTextStates.THANK_YOU_FOR_PLAYING
    self:StartFadeInTextAnimator()

    tmr.performAfterDelay(5000, function()
      sceneLoader:Start(function()
        sceneManager:resetAndEnter(CharacterSelectScene)
      end)
    end)
  end)
end

function FightScene:EndRound(overState)
  -- self.backgroundMusic:stop()
  self.character1.controllable = false
  self.character2.controllable = false
  -- self.character1:setUpdatesEnabled(false)
  -- self.character2:setUpdatesEnabled(false)
  self.overState = overState
  self.state = fightStates.ROUND_END
  self.timer:Stop()

  if (self.overState == overStates.KO) then
    pd.display.setRefreshRate(10)

    self.uiTextState = uiTextStates.KO
  elseif (self.overState == overStates.TIME_OVER) then
    self.uiTextState = uiTextStates.TIME_OVER
  end

  self:DetermineWinner()

  self:StartFadeInTextAnimator()

  tmr.performAfterDelay(2000, function()
    pd.display.setRefreshRate(30)

    self:StartFadeOutTextAnimator()

    tmr.performAfterDelay(500, function()
      if (self.winnerState == winnerStates.CHAR_1) then
        self.uiTextState = uiTextStates.YOU_WIN
      elseif (self.winnerState == winnerStates.CHAR_2) then
        self.uiTextState = uiTextStates.YOU_LOSE
      elseif (self.winnerState == winnerStates.DRAW) then
        self.uiTextState = uiTextStates.DRAW
      end

      self:StartFadeInTextAnimator()

      tmr.performAfterDelay(2000, function()
        if (self.round == 1) then
          -- Do nothing...?
        elseif (self.round == 2) then
          if (self.character1Wins >= 2 or self.character2Wins >= 2) then
            self:EndMatch()

            return
          end
        else
          self:EndMatch()

          return
        end

        self:StartFadeInBlackScreenAnimator()

        tmr.performAfterDelay(1000, function()
          self.round += 1

          self:ResetRound()
          self:StartFadeOutBlackScreenAnimator()
          self:StartRound()
        end)
      end)
    end)
  end)
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
  self.state = config.state or self.state

  self:InitCharacters()
  self:InitLifebars()
  self:InitStage()
  self:InitTimer()
  self:InitImages()
  self:InitMenu()

  self.character1:add()
  self.character2:add()

  pd.setMenuImage(img.new('images/Controls'))
end

function FightScene:InitCharacters()
  self.character1 = self.character1Class({
    controllable = false,
    debug = false,
    startingDirection = charDirections.RIGHT,
  })
  self.character2 = self.character2Class({
    controllable = false,
    debug = false,
    startingDirection = charDirections.LEFT,
  })

  self.character1.opponent = self.character2
  self.character2.opponent = self.character1
end

function FightScene:InitImages()
  local displayRect <const> = pd.display.getRect()

  self.blackScreenImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.drawTextImage = img.new('images/ui/DrawText')
  self.fightImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.fightTextImage = img.new('images/ui/FightText')
  self.finalRoundTextImage = img.new('images/ui/FinalRoundText')
  self.koTextImage = img.new('images/ui/KOText')
  self.matchEndImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.matchEndTextImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.matchStartImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.matchStartTextImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.roundEndImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.roundEndTextImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.round1TextImage = img.new('images/ui/Round1Text')
  self.round2TextImage = img.new('images/ui/Round2Text')
  self.roundStartImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.roundStartTextImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.thankYouForPlayingTextImage = img.new('images/ui/ThankYouForPlayingText')
  self.timeOverImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.timeOverTextImage = img.new('images/ui/TimeOverText')
  self.youLoseTextImage = img.new('images/ui/YouLoseText')
  self.youWinTextImage = img.new('images/ui/YouWinText')
  self.uiImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
  self.uiTextImage = img.new(displayRect.width, displayRect.height, gfx.kColorClear)
end

function FightScene:InitLifebars()
  self.lifebar1 = Meter({
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
    self.lifebar1:SetAmount(health)

    if (health <= 0) then
      self:EndRound(overStates.KO)

      self.character1:SetNextState(charStates.HURT | charStates.AIRBORNE | charStates.END)
    end
  end)
  self.character2.OnHealthChange = (function (health)
    self.lifebar2:SetAmount(health)

    if (health <= 0) then
      self:EndRound(overStates.KO)

      self.character2:SetNextState(charStates.HURT | charStates.AIRBORNE | charStates.END)
    end
  end)

  self.lifebar1:Update()
  self.lifebar2:Update()
end

function FightScene:InitMenu()
  local menu <const> = pd.getSystemMenu()
        menu:addMenuItem("Char Select", function()
          sceneLoader:Start(function()
            sceneManager:resetAndEnter(CharacterSelectScene)
          end)
        end)

        menu:addMenuItem("Reset Match", function()
          self:StartFadeInBlackScreenAnimator()

          tmr.performAfterDelay(1000, function()
            self:ResetMatch()
            self:StartFadeOutBlackScreenAnimator()
            self:StartMatch()
          end)
        end)
end

function FightScene:InitStage()
  self.backgroundMusic = snd.fileplayer.new('music/Stage - Metropolis Grime - Loop')
  self.backgroundMusic:setVolume(0.5)

  self.stage = Stage({
    character1 = self.character1,
    character2 = self.character2,
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
end

function FightScene:InitTimer()
  self.timer = Timer({
    OnStop = function()
      self:EndRound(overStates.TIME_OVER)
    end,
    time = {
      limit = 90,
    },
  })
end

function FightScene:leave(next, ...)
  self:Teardown()
end

-- function FightScene:pause()
--   self.character1:setUpdatesEnabled(false)
--   self.character2:setUpdatesEnabled(false)
-- end

function FightScene:Reset()
  -- Reset Character 1
  self.character1:Reset()
  self.character1.controllable = false
  self.lifebar1:Reset()

  -- Reset Character 2
  self.character2:Reset()
  self.character2.controllable = false
  self.lifebar2:Reset()

  -- Reset Stage
  -- self.stage:Reset()

  -- Reset Timer
  self.timer:Stop()
  self.timer:Reset()

  self.overState = nil
  self.uiTextState = nil
  self.winnerState = nil
end

function FightScene:ResetMatch()
  self.character1Wins = 0
  self.character2Wins = 0
  self.round = 1
  self.state = fightStates.IDLE

  self:Reset()
end

-- function FightScene:RestartMatch()
--   self:ResetMatch()
--   self:StartMatch()
-- end

function FightScene:ResetRound()
  self:Reset()
end

-- function FightScene:resume()
--   self.character1.controllable = true
--   self.character1:setUpdatesEnabled(true)

--   -- self.character2.controllable = true
--   self.character2:setUpdatesEnabled(true)
-- end

function FightScene:StartFadeInBlackScreenAnimator(duration)
  self.blackScreenAlphaAnimator = ani.new(duration or 200, 1, 0)
end

function FightScene:StartFadeOutBlackScreenAnimator(duration)
  self.blackScreenAlphaAnimator = ani.new(duration or 200, 0, 1)
end

function FightScene:StartFadeInTextAnimator(duration)
  self.alphaAnimator = ani.new(duration or 200, 0, 1)
end

function FightScene:StartFadeOutTextAnimator(duration)
  self.alphaAnimator = ani.new(duration or 200, 1, 0)
end

function FightScene:StartMatch()
  if (not self.backgroundMusic:isPlaying()) then
    self.backgroundMusic:play(0)
  end

  self:StartRound()
end

function FightScene:StartRound()
  self.state = fightStates.ROUND_START

  tmr.performAfterDelay(200, function()
    self.uiTextState = uiTextStates.ROUND_START
    self:StartFadeInTextAnimator()

    tmr.performAfterDelay(2000, function()
      self:StartFadeOutTextAnimator()

      tmr.performAfterDelay(500, function()
        self.uiTextState = uiTextStates.FIGHT
        self:StartFadeInTextAnimator()

        tmr.performAfterDelay(1000, function()
          self:ActivateRound()
          self:StartFadeOutTextAnimator()
        end)
      end)
    end)
  end)
end

function FightScene:Teardown()
  self:ResetMatch()

  self.backgroundMusic:stop()
  self.backgroundMusic = nil

  self.character1:remove()
  self.character1:Teardown()
  self.character1 = nil

  self.character2:remove()
  self.character2:Teardown()
  self.character2 = nil

  self.stage:Teardown()

  -- self.lifebar1:Teardown()
  -- self.lifebar2:Teardown()
  -- self.timer:Teardown()

  pd.getSystemMenu():removeAllMenuItems()
  pd.setMenuImage(nil)
end

function FightScene:update(dt)
  if (self.state == fightStates.ACTIVE) then
    self:UpdateActiveState()
  elseif (self.state == fightStates.IDLE) then
    self:UpdateIdleState()
  elseif (self.state == fightStates.MATCH_END) then
    -- self:UpdateMatchEndState()
  -- elseif (self.state == fightStates.MATCH_START) then
    -- self:UpdateMatchStartState()
  elseif (self.state == fightStates.ROUND_END) then
    -- self:UpdateRoundEndState()
  elseif (self.state == fightStates.ROUND_START) then
    -- self:UpdateRoundStartState()
  -- elseif (self.state == fightStates.STARTING) then
  --   self:UpdateStartingState()
  end
end

function FightScene:UpdateActiveState()
  self.lifebar1:Update()
  self.lifebar2:Update()
  self.stage:update()
  self.timer:Update()
end

function FightScene:UpdateIdleState()
  if (self.character1:IsActive() and self.character2:IsActive()) then
    if (sceneLoader.state == loaderStates.ACTIVE) then
      sceneLoader:Stop(function()
        self:ResetMatch()
        self:StartMatch()
      end)
    end
  end
end

function FightScene:UpdateMatchStartImage()
  self.matchStartTextImage:clear(gfx.kColorClear)

  gfx.pushContext(self.matchStartTextImage)
    self.fightTextImage:drawCentered(200, 120)
  gfx.popContext()
end

function FightScene:UpdateUITextImage()
  self.uiTextImage:clear(gfx.kColorClear)

  gfx.pushContext(self.uiTextImage)
    if (self.uiTextState == uiTextStates.DRAW) then
      self.drawTextImage:drawCentered(200, 120)
    elseif (self.uiTextState == uiTextStates.FIGHT) then
      self.fightTextImage:drawCentered(200, 120)
    elseif (self.uiTextState == uiTextStates.KO) then
      self.koTextImage:drawCentered(220, 120)
    elseif (self.uiTextState == uiTextStates.ROUND_START) then
      if (self.round == 1) then
        self.round1TextImage:drawCentered(200, 120)
      elseif (self.round == 2) then
        self.round2TextImage:drawCentered(200, 120)
      else
        self.finalRoundTextImage:drawCentered(200, 120)
      end
    elseif (self.uiTextState == uiTextStates.THANK_YOU_FOR_PLAYING) then
      self.thankYouForPlayingTextImage:drawCentered(200, 120)
    elseif (self.uiTextState == uiTextStates.TIME_OVER) then
      self.timeOverTextImage:drawCentered(200, 120)
    elseif (self.uiTextState == uiTextStates.YOU_LOSE) then
      self.youLoseTextImage:drawCentered(200, 120)
    elseif (self.uiTextState == uiTextStates.YOU_WIN) then
      self.youWinTextImage:drawCentered(200, 120)
    end
  gfx.popContext()
end