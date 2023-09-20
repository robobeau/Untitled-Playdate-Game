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

  local didCharacterBlock <const> = character:CheckBlockInputs()

  if (not didCharacterBlock) then
    if (hitbox.soundFX.onHit) then
      hitbox.soundFX.onHit:play()
    end

    self.character:GetHit(hitbox)
    hitbox:remove()

    return
  else
    if (hitbox.soundFX.onBlock) then
      hitbox.soundFX.onBlock:play()
    end
  end
end