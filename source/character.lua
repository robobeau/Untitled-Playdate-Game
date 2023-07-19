import 'CoreLibs/animation'
import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'

import 'collisionTypes'
import 'frameData'
import 'history'
import 'inputs'
import 'utils'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics

cancellableStates = {
  ATTACK = 1,
  BLOCK = 2,
  CHAIN = 4,
  JUMP = 8,
  MOVE = 16,
  SPECIAL = 32,
  SUPER = 64,
}
charDirections = {
  LEFT = 1,
  RIGHT = 2,
}
charJumpHeights = {
  SHORTEST = 8,
  SHORTER = 10,
  SHORT = 12,
  NORMAL = 14,
  HIGH = 16,
  HIGHER = 18,
  HIGHEST = 20,
}
charSpeeds = {
  SLOWEST = 1,
  SLOWER = 2,
  SLOW = 4,
  NORMAL = 5,
  FAST = 6,
  FASTER = 8,
  FASTEST = 10,
}
charStates = {
  AIRBORNE = 1,
  BACK = 2,
  BEGIN = 4,
  BLOCK = 8,
  CHAIN = 16,
  CROUCH = 32,
  DASH = 64,
  DOWN = 128,
  END = 256,
  ENTRANCE = 512,
  FALL = 1024,
  FORWARD = 2048,
  HURT = 4096,
  JUMP = 8192,
  KICK = 16384,
  KNOCKDOWN = 32768,
  PARRY = 65536,
  PUNCH = 131072,
  RISE = 262144,
  RUN = 524288,
  SPECIAL = 1048576,
  STAND = 2097152,
  TAUNT = 4194304,
  UP = 8388608,
  WALK = 16777216,
  -- 33554432
  -- 67108864
  -- 134217728
  -- 268435456
  -- 536870912
  -- 1073741824
}

local defaults <const> = {
  animations = {},
  canDoubleJump = false,
  canRun = false,
  controllable = false,
  counter = 1,
  debug = false,
  emptyCollisionSprites = {},
  health = 1000,
  gravity = 1,
  imageTables = {},
  jumpHeight = charJumpHeights.NORMAL,
  name = 'Character',
  speeds = {
    dash = {
      back = charSpeeds.FASTER,
      forward = charSpeeds.FASTEST,
    },
    run = charSpeeds.FASTEST,
    walk = {
      back = charSpeeds.SLOW,
      forward = charSpeeds.NORMAL,
    },
  },
  startingPosition = {
    x = 0,
    y = 0,
  },
  stun = 1000,
}
local firstFrame <const> = {
  buttonState = {},
  center = geo.point.new(0, 0),
  direction = charDirections.RIGHT,
  frameCounter = 1,
  frameIndex = 1,
  health = 0, -- Set on Reset()
  hitstun = 0,
  position = {
    x = 0,
    y = 0,
  },
  state = charStates.STAND,
  stun = 0, -- Set on Reset()
  super = 0,
  velocity = {
    x = 0,
    y = 0,
  },
}

class('Character', defaults).extends(gfx.sprite)

function Character:collisionResponse(other)
  local otherGroupMask <const> = other:getGroupMask()
  local collidedWithPushbox <const> = otherGroupMask & collisionTypes.PUSHBOX ~= 0

  if (collidedWithPushbox) then
    return gfx.sprite.kCollisionTypeOverlap
  end

  return gfx.sprite.kCollisionTypeFreeze
end

function Character:init(options)
  Character.super.init(self)

  local config <const> = options or {}

  self.canDoubleJump = config.canDoubleJump or self.canDoubleJump
  self.canRun = config.canRun or self.canRun
  self.controllable = config.controllable or self.controllable -- For debugging ;)
  self.debug = config.debug or self.debug -- For debugging ;)
  self.gravity = config.gravity or self.gravity
  self.health = config.health or self.health
  self.history = History(firstFrame)
  self.jumpHeight = config.jumpHeight or self.jumpHeight
  self.name = config.name or self.name
  self.opponent = config.opponent or self.opponent
  self.speeds = config.speeds or self.speeds
  self.startingDirection = config.startingDirection or self.startingDirection
  self.startingPosition = config.startingPosition or self.startingPosition
  self.stun = config.stun or self.stun

  self:Load()
  self:setCenter(0.5, 1)
  self:Reset()
  self:setZIndex(1)
end

function Character:update()
  local frame <const> = self:GetHistoryFrame(frameIndex)

  -- self:Debug('==================================================')
  -- self:Debug('Update!', self.x, self.y, frame.velocity.x, frame.velocity.y)

  -- self:CheckCrank()

  -- if (self.frozen == true) then
  --   self:UpdateFrozenSprite()

  --   return
  -- end

  -- self:markDirty()

  self:TransitionState()
  self:UpdateDirection()

  -- if (self.controllable) then
    self:CheckInputs()
  -- end

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

    if (delta > 0 and delta < #self.history.frames) then
      self.counter = delta
    end
  end
end

function Character:CheckInputs()
  self:UpdateButtonStates()

  if (self:CheckSpecialInputs()) then
    return
  end

  if (self:CheckChainInputs()) then
    return
  end

  if (self:CheckAttackInputs()) then
    return
  end

  if (self:CheckJumpInputs()) then
    return
  end

  if (self:CheckMovementInputs()) then
    return
  end

  -- if (self:CheckBlockTransitionInputs()) then
  --   return
  -- end
end

function Character:CheckAttackInputs()
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  -- If we can't perform an attack, exit early.
  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.ATTACK) == 0) then
    return
  end

  local backInput <const>, forwardInput <const> = self:GetBackAndForwardInputs()
  local current <const>, pressed <const>, released <const> = table.unpack(frame.buttonState)
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

    if (self:IsAirborne()) then
      newState |= charStates.AIRBORNE

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
    elseif (self:IsCrouching()) then
      newState |= charStates.CROUCH
    else
      newState |= charStates.STAND

      if (self:IsBack()) then
        newState |= charStates.BACK
      elseif (self:IsForward()) then
        newState |= charStates.FORWARD
      end
    end

    self:SetState(newState)

    return true
  end

  if (hasPressedA) then
    local newState = charStates.PUNCH

    if (self:IsAirborne()) then
      newState |= charStates.AIRBORNE

      if (isPressingBack) then
        newState |= charStates.BACK
      elseif (isPressingForward) then
        newState |= charStates.FORWARD
      end

      if (self:IsRunning()) then
        newState |= charStates.RUN
      elseif (self:IsDashing()) then
        newState |= charStates.DASH
      end
    elseif (self:IsCrouching()) then
      newState |= charStates.CROUCH
    else
      newState |= charStates.STAND
    end

    self:SetState(newState)

    return true
  end
