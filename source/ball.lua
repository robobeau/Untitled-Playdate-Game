import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'collisionTypes'
import 'character'
import 'utils'

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics

ballTypes = {
  BASKETBALL = 1,
  BASEBALL = 2,
  BOWLINGBALL = 3,
  TENNISBALL = 4,
  VOLLEYBALL = 5,
}

ballGravities = {
  [ballTypes.BASKETBALL] = 2,
  [ballTypes.BASEBALL] = 4,
  [ballTypes.BOWLINGBALL] = 5,
  [ballTypes.TENNISBALL] = 1,
  [ballTypes.VOLLEYBALL] = 3,
}

ballImages = {
  [ballTypes.BASKETBALL] = 'images/basketball',
  [ballTypes.BASEBALL] = 'images/baseball',
  [ballTypes.BOWLINGBALL] = 'images/bowlingball',
  [ballTypes.TENNISBALL] = 'images/tennisball',
  [ballTypes.VOLLEYBALL] = 'images/volleyball',
}

ballSizes = {
  [ballTypes.BASKETBALL] = {
    x = 30,
    y = 30,
  },
  [ballTypes.BASEBALL] = {
    x = 10,
    y = 10,
  },
  [ballTypes.BOWLINGBALL] = {
    x = 10,
    y = 10,
  },
  [ballTypes.TENNISBALL] = {
    x = 16,
    y = 16,
  },
  [ballTypes.VOLLEYBALL] = {
    x = 10,
    y = 10,
  },
}

local defaults <const> = {
  startingPosition = {
    x = 0,
    y = 0,
  },
  type = ballTypes.TENNISBALL,
  velocity = {
    x = 0,
    y = 0,
  }
}

class('Ball', defaults).extends(gfx.sprite)

function Ball:collisionResponse(other)
  local groupMask <const> = other:getGroupMask()
  local collidedWithHitbox = groupMask & collisionTypes.HITBOX ~= 0
  local collidedWithHurtbox = groupMask & collisionTypes.HURTBOX ~= 0
  local collidedWithWall = groupMask & collisionTypes.WALL ~= 0

  if (collidedWithHitbox or collidedWithHurtbox) then
    return gfx.sprite.kCollisionTypeOverlap
  end

  return gfx.sprite.kCollisionTypeSlide
end

function Ball:init(config)
  Ball.super.init(self)

  -- self.collisionResponse = gfx.sprite.kCollisionTypeSlide
  self.startingPosition = config.startingPosition or self.startingPosition
  self.type = config.type or self.type
  self.gravity = ballGravities[self.type]
  self.velocity = config.velocity or self.velocity

  local image <const> = gfx.image.new(ballImages[self.type])

  self:moveTo(self.startingPosition.x, self.startingPosition.y)
  self:setCenter(0, 0)
  self:setCollideRect(0, 0, ballSizes[self.type].x, ballSizes[self.type].y)
  self:setCollidesWithGroupsMask(collisionTypes.HITBOX | collisionTypes.HURTBOX | collisionTypes.WALL)
  self:setGroupMask(collisionTypes.BALL)
  self:setImage(image)
end

function Ball:update()
  self:CheckButtons()
  self:UpdatePosition()
  -- self:UpdateDebugInfo()

  -- Update global state
end

function Ball:ChangeVelocity(x, y)
  local newVelocity <const> = self.velocity
  local signX <const> = Sign(self.velocity.x)
  local signY <const> = Sign(self.velocity.y)

  if (x ~= nil) then
    newVelocity.x = math.abs(self.velocity.x) + x

    if (signX ~= 0) then
      newVelocity.x *= signX
    end
  end

  if (y ~= nil) then
    newVelocity.y = math.abs(self.velocity.y) + y

    if (signY ~= 0) then
      newVelocity.y *= signY
    end
  end

  self.velocity = newVelocity
end

function Ball:CheckButtons()
  -- if pd.buttonIsPressed(pd.kButtonDown) then
  --   self.gravity += 1
  -- end

  -- if pd.buttonIsPressed(pd.kButtonUp) then
  --   self:Reset()
  -- end
end

function Ball:HandleCollisions(actualX, actualY, collisions, length)
  for i, collision in ipairs(collisions) do
    local groupMask <const> = collision.other:getGroupMask()
    local collidedWithHitbox = groupMask & collisionTypes.HITBOX ~= 0
    local collidedWithHurtbox = groupMask & collisionTypes.HURTBOX ~= 0
    local collidedWithWall = groupMask & collisionTypes.WALL ~= 0

    -- TODO: This check might be unnecessary?
    -- if (collidedWithHurtbox or collidedWithWall) then
      self:HandleWallCollision(collision)
    -- end
  end
end

function Ball:HandleWallCollision(collision)
  if (collision.normal.x ~= 0 or collision.normal.y ~= 0) then
    -- TODO: Find a better way to reduce horizontal velocity
    self.velocity.x -= self.gravity * Sign(self.velocity.x)
    self.velocity.y -= self.gravity * Sign(self.velocity.y)

    if (collision.normal.x ~= 0) then
      self.velocity.x *= -1
    end

    if (collision.normal.y ~= 0) then
      self.velocity.y *= -1
    end
  end
end

function Ball:Reset()
  self:ResetPhysics()
  self:ResetPosition()
end

function Ball:ResetPhysics()
  self.velocity = {
    x = 0,
    y = 0,
  }
end

function Ball:ResetPosition()
  local newPosition <const> = {
    x = self.startingPosition.x or 0,
    y = self.startingPosition.y or 0,
  }

  self:moveTo(newPosition.x, newPosition.y)
end

function Ball:SetPosition(x, y)
  self.position = {
    x = x or self.position.x,
    y = y or self.position.y
  }
end

function Ball:SetVelocity(x, y)
  self.velocity = {
    x = x or self.velocity.x,
    y = y or self.velocity.y
  }
end

function Ball:UpdateDebugInfo()
  -- gfx.drawText("gravity: " .. self.gravity, 0, 0)
  -- gfx.drawText("ball.x: " .. math.abs(self.x), 0, 20)
  -- gfx.drawText("ball.y: " .. math.abs(self.y), 0, 40)
  -- gfx.drawText("velocity.x: " .. math.abs(self.velocity.x), 200, 20)
  -- gfx.drawText("velocity.y: " .. math.abs(self.velocity.y), 200, 40)
end

function Ball:UpdatePosition()
  local nextPosition <const> = {
    x = self.x,
    y = self.y
  }

  -- if (math.abs(self.velocity.x) > 0) then
  --   local refreshRate <const> = pd.display.getRefreshRate()
  --   self.velocity.x -= (self.gravity / refreshRate) * Sign(self.velocity.x)

  --   -- if math.abs(self.velocity.x) < 0.1 then
  --   --   self.velocity.x = 0
  --   -- end
  -- end

  self.velocity.y += self.gravity

  nextPosition.x += self.velocity.x
  nextPosition.y += self.velocity.y

  local actualX, actualY, collisions, length = self:moveWithCollisions(nextPosition.x, nextPosition.y)

  self:HandleCollisions(actualX, actualY, collisions, length)
end