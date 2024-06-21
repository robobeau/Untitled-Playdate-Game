import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/ui'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics
local ani <const> = gfx.animator
local img <const> = gfx.image
local rec <const> = geo.rect

meterDirections = {
  LEFT = 1,
  RIGHT = 2,
}

local defaults <const> = {
  alpha = 1,
  amount = 0,
  direction = meterDirections.LEFT,
  ditherType = nil,
  font = fonts.SuperMonacoGP,
  label = nil,
  max = 0,
  meterRect = rec.new(0, 0, 120, 16),
  startingAmount = 0,
}

class('Meter', defaults).extends()

function Meter:Draw()
  local position <const> = {
    x = self.direction == meterDirections.LEFT
      and self.meterRect.x
      or self.meterRect.x - self.meterRect.width,
    y = self.meterRect.y
  }

  self.meterImage:drawIgnoringOffset(position.x, position.y)
end

function Meter:DrawBackground()
  gfx.pushContext(self.meterImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, self.meterRect.width, self.meterRect.height)
  gfx.popContext()
end

function Meter:DrawBorders()
  gfx.pushContext(self.meterImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(0, 0, self.meterRect.width, self.meterRect.height)
  gfx.popContext()
end

function Meter:DrawLabel()
  local alignment <const> = self.direction == meterDirections.LEFT
    and kTextAlignment.left
    or kTextAlignment.right
  local position <const> = {
    x = self.direction == meterDirections.LEFT
      and 5
      or self.meterRect.width - 5,
    y = self.meterRect.height / 4
  }

  gfx.pushContext(self.meterImage)
    gfx.setImageDrawMode(gfx.kDrawModeNXOR)
    self.font:drawTextAligned(self.label, position.x, position.y, alignment)
  gfx.popContext()
end

function Meter:DrawPercentage()
  local amount <const> = self.amountAnimator
    and self.amountAnimator:currentValue()
    or self.amount
  local amountPercentage <const> = amount / self.max
  local amountWidth <const> = math.floor(amountPercentage * self.meterRect.width)
  local position <const> = {
    x = self.direction == meterDirections.LEFT
      and self.meterRect.width - amountWidth
      or 0,
    y = 0,
  }

  gfx.pushContext(self.meterImage)
    gfx.setColor(gfx.kColorWhite)

    if (self.alpha and self.ditherType) then
      gfx.setDitherPattern(self.alpha, self.ditherType)
    end

    gfx.fillRect(position.x, position.y, amountWidth, self.meterRect.height)
  gfx.popContext()
end

function Meter:init(config)
  self.alpha = config.alpha or self.alpha
  self.direction = config.direction or self.direction
  self.ditherType = config.ditherType or self.ditherType
  self.font = config.font or self.font
  self.label = config.label or self.label
  self.max = config.max or self.max
  self.meterRect = config.meterRect or self.meterRect
  self.meterImage = img.new(self.meterRect.width, self.meterRect.height)
  self.startingAmount = config.startingAmount or self.startingAmount
  self.amount = self.startingAmount

  self:UpdateMeterImage()
  self:Draw()
end

function Meter:Reset()
  self:SetAmount(self.startingAmount)
end

function Meter:SetAmount(amount)
  local prevAmount <const> = self.amount

  self.amount = amount
  self.amountAnimator = ani.new(200, prevAmount, self.amount)
end

function Meter:Update()
  if (self.amountAnimator) then
    if (not self.amountAnimator:ended()) then
      self:UpdateMeterImage()
    end
  end

  self:Draw()
end

function Meter:UpdateMeterImage()
  self.meterImage:clear(gfx.kColorClear)

  self:DrawBackground()
  self:DrawPercentage()
  self:DrawBorders()

  if (self.label) then
    self:DrawLabel()
  end
end