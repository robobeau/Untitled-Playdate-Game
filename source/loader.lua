import 'CoreLibs/animator'
import "CoreLibs/graphics"
import "CoreLibs/sprites"

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics

loaderStates = {
  ACTIVE = 1,
  IDLE = 2,
  STARTING = 4,
  STOPPING = 8,
}

local defaults = {
  state = loaderStates.IDLE
}

class('Loader', defaults).extends(gfx.sprite)

function Loader:Draw()
  local displayRect <const> = pd.display.getRect()
  local loaderImage <const> = gfx.image.new(displayRect.width, displayRect.height, gfx.kColorClear)

  gfx.pushContext(loaderImage)
    gfx.setColor(gfx.kColorClear)
    gfx.fillRect(0, 0, displayRect.width, displayRect.height)

    local fadeImage <const> = gfx.image.new(displayRect.width, displayRect.height, gfx.kColorBlack)
          fadeImage:drawFaded(0, 0, self.alphaAnimator:currentValue(), gfx.image.kDitherTypeBayer8x8)
  gfx.popContext()

  self:setImage(loaderImage)
end

function Loader:init(config)
  local displayRect <const> = pd.display.getRect()

  self:setCollisionsEnabled(false)
  self:setIgnoresDrawOffset(true)
  self:setZIndex(1000)
  self:moveTo(displayRect.width / 2, displayRect.height / 2)
end

function Loader:Start(startCallback)
  self.startCallback = startCallback
  self.state = loaderStates.STARTING
  self.alphaAnimator = gfx.animator.new(500, 0, 1)
end

function Loader:Stop(stopCallback)
  self.stopCallback = stopCallback
  self.state = loaderStates.STOPPING
  self.alphaAnimator = gfx.animator.new(500, 1, 0)
end

function Loader:update()
  if (self.state == loaderStates.ACTIVE or self.state == loaderStates.IDLE) then
    return
  end

  if (self.alphaAnimator) then
    if (self.alphaAnimator:ended()) then
      if (self.state == loaderStates.STARTING) then
        self.state = loaderStates.ACTIVE

        if (self.startCallback) then
          self.startCallback()
        end
      elseif (self.state == loaderStates.STOPPING) then
        self.state = loaderStates.IDLE

        if (self.stopCallback) then
          self.stopCallback()
        end
      end
    else
      self:Draw()
    end
  end
end
