import 'CoreLibs/animation'
import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'collisionTypes'
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
  ATTACK = 1,
  ATTACK_NEUTRAL = 2,
  BACK = 4,
  BEGIN = 8,
  BLOCK = 16,
  CROUCH = 32,
  DASH = 64,
  DOWN = 128,
  END = 256,
  FORWARD = 512,
  HURT = 1024,
  JUMP = 2048,
  KICK = 4096,
  KNOCKDOWN = 8192,
  MOVE = 16384,
  PARRY = 32768,
  PUNCH = 65536,
  RISE = 131072,
  RUN = 262144,
  SPECIAL = 524288,
  STAND = 1048576,
  TAUNT = 2097152,
  UP = 4194304,
}

-- 8388608
-- 16777216
-- 33554432

local defaults <const> = {
  canDoubleJump = false,
  counter = 1,
  dashSpeed = 8,
  drag = 1,
  emptyCollisionSprites = {},
  gravity = 1,
  imageTables = {},
  jumpHeight = 12,
  name = 'Character',
  runSpeed = 10,
  speed = 4,
  startingPosition = {
    x = 0,
    y = 0,
  },
  states = {
    {
      buttonState = {},
      direction = charDirections.RIGHT,
      imageTableIndex = 1,
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
    },
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
  self.jumpHeight = config.jumpHeight or self.jumpHeight
  self.name = config.name or self.name
  self.opponent = config.opponent or self.opponent
  self.speed = config.speed or self.speed
  self.startingPosition = config.startingPosition or self.startingPosition
  self.states = config.states or self.states

  -- self:tableDump()

  self:Load()
  self:moveTo(self.startingPosition.x, self.startingPosition.y)
  self:setCenter(0.5, 1)
  self:SetState(charStates.STAND)
end

function Character:update()
  local state <const> = self.states[self.counter]

  self:CheckCrank()

  if (self.frozen == true) then
    self:UpdateFrozenSprite()

    return
  end

  self:TransitionState()
  self:UpdateDirection()
  self:UpdateButtonStates()
  self:CheckInputs()
  self:UpdateAnimation()
  self:UpdatePhysics()
  self:UpdatePosition()

  self.counter += 1
  self.states[self.counter] = table.deepcopy(state)
end

function Character:UpdateFrozenSprite()
  local filteredState <const> = self:GetFilteredStateForTilesets()
  local state <const> = self.states[self.counter]

  self.imageTable = self.imageTables[filteredState]
  self:UpdateImage()
  self:moveTo(state.position.x, state.position.y)
end

-- function Character:ChangeVelocityX(x, isIncrease)
--   local changeSign = isIncrease ~= false and 1 or -1
--   local state <const> = self.states[self.counter]
--   local newVelocity = state.velocity.x
--   local velocitySign <const> = Sign(state.velocity.x)

--   if (x ~= nil) then
--     newVelocity = math.abs(state.velocity.x) + (x * changeSign)

--     if (velocitySign ~= 0) then
--       newVelocity *= velocitySign
--     end
--   end

--   state.velocity.x = newVelocity
-- end

-- function Character:ChangeVelocityY(y, isIncrease)
--   local changeSign = isIncrease ~= false and 1 or -1
--   local state <const> = self.states[self.counter]
--   local newVelocity = state.velocity.y
--   local velocitySign <const> = Sign(state.velocity.y)

--   if (y ~= nil) then
--     newVelocity = math.abs(state.velocity.y) + (y * changeSign)

--     if (velocitySign ~= 0) then
--       newVelocity *= velocitySign
--     end
--   end

--   state.velocity.y = newVelocity
-- end

-- TODO: Buddy, you gotta decouple your logic so that you draw based on a state simulation
function Character:CheckCrank()
  if (pd.isCrankDocked()) then
    self.frozen = false

    return
  end

  local change <const>, acceleratedChange <const> = pd.getCrankChange()

  if (acceleratedChange ~= 0) then
    local delta <const> = math.floor(self.counter + change)

    print(change, acceleratedChange, self.counter, delta)

    if (delta > 0 and delta < #self.states) then
      self.counter = delta
    end
  end
end

function Character:CheckInputs()
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
  local state <const> = self.states[self.counter]
  local tileProperties <const> = self:GetTileProperties(state.imageTableIndex)

  -- If we can't perform an attack, exit early.
  if (not tileProperties.attackCancellable) then
    return
  end

  local backInput <const>, forwardInput <const> = self:GetBackAndForwardInputs()
  local current <const>, pressed <const>, released <const> = table.unpack(state.buttonState)

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
      newState |= charStates.JUMP

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
    -- TODO: Separate state for running?
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
      newState |= charStates.JUMP

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
    -- TODO: Separate state for running?
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
  local state <const> = self.states[self.counter]
  local tileProperties <const> = self:GetTileProperties(state.imageTableIndex)

  -- Jump check
  if (tileProperties.jumpCancellable and not self:IsJumping()) then
    if (Inputs:CheckJumpInput(self)) then
      local newState = charStates.JUMP | charStates.BEGIN

      if (self:IsBack()) then
        newState |= charStates.BACK
      elseif (self:IsForward()) then
        newState |= charStates.FORWARD
      end

      if (self:IsRunning()) then
        newState |= charStates.RUN
      elseif (self:IsMoving()) then
        newState |= charStates.MOVE
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
  local state <const> = self.states[self.counter]

  -- print('DeriveImageTableFromState', state)

  self.imageTable = self.imageTables[filteredState]
  state.imageTableIndex = 1
end

function Character:DerivePhysicsFromCurrentFrame()
  local state <const> = self.states[self.counter]
  local properties <const> = self:GetTileProperties(state.imageTableIndex)

  if (properties.velocityX ~= nil) then
    local flipSign <const> = self:IsFlipped() and -1 or 1
    -- local moveSign <const> = self:IsBack() and -1 or 1

    -- state.velocity.x = properties.velocityX * moveSign * flipSign
    state.velocity.x = properties.velocityX * flipSign
  end

  if (properties.velocityY ~= nil) then
    state.velocity.y = properties.velocityY
  end
end

function Character:DerivePhysicsFromState()
  local state <const> = self.states[self.counter]

  -- X Velocity
  if (self:IsRunning() and not self:IsTransitioning()) then
    state.velocity.x = self:GetRunVelocityX()
  elseif (self:IsDashing() and not self:IsTransitioning()) then
    state.velocity.x = self:GetDashVelocityX()
  elseif (self:IsMoving() and not self:IsTransitioning()) then
    state.velocity.x = self:GetMoveVelocityX()
  elseif (self:IsCrouching() or self:IsStanding() or self:IsTransitioning()) then
    state.velocity.x = 0
  end

  -- Y Velocity
  if (self:IsJumping() and not self:IsAttacking() and not self:IsTransitioning()) then
    state.velocity.y = -self.jumpHeight
  elseif (self:IsCrouching() or self:IsStanding() or self:IsTransitioning()) then
    state.velocity.y = 0
  end

  self:DerivePhysicsFromCurrentFrame()
end

function Character:GetBackAndForwardInputs()
  local state <const> = self.states[self.counter]

  if (state.direction == charDirections.LEFT) then
    return pd.kButtonRight, pd.kButtonLeft
  end

  return pd.kButtonLeft, pd.kButtonRight
end

function Character:GetDashVelocityX()
  return self:NormalizeMovementVelocityX(self.dashSpeed)
end

-- To reduce the complexity of tileset keys, we want to remove certain states
-- under certain conditions.
function Character:GetFilteredStateForTilesets()
  local state <const> = self.states[self.counter]
  local statesToRemove = 0

  -- Attacking is not visually affected by dashing... yet.
  -- Jumping is not visually affected by dashing.
  if (self:IsAttacking() or self:IsJumping()) then
    statesToRemove |= charStates.DASH | charStates.MOVE | charStates.RUN
  end

  -- There's currently only one possible transition tileset,
  -- so we don't need to distinguish between back/forward movement.
  if (self:IsTransitioning()) then
    statesToRemove |= charStates.BACK | charStates.FORWARD
  end

  return state.state &~ statesToRemove
end

function Character:GetFlip()
  return self:IsFlipped() and gfx.kImageFlippedX or gfx.kImageUnflipped
end

function Character:GetMoveVelocityX()
  return self:NormalizeMovementVelocityX(self.speed)
end

function Character:GetPushboxRectForFrame(frame)
  local bounds <const> = self:getBoundsRect()
  local tile <const> = self:GetTile(frame)
  local x <const> = bounds.x + tile.pushbox.x
  local y <const> = bounds.y + tile.pushbox.y

  return geo.rect.new(x, y, tile.pushbox.width, tile.pushbox.height)
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

function Character:HandleBallCollision(collision)
  local other <const> = collision.other
  local sprite <const> = collision.sprite
  local spriteGroupMask <const> = sprite:getGroupMask()
  local spriteIsHitbox <const> = spriteGroupMask & collisionTypes.HITBOX ~= 0
  local spriteIsHurtbox <const> = spriteGroupMask & collisionTypes.HURTBOX ~= 0

  if (spriteIsHitbox) then
    local properties <const> = sprite.collisionProperties

    gfx.sprite.removeSprites({ collision.sprite })
    other:ChangeVelocity(properties.velocityX, properties.velocityY)
  elseif (spriteIsHurtbox) then
    local isBallDangerous <const> = math.abs(other.velocity.x) > 3 or
      math.abs(other.velocity.y) > 3

    if (isBallDangerous) then
      local newState = charStates.HURT

      if (self:IsJumping()) then
        newState |= charStates.JUMP
      elseif (
        self:IsMoving() or
        self:IsStanding() or
        self:IsTransitioning()
      ) then
        newState |= charStates.STAND
      elseif (self:IsCrouching()) then
        newState |= charStates.CROUCH
      else -- TODO: Find a better default
        newState |= charStates.STAND
      end

      self:SetState(newState)
      gfx.sprite.removeSprites({ sprite })
    end
  end
end

function Character:HandleCollisions(attemptedPosition, actualPosition, collisions, length)
  for i, collision in ipairs(collisions) do
    local other <const> = collision.other
    local otherGroupMask <const> = other:getGroupMask()
    local collidedWithBall = otherGroupMask & collisionTypes.BALL ~= 0
    local collidedWithWall = otherGroupMask & collisionTypes.WALL ~= 0

    if (collidedWithBall) then
      self:HandleBallCollision(collision)
    elseif (collidedWithWall) then
      self:HandleWallCollision(attemptedPosition, actualPosition, collision)
    end
  end
end

function Character:HandleWallCollision(attemptedPosition, actualPosition, collision)
  local state <const> = self.states[self.counter]

  if (collision.normal.x ~= 0) then
    local xDelta <const> = actualPosition.x - attemptedPosition.x
    local xDeltaSign <const> = Sign(xDelta)
    local newPositionX <const> = math.abs(xDelta) * xDeltaSign

    state.position.x += newPositionX
    state.pushboxRect.x += newPositionX
    state.velocity.x = 0
  end

  if (collision.normal.y ~= 0) then
    local yDelta <const> = actualPosition.y - attemptedPosition.y
    local yDeltaSign <const> = Sign(yDelta)
    local newPositionY <const> = math.abs(yDelta) * yDeltaSign

    if (collision.normal.y == -1) then
      if (self:IsFalling() and not self:IsTransitioning()) then
        if (self:IsHurt()) then
          self:SetState(charStates.HURT | charStates.JUMP | charStates.END)
        else
          self:SetState(charStates.JUMP | charStates.END)
        end
      end
    end

    state.position.y += newPositionY
    state.pushboxRect.y += newPositionY
    state.velocity.y = 0
  end
end

function Character:HasAnimationEnded()
  local state <const> = self.states[self.counter]

  return state.imageTableIndex >= self.imageTable:getLength()
end

function Character:HasStateChanged()
  local current <const> = self.states[self.counter]
  local prev <const> = self.states[self.counter - 1]

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

function Character:IsAttacking()
  local state <const> = self.states[self.counter]

  return self:IsKicking() or self:IsPunching() or self:IsSpecialing()

  -- return self:IsAttackingBack() or
  --   self:IsAttackingDown() or
  --   self:IsAttackingForward() or
  --   self:IsAttackingUp()
end

-- function Character:IsAttackingBack()
--   local state <const> = self.states[self.counter]

--   return state.state & charStates.BACK ~= 0
-- end

-- function Character:IsAttackingDown()
--   local state <const> = self.states[self.counter]

--   return state.state & charStates.DOWN ~= 0
-- end

-- function Character:IsAttackingForward()
--   local state <const> = self.states[self.counter]

--   return state.state & charStates.FORWARD ~= 0
-- end

-- function Character:IsAttackingUp()
--   local state <const> = self.states[self.counter]

--   return state.state & charStates.UP ~= 0
-- end

function Character:IsBack()
  local state <const> = self.states[self.counter]

  return state.state & charStates.BACK ~= 0
end

function Character:IsBeginning()
  local state <const> = self.states[self.counter]

  return state.state & charStates.BEGIN ~= 0
end

function Character:IsCrouching(exclusive)
  local isExclusive <const> = exclusive or false
  local state <const> = self.states[self.counter]

  if (isExclusive) then
    return state.state == charStates.CROUCH
  end

  return state.state & charStates.CROUCH ~= 0
end

function Character:IsDashing()
  local state <const> = self.states[self.counter]

  return state.state & charStates.DASH ~= 0
end

function Character:IsDown()
  local state <const> = self.states[self.counter]

  return state.state & charStates.DOWN ~= 0
end

function Character:IsEnding()
  local state <const> = self.states[self.counter]

  return state.state & charStates.END ~= 0
end

function Character:IsFalling()
  local state <const> = self.states[self.counter]

  -- Since gravity is always being applied, we need to check above it.
  return state.velocity.y > self.gravity + 2
end

function Character:IsFlipped()
  local state <const> = self.states[self.counter]

  if (state == nil) then
    return false
  end

  return state.direction == charDirections.LEFT
end

function Character:IsForward()
  local state <const> = self.states[self.counter]

  return state.state & charStates.FORWARD ~= 0
end

function Character:IsHurt()
  local state <const> = self.states[self.counter]

  return state.state & charStates.HURT ~= 0
end

function Character:IsJumping()
  local state <const> = self.states[self.counter]

  return state.state & charStates.JUMP ~= 0
end

-- function Character:IsJumpingBack()
--   local state <const> = self.states[self.counter]

--   return self:IsJumping() and state.state & charStates.BACK ~= 0
-- end

-- function Character:IsJumpingForward()
--   local state <const> = self.states[self.counter]

--   return self:IsJumping() and state.state & charStates.FORWARD ~= 0
-- end

function Character:IsKicking()
  local state <const> = self.states[self.counter]

  return state.state & charStates.KICK ~= 0
end

function Character:IsKnockedDown()
  local state <const> = self.states[self.counter]

  return state.state & charStates.KNOCKDOWN ~= 0
end

function Character:IsMoving()
  local state <const> = self.states[self.counter]

  return state.state & charStates.MOVE ~= 0
end

-- function Character:IsMovingBack(exclusive)
--   local isExclusive <const> = exclusive or false
--   local state <const> = self.states[self.counter]

--   if (isExclusive) then
--     return state.state == charStates.MOVE | charStates.BACK
--   end

--   return self:IsMoving() and state.state & charStates.BACK ~= 0
-- end

-- function Character:IsMovingForward(exclusive)
--   local isExclusive <const> = exclusive or false
--   local state <const> = self.states[self.counter]

--   if (isExclusive) then
--     return state.state == charStates.MOVE | charStates.FORWARD
--   end

--   return self:IsMoving() and state.state & charStates.FORWARD ~= 0
-- end

function Character:IsPunching()
  local state <const> = self.states[self.counter]

  return state.state & charStates.PUNCH ~= 0
end

function Character:IsRising()
  local state <const> = self.states[self.counter]

  return state.state & charStates.RISE ~= 0
end

function Character:IsRunning()
  local state <const> = self.states[self.counter]

  return state.state & charStates.RUN ~= 0
end

-- TODO: Find a better name for this LOL
function Character:IsSpecialing()
  local state <const> = self.states[self.counter]

  return state.state & charStates.SPECIAL ~= 0
end

function Character:IsStanding(exclusive)
  local isExclusive <const> = exclusive or false
  local state <const> = self.states[self.counter]

  if (isExclusive) then
    return state.state == charStates.STAND
  end

  return state.state & charStates.STAND ~= 0
end

function Character:IsTransitioning()
  local state <const> = self.states[self.counter]

  return self:IsBeginning() or self:IsEnding()
end

function Character:IsUp()
  local state <const> = self.states[self.counter]

  return state.state & charStates.UP ~= 0
end

function Character:Load()
  self:LoadTilesets()
  self:LoadImageTables()
end

function Character:HydrateTileset(tileset)
  local index = 0
  local tilesetProperties <const> = ConvertCustomPropertiesToTable(tileset.properties or {})
  local tiles = {}

  for i, tile in ipairs(tileset.tiles) do
    local tileProperties <const> = ConvertCustomPropertiesToTable(tile.properties or {})

    tile.properties = tileProperties

    for j, collision in ipairs(tile.objectgroup.objects) do
      local collisionProperties <const> = ConvertCustomPropertiesToTable(collision.properties or {})

      if (collision.class == 'Pushbox') then
        tile.pushbox = {
          height = collision.height,
          width = collision.width,
          x = collision.x,
          y = collision.y,
        }
      end

      collision.properties = collisionProperties
    end

    for k = 1, tileProperties.frameDuration do
      index += 1
      tiles[index] = tile
    end
  end

  tileset.properties = tilesetProperties
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
  local hurtCrouchTileset <const> = self:HydrateTileset(self:LoadTSJ('HurtCrouch'))
  local hurtTileset <const> = self:HydrateTileset(self:LoadTSJ('Hurt'))
  local hurtJumpTileset <const> = self:HydrateTileset(self:LoadTSJ('HurtJump'))
  local moveTileset <const> = self:HydrateTileset(self:LoadTSJ('Move'))
  local jumpBackTileset <const> = self:HydrateTileset(self:LoadTSJ('JumpBack'))
  local jumpForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('JumpForward'))
  local jumpNeutralTileset <const> = self:HydrateTileset(self:LoadTSJ('JumpNeutral'))
  local kickJumpForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('KickJumpForward'))
  local kickJumpNeutralTileset <const> = self:HydrateTileset(self:LoadTSJ('KickJumpNeutral'))
  local kickForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('KickForward'))
  local kickNeutralTileset <const> = self:HydrateTileset(self:LoadTSJ('KickNeutral'))
  local kickBackTileset <const> = self:HydrateTileset(self:LoadTSJ('KickBack'))
  local punchForwardTileset <const> = self:HydrateTileset(self:LoadTSJ('PunchForward'))
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
    [charStates.HURT | charStates.CROUCH] = hurtCrouchTileset,
    [charStates.HURT | charStates.JUMP] = hurtJumpTileset,
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
    [charStates.MOVE | charStates.BACK] = moveTileset,
    [charStates.MOVE | charStates.FORWARD] = moveTileset,

    -- Punching
    [charStates.PUNCH | charStates.CROUCH] = self:HydrateTileset(self:LoadTSJ('PunchCrouch')),
    [charStates.PUNCH | charStates.JUMP | charStates.BACK] = punchForwardTileset,
    [charStates.PUNCH | charStates.JUMP | charStates.FORWARD] = punchForwardTileset,
    [charStates.PUNCH | charStates.JUMP] = punchForwardTileset,
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

