local defaults <const> = {
  collidesWithGroupsMask = collisionTypes.HURTBOX,
  groupMask = collisionTypes.HITBOX,
  name = 'Hitbox',
}

class('Hitbox', defaults).extends(Collision)

function Hitbox:HandleCollision(collision)
  local hurtbox <const> = collision.other
  local character <const> = hurtbox.character

  -- It's technically possible for a sprite's hitboxes to collide with their own hurtboxes.
  if (character == self.character) then
    return
  end

  -- print('Handle Hitbox Collision', collision.sprite.name, collision.other.name)

  local didCharacterBlock <const> = character:CheckBlockInputs()

  if (not didCharacterBlock) then
    character:GetHit(self)

    self.hasHit = true

    return
  end
end

function Hitbox:HandleCollisions(collisions)
  for i, collision in ipairs(collisions) do
    -- A hitbox should only even register 1 hit, so if we've already hit, exit the loop early.
    if (self.hasHit) then
      return
    end

    self:HandleCollision(collision)
  end
end

function Hitbox:init(config)
  Hitbox.super.init(self, config)
end