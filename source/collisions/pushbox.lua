import 'collision'
import 'collisionTypes'

local defaults <const> = {
  collidesWithGroupsMask = collisionTypes.PUSHBOX,
  groupMask = collisionTypes.PUSHBOX,
}

class('Pushbox', defaults).extends(Collision)

function Pushbox:init(config)
  Hitbox.super.init(self, config)
end