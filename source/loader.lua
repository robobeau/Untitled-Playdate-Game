-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics
local ani <const> = gfx.animator
local img <const> = gfx.image
local spr <const> = gfx.sprite

loaderStates = {
  ACTIVE = 1,
  IDLE = 2,
  STARTING = 4,
  STOPPING = 8,
}

local defaults = {
  state = loaderStates.IDLE
}

class('Loader', defaults).extends(spr)

function Loader:Draw()
  self.loaderImage:clear(gfx.kColorClear)

  gfx.pushContext(self.loaderImage)
    self.fadeImage:drawFaded(0, 0, self.alphaAnimator:currentValue(), img.kDitherTypeBayer8x8)
  gfx.popContext()

  self:setImage(self.loaderImage)
end

function Loader:init(config)
  self.displayRect = pd.display.getRect()
  self.fadeImage = img.new(self.displayRect.width, self.displayRect.height, gfx.kColorBlack)
  self.loaderImage = img.new(self.displayRect.width, self.displayRect.height, gfx.kColorClear)

  self:setCollisionsEnabled(false)
  self:setIgnoresDrawOffset(true)
  self:setZIndex(1000)
  self:moveTo(self.displayRect.width / 2, self.displayRect.height / 2)
end

function Loader:Start(startCallback)
  self.startCallback = startCallback
  self.state = loaderStates.STARTING
  self.alphaAnimator = ani.new(500, 0, 1)
end

function Loader:Stop(stopCallback)
  self.stopCallback = stopCallback
  self.state = loaderStates.STOPPING
  self.alphaAnimator = ani.new(500, 1, 0)
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
