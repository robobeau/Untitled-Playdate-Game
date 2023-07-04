import 'collision'
import 'collisionTypes'

local defaults <const> = {
  collidesWithGroupsMask = collisionTypes.HITBOX,
  groupMask = collisionTypes.HURTBOX,
}

class('Hurtbox', defaults).extends(Collision)

function Hurtbox:init(config)
  Hurtbox.super.init(self, config)
end