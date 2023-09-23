import '../collisionTypes'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics
local rec <const> = geo.rect
local spr <const> = gfx.sprite

local defaults <const> = {
  character = nil,
  collideRect =  rec.new(0, 0, 0, 0),
  collidesWithGroupsMask = 0,
  groupMask = 0,
  name = 'Collision',
  properties = {},
  soundFX = {},
}
local collisionTypes <const> = {
  HIGH = 1,
  LOW = 2,
  MID = 4,
  THROW = 8
}

class('Collision', defaults).extends(spr)

function Collision:HandleCollision(collision)
  -- Do something...?
end

function Collision:HandleCollisions(collisions)
  for i, collision in ipairs(collisions) do
    self:HandleCollision(collision)
  end
end

function Collision:init(config)
  Collision.super.init(self)

  self.character = config.character or self.character
  self.collideRect = config.collideRect or self.collideRect
  self.collisionResponse = spr.kCollisionTypeOverlap
  self.name = config.name or self.name
  self.properties = config.properties or self.properties
  self.soundFX = {}

  local boundsRect <const> = self.character:getBoundsRect()
  local collideRect <const> = self.collideRect:offsetBy(boundsRect.x, boundsRect.y)
        collideRect:flipRelativeToRect(boundsRect, self.character:GetFlip())

  self:setCenter(0, 0)
  self:setBounds(collideRect)
  self:setCollideRect(0, 0, self:getSize())
  self:setCollidesWithGroupsMask(config.collidesWithGroupsMask or self.collidesWithGroupsMask)
  self:setGroupMask(config.groupMask or self.groupMask)
end

function Collision:OnAdd()
  self:UpdatePosition()
end

function Collision:update()
  self:UpdatePosition()

  local actualX <const>,
        actualY <const>,
        collisions <const> = self:checkCollisions(self.x, self.y)

  self:HandleCollisions(collisions)
end

function Collision:UpdatePosition()
  local boundsRect <const> = self.character:getBoundsRect()
  local collideRect <const> = self.collideRect:offsetBy(boundsRect.x, boundsRect.y)
        collideRect:flipRelativeToRect(boundsRect, self.character:GetFlip())

  self:moveTo(collideRect.x, collideRect.y)
end