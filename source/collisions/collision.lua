-- import 'CoreLibs/animation'
-- import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'

-- import 'collisionTypes'
-- import 'history'
-- import 'inputs'
import 'utils'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics

local defaults <const> = {
  collideRect =  geo.rect.new(0, 0, 0, 0),
  collidesWithGroupsMask = 0,
  groupMask = 0,
  parent = nil,
  properties = {}
}

class('Collision', defaults).extends(gfx.sprite)

function Collision:init(config)
  Collision.super.init(self)

  self.collideRect = config.collideRect or self.collideRect
  self.collidesWithGroupsMask = config.collidesWithGroupsMask or self.collidesWithGroupsMask
  self.groupMask = config.groupMask or self.groupMask
  self.parent = config.parent or self.parent
  self.properties = config.properties or self.properties

  self:setCollideRect(self.collideRect)
  self:setCollidesWithGroupsMask(self.collidesWithGroupsMask)
  self:setGroupMask(self.groupMask)
end