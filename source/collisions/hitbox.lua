import 'collision'
import 'collisionTypes'

local defaults <const> = {
  collidesWithGroupsMask = collisionTypes.HURTBOX,
  groupMask = collisionTypes.HITBOX,
}

class('Hitbox', defaults).extends(Collision)

function Hitbox:init(config)
  Hitbox.super.init(self, config)
end