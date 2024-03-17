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
collisionBoxTypes = {
  HIGH = 0,
  LOW = 1,
  MID = 2,
  THROW = 3
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

  self:InitSoundFX()
  self:setCenter(0, 0)
  self:setBounds(collideRect)
  self:setCollideRect(0, 0, self:getSize())
  self:setCollidesWithGroupsMask(config.collidesWithGroupsMask or self.collidesWithGroupsMask)
  self:setGroupMask(config.groupMask or self.groupMask)
end

function Collision:InitSoundFX()
  if (self.properties.soundFX == nil) then
    return
  end

  if (self.properties.soundFX.onBlock) then
    self.soundFX.onBlock = self:SetSoundFX(self.properties.soundFX.onBlock)
  end

  if (self.properties.soundFX.onHit) then
    self.soundFX.onHit = self:SetSoundFX(self.properties.soundFX.onHit)
  end

  if (self.properties.soundFX.onWhiff) then
    self.soundFX.onWhiff = self:SetSoundFX(self.properties.soundFX.onWhiff)
  end
end

function Collision:OnAdd()
  self:UpdatePosition()
end

function Collision:SetSoundFX(soundFXPath)
  -- Chop off the "../"
  soundFXPath = string.gsub(soundFXPath, '%.%./%.%./%.%./', '/')

  if (not self.soundFX[soundFXPath]) then
    self.soundFX[soundFXPath] = pd.sound.sampleplayer.new(soundFXPath)
  end

  return self.soundFX[soundFXPath]
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