function Character:NormalizeMovementVelocityX(velocityX)
  local flipSign <const> = self:IsFlipped() and -1 or 1
  local moveSign <const> = self:IsBack() and -1 or
    self:IsForward() and 1 or 0

  return velocityX * flipSign * moveSign
end

function Character:SetState(state)
  local keyset = {}

  for k, v in pairs(charStates) do
    keyset[v] = k
  end

  print('SetState', keyset[state], state)

  self.states[self.counter].state = state

  self:DeriveImageTableFromState()
  self:DerivePhysicsFromState()
end

function Character:UpdateButtonStates()
  local state <const> = self.states[self.counter]

  state.buttonState = { pd.getButtonState() }
end

function Character:TransitionState()
  local state <const> = self.states[self.counter]
  local tileProperties <const> = self:GetTileProperties(state.imageTableIndex)
  local tilesetProperties <const> = self:GetTilesetProperties()
  local loops = tilesetProperties.loops or tileProperties.loops

  if (not self:HasAnimationEnded()) then
    return
  end

  -- Beginning and ending checks should come first

  if (self:IsBeginning()) then
    local statesToRemove <const> = charStates.BEGIN
    local newState = state.state &~ statesToRemove

    self:SetState(newState)

    return
  end

  if (self:IsEnding()) then
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

    local statesToRemove <const> = charStates.END
    local newState = state.state &~ statesToRemove

    self:SetState(newState)

    return
  end

  if (self:IsDashing()) then
    local newState = state.state | charStates.END

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

