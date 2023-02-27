import 'CoreLibs/animation'
import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'collisionTypes'
import 'history'
import 'inputs'
import 'utils'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics

charDirections = {
  LEFT = 1,
  RIGHT = 2,
}
charStates = {
  AIRBORNE = 1,
  ATTACK = 2,
  ATTACK_NEUTRAL = 4,
  BACK = 8,
  BEGIN = 16,
  BLOCK = 32,
  CROUCH = 64,
  DASH = 128,
  DOWN = 256,
  END = 512,
  FORWARD = 1024,
  HURT = 2048,
  JUMP = 4096,
  KICK = 8192,
  KNOCKDOWN = 16384,
  MOVE = 32768,
  PARRY = 65536,
  PUNCH = 131072,
  RISE = 262144,
  RUN = 524288,
  SPECIAL = 1048576,
  STAND = 2097152,
  TAUNT = 4194304,
  UP = 8388608,
}

-- 16777216
-- 33554432

local defaultState <const> = {
  buttonState = {},
  direction = charDirections.RIGHT,
  frameCounter = 1,
  frameIndex = 1,
  position = {
    x = 0,
    y = 0,
  },
  pushboxRect = nil,
  state = charStates.STAND,
  velocity = {
    x = 0,
    y = 0,
  },
}
local defaults <const> = {
  canDoubleJump = false,
  counter = 1,
  dashSpeed = 10,
  drag = 1,
  emptyCollisionSprites = {},
  gravity = 1,
  imageTables = {},
  jumpHeight = 14,
  name = 'Character',
  runSpeed = 10,
  speed = 5,
  startingPosition = {
    x = 0,
    y = 0,
  },
  states = {
    defaultState,
  },
  tilesets = {},
}

class('Character', defaults).extends(gfx.sprite)

function Character:init(config)
  Character.super.init(self)

  self.canDoubleJump = config.canDoubleJump or self.canDoubleJump
  self.charAnimationFrameDelay = (1 / pd.display.getRefreshRate()) * 1000
  self.collisionResponse = pd.graphics.sprite.kCollisionTypeSlide
  self.dashSpeed = config.dashSpeed or self.dashSpeed
  self.gravity = config.gravity or self.gravity
  self.history = History()
  self.jumpHeight = config.jumpHeight or self.jumpHeight
  self.name = config.name or self.name
  self.opponent = config.opponent or self.opponent
  self.speed = config.speed or self.speed
  self.startingPosition = config.startingPosition or self.startingPosition

  self.history:MutateTick(defaultState)

  -- self:tableDump()

  self:Load()
  self:moveTo(self.startingPosition.x, self.startingPosition.y)
  self:setCenter(0.5, 1)
  self:SetState(charStates.STAND)
end

function Character:update()
  -- local frame <const> = self.history:GetFrame()
  -- print('Bounds', self:getBoundsRect())

  self:CheckCrank()

  if (self.frozen == true) then
    self:UpdateFrozenSprite()

    return
  end

  self:TransitionState()
  self:UpdateDirection()
  self:CheckInputs()

  self:UpdateAnimationFrame()
  self:UpdatePhysics()
  self:UpdatePosition()

  self:PrepareForNextLoop()
end

