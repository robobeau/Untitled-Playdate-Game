local defaults <const> = {
  collidesWithGroupsMask = collisionTypes.HURTBOX,
  groupMask = collisionTypes.HITBOX,
  name = 'Hitbox',
}

class('Hitbox', defaults).extends(Collision)

function Hitbox:OnAdd()
  self.soundFX.onWhiff:play()

  Hitbox.super.OnAdd(self)
end

function Hitbox:OnBlock()
  -- ???
  self:remove()
end

function Hitbox:OnHit()
  if (self.properties.characterNextState) then
    self.character:SetState(self.properties.characterNextState)
  end

  self:remove()
end