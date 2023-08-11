local defaults <const> = {
  collidesWithGroupsMask = collisionTypes.HITBOX,
  groupMask = collisionTypes.HURTBOX,
  name = 'Hurtbox',
}

class('Hurtbox', defaults).extends(Collision)

function Hurtbox:HandleCollision(collision)
  local hitbox <const> = collision.other
  local character <const> = hitbox.character

  -- It's technically possible for a sprite's hurtboxes to collide with their own hitboxes.
  if (character == self.character) then
    return
  end

  -- print('Handle Hurtbox Collision', collision.sprite.name, collision.other.name)

  -- Do something...?
end

function Hurtbox:init(config)
  Hurtbox.super.init(self, config)
end