-- Convenience variables
local pd <const> = playdate
local dis <const> = pd.display
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

class('Timer', defaults).extends()

function Timer:Draw()
  local position <const> = {
    x = (self.displayRect.width / 2) - (self.timerImage.width / 2),
    y = 0
  }

  self.timerImage:drawIgnoringOffset(position.x, position.y)
end

function Timer:init(config)
  self.displayRect = dis.getRect()
  self.font = fon.new(config.fontPath or self.fontPath)
  self.font:setTracking(config.fontTracking or self.fontTracking)
  self.limit = config.limit or self.limit
  self.seconds = config.seconds ~= nil and math.min(config.seconds, self.limit) or self.limit

  self:InitImages()
  self:UpdateTimerImage()
  self:Draw()
end

function Timer:InitImages()
  local secondsImageWidth <const> = self.font:getTextWidth(self.limit)
  local secondsImageHeight <const> = self.font:getHeight()

  self.secondsImage = img.new(secondsImageWidth, secondsImageHeight)

  local labelImageWidth <const> = self.font:getTextWidth(self.label)
  local labelImageHeight <const> = self.font:getHeight()

  self.labelImage = img.new(labelImageWidth, labelImageHeight)

  self.timerImage = img.new(40, 40)
end

function Timer:Reset()
  self.seconds = self.limit

  self:UpdateTimerImage()
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

    self:UpdateTimerImage()
  else
    if (self.onEnd) then
      self.onEnd()
    end
  end
end

function Timer:Update()
  if (self.timer and self.timer.timeLeft == 0) then
    self:Tick()
  end

  self:Draw()
end

function Timer:UpdateLabelImage()
  self.labelImage:clear(gfx.kColorClear)

  gfx.pushContext(self.labelImage)
    local position <const> = {
      x = self.labelImage.width / 2,
      y = 0
    }

    self.font:drawTextAligned(self.label, position.x, position.y, kTextAlignment.center)
  gfx.popContext()

  gfx.pushContext(self.timerImage)
    local labelPosition <const> = {
      x = (self.timerImage.width - self.labelImage.width) / 2,
      y = 7,
    }

    -- Draw the label's stroke
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    self.labelImage:draw(labelPosition.x - 1, labelPosition.y - 1)
    self.labelImage:draw(labelPosition.x - 1, labelPosition.y + 1)
    self.labelImage:draw(labelPosition.x + 1, labelPosition.y - 1)
    self.labelImage:draw(labelPosition.x + 1, labelPosition.y + 1)

    -- Draw the label
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    self.labelImage:draw(labelPosition.x, labelPosition.y)
  gfx.popContext()
end

function Timer:UpdateSecondsImage()
  self.secondsImage:clear(gfx.kColorClear)

  gfx.pushContext(self.secondsImage)
    local position <const> = {
      x = self.secondsImage.width / 2,
      y = 0
    }

    self.font:drawTextAligned(self.seconds, position.x, position.y, kTextAlignment.center)
  gfx.popContext()

  gfx.pushContext(self.timerImage)
    local scaledSeconds <const> = self.secondsImage:scaledImage(2)
    local secondsPosition <const> = {
      x = (self.timerImage.width - scaledSeconds.width) / 2,
      y = ((self.timerImage.height - scaledSeconds.height) / 2) + 6,
    }

    -- Draw the seconds' stroke
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    scaledSeconds:draw(secondsPosition.x - 1, secondsPosition.y - 1)
    scaledSeconds:draw(secondsPosition.x - 1, secondsPosition.y + 1)
    scaledSeconds:draw(secondsPosition.x + 1, secondsPosition.y - 1)
    scaledSeconds:draw(secondsPosition.x + 1, secondsPosition.y + 1)

    -- Draw the seconds
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    scaledSeconds:draw(secondsPosition.x, secondsPosition.y)
  gfx.popContext()
end

function Timer:UpdateTimerImage()
  self.timerImage:clear(gfx.kColorClear)

  self:UpdateLabelImage()
  self:UpdateSecondsImage()
end