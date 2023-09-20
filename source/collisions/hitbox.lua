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