-- TODO: Buddy, you gotta decouple your logic so that you draw based on a state simulation
function Character:CheckCrank()
  if (pd.isCrankDocked()) then
    self.frozen = false

    return
  end

  local change <const>, acceleratedChange <const> = pd.getCrankChange()

  if (acceleratedChange ~= 0) then
    local delta <const> = math.floor(self.counter + change)

    -- print(change, acceleratedChange, self.counter, delta)

    if (delta > 0 and delta < #self.history.ticks) then
      self.counter = delta
    end
  end
end

function Character:CheckInputs()
  self:UpdateButtonStates()

  if (self:CheckSpecialInputs()) then
    return
  end

  if (self:CheckAttackInputs()) then
    return
  end

  if (self:CheckMovementInputs()) then
    return
  end
end

function Character:CheckAttackInputs()
  local frame <const> = self.history:GetFrame()
  local tileProperties <const> = self:GetTileProperties(frame.frameIndex)

  -- If we can't perform an attack, exit early.
  if (not tileProperties.attackCancellable) then
    return
  end

  local backInput <const>, forwardInput <const> = self:GetBackAndForwardInputs()
  local current <const>, pressed <const>, released <const> = table.unpack(frame.buttonState)

  -- print('CheckAttackInputs', current, pressed, released)

  local hasPressedA <const> = pressed & pd.kButtonA ~= 0
  local hasPressedB <const> = pressed & pd.kButtonB ~= 0
  -- local hasPressedBack <const> = pressed & backInput ~= 0
  -- local hasPressedDown <const> = pressed & pd.kButtonDown ~= 0
  -- local hasPressedForward <const> = pressed & forwardInput ~= 0
  -- local hasPressedLeft <const> = pressed & pd.kButtonLeft ~= 0
  -- local hasPressedRight <const> = pressed & pd.kButtonRight ~= 0
  -- local hasPressedUp <const> = pressed & pd.kButtonUp ~= 0

  -- local hasReleasedA <const> = released & pd.kButtonA ~= 0
  -- local hasReleasedB <const> = released & pd.kButtonB ~= 0
  -- local hasReleasedBack <const> = released & backInput ~= 0
  -- local hasReleasedDown <const> = released & pd.kButtonDown ~= 0
  -- local hasReleasedForward <const> = released & forwardInput ~= 0
  -- local hasReleasedLeft <const> = released & pd.kButtonLeft ~= 0
  -- local hasReleasedRight <const> = released & pd.kButtonRight ~= 0
  -- local hasReleasedUp <const> = released & pd.kButtonUp ~= 0

  -- local isPressingA <const> = current & pd.kButtonA ~= 0
  -- local isPressingB <const> = current & pd.kButtonB ~= 0
  local isPressingBack <const> = current & backInput ~= 0
  -- local isPressingDown <const> = current & pd.kButtonDown ~= 0
  local isPressingForward <const> = current & forwardInput ~= 0
  -- local isPressingLeft <const> = current & pd.kButtonLeft ~= 0
  -- local isPressingRight <const> = current & pd.kButtonRight ~= 0
  -- local isPressingUp <const> = current & pd.kButtonUp ~= 0

  if (hasPressedB) then
    local newState = charStates.KICK

    if (self:IsJumping()) then
      newState |= charStates.JUMP | charStates.AIRBORNE

      if (self:IsBack()) then
        newState |= charStates.BACK
      elseif (self:IsForward()) then
        newState |= charStates.FORWARD
      end

      if (self:IsRunning()) then
        newState |= charStates.RUN
      elseif (self:IsDashing()) then
        newState |= charStates.DASH
      end
    elseif (self:IsDashing() or self:IsMoving() or self:IsStanding() or self:IsRunning()) then
      newState |= charStates.STAND

      if (isPressingBack) then
        newState |= charStates.BACK
      elseif (isPressingForward) then
        newState |= charStates.FORWARD
      end
    elseif (self:IsCrouching()) then
      newState |= charStates.CROUCH
    end

    self:SetState(newState)

    return true
  end

  if (hasPressedA) then
    local newState = charStates.PUNCH

    if (self:IsJumping()) then
      newState |= charStates.JUMP | charStates.AIRBORNE

      if (self:IsBack()) then
        newState |= charStates.BACK
      elseif (self:IsForward()) then
        newState |= charStates.FORWARD
      end

      if (self:IsRunning()) then
        newState |= charStates.RUN
      elseif (self:IsDashing()) then
        newState |= charStates.DASH
      end
    elseif (self:IsDashing() or self:IsMoving() or self:IsStanding() or self:IsRunning()) then
      newState |= charStates.STAND
    elseif (self:IsCrouching()) then
      newState |= charStates.CROUCH
    end

    self:SetState(newState)

    return true
  end
end

function Character:CheckMovementInputs()
  local buttonState = Inputs:GetButtonState(self)
  local frame <const> = self.history:GetFrame()
  local tileProperties <const> = self:GetTileProperties(frame.frameIndex)

  -- Jump check
  if (tileProperties.jumpCancellable and not self:IsJumping()) then
    if (Inputs:CheckJumpInput(self)) then
      local newState = charStates.JUMP | charStates.AIRBORNE | charStates.BEGIN

      if (Inputs:CheckMoveBackInput(self)) then
        newState |= charStates.BACK

        if (self:IsRunning()) then
          newState |= charStates.RUN
        else
          newState |= charStates.MOVE
        end
      elseif (Inputs:CheckMoveForwardInput(self)) then
        newState |= charStates.FORWARD

        if (self:IsRunning()) then
          newState |= charStates.RUN
        else
          newState |= charStates.MOVE
        end
      end

      self:SetState(newState)

      return true
    end
  end

  -- From here on out, we're checking if the character can move.
  -- If they can't, exit early.
  if (not tileProperties.moveCancellable) then
    return false
  end

  if (not self:IsCrouching()) then
    -- Dash/Run check
    if (not self:IsDashing() and not self:IsRunning()) then
      if (Inputs:CheckDashBackInput(self)) then
        self:SetState(charStates.DASH | charStates.BEGIN | charStates.BACK)

        return true
      elseif (Inputs:CheckDashForwardInput(self)) then
        -- TODO: We're temporarily using RUN as the DASH,
        -- until we can figure out how to better differentiate the DASH and RUN inputs.
        self:SetState(charStates.RUN | charStates.BEGIN | charStates.FORWARD)

        return true
      end
    end

    -- Move check
    if (not self:IsDashing() and not self:IsMoving() and not self:IsRunning()) then
      if (Inputs:CheckMoveBackInput(self)) then
        self:SetState(charStates.MOVE | charStates.BACK)

        return true
      elseif (Inputs:CheckMoveForwardInput(self)) then
        self:SetState(charStates.MOVE | charStates.FORWARD)

        return true
      end
    end

    -- Crouch check
    if (not self:IsDashing()) then
      if (Inputs:CheckCrouchInput(self)) then
        self:SetState(charStates.CROUCH)

        return true
      end
    end

    -- Stand checks
    if (self:IsMoving() or self:IsRunning()) then
      if (buttonState.hasReleasedBack) then
        self:SetState(charStates.STAND)

        return true
      elseif (buttonState.hasReleasedForward) then
        self:SetState(charStates.STAND)

        return true
      end
    end
  else
    -- Stand check
    if (buttonState.hasReleasedDown) then
      self:SetState(charStates.STAND)

      return true
    end
  end
end

function Character:CheckSpecialInputs()
  -- Overload this on each Character's class!
end

function Character:DeriveImageTableFromState()
  local filteredState <const> = self:GetFilteredStateForTilesets()

  self.history:MutateTick({
    -- TODO: Why 0...?
    frameCounter = 0,
    frameIndex = 1,
  })
  self.imageTable = self.imageTables[filteredState]
end

function Character:DerivePhysicsFromCurrentFrame()
  local frame <const> = self.history:GetFrame()
  local newVelocity <const> = table.deepcopy(frame.velocity)
  local properties <const> = self:GetTileProperties(frame.frameIndex)

  if (properties.velocityX ~= nil) then
    local flipSign <const> = self:GetFlipSign()
    -- local moveSign <const> = self:IsBack() and -1 or 1

    -- newVelocity.x = properties.velocityX * moveSign * flipSign
    newVelocity.x = properties.velocityX * flipSign
  end
  
  if (properties.velocityY ~= nil) then
    newVelocity.y = properties.velocityY
  end

  self.history:MutateTick({
    velocity = newVelocity
  })
end

function Character:DerivePhysicsFromState()
  local frame <const> = self.history:GetFrame()
  local newVelocity <const> = table.deepcopy(frame.velocity)

  -- X Velocity
  if (self:IsRunning() and not self:IsTransitioning()) then
    newVelocity.x = self:GetRunVelocityX()
  elseif (self:IsDashing() and not self:IsTransitioning()) then
    newVelocity.x = self:GetDashVelocityX()
  elseif (self:IsMoving() and not self:IsTransitioning()) then
    newVelocity.x = self:GetMoveVelocityX()
  elseif (self:IsCrouching() or self:IsStanding() or self:IsTransitioning()) then
    newVelocity.x = 0
  end

  -- Y Velocity
  if (self:IsJumping() and not self:IsAttacking() and not self:IsTransitioning()) then
    newVelocity.y = -self.jumpHeight
  elseif (self:IsCrouching() or self:IsStanding() or self:IsTransitioning()) then
    newVelocity.y = 0
  end

  self.history:MutateTick({
    velocity = newVelocity
  })

  self:DerivePhysicsFromCurrentFrame()
end

function Character:GetBackAndForwardInputs()
  local frame <const> = self.history:GetFrame()

  if (frame.direction == charDirections.LEFT) then
    return pd.kButtonRight, pd.kButtonLeft
  end

  return pd.kButtonLeft, pd.kButtonRight
end

-- "self:getCollideRect()" returns the collide rect relative to the position of the sprite bounds.
-- This returns the collide rect relative to the position of the screen.
function Character:GetCollideRectRelativeToScreen()
  local boundsRect <const> = self:getBoundsRect()
  local collideRect <const> = self:getCollideRect():copy()

  collideRect.x += boundsRect.x
  collideRect.y += boundsRect.y

  return collideRect
end

function Character:GetDashVelocityX()
  return self:NormalizeMovementVelocityX(self.dashSpeed)
end

-- To reduce the complexity of tileset keys, we want to remove certain states
-- under certain conditions.
function Character:GetFilteredStateForTilesets()
  local frame <const> = self.history:GetFrame()
  local statesToRemove = 0

  -- Attacking is not visually affected by dashing... yet.
  -- Jumping is not visually affected by dashing.
  if (self:IsAttacking() or self:IsJumping()) then
    statesToRemove |= charStates.DASH | charStates.MOVE | charStates.RUN
  end

  -- The only thing visually effected by being airborne
  -- is getting hurt in mid-air.
  if (not self:IsHurt()) then
    statesToRemove |= charStates.AIRBORNE
  end

  -- There's currently only one possible transition tileset,
  -- so we don't need to distinguish between back/forward movement.
  if (self:IsTransitioning()) then
    statesToRemove |= charStates.BACK | charStates.FORWARD
  end

  return frame.state &~ statesToRemove
end

function Character:GetFlip()
  return self:IsFlipped() and gfx.kImageFlippedX or gfx.kImageUnflipped
end

function Character:GetFlipSign()
  return self:IsFlipped() and -1 or 1
end

function Character:GetHitByBall(hurtbox, ball)
  local newState = charStates.HURT

  if (self:IsAirborne()) then
    newState |= charStates.AIRBORNE
  elseif (
    self:IsMoving() or
    self:IsStanding() or
    self:IsTransitioning()
  ) then
    newState |= charStates.STAND
  elseif (self:IsCrouching()) then
    newState |= charStates.CROUCH
  else
    newState |= charStates.STAND
  end

  self:SetState(newState)

  gfx.sprite.removeSprites({ hurtbox })
end

function Character:GetMoveVelocityX()
  return self:NormalizeMovementVelocityX(self.speed)
end

function Character:GetPushboxRectForFrameIndex(frameIndex)
  local boundsRect <const> = self:getBoundsRect()
  local tile <const> = self:GetTile(frameIndex)
  local x <const> = boundsRect.x + tile.collisions.Pushbox.x
  local y <const> = boundsRect.y + tile.collisions.Pushbox.y

  return geo.rect.new(x, y, tile.collisions.Pushbox.width, tile.collisions.Pushbox.height)
end

function Character:GetRunVelocityX()
  return self:NormalizeMovementVelocityX(self.runSpeed)
end

function Character:GetTile(index)
  local tileset <const> = self:GetTilesetForCurrentState()

  return tileset.tiles[index]
end

function Character:GetTileProperties(index)
  local tile <const> = self:GetTile(index)

  return tile.properties
end

function Character:GetTilesetProperties()
  local tileset <const> = self:GetTilesetForCurrentState()

  return tileset.properties
end

function Character:GetTilesetForCurrentState()
  local state <const> = self:GetFilteredStateForTilesets()

  return self.tilesets[state]
end

function Character:HitBall(collision, hitbox, ball)
  local properties <const> = hitbox.collisionProperties

  -- print(collision.normal)

  if (
    properties.velocityX ~= nil
    -- and collision.normal.x ~= 0
  ) then
    local flipSign <const> = self:GetFlipSign()
    local velocityX <const> = properties.velocityX * flipSign

    ball:SetVelocityX(velocityX)
  end

  if (
    properties.velocityY ~= nil
    -- and collision.normal.y ~= 0
  ) then
    local velocityY <const> = properties.velocityY

    ball:SetVelocityY(velocityY)
  end

  gfx.sprite.removeSprites({ hitbox })
end

function Character:HandleBallCollision(collision, sprite, ball)
  local spriteGroupMask <const> = sprite:getGroupMask()
  local spriteIsHitbox <const> = spriteGroupMask & collisionTypes.HITBOX ~= 0
  local spriteIsHurtbox <const> = spriteGroupMask & collisionTypes.HURTBOX ~= 0

  if (spriteIsHitbox) then
    self:HitBall(collision, sprite, ball)
  elseif (spriteIsHurtbox) then
    if (ball:IsDangerous()) then
      self:GetHitByBall(sprite, ball)

      -- if (collision.normal.x == -1) then
      --   local attemptedPositionX <const> = collision.spriteRect.x + collision.spriteRect.width
      --   local newPositionX <const> = math.min(attemptedPositionX, 400)

      --   other:moveTo(newPositionX, other.y)
      -- elseif (collision.normal.x == 1) then
      --   local attemptedPositionX <const> = collision.spriteRect.x - other.width
      --   local newPositionX <const> = math.max(attemptedPositionX, 0)

      --   other:moveTo(newPositionX, other.y)
      -- end

      -- if (collision.normal.y == -1) then
      --   local attemptedPositionY <const> = collision.spriteRect.y - other.height
      --   local newPositionY <const> = math.min(attemptedPositionY, 240)

      --   other:moveTo(other.x, newPositionY)
      -- elseif (collision.normal.y == 1) then
      --   local attemptedPositionY <const> = collision.spriteRect.y - other.height
      --   local newPositionY <const> = math.max(attemptedPositionY, 0)

      --   other:moveTo(other.x, newPositionY)
      -- end
    end
  end
end

function Character:HandleCollisions(collisions)
  for i, collision in ipairs(collisions) do
    local other <const> = collision.other
    local otherGroupMask <const> = other:getGroupMask()
    local collidedWithBall = otherGroupMask & collisionTypes.BALL ~= 0
    local collidedWithWall = otherGroupMask & collisionTypes.WALL ~= 0

    if (collidedWithBall) then
      self:HandleBallCollision(collision, collision.sprite, other)
    elseif (collidedWithWall) then
      self:HandleWallCollision(collision)
    end
  end
end

function Character:HandleWallCollision(collision)
  local frame <const> = self.history:GetFrame()
  local newVelocity <const> = table.deepcopy(frame.velocity)

  if (collision.normal.x ~= 0) then
    newVelocity.x = 0
  end

  if (collision.normal.y ~= 0) then
    newVelocity.y = 0

    if (collision.normal.y == -1) then
      if (self:IsFalling() and not self:IsTransitioning()) then
        if (self:IsHurt()) then
          self:SetState(charStates.HURT | charStates.JUMP | charStates.END)
        else
          self:SetState(charStates.JUMP | charStates.END)
        end
      end
    end
  end

  self.history:MutateTick({
    position = {
      x = self.x,
      y = self.y,
    },
    pushboxRect = self:GetCollideRectRelativeToScreen(),
    velocity = newVelocity
  })
end

function Character:HasAnimationEnded()
  local frame <const> = self.history:GetFrame()

  return frame.frameIndex == self.imageTable:getLength()
end

function Character:HasAnimationFrameEnded()
  local frame <const> = self.history:GetFrame()
  local tileProperties <const> = self:GetTileProperties(frame.frameIndex)

  return frame.frameCounter == tileProperties.frameDuration
end

function Character:HasDirectionChanged()
  local current <const> = self.history:GetFrame()
  local prev <const> = self.history:GetFrame(self.history.counter - 1)

  if (prev == nil) then
    return false
  end

  -- print('Prev:' .. prev.direction, 'Next:' .. current.direction, current.direction ~= prev.direction)

  return current.direction ~= prev.direction
end

function Character:HasFrameIndexChanged()
  local current <const> = self.history:GetFrame()
  local prev <const> = self.history:GetFrame(self.history.counter - 1)

  -- print(prev ~= nil and prev.frameIndex or 1, current.frameIndex)

  if (prev == nil) then
    return false
  end

  return prev.frameIndex ~= current.frameIndex
end

function Character:HasStateChanged()
  local current <const> = self.history:GetFrame()
  local prev <const> = self.history:GetFrame(self.history.counter - 1)

  if (prev == nil) then
    return false
  end

  -- print('Prev:' .. prev.state, 'Next:' .. current.state, current.state ~= prev.state)

  return current.state ~= prev.state
end

function Character:HydrateImageTable(tileset)
  local imageTable <const> = gfx.imagetable.new(#tileset.tiles)
  local images <const> = {}

  for i, tile in ipairs(tileset.tiles) do
    local image
    local imagePath = tile.image
    -- Chop off the "../" and ".png"
    imagePath = string.gsub(imagePath, '%.%./', '')
    imagePath = string.gsub(imagePath, '%.png', '')

    if (images[imagePath] ~= nil) then
      image = images[imagePath]
    else
      image = gfx.image.new(imagePath)
      images[imagePath] = image
    end

    imageTable:setImage(i, image)
  end

  return imageTable
end

function Character:IsAirborne()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.AIRBORNE ~= 0
end

function Character:IsAttacking()
  return self:IsKicking() or self:IsPunching() or self:IsSpecialing()
end

function Character:IsBack()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.BACK ~= 0
end

function Character:IsBeginning()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.BEGIN ~= 0
end

function Character:IsCrouching(exclusive)
  local frame <const> = self.history:GetFrame()
  local isExclusive <const> = exclusive or false

  if (isExclusive) then
    return frame.state == charStates.CROUCH
  end

  return frame.state & charStates.CROUCH ~= 0
end

function Character:IsDashing()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.DASH ~= 0
end

function Character:IsDown()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.DOWN ~= 0
end

function Character:IsEnding()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.END ~= 0
end

function Character:IsFalling()
  local frame <const> = self.history:GetFrame()

  -- Since gravity is always being applied, we need to check above it.
  return self:IsAirborne() and frame.velocity.y > self.gravity
end

function Character:IsFlipped()
  local frame <const> = self.history:GetFrame()

  if (frame == nil) then
    return false
  end

  return frame.direction == charDirections.LEFT
end

function Character:IsForward()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.FORWARD ~= 0
end

function Character:IsHurt()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.HURT ~= 0
end

function Character:IsJumping()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.JUMP ~= 0
end

function Character:IsKicking()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.KICK ~= 0
end

function Character:IsKnockedDown()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.KNOCKDOWN ~= 0
end

function Character:IsMoving()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.MOVE ~= 0
end

function Character:IsPunching()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.PUNCH ~= 0
end

function Character:IsRising()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.RISE ~= 0
end

function Character:IsRunning()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.RUN ~= 0
end

-- TODO: Find a better name for this LOL
function Character:IsSpecialing()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.SPECIAL ~= 0
end

function Character:IsStanding(exclusive)
  local frame <const> = self.history:GetFrame()
  local isExclusive <const> = exclusive or false

  if (isExclusive) then
    return frame.state == charStates.STAND
  end

  return frame.state & charStates.STAND ~= 0
end

function Character:IsTransitioning()
  return self:IsBeginning() or self:IsEnding()
end

function Character:IsUp()
  local frame <const> = self.history:GetFrame()

  return frame.state & charStates.UP ~= 0
end

function Character:Load()
  self:LoadTilesets()
  self:LoadImageTables()
end

function Character:HydrateTileset(tileset)
  local tiles = {}

  for i, tile in ipairs(tileset.tiles) do
    tile.collisions = ConvertCollisionsArrayToTable(tile.objectgroup.objects)
    tile.properties = ConvertCustomPropertiesToTable(tile.properties or {})

    tiles[i] = tile
  end

  tileset.properties = ConvertCustomPropertiesToTable(tileset.properties or {})
  tileset.tiles = tiles

  return tileset
end

function Character:LoadImageTables()
  for key, tileset in pairs(self.tilesets) do
    self.imageTables[key] = self:HydrateImageTable(tileset)
  end
end

function Character:LoadTilesets()
  local dashBackTileset <const> = self:HydrateTileset(self:LoadTSJ('DashBack'))
  local dashForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('DashForward'))
  local hurtAirborneTileset <const> = self:HydrateTileset(self:LoadTSJ('HurtAirborne'))
  local hurtCrouchTileset <const> = self:HydrateTileset(self:LoadTSJ('HurtCrouch'))
  local hurtTileset <const> = self:HydrateTileset(self:LoadTSJ('Hurt'))
  local moveBackTileset <const> = self:HydrateTileset(self:LoadTSJ('MoveBack'))
  local moveForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('MoveForward'))
  local jumpBackTileset <const> = self:HydrateTileset(self:LoadTSJ('JumpBack'))
  local jumpForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('JumpForward'))
  local jumpNeutralTileset <const> = self:HydrateTileset(self:LoadTSJ('JumpNeutral'))
  local kickJumpForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('KickJumpForward'))
  local kickJumpNeutralTileset <const> = self:HydrateTileset(self:LoadTSJ('KickJumpNeutral'))
  local kickForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('KickForward'))
  local kickNeutralTileset <const> = self:HydrateTileset(self:LoadTSJ('KickNeutral'))
  local kickBackTileset <const> = self:HydrateTileset(self:LoadTSJ('KickBack'))
  local punchForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('PunchForward'))
  local punchJumpForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('PunchJumpForward'))
  local transitionTileset <const> = self:HydrateTileset(self:LoadTSJ('Transition'))

  self.tilesets = {
    -- Attacking ???
    -- [charStates.ATTACK] = self:HydrateTileset(self:LoadTSJ('Crouch')),

    -- Crouching
    [charStates.CROUCH] = self:HydrateTileset(self:LoadTSJ('Crouch')),

    -- Dashing
    [charStates.DASH | charStates.BACK] = dashBackTileset,
    [charStates.DASH | charStates.BEGIN] = transitionTileset,
    [charStates.DASH | charStates.END] = transitionTileset,
    [charStates.DASH | charStates.FORWARD] = dashForwardTileset,

    -- Hurting
    [charStates.HURT | charStates.AIRBORNE] = hurtAirborneTileset,
    [charStates.HURT | charStates.CROUCH] = hurtCrouchTileset,
    [charStates.HURT | charStates.JUMP | charStates.END] = self:HydrateTileset(self:LoadTSJ('TransitionHurtJump')),
    [charStates.HURT | charStates.STAND] = hurtTileset,

    -- Kicking
    [charStates.KICK | charStates.CROUCH] = self:HydrateTileset(self:LoadTSJ('KickCrouch')),
    [charStates.KICK | charStates.JUMP] = kickJumpNeutralTileset,
    [charStates.KICK | charStates.JUMP | charStates.BACK] = kickJumpForwardTileset,
    [charStates.KICK | charStates.JUMP | charStates.FORWARD] = kickJumpForwardTileset,
    [charStates.KICK | charStates.STAND] = kickNeutralTileset,
    [charStates.KICK | charStates.STAND | charStates.BACK] = kickBackTileset,
    [charStates.KICK | charStates.STAND | charStates.FORWARD] = kickForwardTileset,

    -- Knockdown
    [charStates.KNOCKDOWN] = self:HydrateTileset(self:LoadTSJ('Knockdown')),

    -- Jumping
    [charStates.JUMP] = jumpNeutralTileset,
    [charStates.JUMP | charStates.BACK] = jumpBackTileset,
    [charStates.JUMP | charStates.BEGIN] = transitionTileset,
    [charStates.JUMP | charStates.END] = transitionTileset,
    [charStates.JUMP | charStates.FORWARD] = jumpForwardTileset,

    -- Moving
    [charStates.MOVE | charStates.BACK] = moveBackTileset,
    [charStates.MOVE | charStates.FORWARD] = moveForwardTileset,

    -- Punching
    [charStates.PUNCH | charStates.CROUCH] = self:HydrateTileset(self:LoadTSJ('PunchCrouch')),
    [charStates.PUNCH | charStates.JUMP | charStates.BACK] = punchJumpForwardTileset,
    [charStates.PUNCH | charStates.JUMP | charStates.FORWARD] = punchJumpForwardTileset,
    [charStates.PUNCH | charStates.JUMP] = punchJumpForwardTileset,
    [charStates.PUNCH | charStates.STAND] = punchForwardTileset,

    -- Rising
    [charStates.RISE] = self:HydrateTileset(self:LoadTSJ('Rise')),

    -- Running
    [charStates.RUN | charStates.BEGIN] = transitionTileset,
    [charStates.RUN | charStates.END] = transitionTileset,
    [charStates.RUN | charStates.FORWARD] = self:HydrateTileset(self:LoadTSJ('Run')),

    -- Standing
    [charStates.STAND] = self:HydrateTileset(self:LoadTSJ('Stand')),
  }
