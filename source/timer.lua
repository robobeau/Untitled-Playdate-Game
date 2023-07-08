-- import 'CoreLibs/animation'
-- import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics

local defaults <const> = {
  fontPath = "fonts/Super Monaco GP",
  -- fontPath = "fonts/Battle Garegga - Type 2"
  -- fontPath = "fonts/ST-DIN"
  fontTracking = 0,
  limit = 99,
  label = "TIME",
  seconds = 99,
}

class('Timer', defaults).extends(gfx.sprite)

function Timer:SetTimerSpriteImage()
  local timeImage <const> = gfx.image.new(self.width, self.height)

  gfx.pushContext(timeImage)
    local position <const> = {
      x = timeImage.width / 2,
      y = timeImage.height / 2,
    }

    self.font:drawTextAligned(self.label, position.x, position.y, kTextAlignment.center)
  gfx.popContext()

  local secondsImage <const> = gfx.image.new(self.width, self.height)

  gfx.pushContext(secondsImage)
    local position <const> = {
      x = secondsImage.width / 2,
      y = secondsImage.height / 2,
    }

    self.font:drawTextAligned(self.seconds, position.x, position.y, kTextAlignment.center)
  gfx.popContext()

  local backgroundImage <const> = gfx.image.new(self.width, self.height)

  gfx.pushContext(backgroundImage)
    local scaledSecondsImage <const> = secondsImage:scaledImage(2)

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(self.x, self.y, backgroundImage.width, backgroundImage.height)

    local timePosition <const> = {
      x = 0,
      y = -10,
    }

    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    timeImage:draw(timePosition.x - 1, timePosition.y - 1)
    timeImage:draw(timePosition.x - 1, timePosition.y + 1)
    timeImage:draw(timePosition.x + 1, timePosition.y - 1)
    timeImage:draw(timePosition.x + 1, timePosition.y + 1)

    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    timeImage:draw(timePosition.x, timePosition.y)

    local secondsPosition <const> = {
      x = -(scaledSecondsImage.width / 4),
      y = -(scaledSecondsImage.height / 4),
    }

    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    scaledSecondsImage:draw(secondsPosition.x - 1, secondsPosition.y - 1)
    scaledSecondsImage:draw(secondsPosition.x - 1, secondsPosition.y + 1)
    scaledSecondsImage:draw(secondsPosition.x + 1, secondsPosition.y - 1)
    scaledSecondsImage:draw(secondsPosition.x + 1, secondsPosition.y + 1)

    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    scaledSecondsImage:draw(secondsPosition.x, secondsPosition.y)
  gfx.popContext()

  self.timerSprite:setImage(backgroundImage)
end

function Timer:init(config)
  self.font = gfx.font.new(config.fontPath or self.fontPath)
  self.font:setTracking(config.fontTracking or self.fontTracking)
  self.limit = config.limit or self.limit
  self.position = config.position or self.position
  self.seconds = config.seconds ~= nil and math.min(config.second, self.limit) or self.limit

  self:setIgnoresDrawOffset(true)
  self:setSize(50, 50)
  self:moveTo(self.position.x, self.position.y)

  local timerSprite <const> = gfx.sprite.new()
        timerSprite:moveTo(self.x, self.y)
        timerSprite:setIgnoresDrawOffset(true)
        timerSprite:add()

  self.timerSprite = timerSprite
  self:SetTimerSpriteImage()
end

function Timer:Start()
  self:Reset()
end

function Timer:Reset()
  self.timer = pd.timer.new(1000)
end

function Timer:Tick()
  self.seconds -= 1

  if (self.seconds > 0) then
    self:Reset()
  else
    -- Do something...?
  end

  self:SetTimerSpriteImage()
end

function Timer:update()
  if (self.timer and self.timer.timeLeft == 0) then
    self:Tick()
  end
end