end

function Character:CheckBlockInputs()
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.BLOCK) == 0) then
    return false
  end

  if (Inputs:CheckBackInput(self)) then
    local newState = charStates.BLOCK

    if (self:IsAirborne()) then
      newState |= charStates.AIRBORNE
    elseif (self:IsCrouching()) then
      newState |= charStates.CROUCH
    else
      newState |= charStates.STAND
    end

    self:SetState(newState)

    return true
  end
end

function Character:CheckChainInputs()
  -- Overload this on each character's class!
end

function Character:CheckJumpInputs()
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.JUMP) == 0) then
    return false
  end

  if (not self:IsJumping()) then
    if (Inputs:CheckJumpInput(self)) then
      local newState = charStates.JUMP | charStates.BEGIN

      if (Inputs:CheckBackInput(self)) then
        newState |= charStates.BACK

        if (self:IsRunning()) then
          newState |= charStates.RUN
        end
      elseif (Inputs:CheckForwardInput(self)) then
        newState |= charStates.FORWARD

        if (self:IsRunning()) then
          newState |= charStates.RUN
        end
      end

      self:SetState(newState)

      return true
    end
  end
end

function Character:CheckMovementInputs()
  local buttonState <const> = Inputs:GetButtonState(self)
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.MOVE) == 0) then
    return false
  end

  if (not self:IsCrouching()) then
    -- Dash/Run check
    if (not self:IsDashing() and not self:IsRunning()) then
      if (Inputs:CheckDashBackInput(self)) then
        self:SetState(charStates.DASH | charStates.BEGIN | charStates.BACK)

        return true
      elseif (Inputs:CheckDashForwardInput(self)) then
        if (self.canRun) then
          self:SetState(charStates.RUN | charStates.BEGIN | charStates.FORWARD)
        else
          self:SetState(charStates.DASH | charStates.BEGIN | charStates.FORWARD)
        end

        return true
      end
    end

    -- Walk check
    if (not self:IsDashing() and not self:IsWalking() and not self:IsRunning()) then
      if (Inputs:CheckBackInput(self)) then
        self:SetState(charStates.WALK | charStates.BACK)

        return true
      elseif (Inputs:CheckForwardInput(self)) then
        self:SetState(charStates.WALK | charStates.FORWARD)

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
    if (self:IsWalking() or self:IsRunning()) then
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
  -- Overload this on each character's class!
end

function Character:CleanUp()
  -- TODO: Clear every single image in "self.imageTables"
  gfx.sprite.removeSprites(self.emptyCollisionSprites)
end

-- For debugging ;)
function Character:Debug(...)
  if (self.debug) then
    print(self.controllable, ...)
  end
end

function Character:DeriveImageTableFromState()
  local filteredState <const> = self:GetFilteredStateForAnimation()

  self:UpdateHistoryFrame({
    -- TODO: Why 0...?
    frameCounter = 0,
    frameIndex = 1,
  })
  self.imageTable = self.imageTables[filteredState]
end

function Character:DerivePhysicsFromCurrentFrame()
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)
  local newVelocity <const> = table.deepcopy(self:GetVelocity())

  if (frameData.velocityX ~= nil) then
    local flipSign <const> = self:GetFlipSign()

    newVelocity.x = frameData.velocityX * flipSign
  end

  if (frameData.velocityY ~= nil) then
    newVelocity.y = frameData.velocityY
  end

  self:UpdateHistoryFrame({
    velocity = newVelocity
  })
end

function Character:DerivePhysicsFromState()
  -- A hitbox's properties determine the physics for the Hurt state.
  if (self:IsHurt()) then
    return
  end

  local newVelocity <const> = table.deepcopy(self:GetVelocity())

  self:Debug(newVelocity.x, newVelocity.y)

  -- X Velocity

  if (self:IsTransitioning()) then
    self:Debug('Transitioning')
    newVelocity.x = 0
  elseif (self:IsDashing()) then
    self:Debug('Dashing')
    newVelocity.x = self:GetDashVelocity()
  elseif (self:IsJumping()) then
    if (self:IsRunning()) then
      self:Debug('Running Jumping')
      newVelocity.x = self:GetRunVelocity()
    elseif (self:IsBack() or self:IsForward()) then
      self:Debug('Moving Jumping')
      newVelocity.x = self:GetWalkVelocity()
    else
      self:Debug('Neutral Jumping')
    end
  elseif (self:IsRunning()) then
    self:Debug('Running')
    newVelocity.x = self:GetRunVelocity()
  elseif (self:IsWalking()) then
    self:Debug('Walking')
    newVelocity.x = self:GetWalkVelocity()
  -- elseif (self:IsCrouching() or self:IsStanding() or self:IsTransitioning()) then
  elseif (not self:IsAirborne()) then
    self:Debug('Standing')
    newVelocity.x = 0
  end

  -- Y Velocity

  if (self:IsTransitioning()) then
    self:Debug('Transitioning')
    newVelocity.y = 0
  elseif (self:IsJumping()) then
    -- if (not self:IsAttacking()) then
      self:Debug('Y Jumping')
      newVelocity.y = -self.jumpHeight
    -- end
  -- elseif (self:IsCrouching() or self:IsStanding()) then
  elseif (not self:IsAirborne()) then
    self:Debug('Y Standing')
    newVelocity.y = 0
  end

  self:Debug('FAAAAAAAAAK', newVelocity.x, newVelocity.y)

  self:UpdateHistoryFrame({
    velocity = newVelocity
  })

  self:DerivePhysicsFromCurrentFrame()