end

function Character:LoadTSJ(state)
  local filePath = 'tsj/' .. self.name .. '/' .. self.name .. state .. '.tsj'

  return json.decodeFile(filePath)
end

function Character:MoveEmptyCollisionSprites()
  local frame <const> = self.history:GetFrame()

  for i, sprite in ipairs(self.emptyCollisionSprites) do
    local _actualX <const>, _actualY <const>, collisions <const> = sprite:moveWithCollisions(
      sprite.x + frame.velocity.x,
      sprite.y + frame.velocity.y
    )

    self:HandleCollisions(collisions)
  end
end

function Character:MoveSelf()
  local frame <const> = self.history:GetFrame()
  local _actualX <const>, _actualY <const>, collisions <const> = self:moveWithCollisions(
    self.x + frame.velocity.x,
    self.y + frame.velocity.y
  )

  self:HandleCollisions(collisions)

  self.history:MutateTick({
    pushboxRect = self:GetCollideRectRelativeToScreen(),
    position = {
      x = self.x,
      y = self.y,
    },
  })
end

function Character:NormalizeMovementVelocityX(velocityX)
  local flipSign <const> = self:GetFlipSign()
  local moveSign <const> = self:IsBack() and -1 or
    self:IsForward() and 1 or 0

  return velocityX * flipSign * moveSign
