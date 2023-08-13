import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/ui'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics
local ani <const> = gfx.animator
local fon <const> = gfx.font
local img <const> = gfx.image
local rec <const> = geo.rect
local spr <const> = gfx.sprite

meterDirections = {
  LEFT = 1,
  RIGHT = 2,
}

local defaults <const> = {
  amount = 0,
  direction = meterDirections.LEFT,
  fontPath = 'fonts/Super Monaco GP',
  label = nil,
  meterRect = rec.new(0, 0, 120, 16),
  total = 0,
}

class('Meter', defaults).extends(spr)

function Meter:Draw()
  self.meterImage:clear(gfx.kColorClear)

  self:DrawBackground()
  self:DrawPercentage()
  self:DrawBorders()

  if (self.label) then
    self:DrawLabel()
  end

  self:setImage(self.meterImage)
end

function Meter:DrawBackground()
  gfx.pushContext(self.meterImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, self.width, self.height)
  gfx.popContext()
end

function Meter:DrawBorders()
  gfx.pushContext(self.meterImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(0, 0, self.width, self.height)
  gfx.popContext()
end

function Meter:DrawLabel()
  local alignment <const> = self.direction == meterDirections.LEFT
    and kTextAlignment.left
    or kTextAlignment.right
  local position <const> = {
    x = alignment == kTextAlignment.left
      and 5
      or self.width - 5,
    y = self.height / 4
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
  local amountPercentage <const> = amount / self.total
  local amountWidth <const> = math.floor(amountPercentage * self.meterRect.width)
  local position <const> = {
    x = 0,
    y = 0,
  }

  if (self.direction == meterDirections.LEFT) then
    position.x = self.width - amountWidth
  end

  gfx.pushContext(self.meterImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(position.x, 0, amountWidth, self.height)
  gfx.popContext()
end

function Meter:init(config)
  self.amount = config.amount or self.amount
  self.direction = config.direction or self.direction
  self.font = fon.new(config.fontPath or self.fontPath)
  self.label = config.label or self.label
  self.meterImage = img.new(self.meterRect.width, self.meterRect.height)
  self.meterRect = config.meterRect or self.meterRect
  self.total = config.total or self.total

  local meterCenter <const> = {
    x = self.direction == meterDirections.LEFT and 0 or 1,
    y = 0,
  }

  self:setCenter(meterCenter.x, meterCenter.y)
  self:moveTo(self.meterRect.x, self.meterRect.y)
  self:setCollisionsEnabled(false)
  self:setIgnoresDrawOffset(true)
  self:setSize(self.meterRect.width, self.meterRect.height)
  self:setZIndex(100)

  self:Draw()
end

function Meter:SetAmount(amount)
  local prevAmount <const> = self.amount

  self.amount = amount
  self.amountAnimator = ani.new(200, prevAmount, self.amount)

  self:setUpdatesEnabled(true)
end

function Meter:update()
  if (self.amountAnimator) then
    if (self.amountAnimator:ended()) then
      self:setUpdatesEnabled(false)
    else
      self:Draw()
    end
  end
end