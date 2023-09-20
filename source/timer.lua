-- Convenience variables
local pd <const> = playdate
local dis <const> = pd.display
local gfx <const> = pd.graphics
local fon <const> = gfx.font
local img <const> = gfx.image
local tmr <const> = pd.timer

local defaults <const> = {
  fontConfig = {
    -- path = "fonts/A.B. Cop",
    -- path = "fonts/Battle Garegga - Type 2"
    -- path = "fonts/ST-DIN"
    path = "fonts/Super Monaco GP",
    tracking = 0,
  },
  label = "TIME",
  OnStop = nil,
  OnStart = nil,
  time = {
    limit = 99,
    seconds = 99,
  },
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
  self.font = fon.new((config.fontConfig and config.fontConfig.path) or self.fontConfig.path)
  self.font:setTracking((config.fontConfig and config.fontConfig.tracking) or self.fontConfig.tracking)
  self.OnStart = config.OnStart or self.OnStart
  self.OnStop = config.OnStop or self.OnStop
  self.time.limit = (config.time and config.time.limit) or self.time.limit
  self.time.seconds = (config.time and config.time.seconds) or self.time.seconds

  self:InitImages()
  self:Reset()
end

function Timer:InitImages()
  local fontHeight <const> = self.font:getHeight()
  local labelImageWidth <const> = self.font:getTextWidth(self.label)
  local secondsImageWidth <const> = self.font:getTextWidth(self.time.limit)

  self.labelImage = img.new(labelImageWidth, fontHeight)
  self.secondsImage = img.new(secondsImageWidth, fontHeight)
  self.timerImage = img.new(40, 40)
end

function Timer:Reset()
  self.time.seconds = self.time.limit

  self:UpdateTimerImage()
  self:Draw()
end

function Timer:Start()
  self:Reset()

  if (self.timer) then
    self.timer:remove()
  end

  self.timer = tmr.new(1000)
end

function Timer:Stop()
  if (self.timer) then
    self.timer:remove()
  end
end

function Timer:Teardown()
  if (self.timer) then
    self.timer:remove()
  end

  self.labelImage:clear(gfx.kColorClear)
  self.labelImage = nil

  self.secondsImage:clear(gfx.kColorClear)
  self.secondsImage = nil

  self.timerImage:clear(gfx.kColorClear)
  self.timerImage = nil
end

function Timer:Tick()
  self.time.seconds -= 1

  if (self.time.seconds >= 0) then
    self.timer = tmr.new(1000)

    self:UpdateTimerImage()
  else
    if (self.OnStop) then
      self.timer = nil
      self.OnStop()
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

    self.font:drawTextAligned(self.time.seconds, position.x, position.y, kTextAlignment.center)
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