end

function Character:PrepareForNextLoop()
  self.history:Tick()
  self:UpdateFrameIndex()
end

function Character:Reset()
  self:ResetPosition()
  self:ResetState()
end

function Character:ResetPosition()
  self:moveTo(self.startingPosition.x, self.startingPosition.y)
end

function Character:ResetState()
  self.history:Reset()
  self:SetState(charStates.STAND)
end

function Character:SetAnimationFrame()
  self:SetFrameImage()
  -- self:UpdatePushboxPosition()
  self:SetFrameCollisions()
end

function Character:SetCollisionBox(collision)
  local collidesWithGroupMasks <const> = {
    Hitbox = collisionTypes.BALL,
    Hurtbox = collisionTypes.BALL,
  }
  local flip <const> = self:GetFlip()
  local groupMasks <const> = {
    Hitbox = collisionTypes.HITBOX,
    Hurtbox = collisionTypes.HURTBOX,
  }
  -- Setting an empty collision sprite is not center-aware, so we need a bit of math.
  local collisionX <const> = (self.x - (self.width / 2)) + collision.x
  local collisionY <const> = (self.y - self.height) + collision.y
  local collideRect <const> = geo.rect.new(
    collisionX,
    collisionY,
    collision.width,
    collision.height
  )

  collideRect:flipRelativeToRect(self:getBoundsRect(), flip)

  local sprite <const> = self.addEmptyCollisionSprite(collideRect)
  sprite.collisionProperties = collision.properties
  sprite.parent = self
  sprite:setCollidesWithGroupsMask(collidesWithGroupMasks[collision.class])
  sprite:setGroupMask(groupMasks[collision.class])
  sprite:setImageFlip(flip, true)

  table.insert(self.emptyCollisionSprites, sprite)