end

function Character:GetAnimation(frameIndex)
  local state <const> = self:GetFilteredStateForAnimation(frameIndex)

  return self.animations[state]
end

function Character:GetAnimationData(frameIndex)
  local animation <const> = self:GetAnimation(frameIndex)

  return animation.data
end

function Character:GetAnimationFrame(animationFrameIndex, historyFrameIndex)
  local animation <const> = self:GetAnimation(historyFrameIndex)

  return animation.frames[animationFrameIndex]
end

function Character:GetDirection(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.direction
end

function Character:GetHistoryFrame(frameIndex)
  return self.history:GetFrame(frameIndex)
end

function Character:GetPosition(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.position
end

function Character:GetStun(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.stun
end

function Character:GetSuper(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.super
end

function Character:GetVelocity(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  -- self:Debug('Velocity', frame.velocity.x, frame.velocity.y)

  return frame.velocity
end

function Character:GetBackAndForwardInputs()
  local frame <const> = self:GetHistoryFrame()

  if (frame.direction == charDirections.LEFT) then
    return pd.kButtonRight, pd.kButtonLeft
  end

  return pd.kButtonLeft, pd.kButtonRight
end

function Character:GetCenterRelativeToBounds()
  local bX <const>,
        bY <const>,
        bWidth <const> = self:getBoundsRect():unpack()
  local frame <const> = self:GetHistoryFrame()
  local animationFrame <const> = self:GetAnimationFrame(frame.frameIndex)
  local offset <const> = {
    x = self:IsFlipped() and
      (bX + bWidth - (animationFrame.center.x * 2)) or
      bX,
    y = bY,
  }

  -- "offsetBy(dx, dy)" returns a new point.
  return animationFrame.center:offsetBy(offset.x, offset.y)
end

function Character:GetHealth(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.health
end

function Character:GetHitstun(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.hitstun
end

-- Used by Stage
function Character:GetSpeed()
  if (self:IsRunning()) then
    return self:GetRunSpeed()
  elseif (self:IsDashing()) then
    return self:GetDashSpeed()
  end

  return self:GetWalkSpeed()
end

function Character:GetDashSpeed()
  if (self:IsBack()) then
    return self.speeds.dash.back
  end

  return self.speeds.dash.forward
end

function Character:GetDashVelocity()
  return self:NormalizeHorizontalVelocity(self:GetDashSpeed())
end

-- To reduce the complexity of animation keys,
-- we want to remove certain states under certain conditions.
function Character:GetFilteredStateForAnimation(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)
  local statesToRemove = 0

  -- Attacking is not visually affected by dashing... yet.
  -- Jumping is not visually affected by dashing.
  if (self:IsAttacking(frameIndex) or self:IsJumping(frameIndex)) then
    statesToRemove |= charStates.DASH | charStates.RUN | charStates.WALK
  end

  -- There's currently only one possible transition animation,
  -- so we don't need to distinguish between back/forward movement.
  if (self:IsTransitioning(frameIndex)) then
    statesToRemove |= charStates.BACK | charStates.FORWARD
  end

  return frame.state &~ statesToRemove
end

function Character:GetFlip(frameIndex)
  return self:IsFlipped(frameIndex) and gfx.kImageFlippedX or gfx.kImageUnflipped
end

function Character:GetFlipSign(frameIndex)
  return self:IsFlipped(frameIndex) and -1 or 1
end

function Character:GetFrameData(animationFrameIndex, historyFrameIndex)
  local frame <const> = self:GetAnimationFrame(animationFrameIndex, historyFrameIndex)

  return frame.data
end

function Character:GetHit(hitbox)
  local newState = charStates.HURT

  if (self:IsAirborne()) then
    newState |= charStates.AIRBORNE
  -- elseif (self:IsWalking() or self:IsStanding() or self:IsTransitioning()) then
  --   newState |= charStates.STAND
  elseif (self:IsCrouching()) then
    newState |= charStates.CROUCH
  else
    newState |= charStates.STAND
  end

  local health = self:GetHealth()
  local hitstun = self:GetHitstun()
  local newVelocity <const> = table.deepcopy(self:GetVelocity())

  if (hitbox.properties.damage) then
    health -= hitbox.properties.damage
  end

  if (hitbox.properties.hitstun) then
    hitstun = hitbox.properties.hitstun
  end

  if (hitbox.properties.launch) then
    -- Note the negation of "hitbox.properties.launch"
    newVelocity.y = -hitbox.properties.launch
  end

  if (hitbox.properties.pushback) then
    -- Note the negation of "GetFlipSign()"
    newVelocity.x = hitbox.properties.pushback * -self:GetFlipSign()
  end

  self:Debug('GetHit', health, newVelocity.x)

  self:UpdateHistoryFrame({
    health = health,
    hitstun = hitstun,
    velocity = newVelocity,
  })
  self.OnHealthChange(health)
  self:SetState(newState)

  gfx.sprite.removeSprites({ hitbox })
end

function Character:GetHitByBall(hurtbox, ball)
  local newState = charStates.HURT

  if (self:IsAirborne()) then
    newState |= charStates.AIRBORNE
  elseif (
    self:IsWalking() or
    self:IsStanding() or
    self:IsTransitioning()
  ) then
    newState |= charStates.STAND
  elseif (self:IsCrouching()) then
    newState |= charStates.CROUCH
  else
    newState |= charStates.STAND
  end

  local health <const> = self:GetHealth() - 100

  self:Debug(health)

  self:UpdateHistoryFrame({
    health = health
  })
  self.OnHealthChange(health)
  self:SetState(newState)

  gfx.sprite.removeSprites({ hurtbox })
end

function Character:GetRunSpeed()
  return self.speeds.run
end

function Character:GetRunVelocity()
  return self:NormalizeHorizontalVelocity(self:GetRunSpeed())
end

function Character:GetWalkSpeed()
  if (self:IsBack()) then
    return self.speeds.walk.back
  end

  return self.speeds.walk.forward
end

function Character:GetWalkVelocity()
  return self:NormalizeHorizontalVelocity(self:GetWalkSpeed())
end

function Character:HitBall(collision)
  self.Debug('HitBall', collision.other.name, collision.sprite.name)

  local ball <const> = collision.other
  local box <const> = collision.sprite
  local properties <const> = box.properties


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

function Character:HandleBallCollision(collision)
  self:Debug('HandleBallCollision', collision.name)

  local ball <const> = collision.other
  local box <const> = collision.sprite
  local boxGroupMask <const> = box:getGroupMask()
  local boxIsHitbox <const> = boxGroupMask & collisionTypes.HITBOX ~= 0
  local boxIsHurtbox <const> = boxGroupMask & collisionTypes.HURTBOX ~= 0

  if (boxIsHitbox) then
    self:HitBall(collision)
  elseif (boxIsHurtbox) then
    if (self.controllable and self:CheckBlockInputs()) then
      return
    end

    if (
      (collision.normal.x ~= 0 and ball:IsDeadlyX()) or
      (collision.normal.y ~= 0 and ball:IsDeadlyY())
    ) then
      self:GetHitByBall(box, ball)
    end
  end
end

function Character:HandleCollisions(collisions)
  for i, collision in ipairs(collisions) do
    if (collision.type == gfx.sprite.kCollisionTypeFreeze) then
      self:HandleFreezeCollision(collision)
    elseif (collision.type == gfx.sprite.kCollisionTypeOverlap) then
      self:HandleOverlapCollision(collision)
    end
  end
end

function Character:HandleFreezeCollision(collision)
  local otherGroupMask <const> = collision.other:getGroupMask()
  local collidedWithBall <const> = otherGroupMask & collisionTypes.BALL ~= 0
  local collidedWithWall <const> = otherGroupMask & collisionTypes.WALL ~= 0

  if (collidedWithWall) then
    self:HandleWallCollision(collision)
  end
end

function Character:HandleHitboxCollision(collision)
  -- local hitbox <const> = collision.other
  -- -- local hurtbox <const> = collision.sprite

  -- -- It's technically possible for a sprite's hurtboxes to collide with their own hitboxes
  -- if (hitbox.parent == self) then
  --   return
  -- end

  -- if (self.controllable and self:CheckBlockInputs()) then
  --   -- TODO: Handle pushback here?
  --   return
  -- end

  -- self:GetHit(hitbox)
end


function Character:HandleHurtboxCollision(collision)
  local hitbox <const> = collision.sprite
  local hurtbox <const> = collision.other
  local opponent <const> = hurtbox.parent

  -- It's technically possible for a sprite's hitboxes to collide with their own hurtboxes
  if (opponent == self) then
    local frame <const> = self:GetHistoryFrame()
    -- self:Debug('What the fuck?', frame.velocity.x, self.controllable)
    return
  end

  local opponentBlocked <const> = opponent:CheckBlockInputs()

  if (not opponentBlocked) then
    opponent:GetHit(hitbox)

    return
  end
end

function Character:HandleOverlapCollision(collision)
  local otherGroupMask <const> = collision.other:getGroupMask()
  local collidedWithBall <const> = otherGroupMask & collisionTypes.BALL ~= 0
  local collidedWithHitbox <const> = otherGroupMask & collisionTypes.HITBOX ~= 0
  local collidedWithHurtbox <const> = otherGroupMask & collisionTypes.HURTBOX ~= 0
  local collidedWithPushbox <const> = otherGroupMask & collisionTypes.PUSHBOX ~= 0

  if (collidedWithBall) then
    self:HandleBallCollision(collision)
  elseif (collidedWithHitbox) then
    self:HandleHitboxCollision(collision)
  elseif (collidedWithHurtbox) then
    self:HandleHurtboxCollision(collision)
  elseif (collidedWithPushbox) then
    self:HandlePushboxCollision(collision)
  end
end

function Character:HandlePushboxCollision(collision)
  -- self:Debug('--------------- Pushbox Collision ---------------')
  -- self:Debug('Current Position', self.x, self.y)

  local newVelocity <const> = table.deepcopy(self:GetVelocity())

  -- self:Debug('Move', collision.move)
  -- self:Debug('Normal', collision.normal)
  -- self:Debug('Overlaps', collision.overlaps)
  -- self:Debug('Touch', collision.touch)
  -- self:Debug('Sprite Bounds', collision.sprite:getBoundsRect())
  -- self:Debug('Sprite Collide Rect', collision.sprite:getCollideRect())
  -- self:Debug('Sprite Position', collision.sprite.x, collision.sprite.y)
  -- self:Debug('Sprite Touch Rect', collision.spriteRect)
  -- self:Debug('Other Bounds', collision.other:getBoundsRect())
  -- self:Debug('Other Collide Rect', collision.other:getCollideRect())
  -- self:Debug('Other Position', collision.other.x, collision.other.y)
  -- self:Debug('Other Touch Rect', collision.otherRect)

  if (collision.normal.x ~= 0) then
    if (self:WouldHitAWall(self.x + collision.move.x, self.y)) then
      local newPosition <const> = {
        x = collision.other.x - collision.move.x,
        y = collision.other.y,
      }

      collision.other:MoveToXY(newPosition.x, newPosition.y)
    else
      local newPosition <const> = {
        x = self.x + collision.move.x,
        y = self.y,
      }

      self:MoveToXY(newPosition.x, newPosition.y)
    end
  end

  -- if (collision.normal.y ~= 0) then
    
  -- end

  self:UpdateHistoryFrame({
    velocity = newVelocity
  })

  -- self:Debug('---------------------------------------------')
end

function Character:HandleWallCollision(collision)
  local newVelocity <const> = table.deepcopy(self:GetVelocity())

  -- self:Debug('--------------- Wall Collision ---------------')
  -- self:Debug('Move', collision.move)
  -- self:Debug('Normal', collision.normal)
  -- self:Debug('Overlaps', collision.overlaps)
  -- self:Debug('Touch', collision.touch)
  -- self:Debug('Sprite Bounds', collision.sprite:getBoundsRect())
  -- self:Debug('Sprite Collide Rect', collision.sprite:getCollideRect())
  -- self:Debug('Sprite Position', collision.sprite.x, collision.sprite.y)
  -- self:Debug('Sprite Touch Rect', collision.spriteRect)
  -- self:Debug('Other Bounds', collision.other:getBoundsRect())
  -- self:Debug('Other Collide Rect', collision.other:getCollideRect())
  -- self:Debug('Other Position', collision.other.x, collision.other.y)
  -- self:Debug('Other Touch Rect', collision.otherRect)

  if (collision.normal.x ~= 0) then
    newVelocity.x = 0
  end

  if (collision.normal.y ~= 0) then
    if (collision.normal.y == -1) then -- Collided with the floor
      self:HandleJumpEnd()
    else -- Collided with the ceiling
      -- Do nothing?
    end
  end

  self:UpdateHistoryFrame({
    velocity = newVelocity
  })

  -- self:Debug('---------------------------------------------')
end

function Character:HandleJumpEnd()
  -- TODO: We may not need this anymore?
  if (self:IsTransitioning()) then
    return
  end

  if (self:IsHurt()) then
    self:SetState(charStates.HURT | charStates.AIRBORNE | charStates.END)
  else
    self:SetState(charStates.JUMP | charStates.END)
  end
end

function Character:HasAnimationEnded()
  local frame <const> = self:GetHistoryFrame()

  return frame.frameIndex == self.imageTable:getLength()
end

function Character:HasAnimationFrameEnded()
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  return frame.frameCounter == frameData.duration
end

function Character:HasDirectionChanged()
  local current <const> = self:GetHistoryFrame()
  local prev <const> = self:GetHistoryFrame(self.history.counter - 1)

  if (prev == nil) then
    return false
  end

  return current.direction ~= prev.direction
end

function Character:HasFrameIndexChanged()
  local current <const> = self:GetHistoryFrame()
  local prev <const> = self:GetHistoryFrame(self.history.counter - 1)

  if (prev == nil) then
    return false
  end

  return prev.frameIndex ~= current.frameIndex
end

function Character:HasStateChanged()
  local current <const> = self:GetHistoryFrame()
  local prev <const> = self:GetHistoryFrame(self.history.counter - 1)

  if (prev == nil) then
    return false
  end

  return current.state ~= prev.state
end

function Character:HydrateAnimation(animation)
  local animationData <const> = ConvertCustomPropertiesToTable(animation.properties or {})
  local frames <const> = {}

  for i, frame in ipairs(animation.tiles) do
    local frameData <const> = ConvertCustomPropertiesToTable(frame.properties or {})
    local center <const>, collisions <const> = ExtractCharacterObjects(frame.objectgroup.objects)

    frames[i] = {
      center = center,
      collisions = collisions,
      data = FrameData(frameData),
      image = frame.image,
    }
  end

  return {
    data = animationData,
    frames = frames,
    name = animation.name, -- For debugging ;)
  }
end

function Character:HydrateImageTable(animation)
  local imageTable <const> = gfx.imagetable.new(#animation.frames)
  local images <const> = {}

  for i, frame in ipairs(animation.frames) do
    local image
    local imagePath = frame.image
          -- Chop off the "../" and ".png"
          imagePath = string.gsub(imagePath, '%.%./', 'characters/' .. self.name .. '/')
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

function Character:IsAirborne(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.AIRBORNE ~= 0
end

function Character:IsAttacking(frameIndex)
  return self:IsKicking(frameIndex) or
        self:IsPunching(frameIndex) or
        self:IsSpecialing(frameIndex)
end

function Character:IsBack(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.BACK ~= 0
end

function Character:IsBeginning(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.BEGIN ~= 0
end

function Character:IsBlocking(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.BLOCK ~= 0
end

function Character:IsCrouching(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.CROUCH ~= 0
end

function Character:IsDashing(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.DASH ~= 0
end

function Character:IsDown(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.DOWN ~= 0
end

function Character:IsEnding(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.END ~= 0
end

function Character:IsFalling(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  -- Since gravity is always being applied, we need to check above it.
  return self:IsAirborne(frameIndex) and frame.velocity.y > self.gravity
end

function Character:IsFlipped(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  if (frame == nil) then
    return false
  end

  return frame.direction == charDirections.LEFT
end

function Character:IsForward(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.FORWARD ~= 0
end

function Character:IsHitstunned(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  return frameData:IsHitstunnable() and frame.hitstun > 0
end

function Character:IsHurt(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.HURT ~= 0
end

function Character:IsJumping(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.JUMP ~= 0
end

function Character:IsKicking(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.KICK ~= 0
end

function Character:IsKnockedDown(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.KNOCKDOWN ~= 0
end

function Character:IsPunching(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.PUNCH ~= 0
end

function Character:IsRising(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.RISE ~= 0
end

function Character:IsRunning(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.RUN ~= 0
end

-- TODO: Find a better name for this LOL
function Character:IsSpecialing(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.SPECIAL ~= 0
end

function Character:IsStanding(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.STAND ~= 0
end

function Character:IsTransitioning(frameIndex)
  return self:IsBeginning(frameIndex) or self:IsEnding(frameIndex)
end

function Character:IsUp(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.UP ~= 0
end

function Character:IsWalking(frameIndex)
  local frame <const> = self:GetHistoryFrame(frameIndex)

  return frame.state & charStates.WALK ~= 0
end

function Character:Load()
  self:LoadAnimations()
  self:LoadImageTables()
end

function Character:LoadImageTables()
  for key, animation in pairs(self.animations) do
    self.imageTables[key] = self:HydrateImageTable(animation)
  end

  local menuImageFilePath <const> = 'images/characters/' .. self.name .. '/' .. self.name .. 'PortraitMenu'
  local portraitImageFilePath <const> = 'images/characters/' .. self.name .. '/' .. self.name .. 'Portrait'

  self.menuImage = gfx.image.new(menuImageFilePath)
  self.portraitImage = gfx.image.new(portraitImageFilePath)
end

function Character:LoadAnimations()
  local dashBackAnimation <const> = self:HydrateAnimation(self:LoadTSJ('DashBack'))
  local dashForwardAnimation <const> = self:HydrateAnimation(self:LoadTSJ('DashForward'))
  local hurtAirborneAnimation <const> = self:HydrateAnimation(self:LoadTSJ('HurtAirborne'))
  local hurtCrouchAnimation <const> = self:HydrateAnimation(self:LoadTSJ('HurtCrouch'))
  local hurtAnimation <const> = self:HydrateAnimation(self:LoadTSJ('Hurt'))
  local jumpBackAnimation <const> = self:HydrateAnimation(self:LoadTSJ('JumpBack'))
  local jumpForwardAnimation <const> = self:HydrateAnimation(self:LoadTSJ('JumpForward'))
  local jumpNeutralAnimation <const> = self:HydrateAnimation(self:LoadTSJ('JumpNeutral'))
  local kickJumpForwardAnimation <const> = self:HydrateAnimation(self:LoadTSJ('KickJumpForward'))
  local kickJumpNeutralAnimation <const> = self:HydrateAnimation(self:LoadTSJ('KickJumpNeutral'))
  local kickForwardAnimation <const> = self:HydrateAnimation(self:LoadTSJ('KickForward'))
  local kickNeutralAnimation <const> = self:HydrateAnimation(self:LoadTSJ('KickNeutral'))
  local kickBackAnimation <const> = self:HydrateAnimation(self:LoadTSJ('KickBack'))
  local punchForwardAnimation <const> = self:HydrateAnimation(self:LoadTSJ('PunchForward'))
  local punchJumpForwardAnimation <const> = self:HydrateAnimation(self:LoadTSJ('PunchJumpForward'))
  local transitionAnimation <const> = self:HydrateAnimation(self:LoadTSJ('Transition'))
  local walkBackAnimation <const> = self:HydrateAnimation(self:LoadTSJ('MoveBack'))
  local walkForwardAnimation <const> = self:HydrateAnimation(self:LoadTSJ('MoveForward'))

  self.animations = {
    -- Airborne
    [charStates.AIRBORNE] = self:HydrateAnimation(self:LoadTSJ('Airborne')),

    -- Blocking
    [charStates.BLOCK | charStates.AIRBORNE] = self:HydrateAnimation(self:LoadTSJ('BlockAirborne')),
    [charStates.BLOCK | charStates.CROUCH] = self:HydrateAnimation(self:LoadTSJ('BlockCrouch')),
    [charStates.BLOCK | charStates.STAND] = self:HydrateAnimation(self:LoadTSJ('Block')),

    -- Crouching
    [charStates.CROUCH] = self:HydrateAnimation(self:LoadTSJ('Crouch')),

    -- Dashing
    [charStates.DASH | charStates.BACK] = dashBackAnimation,
    [charStates.DASH | charStates.BEGIN] = transitionAnimation,
    [charStates.DASH | charStates.END] = transitionAnimation,
    [charStates.DASH | charStates.FORWARD] = dashForwardAnimation,

    -- Entrance
    [charStates.ENTRANCE] = self:HydrateAnimation(self:LoadTSJ('Entrance')),

    -- Hurting
    [charStates.HURT | charStates.AIRBORNE] = hurtAirborneAnimation,
    [charStates.HURT | charStates.AIRBORNE | charStates.END] = self:HydrateAnimation(self:LoadTSJ('TransitionHurtJump')),
    [charStates.HURT | charStates.CROUCH] = hurtCrouchAnimation,
    [charStates.HURT | charStates.STAND] = hurtAnimation,

    -- Kicking
    [charStates.KICK | charStates.AIRBORNE] = kickJumpNeutralAnimation,
    [charStates.KICK | charStates.AIRBORNE | charStates.BACK] = kickJumpForwardAnimation,
    [charStates.KICK | charStates.AIRBORNE | charStates.FORWARD] = kickJumpForwardAnimation,
    [charStates.KICK | charStates.CROUCH] = self:HydrateAnimation(self:LoadTSJ('KickCrouch')),
    [charStates.KICK | charStates.STAND] = kickNeutralAnimation,
    [charStates.KICK | charStates.STAND | charStates.BACK] = kickBackAnimation,
    [charStates.KICK | charStates.STAND | charStates.FORWARD] = kickForwardAnimation,

    -- Knockdown
    [charStates.KNOCKDOWN] = self:HydrateAnimation(self:LoadTSJ('Knockdown')),

    -- Jumping
    [charStates.JUMP | charStates.AIRBORNE] = jumpNeutralAnimation,
    [charStates.JUMP | charStates.AIRBORNE | charStates.BACK] = jumpBackAnimation,
    [charStates.JUMP | charStates.AIRBORNE | charStates.FORWARD] = jumpForwardAnimation,
    [charStates.JUMP | charStates.BEGIN] = transitionAnimation,
    [charStates.JUMP | charStates.END] = transitionAnimation,

    -- Moving
    [charStates.WALK | charStates.BACK] = walkBackAnimation,
    [charStates.WALK | charStates.FORWARD] = walkForwardAnimation,

    -- Punching
    [charStates.PUNCH | charStates.AIRBORNE] = punchJumpForwardAnimation,
    [charStates.PUNCH | charStates.AIRBORNE | charStates.BACK] = punchJumpForwardAnimation,
    [charStates.PUNCH | charStates.AIRBORNE | charStates.FORWARD] = punchJumpForwardAnimation,
    [charStates.PUNCH | charStates.CROUCH] = self:HydrateAnimation(self:LoadTSJ('PunchCrouch')),
    [charStates.PUNCH | charStates.STAND] = punchForwardAnimation,

    -- Rising
    [charStates.RISE] = self:HydrateAnimation(self:LoadTSJ('Rise')),

    -- Running
    [charStates.RUN | charStates.BEGIN] = transitionAnimation,
    [charStates.RUN | charStates.END] = transitionAnimation,
    [charStates.RUN | charStates.FORWARD] = self:HydrateAnimation(self:LoadTSJ('Run')),

    -- Standing
    [charStates.STAND] = self:HydrateAnimation(self:LoadTSJ('Stand')),
  }
end

function Character:LoadTSJ(state)
  local filePath <const> = 'characters/' .. self.name .. '/tsjs/' .. self.name .. state .. '.tsj'

  return json.decodeFile(filePath)
end

function Character:MoveToXY(x, y)
  local positionDelta <const> = {
    x = x - self.x,
    y = y - self.y,
  }

  self:moveTo(x, y)

  for i, sprite in ipairs(self.emptyCollisionSprites) do
    local newPosition <const> = {
      x = sprite.x + positionDelta.x,
      y = sprite.y + positionDelta.y,
    }

    sprite:moveTo(newPosition.x, newPosition.y)
  end

  self:UpdateHistoryFrame({
    center = self:GetCenterRelativeToBounds(),
    position = {
      x = self.x,
      y = self.y,
    },
  })
end

function Character:MoveToXYWithCollisions(x, y)
  local originalPosition <const> = {
    x = self.x,
    y = self.y,
  }
  local _selfActualX <const>,
        _selfActualY <const>,
        collisions <const> = self:moveWithCollisions(x, y)

  self:HandleCollisions(collisions)

  -- Set the delta after we handle collisions, in case the position changed.
  local positionDelta <const> = {
    x = self.x - originalPosition.x,
    y = self.y - originalPosition.y,
  }

  for i, sprite in ipairs(self.emptyCollisionSprites) do
    local newPosition <const> = {
      x = sprite.x + positionDelta.x,
      y = sprite.y + positionDelta.y,
    }
    local _spriteActualX <const>,
          _spriteActualY <const>,
          spriteCollisions <const> = sprite:moveWithCollisions(newPosition.x, newPosition.y)

    self:HandleCollisions(spriteCollisions)
  end

  self:UpdateHistoryFrame({
    center = self:GetCenterRelativeToBounds(),
    position = {
      x = self.x,
      y = self.y,
    },
  })
end

function Character:NormalizeHorizontalVelocity(speed)
  local flipSign <const> = self:GetFlipSign()
  local moveSign <const> = self:IsBack() and -1 or 1

  return speed * flipSign * moveSign
end

function Character:PrepareForNextLoop()
  self.history:Tick()
  self:UpdateCounters()
  self:UpdateFrameIndex()
end

function Character:RecenterSprite()
  local nextCenter <const> = self:GetCenterRelativeToBounds()
  local prevFrame <const> = self:GetHistoryFrame(self.history.counter - 1)
  local prevCenter <const> = prevFrame.center or nextCenter

  local xDelta <const> = prevCenter.x - nextCenter.x
  local x <const> = self.x + xDelta

  self:MoveToXY(x, self.y)
end

function Character:Reset()
  self.history:Reset()
  self:UpdateHistoryFrame({
    direction = self.startingDirection,
    health = self.health,
    stun = self.stun,
    super = 0,
  })

  self:ResetEmptyCollisionSprites()
  self:ResetPosition()
  self:ResetState()
end

function Character:ResetEmptyCollisionSprites()
  gfx.sprite.removeSprites(self.emptyCollisionSprites)
  self.emptyCollisionSprites = {}
end

function Character:ResetPosition()
  self:MoveToXY(self.startingPosition.x, self.startingPosition.y)
end

function Character:ResetState()
  self:SetState(firstFrame.state)
end

function Character:SetAnimationFrame()
  self:SetFrameImage()
  self:SetFrameCollisions()
end

function Character:SetCollisionBox(box)
  local boundsRect <const> = self:getBoundsRect()
  -- "offsetBy(dx, dy)" returns a new rect.
  local collideRect <const> = box.rect:offsetBy(boundsRect.x, boundsRect.y)
        collideRect:flipRelativeToRect(boundsRect, self:GetFlip())
  local collidesWithGroupMasks <const> = {
    Hitbox = collisionTypes.BALL | collisionTypes.HURTBOX,
    Hurtbox = collisionTypes.BALL | collisionTypes.HITBOX,
    Pushbox = collisionTypes.PUSHBOX
  }
  local groupMasks <const> = {
    Hitbox = collisionTypes.HITBOX,
    Hurtbox = collisionTypes.HURTBOX,
    Pushbox = collisionTypes.PUSHBOX,
  }

  local sprite <const> = self.addEmptyCollisionSprite(collideRect)
        sprite.collisionResponse = gfx.sprite.kCollisionTypeOverlap
        sprite.name = box.name -- For debugging ;)
        sprite.parent = self
        sprite.properties = box.properties
        sprite:setCollidesWithGroupsMask(collidesWithGroupMasks[box.type])
        sprite:setGroupMask(groupMasks[box.type])

  table.insert(self.emptyCollisionSprites, sprite)
end

function Character:SetFrameCollisions()
  local frame <const> = self:GetHistoryFrame()
  local nextFrame <const> = self:GetAnimationFrame(frame.frameIndex)

  self:ResetEmptyCollisionSprites()

  self:SetPushbox(nextFrame.collisions.Pushbox)

  for _, hitbox in ipairs(nextFrame.collisions.Hitboxes) do
    self:SetCollisionBox(hitbox)
  end

  for _, hurtbox in ipairs(nextFrame.collisions.Hurtboxes) do
    self:SetCollisionBox(hurtbox)
  end
end

function Character:SetFrameImage()
  local frame <const> = self:GetHistoryFrame()
  local nextImage <const> = self.imageTable:getImage(frame.frameIndex)

  self:setImage(nextImage)
  self:setImageFlip(self:GetFlip(), true)
end

function Character:SetPushbox(pushbox)
  local boundsRect <const> = self:getBoundsRect():copy()
        boundsRect.x = 0 -- TODO: Why do I have do this, again...?
  local pushboxRect <const> = pushbox.rect:copy()
        pushboxRect:flipRelativeToRect(boundsRect, self:GetFlip())

  self:setCollideRect(pushboxRect)
  self:setCollidesWithGroupsMask(collisionTypes.PUSHBOX | collisionTypes.WALL)
  self:setGroupMask(collisionTypes.PUSHBOX)

  self:UpdateHistoryFrame({
    center = self:GetCenterRelativeToBounds(),
  })

  self:RecenterSprite()
end

-- Because we are changing the sprite's collision rect for every animation frame,
-- it's possible to set it in a way that's overlapping another collision.
-- Since this causes the sprite to clip through the collision,
-- we need to take some extra steps to ensure that doesn't happen.
function Character:PreventClipping()
  local _actualX <const>,
        _actualY <const>,
        collisions <const> = self:checkCollisions(self.x, self.y)

  self:HandleCollisions(collisions)
end

function Character:SetState(state)
  local keyset = {}

  for k, v in pairs(charStates) do
    keyset[v] = k
  end

  local frame <const> = self:GetHistoryFrame()

  self:Debug('SetState()', state, keyset[state], frame.velocity.x)

  self:UpdateHistoryFrame({
    state = state,
  })

  self:DeriveImageTableFromState()
  self:SetAnimationFrame()
  self:DerivePhysicsFromState()
  -- self:markDirty()
end

function Character:TransitionState()
  if (self:HasDirectionChanged()) then
    if (self:IsWalking()) then
      if (self:IsForward()) then
        self:SetState(charStates.WALK | charStates.BACK)
      else
        self:SetState(charStates.WALK | charStates.FORWARD)
      end
    end
  end

  if (not self:HasAnimationFrameEnded() or not self:HasAnimationEnded()) then
    return
  end

  local animationData <const> = self:GetAnimationData()
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)
  local loops <const> = animationData.loops or frameData.loops

  if (frameData.nextState ~= nil) then
    self:SetState(frameData.nextState)

    return
  end

  -- Beginning and ending checks should come first

  if (self:IsBeginning()) then
    local statesToRemove <const> = charStates.BEGIN

    if (self:IsDashing()) then
      local newState = frame.state &~ statesToRemove

      self:SetState(newState)

      return
    end

    if (self:IsJumping()) then
      local newState = frame.state &~ statesToRemove
            newState |= charStates.AIRBORNE

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

  if (not loops) then
    self:SetState(charStates.STAND)

    return
  end
end

function Character:UpdateAnimationFrame()
  if (not self:HasStateChanged() and self:HasFrameIndexChanged()) then
    self:SetAnimationFrame()
  end
end

function Character:UpdateButtonStates()
  self:UpdateHistoryFrame({
    buttonState = { pd.getButtonState() }
  })
end

function Character:UpdateDirection()
  local frame <const> = self:GetHistoryFrame()
  local opponentCenter <const> = self.opponent:getBoundsRect():centerPoint()
  local selfCenter <const> = self:getBoundsRect():centerPoint()

  if (
    self:IsAttacking() or
    self:IsAirborne() or
    self:IsRunning()
  ) then
    return
  end

  if (
    opponentCenter.x > selfCenter.x and
    frame.direction ~= charDirections.RIGHT
  ) then
    self:UpdateHistoryFrame({
      direction = charDirections.RIGHT
    })
    self:setImageFlip(self:GetFlip(), true)
  elseif (
    opponentCenter.x < selfCenter.x and
    frame.direction ~= charDirections.LEFT
  ) then
    self:UpdateHistoryFrame({
      direction = charDirections.LEFT
    })
    self:setImageFlip(self:GetFlip(), true)
  end
end

function Character:UpdateCounters()
  local frame <const> = self:GetHistoryFrame()

  self:UpdateHistoryFrame({
    frameCounter = frame.frameCounter + 1
  })

  if (self:IsHitstunned()) then
    self:UpdateHistoryFrame({
      hitstun = frame.hitstun - 1
    })
  end
end

function Character:ShouldUpdateFrameIndex()
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  return frame.frameCounter > frameData.duration
end

function Character:UpdateFrameIndex()
  if (self:IsHitstunned() or not self:ShouldUpdateFrameIndex()) then
    return
  end

  local nextFrame <const> = self:GetHistoryFrame()
  local animationData <const> = self:GetAnimationData()
  local nextFrameIndex = nextFrame.frameIndex

  if (not self:HasAnimationEnded()) then
    nextFrameIndex += 1
  elseif (self:HasAnimationEnded() and animationData.loops) then
    nextFrameIndex = 1
  end

  self:UpdateHistoryFrame({
    frameCounter = 1,
    frameIndex = nextFrameIndex,
  })
  -- self:markDirty()
end

function Character:UpdateFrozenSprite()
  local filteredState <const> = self:GetFilteredStateForAnimation()
  local frame <const> = self:GetHistoryFrame()

  self.imageTable = self.imageTables[filteredState]
  self:SetFrameImage()
  self:moveTo(frame.position.x, frame.position.y)
end

function Character:UpdatePhysics()
  local newVelocity <const> = table.deepcopy(self:GetVelocity())

  if (self:IsAirborne()) then
    -- Apply gravity
    newVelocity.y += self.gravity
  end

  self:UpdateHistoryFrame({
    velocity = newVelocity
  })
  self:DerivePhysicsFromCurrentFrame()
end

function Character:UpdateHistoryFrame(properties, frameIndex)
  self.history:MutateFrame(properties, frameIndex)
end

function Character:UpdatePosition()
  local frame <const> = self:GetHistoryFrame()
  local newPosition <const> = {
    x = self.x + frame.velocity.x,
    y = self.y + frame.velocity.y,
  }

  -- If there's no velocity, exit early.
  -- if (frame.velocity.x == 0 and frame.velocity.y == 0) then
  --   return
  -- end

  self:MoveToXYWithCollisions(newPosition.x, newPosition.y)
end

function Character:WouldHitAWall(x, y)
  local _actualX <const>,
        _actualY <const>,
        collisions <const> = self:checkCollisions(x, y)

  for i, collision in ipairs(collisions) do
    local otherGroupMask <const> = collision.other:getGroupMask()

    if (otherGroupMask & collisionTypes.WALL ~= 0) then
      return true
    end
  end

  return false
end