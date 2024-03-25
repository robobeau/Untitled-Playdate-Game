local defaults <const> = {
  collidesWithGroupsMask = collisionTypes.HURTBOX,
  groupMask = collisionTypes.HITBOX,
  name = 'Hitbox',
}

class('Hitbox', defaults).extends(Collision)

function Hitbox:OnAdd()
  Hitbox.super.OnAdd(self)
end

function Hitbox:OnBlock()
  self:remove()
end

function Hitbox:OnHit()
  if (self.properties.characterState) then
    self.character:SetState(self.properties.characterState)
  end

  self:remove()
end