function Character:UpdateAnimation()
  self:UpdateImage()
  self:UpdateImageTableIndex()
  self:UpdatePushboxPosition()
  self:UpdateCollisions()
  self:setImageFlip(self:GetFlip(), true)
end

function Character:UpdateCollisions()
  local state <const> = self.states[self.counter]
  local nextTile <const> = self:GetTile(state.imageTableIndex)
  local selfBoundsRect <const> = self:getBoundsRect()

  gfx.sprite.removeSprites(self.emptyCollisionSprites)
  self.emptyCollisionSprites = {}

  for i, collision in ipairs(nextTile.objectgroup.objects) do
    local collidesWithGroupMasks <const> = {
      Hitbox = collisionTypes.BALL,
      Hurtbox = collisionTypes.BALL,
      Pushbox = collisionTypes.WALL,
    }
    local groupMasks <const> = {
      Hitbox = collisionTypes.HITBOX,
      Hurtbox = collisionTypes.HURTBOX,
      Pushbox = collisionTypes.PUSHBOX,
    }
    local isHitbox <const> = collision.class == 'Hitbox'
    local isHurtbox <const> = collision.class == 'Hurtbox'
    local isPushbox <const> = collision.class == 'Pushbox'

    if (isPushbox) then
      -- Setting the collide rect is center-aware, so no need for any math.
      local collideRect <const> = geo.rect.new(
        collision.x,
        collision.y,
        collision.width,
        collision.height
      )

      self.collisionProperties = collision.properties
      self:setCollideRect(collideRect)
      self:setCollidesWithGroupsMask(collidesWithGroupMasks[collision.class])
      self:setGroupMask(groupMasks[collision.class])
    elseif (isHitbox or isHurtbox) then
      -- Setting an empty collision sprite is not center-aware, so we need a bit of math.
      local collisionX <const> = (self.x - (self.width / 2)) + collision.x
      local collisionY <const> = (self.y - self.height) + collision.y
      local collideRect <const> = geo.rect.new(
        collisionX,
        collisionY,
        collision.width,
        collision.height
      )
      local flip <const> = self:GetFlip()

      collideRect:flipRelativeToRect(selfBoundsRect, flip)

      local sprite <const> = self.addEmptyCollisionSprite(collideRect)

      sprite.collisionProperties = collision.properties
      sprite:setCollidesWithGroupsMask(collidesWithGroupMasks[collision.class])
      sprite:setGroupMask(groupMasks[collision.class])
      sprite:setImageFlip(flip, true)

      table.insert(self.emptyCollisionSprites, sprite)
    end
  end
