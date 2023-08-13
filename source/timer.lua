-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics
local fon <const> = gfx.font
local img <const> = gfx.image
local tmr <const> = pd.timer

local defaults <const> = {
  -- fontPath = "fonts/A.B. Cop",
  fontPath = "fonts/Super Monaco GP",
  -- fontPath = "fonts/Battle Garegga - Type 2"
  -- fontPath = "fonts/ST-DIN"
  fontTracking = 0,
  limit = 99,
  label = "TIME",
  onEnd = nil,
  onStart = nil,
  seconds = 99,
}

class('Timer', defaults).extends(gfx.sprite)

function Timer:Draw()
  self.backgroundImage:clear(gfx.kColorClear)

  self:DrawLabel()
  self:DrawSeconds()

  self:setImage(self.backgroundImage)
end

function Timer:DrawLabel()
  self.labelImage:clear(gfx.kColorClear)

  gfx.pushContext(self.labelImage)
    local position <const> = {
      x = self.labelImage.width / 2,
      y = self.labelImage.height / 2,
    }

    self.font:drawTextAligned(self.label, position.x, position.y, kTextAlignment.center)
  gfx.popContext()

  gfx.pushContext(self.backgroundImage)
    local timePosition <const> = {
      x = 0,
      y = -10,
    }

    -- Draw the label's stroke
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    self.labelImage:draw(timePosition.x - 1, timePosition.y - 1)
    self.labelImage:draw(timePosition.x - 1, timePosition.y + 1)
    self.labelImage:draw(timePosition.x + 1, timePosition.y - 1)
    self.labelImage:draw(timePosition.x + 1, timePosition.y + 1)

    -- Draw the label
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    self.labelImage:draw(timePosition.x, timePosition.y)
  gfx.popContext()
end

function Timer:DrawSeconds()
  self.secondsImage:clear(gfx.kColorClear)

  gfx.pushContext(self.secondsImage)
    local position <const> = {
      x = self.secondsImage.width / 2,
      y = self.secondsImage.height / 2,
    }

    self.font:drawTextAligned(self.seconds, position.x, position.y, kTextAlignment.center)
  gfx.popContext()

  gfx.pushContext(self.backgroundImage)
    local scaledSecondsImage <const> = self.secondsImage:scaledImage(2)
    local secondsPosition <const> = {
      x = -(scaledSecondsImage.width / 4),
      y = -(scaledSecondsImage.height / 4),
    }

    -- Draw the seconds' stroke
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    scaledSecondsImage:draw(secondsPosition.x - 1, secondsPosition.y - 1)
    scaledSecondsImage:draw(secondsPosition.x - 1, secondsPosition.y + 1)
    scaledSecondsImage:draw(secondsPosition.x + 1, secondsPosition.y - 1)
    scaledSecondsImage:draw(secondsPosition.x + 1, secondsPosition.y + 1)

    -- Draw the seconds
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    scaledSecondsImage:draw(secondsPosition.x, secondsPosition.y)
  gfx.popContext()
end

function Timer:init(config)
  self.font = fon.new(config.fontPath or self.fontPath)
  self.font:setTracking(config.fontTracking or self.fontTracking)
  self.limit = config.limit or self.limit
  self.position = config.position or self.position
  self.seconds = config.seconds ~= nil and math.min(config.seconds, self.limit) or self.limit

  self:setSize(50, 50)
  self.backgroundImage = img.new(self.width, self.height)
  self.secondsImage = img.new(self.width, self.height)
  self.labelImage = img.new(self.width, self.height)

  self:setCollisionsEnabled(false)
  self:setIgnoresDrawOffset(true)
  self:setZIndex(100)
  self:moveTo(self.position.x, self.position.y)

  self:Draw()
end

function Timer:Reset()
  self.seconds = self.limit

  self:Draw()

  if (self.timer and self.timer.timeLeft > 0) then
    self.timer:remove()
  end

  self.timer = tmr.new(1000)
end

function Timer:Start()
  self:Reset()
end

function Timer:Tick()
  self.seconds -= 1

  if (self.seconds >= 0) then
    self.timer = tmr.new(1000)

    self:Draw()
  else
    if (self.onEnd) then
      self.onEnd()
    end
  end
end

function Timer:update()
  if (self.timer and self.timer.timeLeft == 0) then
    self:Tick()
  end
end