end

function Character:SetFrameCollisions()
  local frame <const> = self.history:GetFrame()
  local nextTile <const> = self:GetTile(frame.frameIndex)

  gfx.sprite.removeSprites(self.emptyCollisionSprites)
  self.emptyCollisionSprites = {}

  self:SetPushbox(nextTile.collisions.Pushbox)

  for _, collision in ipairs(nextTile.collisions.Hitboxes) do
    self:SetCollisionBox(collision)
  end

  for _, collision in ipairs(nextTile.collisions.Hurtboxes) do
    self:SetCollisionBox(collision)
  end
end

function Character:SetFrameImage()
  local frame <const> = self.history:GetFrame()
  local nextImage <const> = self.imageTable:getImage(frame.frameIndex)

  self:setImage(nextImage)

  -- This won't flip the image when we're in a single-frame looping animation, like crouching.
  -- To account for that, we are also setting the image flip during "UpdateDirection()".
  self:setImageFlip(self:GetFlip(), true)
end

function Character:SetPushbox(pushbox)
  -- Setting the collide rect is center-aware, so no need for any math or "self:GetPushboxRectForFrameIndex()".
  local pushboxRect <const> = geo.rect.new(
    pushbox.x,
    pushbox.y,
    pushbox.width,
    pushbox.height
  )

  self:setCollideRect(pushboxRect)
  self:setCollidesWithGroupsMask(collisionTypes.WALL)
  self:setGroupMask(collisionTypes.PUSHBOX)
  self:UpdatePushboxPosition()
