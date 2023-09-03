-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics
local img <const> = gfx.image
local spr <const> = gfx.sprite

loaderStates = {
  ACTIVE = 1,
  IDLE = 2,
  STARTING = 4,
  STOPPING = 8,
}

local defaults <const> = {
  state = loaderStates.IDLE
}
local kimLoaderImagetable <const> = gfx.imagetable.new('images/loaders/KimLoader')
local kimLoader <const> = gfx.animation.loop.new(100, kimLoaderImagetable, true)

class('Loader', defaults).extends()

function Loader:Draw()
  self.loaderImage:clear(gfx.kColorClear)

  gfx.pushContext(self.loaderImageMask)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, self.loaderImage.width, self.loaderImage.height)

    gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    local scaledImage <const> = kimLoader:image():scaledImage(self.scaleAnimator:currentValue())
          scaledImage:drawCentered(self.xAnimator:currentValue(), self.yAnimator:currentValue())
  gfx.popContext()

  if (self.state == loaderStates.ACTIVE) then
    gfx.pushContext(self.loaderImage)
      self.loaderImageMask:invertedImage():draw(0, 0)
    gfx.popContext()
  else
    self.loaderImage:setMaskImage(self.loaderImageMask)
  end

  self.loaderImage:drawIgnoringOffset(0, 0)
end

function Loader:init(config)
  self.displayRect = pd.display.getRect()
  self.fadeImage = img.new(self.displayRect.width, self.displayRect.height, gfx.kColorBlack)
  self.loaderImage = img.new(self.displayRect.width, self.displayRect.height, gfx.kColorClear)
  self.loaderImageMask = img.new(self.displayRect.width, self.displayRect.height, gfx.kColorClear)
end

function Loader:Start(startCallback)
  self.startCallback = startCallback
  self.state = loaderStates.STARTING
  self.scaleAnimator = gfx.animator.new(500, 30, 1)
  self.xAnimator = gfx.animator.new(500, self.displayRect.width / 2, self.displayRect.width - 40)
  self.yAnimator = gfx.animator.new(500, self.displayRect.height / 2, self.displayRect.height - 40)
end

function Loader:Stop(stopCallback)
  self.stopCallback = stopCallback
  self.state = loaderStates.STOPPING
  self.scaleAnimator = gfx.animator.new(500, 1, 30)
  self.xAnimator = gfx.animator.new(500, self.displayRect.width - 40, self.displayRect.width / 2)
  self.yAnimator = gfx.animator.new(500, self.displayRect.height - 40, self.displayRect.height / 2)
end

function Loader:Update()
  if (self.state == loaderStates.IDLE) then
    return
  end

  if (self.scaleAnimator) then
    if (self.scaleAnimator:ended()) then
      if (self.state == loaderStates.STARTING) then
        self.state = loaderStates.ACTIVE

        if (self.startCallback) then
          self.startCallback()
        end
      elseif (self.state == loaderStates.STOPPING) then
        self.loaderImage:clear(gfx.kColorClear)
        self.state = loaderStates.IDLE

        if (self.stopCallback) then
          self.stopCallback()
        end
      end
    end
  end

  self:Draw()
end
