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
  fontPath = "fonts/Super Monaco GP",
  label = nil,
  meterRect = geo.rect.new(0, 0, 120, 16),
  total = 0,
}

class('Meter', defaults).extends(gfx.sprite)

function Meter:SetMeterSpriteImage()
  local meterImage <const> = gfx.image.new(self.meterRect.width, self.meterRect.height)

  gfx.pushContext(meterImage)
    self:DrawBackground(0, 0, self.width, self.height)
    self:DrawPercentage(0, 0, self.width, self.height)
    self:DrawBorders(0, 0, self.width, self.height)

    if (self.label) then
      self:DrawLabel(0, 0, self.width, self.height)
    end
  gfx.popContext()

  self.meterSprite:setImage(meterImage)
end

function Meter:DrawBackground(x, y, width, height)
  gfx.setColor(gfx.kColorBlack)
  gfx.fillRect(x, y, width, height)
end

function Meter:DrawBorders(x, y, width, height)
  gfx.setColor(gfx.kColorBlack)
  gfx.drawRect(x, y, width, height)
end

function Meter:DrawLabel(x, y, width, height)
  local alignment <const> = self.direction == meterDirections.LEFT and
    kTextAlignment.left or
    kTextAlignment.right
  local position <const> = {
    x = alignment == kTextAlignment.left and
      5 or
      width - 5,
    y = height / 4
  }

  gfx.setImageDrawMode(gfx.kDrawModeNXOR)
  self.font:drawTextAligned(self.label, position.x, position.y, alignment)
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
  self.font = gfx.font.new(config.fontPath or self.fontPath)
  self.label = config.label or self.label
  self.meterRect = config.meterRect or self.meterRect
  self.total = config.total or self.total

  local meterCenter <const> = {
    x = self.direction == meterDirections.LEFT and 0 or 1,
    y = 0,
  }

  self:setCenter(meterCenter.x, meterCenter.y)
  self:setSize(self.meterRect.width, self.meterRect.height)
  self:moveTo(self.meterRect.x, self.meterRect.y)
  self:setIgnoresDrawOffset(true)

  local meterSprite <const> = gfx.sprite.new()
        meterSprite:setCenter(meterCenter.x, meterCenter.y)
        meterSprite:moveTo(self.meterRect.x, self.meterRect.y)
        meterSprite:setIgnoresDrawOffset(true)
        meterSprite:add()

  self.meterSprite = meterSprite

  self:SetMeterSpriteImage()
end

function Meter:SetAmount(amount)
  local prevAmount <const> = self.amount
  self.amount = amount
  self.amountAnimator = gfx.animator.new(200, prevAmount, self.amount)
end

function Meter:update()
  if (self.amountAnimator and not self.amountAnimator:ended()) then
    self:SetMeterSpriteImage()
  end
end