end

function Character:SetState(state)
  -- local keyset = {}

  -- for k, v in pairs(charStates) do
  --   keyset[v] = k
  -- end

  -- print('SetState()', keyset[state], state)

  self.history:MutateTick({
    state = state,
  })

  self:DeriveImageTableFromState()
  self:SetAnimationFrame()
  self:DerivePhysicsFromState()
end

function Character:TransitionState()
  if (self:HasDirectionChanged()) then
    if (self:IsMoving()) then
      if (self:IsForward()) then
        self:SetState(charStates.MOVE | charStates.BACK)
      else
        self:SetState(charStates.MOVE | charStates.FORWARD)
      end
    end
  end

  if (not self:HasAnimationFrameEnded() or not self:HasAnimationEnded()) then
    return
  end

  local frame <const> = self.history:GetFrame()
  local tileProperties <const> = self:GetTileProperties(frame.frameIndex)
  local tilesetProperties <const> = self:GetTilesetProperties()
  local loops = tilesetProperties.loops or tileProperties.loops

  -- Beginning and ending checks should come first

  if (self:IsBeginning()) then
    local statesToRemove <const> = charStates.BEGIN

    if (self:IsDashing()) then
      local newState = frame.state &~ statesToRemove

      self:SetState(newState)

      return
    end

    local newState = frame.state &~ statesToRemove

    self:SetState(newState)

    return
  end

  if (self:IsEnding()) then
    local statesToRemove <const> = charStates.END

    if (self:IsDashing()) then
      self:SetState(charStates.STAND)

      return
    end

    if (self:IsHurt()) then
      self:SetState(charStates.KNOCKDOWN)

      return
    end

    if (self:IsJumping()) then
      self:SetState(charStates.STAND)

      return
    end

    local newState = frame.state &~ statesToRemove

    self:SetState(newState)

    return
  end

  if (self:IsDashing()) then
    local newState = frame.state | charStates.END

    self:SetState(newState)

    return
  end

  if (self:IsKnockedDown()) then
    self:SetState(charStates.RISE)

    return
  end

  if (self:IsRising()) then
    self:SetState(charStates.STAND)

    return
  end

  if (not loops) then
    self:SetState(charStates.STAND)

    return
  end