end

function Character:UpdateDirection()
  local opponentCenter <const> = self.opponent:getBoundsRect():centerPoint()
  local selfCenter <const> = self:getBoundsRect():centerPoint()
  local state <const> = self.states[self.counter]

  if (not self:IsCrouching(true) and not self:IsMoving() and not self:IsStanding(true)) then
    return
  end

  if (opponentCenter.x > selfCenter.x) then
    state.direction = charDirections.RIGHT
  elseif (opponentCenter.x < selfCenter.x) then
    state.direction = charDirections.LEFT
  end
end

function Character:UpdateImage()
  local state <const> = self.states[self.counter]
  local nextImage <const> = self.imageTable:getImage(state.imageTableIndex)

  self:setImage(nextImage)
end

function Character:UpdatePhysics()
  local state <const> = self.states[self.counter]

  -- Apply drag
  if (math.abs(state.velocity.x) > 0) then
    -- TODO: Implement drag based on stage weather...?
    -- self:ChangeVelocityX(self.drag, false)
  end

  -- Apply gravity
  state.velocity.y += self.gravity

  self:DerivePhysicsFromCurrentFrame()

  -- print(state.velocity.x, state.velocity.y)
end

function Character:UpdateImageTableIndex()
  local state <const> = self.states[self.counter]
  local tilesetProperties <const> = self:GetTilesetProperties()

  if (not self:HasAnimationEnded()) then
    state.imageTableIndex += 1
  elseif (self:HasAnimationEnded() and tilesetProperties.loops) then
    state.imageTableIndex = 1
  end

  -- print(state.imageTableIndex)
