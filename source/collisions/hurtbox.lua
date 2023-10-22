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

  if (hitbox.properties.type == collisionBoxTypes.THROW) then
    local didCharacterThrowEscape <const> = character:CheckThrowInputs()

    if (didCharacterThrowEscape) then
      -- TODO: Implement throw escape
    else
      self.character:GetThrown(hitbox)
      hitbox:OnHit()
    end
  else
    local didCharacterBlock <const> = character:CheckBlockInputs()

    if (didCharacterBlock) then
      if (hitbox.soundFX.onBlock) then
        hitbox.soundFX.onBlock:play()
      end

      self.character:TakeDamage(hitbox, true)
      hitbox:OnBlock()
    else
      if (hitbox.soundFX.onHit) then
        hitbox.soundFX.onHit:play()
      end

      self.character:TakeDamage(hitbox, false)
      hitbox:OnHit()
    end
  end
end