end

function Character:UpdateAnimationFrame()
  if (self:HasFrameIndexChanged()) then
    self:SetAnimationFrame()
  end
end

function Character:UpdateButtonStates()
  self.history:MutateTick({
    buttonState = { pd.getButtonState() }
  })
end

function Character:UpdateDirection()
  local frame <const> = self.history:GetFrame()
  local opponentCenter <const> = self.opponent:getBoundsRect():centerPoint()
  local selfCenter <const> = self:getBoundsRect():centerPoint()

  if (
    self:IsAttacking() or
    self:IsJumping() or
    self:IsRunning()
  ) then
    return
  end

  if (
    opponentCenter.x > selfCenter.x and
    frame.direction ~= charDirections.RIGHT
  ) then
    self.history:MutateTick({
      direction = charDirections.RIGHT
    })
    self:setImageFlip(self:GetFlip(), true)
  elseif (
    opponentCenter.x < selfCenter.x and
    frame.direction ~= charDirections.LEFT
  ) then
    self.history:MutateTick({
      direction = charDirections.LEFT
    })
    self:setImageFlip(self:GetFlip(), true)
  end
end

function Character:UpdateFrameIndex()
  local nextFrame <const> = self.history:GetFrame()

  self.history:MutateTick({
    frameCounter = nextFrame.frameCounter + 1
  })

  local tileProperties <const> = self:GetTileProperties(nextFrame.frameIndex)
  local shouldUpdateFrameIndex <const> = nextFrame.frameCounter > tileProperties.frameDuration

  if (not shouldUpdateFrameIndex) then
    return
  end

  local tilesetProperties <const> = self:GetTilesetProperties()
  local nextFrameIndex = nextFrame.frameIndex

  if (not self:HasAnimationEnded()) then
    nextFrameIndex += 1
  elseif (self:HasAnimationEnded() and tilesetProperties.loops) then
    nextFrameIndex = 1
  end

  self.history:MutateTick({
    frameCounter = 1,
    frameIndex = nextFrameIndex,
  })

  -- print('UpdateFrameIndex()', nextState.frameCounter, nextState.frameIndex)