end

function Character:UpdatePosition()
  local attemptedPosition = {
    x = self.x,
    y = self.y,
  }
  local state <const> = self.states[self.counter]

  if (not self:IsBeginning() and not self:IsEnding()) then
    attemptedPosition.x += state.velocity.x
    attemptedPosition.y += state.velocity.y
    -- We also need to update the position of the pushbox's rect.
    state.pushboxRect.x += state.velocity.x
    state.pushboxRect.y += state.velocity.y
  end

  local actualX, actualY, collisions, length = self:moveWithCollisions(attemptedPosition.x, attemptedPosition.y)

  state.position.x = actualX
  state.position.y = actualY

  if (#collisions > 0) then
    local actualPosition <const> = {
      x = actualX,
      y = actualY,
    }

    self:HandleCollisions(attemptedPosition, actualPosition, collisions, length)
  end

  for i, collisionSprite in ipairs(self.emptyCollisionSprites) do
    local actualX, actualY, collisions, length = collisionSprite:checkCollisions(collisionSprite.x, collisionSprite.y)

    if (#collisions > 0) then
      local actualPosition <const> = {
        x = actualX,
        y = actualY,
      }
      local attemptedPosition <const> = {
        x = collisionSprite.x,
        y = collisionSprite.y,
      }

      self:HandleCollisions(attemptedPosition, actualPosition, collisions, length)
    end
  end
end

function Character:UpdatePushboxPosition()
  local newPosition = {
    x = self.x,
    y = self.y,
  }
  local state <const> = self.states[self.counter]
  local nextPushboxRect <const> = self:GetPushboxRectForFrame(state.imageTableIndex)
  local prevPushboxRect <const> = state.pushboxRect

  if (prevPushboxRect ~= nil) then
    local flipSign <const> = self:IsFlipped() and -1 or 1
    local nextPushboxCenter <const> = nextPushboxRect:centerPoint()
    local prevPushboxCenter <const> = prevPushboxRect:centerPoint()
    local x <const> = (prevPushboxCenter.x - nextPushboxCenter.x) * flipSign
    local y <const> = prevPushboxCenter.y - nextPushboxCenter.y

    newPosition.x += x
    newPosition.y += y
    nextPushboxRect.x += x
    nextPushboxRect.y += y
  end

  state.pushboxRect = nextPushboxRect

  self:moveTo(newPosition.x, newPosition.y)
end
