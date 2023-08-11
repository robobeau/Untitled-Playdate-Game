local defaults <const> = {
  collidesWithGroupsMask = collisionTypes.PUSHBOX,
  groupMask = collisionTypes.PUSHBOX,
  name = 'Pushbox',
}

class('Pushbox', defaults).extends(Collision)

function Pushbox:init(config)
  Hitbox.super.init(self, config)
end