end

function Character:UpdateFrozenSprite()
  local filteredState <const> = self:GetFilteredStateForTilesets()
  local frame <const> = self.history:GetFrame()

  self.imageTable = self.imageTables[filteredState]
  self:SetFrameImage()
  self:moveTo(frame.position.x, frame.position.y)
end

function Character:UpdatePhysics()
  local frame <const> = self.history:GetFrame()
  local newVelocity <const> = table.deepcopy(frame.velocity)

  -- Apply drag
  -- if (math.abs(state.velocity.x) > 0) then
  --   -- TODO: Implement drag based on stage weather...?
  --   self:ChangeVelocityX(self.drag, false)
  -- end

  -- Apply gravity
  newVelocity.y += self.gravity

  self.history:MutateTick({
    velocity = newVelocity
  })
  self:DerivePhysicsFromCurrentFrame()

  -- print(state.velocity.x, state.velocity.y)
end

function Character:UpdatePosition()
  if (not self:IsBeginning() and not self:IsEnding()) then
    self:MoveSelf()
    self:MoveEmptyCollisionSprites()
  end
end

function Character:UpdatePushboxPosition()
  local frame <const> = self.history:GetFrame()
  local newPosition = {
    x = self.x,
    y = self.y,
  }
  local nextPushboxRect <const> = self:GetPushboxRectForFrameIndex(frame.frameIndex)
  local prevPushboxRect <const> = (frame.pushboxRect or nextPushboxRect):copy()

  if (prevPushboxRect ~= nil) then
    local flipSign <const> = self:GetFlipSign()
    local nextPushboxCenter <const> = nextPushboxRect:centerPoint()
    local prevPushboxCenter <const> = prevPushboxRect:centerPoint()
    local x <const> = (prevPushboxCenter.x - nextPushboxCenter.x) * flipSign
    local y <const> = prevPushboxCenter.y - nextPushboxCenter.y

    newPosition.x += x
    newPosition.y += y
    nextPushboxRect.x += x
    nextPushboxRect.y += y
  end

  self.history:MutateTick({
    pushboxRect = nextPushboxRect
  })
  self:moveTo(newPosition.x, newPosition.y)
end
