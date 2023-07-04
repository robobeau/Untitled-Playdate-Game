import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/ui'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics
local ui <const> = pd.ui

meterDirections = {
  LEFT = 1,
  RIGHT = 2,
}

local defaults <const> = {
  amount = 0,
  direction = meterDirections.LEFT,
  meterRect = geo.rect.new(0, 0, 120, 16),
  total = 0,
}

class('Meter', defaults).extends(gfx.sprite)

function Meter:draw(x, y, width, height)
  local meterImage <const> = gfx.image.new(self.meterRect.width, self.meterRect.height)

  gfx.pushContext(meterImage)
    self:DrawBackground(x, y, width, height)
    self:DrawPercentage(x, y, width, height)
    self:DrawBorders(x, y, width, height)
  gfx.popContext()

  self.meterSprite:setImage(meterImage)
end

function Meter:DrawBackground(x, y, width, height)
  gfx.setColor(gfx.kColorBlack)
  gfx.fillRect(x, y, width, height)
end

function Meter:DrawBorders(x, y, width, height)
  gfx.setColor(gfx.kColorBlack)
  gfx.drawRect( x, y, width, height)
end

function Meter:DrawPercentage(x, y, width, height)
  local amount <const> = self.amountAnimator
    and self.amountAnimator:currentValue()
    or self.amount

  local amountPercentage <const> = amount / self.total
  local amountWidth <const> = math.floor(amountPercentage * self.meterRect.width)
  local offset = 0

  if (self.direction == meterDirections.LEFT) then
    offset = width - amountWidth
  end

  gfx.setColor(gfx.kColorWhite)
  gfx.fillRect(x + offset, y, amountWidth, height)
end

function Meter:init(config)
  self.amount = config.amount or self.amount
  self.direction = config.direction or self.direction
  self.meterRect = config.meterRect or self.meterRect
  self.total = config.total or self.total

  local meterCenter <const> = {
    x = self.direction == meterDirections.LEFT and 0 or 1,
    y = 0,
  }
  local meterSprite <const> = gfx.sprite.new()
        meterSprite:setCenter(meterCenter.x, meterCenter.y)
        meterSprite:setIgnoresDrawOffset(true)
        meterSprite:moveTo(self.meterRect.x, self.meterRect.y)
        meterSprite:add()

  self.meterSprite = meterSprite

  self:setCenter(meterCenter.x, meterCenter.y)
  self:setIgnoresDrawOffset(true)
  self:setSize(self.meterRect.width, self.meterRect.height)
  self:moveTo(self.meterRect.x, self.meterRect.y)
end

function Meter:SetAmount(amount)
  local prevAmount <const> = self.amount
  self.amount = amount
  self.amountAnimator = gfx.animator.new(200, prevAmount, self.amount)
end

function Meter:update()
  if (self.amountAnimator) then
    if (not self.amountAnimator:ended()) then
      self:markDirty()
    end
  end
end