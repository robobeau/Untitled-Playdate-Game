import 'CoreLibs/animation'
import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'

import 'frameData'
import 'inputs'
import 'loadableSprite'
import 'utils'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics
local img <const> = gfx.image
local poi <const> = geo.point
local rec <const> = geo.rect
local spr <const> = gfx.sprite

cancellableStates = {
  ATTACK = 1,
  BLOCK = 2,
  CHAIN = 4,
  JUMP = 8,
  MOVE = 16,
  SPECIAL = 32,
  SUPER = 64,
  THROW = 128,
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
  NORMAL = 6,
  FAST = 8,
  FASTER = 10,
  FASTEST = 12,
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
  DIZZY = 256,
  END = 512,
  ENTRANCE = 1024,
  FORWARD = 2048,
  HURT = 4096,
  JUMP = 8192,
  KICK = 16384,
  KNOCKDOWN = 32768,
  MOVE = 65536,
  PARRY = 131072,
  PUNCH = 262144,
  RISE = 524288,
  RUN = 1048576,
  SPECIAL = 2097152,
  STAND = 4194304,
  TAUNT = 8388608,
  THROW = 16777216,
  UP = 33554432,
  -- 67108864
  -- 134217728
  -- 268435456
  -- 536870912
  -- 1073741824
}
charStatesList = {
  'Airborne',
  'BlockAirborne',
  'BlockCrouch',
  'Block',
  'Crouch',
  'DashBack',
  'DashForward',
  'Entrance',
  'Hurt',
  'HurtAirborne',
  'HurtAirborneEnd',
  'HurtCrouch',
  'HurtThrow',
  'JumpBack',
  'JumpForward',
  'JumpNeutral',
  'KickCrouch',
  'KickJumpForward',
  'KickJumpNeutral',
  'KickForward',
  'KickNeutral',
  'KickBack',
  'Knockdown',
  'MoveBack',
  'MoveForward',
  'PunchCrouch',
  'PunchForward',
  'PunchJumpForward',
  'Rise',
  'Run',
  'Stand',
  'Throw',
  'ThrowBegin',
  'Transition',
}

local defaults <const> = {
  animations = {},
  assetsList = charStatesList,
  canDoubleJump = false,
  canRun = false,
  controllable = false,
  counter = 1,
  debug = false,
  emptyCollisionSprites = {},
  gravity = 1,
  health = 100,
  history = {
    counter = 1,
    frames = {
      firstFrame,
    }
  },
  hydratedAnimations = {},
  hydratedImagetables = {},
  imagetables = {},
  jumpHeight = charJumpHeights.NORMAL,
  menuImagePath = 'characters/Character/images/CharacterPortraitMenu',
  name = 'Character',
  opponent = nil,
  portraitImagePath = 'characters/Character/images/CharacterPortrait',
  soundFX = {},
  speeds = {
    dash = {
      back = charSpeeds.FASTER,
      forward = charSpeeds.FASTEST,
    },
    move = {
      back = charSpeeds.SLOW,
      forward = charSpeeds.NORMAL,
    },
    run = charSpeeds.FASTEST,
  },
  startingDirection = charDirections.RIGHT,
  startingPosition = {
    x = 0,
    y = 0,
  },
  stun = 50,
}
local firstFrame <const> = {
  buttonState = {},
  center = poi.new(0, 0),
  direction = charDirections.RIGHT,
  frameCounter = 1,
  frameIndex = 1,
  health = 0, -- Set on Reset()
  hitstun = 0,
  nextState = nil,
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

class('Character', defaults).extends(LoadableSprite)

function Character:collisionResponse(other)
  local otherGroupMask <const> = other:getGroupMask()
  local collidedWithPushbox <const> = otherGroupMask & collisionTypes.PUSHBOX ~= 0

  if (collidedWithPushbox) then
    return spr.kCollisionTypeOverlap
  end

  return spr.kCollisionTypeFreeze
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
  if (self:CheckSpecialInputs()) then
    return
  end

  if (self:CheckThrowInputs()) then
    local newState = charStates.THROW | charStates.BEGIN

    -- TODO: Account for direction in throws
    -- if (isPressingBack) then
    --   newState |= charStates.BACK
    -- elseif (isPressingForward) then
    --   newState |= charStates.FORWARD
    -- end

    self:SetState(newState)

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
end

function Character:CheckAttackInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  -- If we can't perform an attack, exit early.
  if (not frameData.checks.isAttackCancellable) then
    return
  end

  local hasPressedB <const> = frame.buttonState.pressed & pd.kButtonB ~= 0

  if (hasPressedB) then
    local newState = charStates.KICK
    local isAirborne <const> = frame.state & charStates.AIRBORNE ~= 0
    local isCrouching <const> = frame.state & charStates.CROUCH ~= 0
    local isDashing <const> = frame.state & charStates.DASH ~= 0

    if (isAirborne) then
      local isRunning <const> = frame.state & charStates.RUN ~= 0

      newState |= charStates.AIRBORNE

      if (math.abs(frame.velocity.x) > 0) then
        newState |= charStates.FORWARD
      end

      if (isRunning) then
        newState |= charStates.RUN
      elseif (isDashing) then
        newState |= charStates.DASH
      end
    elseif (isCrouching) then
      newState |= charStates.CROUCH
    else
      local isBack <const> = frame.state & charStates.BACK ~= 0
      local isForward <const> = frame.state & charStates.FORWARD ~= 0

      newState |= charStates.STAND

      if (isBack) then
        newState |= charStates.BACK
      elseif (isForward) then
        newState |= charStates.FORWARD
      end
    end

    self:SetState(newState)

    return true
  end

  local hasPressedA <const> = frame.buttonState.pressed & pd.kButtonA ~= 0

  if (hasPressedA) then
    local newState = charStates.PUNCH
    local isAirborne <const> = frame.state & charStates.AIRBORNE ~= 0
    local isCrouching <const> = frame.state & charStates.CROUCH ~= 0

    if (isAirborne) then
      local backInput <const> = frame.direction == charDirections.LEFT
        and pd.kButtonRight
        or pd.kButtonLeft
      local forwardInput <const> = frame.direction == charDirections.LEFT
        and pd.kButtonLeft
        or pd.kButtonRight
      local isDashing <const> = frame.state & charStates.DASH ~= 0
      local isPressingBack <const> = frame.buttonState.current & backInput ~= 0
      local isPressingForward <const> = frame.buttonState.current & forwardInput ~= 0
      local isRunning <const> = frame.state & charStates.RUN ~= 0

      newState |= charStates.AIRBORNE

      if (isPressingBack) then
        newState |= charStates.BACK
      elseif (isPressingForward) then
        newState |= charStates.FORWARD
      end

      if (isRunning) then
        newState |= charStates.RUN
      elseif (isDashing) then
        newState |= charStates.DASH
      end
    elseif (isCrouching) then
      newState |= charStates.CROUCH
    else
      newState |= charStates.STAND
    end

    self:SetState(newState)

    return true
  end
end

function Character:CheckBlockInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  if (not frameData.checks.isBlockCancellable) then
    return false
  end

  local backInput <const> = frame.direction == charDirections.LEFT
    and pd.kButtonRight
    or pd.kButtonLeft
  local isPressingBack <const> = frame.buttonState.current & backInput ~= 0

  if (isPressingBack) then
    return true
  end
end

function Character:CheckChainInputs()
  -- Overload this on each character's class!
end

function Character:CheckDashBackInput()
  local frame <const> = self.history.frames[self.history.counter]
  local backInput <const> = frame.direction == charDirections.LEFT
    and pd.kButtonRight
    or pd.kButtonLeft
  local isPressingBack <const> = frame.buttonState.current & backInput ~= 0

  if (isPressingBack) then
    local buttonStates <const> = {}
    local frameCount <const> = 10
    local start <const> = math.max(#self.history.frames - frameCount - 1, 1)
    local stop <const> = math.max(#self.history.frames - 1, 1)

    for i = start, stop, 1 do
      table.insert(buttonStates, self.history.frames[i].buttonState)
    end

    return Inputs:CheckDashBackInput(buttonStates, frame.direction)
  end
end

function Character:CheckDashForwardInput()
  local frame <const> = self.history.frames[self.history.counter]
  local forwardInput <const> = frame.direction == charDirections.LEFT
    and pd.kButtonLeft
    or pd.kButtonRight
  local isPressingForward <const> = frame.buttonState.current & forwardInput ~= 0

  if (isPressingForward) then
    local buttonStates <const> = {}
    local frameCount <const> = 10
    local start <const> = math.max(#self.history.frames - frameCount - 1, 1)
    local stop <const> = math.max(#self.history.frames - 1, 1)

    for i = start, stop, 1 do
      table.insert(buttonStates, self.history.frames[i].buttonState)
    end

    return Inputs:CheckDashForwardInput(buttonStates, frame.direction)
  end
end

function Character:CheckJumpInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  if (not frameData.checks.isJumpCancellable) then
    return false
  end

  local isJumping <const> = frame.state & charStates.JUMP ~= 0

  if (not isJumping) then
    local isPressingUp <const> = frame.buttonState.current & pd.kButtonUp ~= 0

    if (isPressingUp) then
      local backInput <const> = frame.direction == charDirections.LEFT
        and pd.kButtonRight
        or pd.kButtonLeft
      local forwardInput <const> = frame.direction == charDirections.LEFT
        and pd.kButtonLeft
        or pd.kButtonRight
      local isPressingBack <const> = frame.buttonState.current & backInput ~= 0
      local isPressingForward <const> = frame.buttonState.current & forwardInput ~= 0
      local newState = charStates.JUMP | charStates.BEGIN

      if (isPressingBack) then
        local isRunning <const> = frame.state & charStates.RUN ~= 0

        newState |= charStates.BACK

        if (isRunning) then
          newState |= charStates.RUN
        end
      elseif (isPressingForward) then
        local isRunning <const> = frame.state & charStates.RUN ~= 0

        newState |= charStates.FORWARD

        if (isRunning) then
          newState |= charStates.RUN
        end
      end

      self:SetState(newState)

      return true
    end
  end
end

function Character:CheckMovementInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  if (not frameData.checks.isMoveCancellable) then
    return false
  end

  local isCrouching <const> = frame.state & charStates.CROUCH ~= 0

  if (not isCrouching) then
    local isDashing <const> = frame.state & charStates.DASH ~= 0
    local isMoving <const> = frame.state & charStates.MOVE ~= 0
    local isRunning <const> = frame.state & charStates.RUN ~= 0

    -- Dash/Run check
    if (not isDashing and not isRunning) then
      if (self:CheckDashBackInput()) then
        self:SetState(charStates.DASH | charStates.BEGIN | charStates.BACK)

        return true
      elseif (self:CheckDashForwardInput()) then
        if (self.canRun) then
          self:SetState(charStates.RUN | charStates.BEGIN | charStates.FORWARD)
        else
          self:SetState(charStates.DASH | charStates.BEGIN | charStates.FORWARD)
        end

        return true
      end
    end

    -- Move check
    if (not isDashing and not isMoving and not isRunning) then
      local backInput <const> = frame.direction == charDirections.LEFT
        and pd.kButtonRight
        or pd.kButtonLeft
      local forwardInput <const> = frame.direction == charDirections.LEFT
        and pd.kButtonLeft
        or pd.kButtonRight
      local isPressingBack <const> = frame.buttonState.current & backInput ~= 0
      local isPressingForward <const> = frame.buttonState.current & forwardInput ~= 0

      if (isPressingBack) then
        self:SetState(charStates.MOVE | charStates.BACK)

        return true
      elseif (isPressingForward) then
        self:SetState(charStates.MOVE | charStates.FORWARD)

        return true
      end
    end

    -- Crouch check
    if (not isDashing) then
      local isPressingDown <const> = frame.buttonState.current & pd.kButtonDown ~= 0

      if (isPressingDown) then
        self:SetState(charStates.CROUCH)

        return true
      end
    end

    -- Stand checks
    if (isMoving or isRunning) then
      local backInput <const> = frame.direction == charDirections.LEFT
        and pd.kButtonRight
        or pd.kButtonLeft
      local forwardInput <const> = frame.direction == charDirections.LEFT
        and pd.kButtonLeft
        or pd.kButtonRight
      local hasReleasedBack <const> = frame.buttonState.released & backInput ~= 0
      local hasReleasedForward <const> = frame.buttonState.released & forwardInput ~= 0

      if (hasReleasedBack) then
        self:SetState(charStates.STAND)

        return true
      elseif (hasReleasedForward) then
        self:SetState(charStates.STAND)

        return true
      end
    end
  else
    local hasReleasedDown <const> = frame.buttonState.released & pd.kButtonDown ~= 0

    -- Stand check
    if (hasReleasedDown) then
      self:SetState(charStates.STAND)

      return true
    end
  end
end

function Character:CheckSpecialInputs()
  -- Overload this on each character's class!
end

function Character:CheckThrowInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  if (not frameData.checks.isThrowCancellable) then
    return false
  end

  local isThrowing <const> = frame.state & charStates.THROW ~= 0

  if (not isThrowing) then
    local hasPressedA <const> = frame.buttonState.pressed & pd.kButtonA ~= 0
    local hasPressedB <const> = frame.buttonState.pressed & pd.kButtonB ~= 0
    local isPressingA <const> = frame.buttonState.current & pd.kButtonA ~= 0
    local isPressingB <const> = frame.buttonState.current & pd.kButtonB ~= 0
    
    if (
      (hasPressedB and hasPressedA) or
      (hasPressedB and isPressingA) or
      (isPressingB and hasPressedA)
    ) then
      return true
    end
  end

  return false
end

function Character:CreateCollisionSprites(objects)
  local center = nil
  local opponentCenter = nil
  local collisions <const> = {
    Hitboxes = {},
    Hurtboxes = {},
    Pushbox = nil,
  }

  for _, object in ipairs(objects) do
    local properties <const> = object.properties or {}

    if (object.type == 'Center') then
      center = poi.new(object.x, object.y)
    elseif (object.type == 'Hitbox') then
      table.insert(collisions['Hitboxes'], Hitbox({
        character = self,
        collideRect = rec.new(object.x, object.y, object.width, object.height),
        name = object.name, -- For debugging ;)
        properties = properties,
      }))
    elseif (object.type == 'Hurtbox') then
      table.insert(collisions['Hurtboxes'], Hurtbox({
        character = self,
        collideRect = rec.new(object.x, object.y, object.width, object.height),
        name = object.name, -- For debugging ;)
        properties = properties,
      }))
    elseif (object.type == 'OpponentCenter') then
      opponentCenter = poi.new(object.x, object.y)
    elseif (object.type == 'Pushbox') then
      collisions['Pushbox'] = {
        collideRect = rec.new(object.x, object.y, object.width, object.height),
        name = object.name, -- For debugging ;)
        properties = properties,
      }
    end
  end

  return center, collisions, opponentCenter
end

-- For debugging ;)
function Character:Debug(...)
  if (self.debug) then
    printTable(...)
  end
end

function Character:DeriveImageTableFromState()
  local filteredState <const> = self:GetFilteredStateForAnimation()

  self.imagetable = self.imagetables[filteredState]

  table.assign(
    self.history.frames[self.history.counter],
    {
      -- TODO: This might need to be 0...?
      frameCounter = 1,
      frameIndex = 1,
    }
  )
end

function Character:DerivePhysicsFromCurrentFrame()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)
  local newVelocity <const> = {
    x = frame.velocity.x,
    y = frame.velocity.y,
  }


  if (frameData.velocityX ~= nil) then
    local flipSign <const> = self:GetFlipSign()

    newVelocity.x = frameData.velocityX * flipSign
  end

  if (frameData.velocityY ~= nil) then
    newVelocity.y = frameData.velocityY
  end

  table.assign(
    self.history.frames[self.history.counter],
    {
      velocity = newVelocity
    }
  )
end

function Character:DerivePhysicsFromState()
  local frame <const> = self.history.frames[self.history.counter]
  local isHurt <const> = frame.state & charStates.HURT ~= 0

  -- A hitbox's properties determine the physics for the Hurt state.
  if (isHurt) then
    return
  end

  local isAirborne <const> = frame.state & charStates.AIRBORNE ~= 0
  local isBeginning <const> = frame.state & charStates.BEGIN ~= 0
  local isDashing <const> = frame.state & charStates.DASH ~= 0
  local isEnding <const> = frame.state & charStates.END ~= 0
  local isMoving <const> = frame.state & charStates.MOVE ~= 0
  local isJumping <const> = frame.state & charStates.JUMP ~= 0
  local isRunning <const> = frame.state & charStates.RUN ~= 0
  local isTransitioning <const> = isBeginning or isEnding
  local newVelocity <const> = {
    x = frame.velocity.x,
    y = frame.velocity.y,
  }

  -- X Velocity

  if (isTransitioning) then
    newVelocity.x = 0
  elseif (isDashing) then
    newVelocity.x = self:GetDashVelocity()
  elseif (isJumping) then
    local isBack <const> = frame.state & charStates.BACK ~= 0
    local isForward <const> = frame.state & charStates.FORWARD ~= 0

    if (isRunning) then
      newVelocity.x = self:GetRunVelocity()
    elseif (isBack or isForward) then
      newVelocity.x = self:GetMoveVelocity()
    else
      -- Do nothing!
    end
  elseif (isRunning) then
    newVelocity.x = self:GetRunVelocity()
  elseif (isMoving) then
    newVelocity.x = self:GetMoveVelocity()
  elseif (not isAirborne) then
    newVelocity.x = 0
  end

  -- Y Velocity

  if (isTransitioning) then
    newVelocity.y = 0
  elseif (isJumping) then
    newVelocity.y = -self.jumpHeight
  elseif (not isAirborne) then
    newVelocity.y = 0
  end

  table.assign(
    self.history.frames[self.history.counter],
    {
      velocity = newVelocity
    }
  )

  self:DerivePhysicsFromCurrentFrame()
end

function Character:GetAnimationFrame(animationFrameIndex, historyFrameIndex)
  local animation <const> = self.animations[self:GetFilteredStateForAnimation(historyFrameIndex)]

  return animation.frames[animationFrameIndex]
end

function Character:GetCenterRelativeToBounds()
  local boundsRect <const> = self:getBoundsRect()
  local frame <const> = self.history.frames[self.history.counter]
  local animationFrame <const> = self:GetAnimationFrame(frame.frameIndex)
  local offset <const> = {
    x = self:IsFlipped(self.history.counter)
      and (boundsRect.x + boundsRect.width - (animationFrame.center.x * 2))
      or boundsRect.x,
    y = boundsRect.y,
  }

  -- "offsetBy(dx, dy)" returns a new point.
  return animationFrame.center:offsetBy(offset.x, offset.y)
end

-- Used by Stage
function Character:GetSpeed()
  local frame <const> = self.history.frames[self.history.counter]
  local isDashing <const> = frame.state & charStates.DASH ~= 0
  local isRunning <const> = frame.state & charStates.RUN ~= 0

  if (isRunning) then
    return self:GetRunSpeed()
  elseif (isDashing) then
    return self:GetDashSpeed()
  end

  return self:GetMoveSpeed()
end

function Character:GetDashSpeed()
  local frame <const> = self.history.frames[self.history.counter]
  local isBack <const> = frame.state & charStates.BACK ~= 0

  if (isBack) then
    return self.speeds.dash.back
  end

  return self.speeds.dash.forward
end

function Character:GetDashVelocity()
  return self:NormalizeHorizontalVelocity(self:GetDashSpeed())
end

-- To reduce the complexity of animation keys,
-- we want to remove certain states under certain conditions.
function Character:GetFilteredStateForAnimation(historyIndex)
  local frame <const> = self.history.frames[historyIndex or self.history.counter]
  local isBeginning <const> = frame.state & charStates.BEGIN ~= 0
  local isEnding <const> = frame.state & charStates.END ~= 0
  local isJumping <const> = frame.state & charStates.JUMP ~= 0
  local isKicking <const> = frame.state & charStates.KICK ~= 0
  local isPunching <const> = frame.state & charStates.PUNCH ~= 0
  local isSpecialing <const> = frame.state & charStates.SPECIAL ~= 0
  local isThrowing <const> = frame.state & charStates.THROW ~= 0
  local isAttacking <const> = isKicking or isPunching or isSpecialing or isThrowing
  local statesToRemove = 0

  -- Attacking is not visually affected by dashing... yet.
  -- Jumping is not visually affected by dashing.
  if (isAttacking or isJumping) then
    statesToRemove |= charStates.DASH | charStates.RUN | charStates.MOVE
  end

  -- There's currently only one possible transition animation,
  -- so we don't need to distinguish between back/forward movement.
  if (isBeginning or isEnding) then
    statesToRemove |= charStates.BACK | charStates.FORWARD
  end

  return frame.state &~ statesToRemove
end

function Character:GetFlip(frameIndex)
  return self:IsFlipped(frameIndex)
    and gfx.kImageFlippedX
    or gfx.kImageUnflipped
end

function Character:GetFlipSign(frameIndex)
  return self:IsFlipped(frameIndex)
    and -1
    or 1
end

function Character:GetFrameData(animationFrameIndex, historyFrameIndex)
  local frame <const> = self:GetAnimationFrame(animationFrameIndex, historyFrameIndex)

  return frame.data
end

function Character:GetRunSpeed()
  return self.speeds.run
end

function Character:GetRunVelocity()
  return self:NormalizeHorizontalVelocity(self:GetRunSpeed())
end

function Character:GetMoveSpeed()
  local frame <const> = self.history.frames[self.history.counter]
  local isBack <const> = frame.state & charStates.BACK ~= 0

  if (isBack) then
    return self.speeds.move.back
  end

  return self.speeds.move.forward
end

function Character:GetMoveVelocity()
  return self:NormalizeHorizontalVelocity(self:GetMoveSpeed())
end

function Character:GetThrown(hitbox)
  local character <const> = hitbox.character
  local characterFrame <const> = character.history.frames[character.history.counter]
  local frame <const> = self.history.frames[self.history.counter]
  local health = frame.health
  local hitstun = frame.hitstun
  local newVelocity <const> = {
    x = frame.velocity.x,
    y = frame.velocity.y,
  }

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

  table.assign(
    self.history.frames[self.history.counter],
    {
      health = health,
      hitstun = hitstun,
      velocity = newVelocity,
    }
  )

  if (self.OnHealthChange) then
    self.OnHealthChange(health)
  end

  if (hitbox.properties.opponentNextState) then
    self:SetState(hitbox.properties.opponentNextState)
  else
    self:SetState(charStates.HURT | charStates.THROW)
  end

  spr.removeSprites({ hitbox })
end

function Character:HandleCollisions(collisions)
  for i, collision in ipairs(collisions) do
    if (collision.type == spr.kCollisionTypeFreeze) then
      self:HandleFreezeCollision(collision)
    elseif (collision.type == spr.kCollisionTypeOverlap) then
      self:HandleOverlapCollision(collision)
    end
  end
end

function Character:HandleFreezeCollision(collision)
  local otherGroupMask <const> = collision.other:getGroupMask()
  local collidedWithWall <const> = otherGroupMask & collisionTypes.WALL ~= 0

  if (collidedWithWall) then
    self:HandleWallCollision(collision)
  end
end

function Character:HandleOverlapCollision(collision)
  local otherGroupMask <const> = collision.other:getGroupMask()
  local collidedWithPushbox <const> = otherGroupMask & collisionTypes.PUSHBOX ~= 0

  if (collidedWithPushbox) then
    self:HandlePushboxCollision(collision)
  end
end

function Character:HandlePushboxCollision(collision)
  local character <const> = collision.sprite
  local opponent <const> = collision.other

  if (collision.normal.x ~= 0) then
    local characterBoundsX <const>, characterBoundsY <const> = character:getBounds()
    local characterPushbox <const> = character:getCollideRect()
    local characterOffsetPushbox <const> = characterPushbox:offsetBy(characterBoundsX, characterBoundsY)
    local characterCenter <const> = characterOffsetPushbox:centerPoint()
    local opponentBoundsX <const>, opponentBoundsY <const> = opponent:getBounds()
    local opponentPushbox <const> = opponent:getCollideRect()
    local opponentOffsetPushbox <const> = opponentPushbox:offsetBy(opponentBoundsX, opponentBoundsY)
    local opponentCenter <const> = opponentOffsetPushbox:centerPoint()

    if (collision.normal.x < 0) then -- Collided with the opponent's left side
      if (math.abs(collision.move.x) > 0) then
        local hasCrossedOver <const> = characterCenter.x > opponentCenter.x

        if (hasCrossedOver) then -- Crossed over to the opponent's right side
          local opponentRightEdge <const> = opponentOffsetPushbox.right + (characterPushbox.width / 2)

          if (character:WouldHitAWall(opponentRightEdge, character.y)) then
            local characterLeftEdge <const> = characterOffsetPushbox.left - (opponentPushbox.width / 2)

            opponent:MoveToXY(characterLeftEdge, opponent.y)
          else
            character:MoveToXY(opponentRightEdge, character.y)
          end
        else
          local opponentLeftEdge <const> = opponentOffsetPushbox.left - (characterPushbox.width / 2)

          if (character:WouldHitAWall(opponentLeftEdge, character.y)) then
            local characterRightEdge <const> = characterOffsetPushbox.right + (opponentPushbox.width / 2)

            opponent:MoveToXY(characterRightEdge, opponent.y)
          else
            character:MoveToXY(opponentLeftEdge, character.y)
          end
        end
      end
    else -- Collided with the opponent's right side
      if (math.abs(collision.move.x) > 0) then
        local hasCrossedOver <const> = characterCenter.x <= opponentCenter.x

        if (hasCrossedOver) then -- Crossed over to the opponent's left side
          local opponentLeftEdge <const> = opponentOffsetPushbox.left - (characterPushbox.width / 2)

          if (character:WouldHitAWall(opponentLeftEdge, character.y)) then
            local characterRightEdge <const> = characterOffsetPushbox.right + (opponentPushbox.width / 2)

            opponent:MoveToXY(characterRightEdge, opponent.y)
          else
            character:MoveToXY(opponentLeftEdge, character.y)
          end
        else
          local opponentRightEdge <const> = opponentOffsetPushbox.right + (characterPushbox.width / 2)

          if (character:WouldHitAWall(opponentRightEdge, character.y)) then
            local characterLeftEdge <const> = characterOffsetPushbox.left - (opponentPushbox.width / 2)

            opponent:MoveToXY(characterLeftEdge, opponent.y)
          else
            character:MoveToXY(opponentRightEdge, character.y)
          end
        end
      end
    end
  end
end

function Character:HandleWallCollision(collision)
  local frame <const> = self.history.frames[self.history.counter]
  local newVelocity <const> = {
    x = frame.velocity.x,
    y = frame.velocity.y,
  }

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

  table.assign(
    self.history.frames[self.history.counter],
    {
      velocity = newVelocity
    }
  )
end

function Character:HandleJumpEnd()
  local frame <const> = self.history.frames[self.history.counter]
  local isBeginning <const> = frame.state & charStates.BEGIN ~= 0
  local isEnding <const> = frame.state & charStates.END ~= 0
  local isTransitioning <const> = isBeginning or isEnding

  if (isTransitioning) then
    return
  end

  local isHurt <const> = frame.state & charStates.HURT ~= 0
  local isKnockedDown <const> = frame.state & charStates.KNOCKDOWN ~= 0

  if (isHurt) then
    self:SetState(charStates.HURT | charStates.AIRBORNE | charStates.END)
  elseif (not isKnockedDown) then
    self:SetState(charStates.JUMP | charStates.END)
  end
end

function Character:HasAnimationEnded()
  local frame <const> = self.history.frames[self.history.counter]

  return frame.frameIndex == self.imagetable:getLength()
end

function Character:HasAnimationFrameEnded()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  return frame.frameCounter == frameData.duration
end

function Character:HasDirectionChanged()
  local current <const> = self.history.frames[self.history.counter]
  local prev <const> = self.history.frames[self.history.counter - 1] or {}

  if (prev == nil) then
    return false
  end

  return current.direction ~= prev.direction
end

function Character:HasFrameIndexChanged()
  local current <const> = self.history.frames[self.history.counter]
  local prev <const> = self.history.frames[self.history.counter - 1] or {}

  if (prev == nil) then
    return false
  end

  return prev.frameIndex ~= current.frameIndex
end

function Character:HasStateChanged()
  local current <const> = self.history.frames[self.history.counter]
  local prev <const> = self.history.frames[self.history.counter - 1] or {}

  if (prev == nil) then
    return false
  end

  return current.state ~= prev.state
end

function Character:HydrateAnimation(animation)
  local animationData <const> = animation.properties or {}
  local frames <const> = {}

  for i, frame in ipairs(animation.tiles) do
    local frameData <const> = frame.properties or {}
    local center <const>, collisions <const>, opponentCenter <const> = self:CreateCollisionSprites(frame.objectGroup.objects)

    -- for j, hitbox in ipairs(collisions.Hitboxes) do
    --   if (frameData.soundFX) then
    --     if (frameData.soundFX.onBlock) then
    --       hitbox.soundFX.onBlock = self:SetSoundFX(frameData.soundFX.onBlock)
    --     end

    --     if (frameData.soundFX.onHit) then
    --       hitbox.soundFX.onHit = self:SetSoundFX(frameData.soundFX.onHit)
    --     end

    --     if (frameData.soundFX.onWhiff) then
    --       hitbox.soundFX.onWhiff = self:SetSoundFX(frameData.soundFX.onWhiff)
    --     end
    --   else
    --     hitbox.soundFX.onBlock = self.soundFX['genericOnBlock']
    --     hitbox.soundFX.onHit = self.soundFX['genericOnHit']
    --     hitbox.soundFX.onWhiff = self.soundFX['genericOnWhiff']
    --   end
    -- end

    frames[i] = {
      center = center,
      collisions = collisions,
      data = FrameData(frameData),
      image = frame.image,
      opponentCenter = opponentCenter,
    }
  end

  return {
    data = animationData,
    frames = frames,
    name = animation.name, -- For debugging ;)
  }
end

function Character:HydrateImageTable(animation)
  local imagetable <const> = gfx.imagetable.new(#animation.frames)
  local images <const> = {}

  for i, frame in ipairs(animation.frames) do
    local image
    local imagePath = frame.image
          -- Chop off the "../" and ".gif"
          imagePath = string.gsub(imagePath, '%.%./', 'characters/' .. self.name .. '/')
          imagePath = string.gsub(imagePath, '%.gif', '')

    if (images[imagePath] ~= nil) then
      image = images[imagePath]
    else
      image = img.new(imagePath)
      images[imagePath] = image
    end

    imagetable:setImage(i, image)
  end

  return imagetable
end

function Character:init(options)
  Character.super.init(self)

  local config <const> = options or {}

  self.animations = {}
  self.canDoubleJump = config.canDoubleJump or self.canDoubleJump
  self.canRun = config.canRun or self.canRun
  self.controllable = config.controllable or self.controllable
  self.debug = config.debug or self.debug -- For debugging ;)
  self.emptyCollisionSprites = {}
  self.gravity = config.gravity or self.gravity
  self.health = config.health or self.health
  self.history = {
    counter = 1,
    frames = {
      firstFrame,
    }
  }
  self.hydratedAnimations = {}
  self.hydratedImagetables = {}
  self.imagetables = {}
  self.jumpHeight = config.jumpHeight or self.jumpHeight
  self.name = config.name or self.name
  self.opponent = config.opponent or self.opponent
  self.soundFX = {
    ['genericOnBlock'] = self:SetSoundFX('/sounds/blocks/block_small_10.wav'),
    ['genericOnHit'] = self:SetSoundFX('/sounds/hits/face_hit_small_01.wav'),
    ['genericOnWhiff'] = self:SetSoundFX('/sounds/whooshes/kick_short_whoosh_01.wav'),
  }
  self.speeds = config.speeds or self.speeds
  self.startingDirection = config.startingDirection or self.startingDirection
  self.startingPosition = config.startingPosition or self.startingPosition
  self.stun = config.stun or self.stun

  self:setCenter(0.5, 1)
  self:setCollidesWithGroupsMask(collisionTypes.PUSHBOX | collisionTypes.WALL)
  self:setGroupMask(collisionTypes.PUSHBOX)
  self:setZIndex(1)
end

function Character:IsFlipped(frameIndex)
  local frame <const> = self.history.frames[frameIndex or self.history.counter]

  return frame.direction == charDirections.LEFT
end

function Character:LoadAsset()
  self:LoadAnimation()
  self:LoadImagetable()
end

function Character:LoadAnimation()
  local animationName <const> = self.assetsList[self.assetIndex]
  local animation <const> = self.AnimationObjects[animationName]

  self.hydratedAnimations[animationName] = self:HydrateAnimation(animation)
end

function Character:LoadImagetable()
  local animationName <const> = self.assetsList[self.assetIndex]
  local hydratedAnimation <const> = self.hydratedAnimations[animationName]

  self.hydratedImagetables[animationName] = self:HydrateImageTable(hydratedAnimation)
end

function Character:MoveToXY(x, y)
  self:moveTo(x, y)

  table.assign(
    self.history.frames[self.history.counter],
    {
      center = self:GetCenterRelativeToBounds(),
      position = {
        x = self.x,
        y = self.y,
      },
    }
  )
end

function Character:MoveToXYWithCollisions(x, y)
  local actualX <const>,
        actualY <const>,
        collisions <const> = self:moveWithCollisions(x, y)

  self:HandleCollisions(collisions)

  table.assign(
    self.history.frames[self.history.counter],
    {
      center = self:GetCenterRelativeToBounds(),
      position = {
        x = self.x,
        y = self.y,
      },
    }
  )
end

function Character:NormalizeHorizontalVelocity(speed)
  local frame <const> = self.history.frames[self.history.counter]
  local flipSign <const> = self:GetFlipSign()
  local isBack <const> = frame.state & charStates.BACK ~= 0
  local moveSign <const> = isBack and -1 or 1

  return speed * flipSign * moveSign
end

function Character:OnLoaded()
  self:SetAnimations()
  self:SetImagetables()

  self.menuImage = img.new(self.menuImagePath)
  self.portraitImage = img.new(self.portraitImagePath)

  self:Reset()
end

function Character:PrepareForNextLoop()
  local nextFrame = {}
  local prevFrame <const> = self.history.frames[self.history.counter]
  -- local nextFrame <const> = table.deepcopy(self.history.frames[self.history.counter])

  self.history.counter += 1

  -- if (self.history.counter % 10) then
    nextFrame = table.deepcopy(prevFrame)
  -- end

  self.history.frames[self.history.counter] = nextFrame
  -- self.history.frames[self.history.counter - 30] = nil

  self:UpdateCounters()

  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)
  local isHitstunned <const> = frameData.hitstunnable and (frame.hitstun > 0)
  local shouldUpdateFrameIndex <const> = frame.frameCounter > frameData.duration

  if (not isHitstunned and shouldUpdateFrameIndex) then
    self:UpdateFrameIndex()
  end
end

function Character:Reset()
  self:setUpdatesEnabled(false)

  self.history.counter = 1
  self.history.frames = {
    firstFrame,
  }

  table.assign(
    self.history.frames[self.history.counter],
    {
      direction = self.startingDirection,
      health = self.health,
      stun = self.stun,
      super = 0,
    }
  )

  self:ResetEmptyCollisionSprites()
  self:ResetState()
  self:ResetPosition()

  self:setUpdatesEnabled(true)
end

function Character:ResetEmptyCollisionSprites()
  spr.removeSprites(self.emptyCollisionSprites)
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
    -- self:PlaySoundFX()
end

function Character:SetAnimations()
  -- Airborne
  self.animations[charStates.AIRBORNE] = self.hydratedAnimations['Airborne']

  -- Blocking
  self.animations[charStates.BLOCK | charStates.AIRBORNE] = self.hydratedAnimations['BlockAirborne']
  self.animations[charStates.BLOCK | charStates.CROUCH] = self.hydratedAnimations['BlockCrouch']
  self.animations[charStates.BLOCK | charStates.STAND] = self.hydratedAnimations['Block']

  -- Crouching
  self.animations[charStates.CROUCH] = self.hydratedAnimations['Crouch']

  -- Dashing
  self.animations[charStates.DASH | charStates.BACK] = self.hydratedAnimations['DashBack']
  self.animations[charStates.DASH | charStates.BEGIN] = self.hydratedAnimations['Transition']
  self.animations[charStates.DASH | charStates.END] = self.hydratedAnimations['Transition']
  self.animations[charStates.DASH | charStates.FORWARD] = self.hydratedAnimations['DashForward']

  -- Entrance
  self.animations[charStates.ENTRANCE] = self.hydratedAnimations['Entrance']

  -- Hurt
  self.animations[charStates.HURT | charStates.AIRBORNE] = self.hydratedAnimations['HurtAirborne']
  self.animations[charStates.HURT | charStates.AIRBORNE | charStates.END] = self.hydratedAnimations['HurtAirborneEnd']
  self.animations[charStates.HURT | charStates.CROUCH] = self.hydratedAnimations['HurtCrouch']
  self.animations[charStates.HURT | charStates.THROW] = self.hydratedAnimations['HurtThrow']
  self.animations[charStates.HURT | charStates.STAND] = self.hydratedAnimations['Hurt']

  -- Kicking
  self.animations[charStates.KICK | charStates.AIRBORNE] = self.hydratedAnimations['KickJumpNeutral']
  self.animations[charStates.KICK | charStates.AIRBORNE | charStates.BACK] = self.hydratedAnimations['KickJumpForward']
  self.animations[charStates.KICK | charStates.AIRBORNE | charStates.FORWARD] = self.hydratedAnimations['KickJumpForward']
  self.animations[charStates.KICK | charStates.CROUCH] = self.hydratedAnimations['KickCrouch']
  self.animations[charStates.KICK | charStates.STAND] = self.hydratedAnimations['KickNeutral']
  self.animations[charStates.KICK | charStates.STAND | charStates.BACK] = self.hydratedAnimations['KickBack']
  self.animations[charStates.KICK | charStates.STAND | charStates.FORWARD] = self.hydratedAnimations['KickForward']

  -- Knockdown
  self.animations[charStates.KNOCKDOWN] = self.hydratedAnimations['Knockdown']

  -- Jumping
  self.animations[charStates.JUMP | charStates.AIRBORNE] = self.hydratedAnimations['JumpNeutral']
  self.animations[charStates.JUMP | charStates.AIRBORNE | charStates.BACK] = self.hydratedAnimations['JumpBack']
  self.animations[charStates.JUMP | charStates.AIRBORNE | charStates.FORWARD] = self.hydratedAnimations['JumpForward']
  self.animations[charStates.JUMP | charStates.BEGIN] = self.hydratedAnimations['Transition']
  self.animations[charStates.JUMP | charStates.END] = self.hydratedAnimations['Transition']

  -- Moving
  self.animations[charStates.MOVE | charStates.BACK] = self.hydratedAnimations['MoveBack']
  self.animations[charStates.MOVE | charStates.FORWARD] = self.hydratedAnimations['MoveForward']

  -- Punching
  self.animations[charStates.PUNCH | charStates.AIRBORNE] = self.hydratedAnimations['PunchJumpForward']
  self.animations[charStates.PUNCH | charStates.AIRBORNE | charStates.BACK] = self.hydratedAnimations['PunchJumpForward']
  self.animations[charStates.PUNCH | charStates.AIRBORNE | charStates.FORWARD] = self.hydratedAnimations['PunchJumpForward']
  self.animations[charStates.PUNCH | charStates.CROUCH] = self.hydratedAnimations['PunchCrouch']
  self.animations[charStates.PUNCH | charStates.STAND] = self.hydratedAnimations['PunchForward']

  -- Rising
  self.animations[charStates.RISE] = self.hydratedAnimations['Rise']

  -- Running
  self.animations[charStates.RUN | charStates.BEGIN] = self.hydratedAnimations['Transition']
  self.animations[charStates.RUN | charStates.END] = self.hydratedAnimations['Transition']
  self.animations[charStates.RUN | charStates.FORWARD] = self.hydratedAnimations['Run']

  -- Standing
  self.animations[charStates.STAND] = self.hydratedAnimations['Stand']

  -- Throw
  self.animations[charStates.THROW] = self.hydratedAnimations['Throw']
  self.animations[charStates.THROW | charStates.BEGIN] = self.hydratedAnimations['ThrowBegin']
end

function Character:SetImagetables()
  -- Airborne
  self.imagetables[charStates.AIRBORNE] = self.hydratedImagetables['Airborne']

  -- Blocking
  self.imagetables[charStates.BLOCK | charStates.AIRBORNE] = self.hydratedImagetables['BlockAirborne']
  self.imagetables[charStates.BLOCK | charStates.CROUCH] = self.hydratedImagetables['BlockCrouch']
  self.imagetables[charStates.BLOCK | charStates.STAND] = self.hydratedImagetables['Block']

  -- Crouching
  self.imagetables[charStates.CROUCH] = self.hydratedImagetables['Crouch']

  -- Dashing
  self.imagetables[charStates.DASH | charStates.BACK] = self.hydratedImagetables['DashBack']
  self.imagetables[charStates.DASH | charStates.BEGIN] = self.hydratedImagetables['Transition']
  self.imagetables[charStates.DASH | charStates.END] = self.hydratedImagetables['Transition']
  self.imagetables[charStates.DASH | charStates.FORWARD] = self.hydratedImagetables['DashForward']

  -- Entrance
  self.imagetables[charStates.ENTRANCE] = self.hydratedImagetables['Entrance']

  -- Hurt
  self.imagetables[charStates.HURT | charStates.AIRBORNE] = self.hydratedImagetables['HurtAirborne']
  self.imagetables[charStates.HURT | charStates.AIRBORNE | charStates.END] = self.hydratedImagetables['HurtAirborneEnd']
  self.imagetables[charStates.HURT | charStates.CROUCH] = self.hydratedImagetables['HurtCrouch']
  self.imagetables[charStates.HURT | charStates.THROW] = self.hydratedImagetables['HurtThrow']
  self.imagetables[charStates.HURT | charStates.STAND] = self.hydratedImagetables['Hurt']

  -- Kicking
  self.imagetables[charStates.KICK | charStates.AIRBORNE] = self.hydratedImagetables['KickJumpNeutral']
  self.imagetables[charStates.KICK | charStates.AIRBORNE | charStates.BACK] = self.hydratedImagetables['KickJumpForward']
  self.imagetables[charStates.KICK | charStates.AIRBORNE | charStates.FORWARD] = self.hydratedImagetables['KickJumpForward']
  self.imagetables[charStates.KICK | charStates.CROUCH] = self.hydratedImagetables['KickCrouch']
  self.imagetables[charStates.KICK | charStates.STAND] = self.hydratedImagetables['KickNeutral']
  self.imagetables[charStates.KICK | charStates.STAND | charStates.BACK] = self.hydratedImagetables['KickBack']
  self.imagetables[charStates.KICK | charStates.STAND | charStates.FORWARD] = self.hydratedImagetables['KickForward']

  -- Knockdown
  self.imagetables[charStates.KNOCKDOWN] = self.hydratedImagetables['Knockdown']

  -- Jumping
  self.imagetables[charStates.JUMP | charStates.AIRBORNE] = self.hydratedImagetables['JumpNeutral']
  self.imagetables[charStates.JUMP | charStates.AIRBORNE | charStates.BACK] = self.hydratedImagetables['JumpBack']
  self.imagetables[charStates.JUMP | charStates.AIRBORNE | charStates.FORWARD] = self.hydratedImagetables['JumpForward']
  self.imagetables[charStates.JUMP | charStates.BEGIN] = self.hydratedImagetables['Transition']
  self.imagetables[charStates.JUMP | charStates.END] = self.hydratedImagetables['Transition']

  -- Moving
  self.imagetables[charStates.MOVE | charStates.BACK] = self.hydratedImagetables['MoveBack']
  self.imagetables[charStates.MOVE | charStates.FORWARD] = self.hydratedImagetables['MoveForward']

  -- Punching
  self.imagetables[charStates.PUNCH | charStates.AIRBORNE] = self.hydratedImagetables['PunchJumpForward']
  self.imagetables[charStates.PUNCH | charStates.AIRBORNE | charStates.BACK] = self.hydratedImagetables['PunchJumpForward']
  self.imagetables[charStates.PUNCH | charStates.AIRBORNE | charStates.FORWARD] = self.hydratedImagetables['PunchJumpForward']
  self.imagetables[charStates.PUNCH | charStates.CROUCH] = self.hydratedImagetables['PunchCrouch']
  self.imagetables[charStates.PUNCH | charStates.STAND] = self.hydratedImagetables['PunchForward']

  -- Rising
  self.imagetables[charStates.RISE] = self.hydratedImagetables['Rise']

  -- Running
  self.imagetables[charStates.RUN | charStates.BEGIN] = self.hydratedImagetables['Transition']
  self.imagetables[charStates.RUN | charStates.END] = self.hydratedImagetables['Transition']
  self.imagetables[charStates.RUN | charStates.FORWARD] = self.hydratedImagetables['Run']

  -- Standing
  self.imagetables[charStates.STAND] = self.hydratedImagetables['Stand']

  -- Throwing
  self.imagetables[charStates.THROW] = self.hydratedImagetables['Throw']
  self.imagetables[charStates.THROW | charStates.BEGIN] = self.hydratedImagetables['ThrowBegin']
end

function Character:SetNextState(state)
  table.assign(
    self.history.frames[self.history.counter],
    {
      nextState = state
    }
  )
end

-- function Character:PlaySoundFX()
--   local frame <const> = self.history.frames[self.history.counter]
--   local frameData <const> = self:GetFrameData(frame.frameIndex)

--   -- self:Debug('Sound FX', frame.soundFX, frameData.soundFX)

--   if (frameData.soundFX) then
--     local soundFXPath = frameData.soundFX.onWhiff
--           -- Chop off the "../" and ".wav"
--           soundFXPath = string.gsub(soundFXPath, '%.%./', '/')
--           soundFXPath = string.gsub(soundFXPath, '%.wav', '')

--     self.soundFX[soundFXPath]:play()
--   end
-- end

function Character:SetFrameCollisions()
  local frame <const> = self.history.frames[self.history.counter]
  local nextAnimationFrame <const> = self:GetAnimationFrame(frame.frameIndex)

  self:ResetEmptyCollisionSprites()

  self:SetPushbox(nextAnimationFrame.collisions.Pushbox)

  for _, hitbox in ipairs(nextAnimationFrame.collisions.Hitboxes) do
    hitbox:add()
    hitbox:OnAdd()

    table.insert(self.emptyCollisionSprites, hitbox)
  end

  for _, hurtbox in ipairs(nextAnimationFrame.collisions.Hurtboxes) do
    hurtbox:add()
    hurtbox:OnAdd()

    table.insert(self.emptyCollisionSprites, hurtbox)
  end
end

function Character:SetFrameImage()
  local frame <const> = self.history.frames[self.history.counter]
  local nextImage <const> = self.imagetable[frame.frameIndex]

  self:setImage(nextImage, self:GetFlip())

  local nextCenter <const> = self:GetCenterRelativeToBounds()
  local prevFrame <const> = self.history.frames[self.history.counter - 1] or {}
  local prevCenter <const> = prevFrame.center or nextCenter

  local xDelta <const> = prevCenter.x - nextCenter.x
  local yDelta <const> = prevCenter.y - nextCenter.y

  self:setBounds(self:getBoundsRect():offsetBy(xDelta, yDelta))
  self:markDirty()

  table.assign(
    self.history.frames[self.history.counter],
    {
      center = self:GetCenterRelativeToBounds(),
      position = {
        x = self.x,
        y = self.y,
      },
    }
  )
end

function Character:SetPushbox(pushbox)
  local boundsRect <const> = self:getBoundsRect():copy()
        boundsRect.x = 0
  local pushboxRect <const> = pushbox.collideRect:copy()
        pushboxRect:flipRelativeToRect(boundsRect, self:GetFlip())

  self:setCollideRect(pushboxRect)

  table.assign(
    self.history.frames[self.history.counter],
    {
      center = self:GetCenterRelativeToBounds(),
    }
  )
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

  local keyset = {}

  for k, v in pairs(charStates) do
    keyset[v] = k
  end

function Character:SetSoundFX(soundFXPath)
  -- Chop off the "../" and ".wav"
  soundFXPath = string.gsub(soundFXPath, '%.%./%.%./%.%./', '/')

  if (not self.soundFX[soundFXPath]) then
    self.soundFX[soundFXPath] = pd.sound.sampleplayer.new(soundFXPath)
  end

  return self.soundFX[soundFXPath]
end

function Character:SetState(state)
  table.assign(
    self.history.frames[self.history.counter],
    {
      state = state,
    }
  )

  self:DeriveImageTableFromState()
  self:SetAnimationFrame()
  self:DerivePhysicsFromState()
end

function Character:TakeDamage(hitbox, isBlocking)
  local frame <const> = self.history.frames[self.history.counter]
  local health = frame.health
  local hitstun = frame.hitstun
  local newVelocity <const> = {
    x = frame.velocity.x,
    y = frame.velocity.y,
  }

  if (hitbox.properties.damage) then
    local damage <const> = isBlocking
      and (hitbox.properties.damage / 2)
      or hitbox.properties.damage

    -- TODO: Supers should be able to kill, even while blocking
    health -= math.max(damage, 1)
  end

  if (hitbox.properties.hitstun) then
    hitstun = hitbox.properties.hitstun
  end

  if (not isBlocking) then
    if (hitbox.properties.launch) then
      -- Note the negation of "hitbox.properties.launch"
      newVelocity.y = -hitbox.properties.launch
    end
  end

  if (hitbox.properties.pushback) then
    -- Note the negation of "GetFlipSign()"
    newVelocity.x = hitbox.properties.pushback * -self:GetFlipSign()
  end

  table.assign(
    self.history.frames[self.history.counter],
    {
      health = health,
      hitstun = hitstun,
      velocity = newVelocity,
    }
  )

  local isAirborne <const> = frame.state & charStates.AIRBORNE ~= 0
  local isCrouching <const> = frame.state & charStates.CROUCH ~= 0
  local newState = isBlocking
    and charStates.BLOCK
    or charStates.HURT

  if (isAirborne) then
    newState |= charStates.AIRBORNE
  elseif (isCrouching) then
      newState |= charStates.CROUCH
  else
    -- Did the character get sweeped?
    if (hitbox.properties.type == collisionBoxTypes.LOW) then
      -- TODO: Make a better state than this
      newState = charStates.HURT | charStates.AIRBORNE
      newVelocity.y = -3
    else
      newState |= charStates.STAND
    end
  end

  self:SetState(newState)

  if (self.OnHealthChange) then
    self.OnHealthChange(health)
  end

  spr.removeSprites({ hitbox })
end

function Character:Teardown()
  -- TODO: Clear every single image in "self.imagetables"
  spr.removeSprites(self.emptyCollisionSprites)

  self.animations = {}
  self.history = {}
  self.hydratedAnimations = {}
  self.hydratedImagetables = {}
end

function Character:TransitionState()
  local frame <const> = self.history.frames[self.history.counter]

  local isHurt <const> = frame.state & charStates.HURT ~= 0
  local isThrowing <const> = frame.state & charStates.THROW ~= 0
  local isThrown <const> = isHurt and isThrowing

  if (isThrown) then
    local opponentFrame <const> = self.opponent.history.frames[self.opponent.history.counter]
    local opponentFrameData <const> = self.opponent:GetAnimationFrame(opponentFrame.frameIndex)

    if (opponentFrameData.opponentCenter) then
      local isOpponentFlipped <const> = opponentFrame.direction == charDirections.LEFT
      local opponentBoundsRect <const> = self.opponent:getBoundsRect()
      local offsetCenter <const> = opponentFrameData.opponentCenter:offsetBy(opponentBoundsRect.x, opponentBoundsRect.y)
            offsetCenter.x = isOpponentFlipped
              and (offsetCenter.x + opponentBoundsRect.width - (opponentFrameData.opponentCenter.x * 2))
              or offsetCenter.x
            offsetCenter.y = offsetCenter.y + (self.height / 2)

      self:MoveToXY(offsetCenter.x, offsetCenter.y)
    end
  end

  if (self:HasDirectionChanged()) then
    local isMoving <const> = frame.state & charStates.MOVE ~= 0

    if (isMoving) then
      local isForward <const> = frame.state & charStates.FORWARD ~= 0

      if (isForward) then
        self:SetState(charStates.MOVE | charStates.BACK)
      else
        self:SetState(charStates.MOVE | charStates.FORWARD)
      end
    end
  end

  if (not self:HasAnimationFrameEnded() or not self:HasAnimationEnded()) then
    return
  end

  local state <const> = self:GetFilteredStateForAnimation()
  local animation <const> = self.animations[state]
  local frameData <const> = self:GetFrameData(frame.frameIndex)
  local loops <const> = animation.data.loops or frameData.loops
  local nextState <const> = frame.nextState or frameData.nextState

  if (nextState ~= nil) then
    -- Normally, I would use "table.assign" to set this,
    -- but a "nil" property on a table will be ignored on "pairs()"
    self.history.frames[self.history.counter].nextState = nil

    -- A KO'd character should not get back up!
    -- TODO: "KO" state?
    if (state == charStates.KNOCKDOWN and nextState == charStates.RISE and frame.health <= 0) then
      return
    end

    self:SetState(nextState)

    return
  end

  -- Beginning and ending checks should come first

  local isBeginning <const> = frame.state & charStates.BEGIN ~= 0

  if (isBeginning) then
    local isJumping <const> = frame.state & charStates.JUMP ~= 0
    local statesToRemove <const> = charStates.BEGIN

    if (isJumping) then
      local newState = frame.state &~ statesToRemove
            newState |= charStates.AIRBORNE

      self:SetState(newState)

      return
    end

    local isThrowing <const> = frame.state & charStates.THROW ~= 0

    if (not isThrowing) then
      local newState <const> = frame.state &~ statesToRemove

      self:SetState(newState)

      return
    end
  end

  local isEnding <const> = frame.state & charStates.END ~= 0

  if (isEnding) then
    local isDashing <const> = frame.state & charStates.DASH ~= 0
    local statesToRemove <const> = charStates.END

    if (isDashing) then
      self:SetState(charStates.STAND)

      return
    end

    local isHurt <const> = frame.state & charStates.HURT ~= 0

    if (isHurt) then
      self:SetState(charStates.KNOCKDOWN)

      return
    end

    local isJumping <const> = frame.state & charStates.JUMP ~= 0

    if (isJumping) then
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

function Character:update()
  if (not self:IsActive()) then
    Character.super.update(self)

    return
  end

  -- self:CheckCrank()

  -- if (self.frozen == true) then
  --   self:UpdateFrozenSprite()

  --   return
  -- end

  self:TransitionState()
  self:UpdateDirection()

  self:UpdateButtonStates()

  if (self.controllable) then
    local frame <const> = self.history.frames[self.history.counter]

    if (
      frame.buttonState.current ~= 0 or
      frame.buttonState.pressed ~= 0 or
      frame.buttonState.released ~= 0
    ) then
      self:CheckInputs()
    end
  end

  self:UpdateAnimationFrame()
  self:UpdatePhysics()
  self:UpdatePosition()

  self:PrepareForNextLoop()
end

function Character:UpdateAnimationFrame()
  if (not self:HasStateChanged() and self:HasFrameIndexChanged()) then
    self:SetAnimationFrame()
  end
end

function Character:UpdateButtonStates()
  local frame <const> = self.history.frames[self.history.counter]
  local current <const>, pressed <const>, released <const> = table.unpack({ pd.getButtonState() })

  table.assign(
    self.history.frames[self.history.counter],
    {
      buttonState = {
        current = current,
        pressed = pressed,
        released = released,
      }
    }
  )
end

function Character:UpdateDirection()
  local frame <const> = self.history.frames[self.history.counter]
  local isAirborne <const> = frame.state & charStates.AIRBORNE ~= 0
  local isKicking <const> = frame.state & charStates.KICK ~= 0
  local isPunching <const> = frame.state & charStates.PUNCH ~= 0
  local isRunning <const> = frame.state & charStates.RUN ~= 0
  local isSpecialing <const> = frame.state & charStates.SPECIAL ~= 0
  local isThrowing <const> = frame.state & charStates.THROW ~= 0
  local isAttacking <const> = isKicking or isPunching or isSpecialing or isThrowing
  local opponentCenter <const> = self.opponent:getBoundsRect():centerPoint()
  local selfCenter <const> = self:getBoundsRect():centerPoint()

  if (isAttacking or isAirborne or isRunning) then
    return
  end

  if (
    opponentCenter.x > selfCenter.x and
    frame.direction ~= charDirections.RIGHT
  ) then
    table.assign(
      self.history.frames[self.history.counter],
      {
        direction = charDirections.RIGHT
      }
    )
    self:setImageFlip(self:GetFlip(), true)
  elseif (
    opponentCenter.x < selfCenter.x and
    frame.direction ~= charDirections.LEFT
  ) then
    table.assign(
      self.history.frames[self.history.counter],
      {
        direction = charDirections.LEFT
      }
    )
    self:setImageFlip(self:GetFlip(), true)
  end
end

function Character:UpdateCounters()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  table.assign(
    self.history.frames[self.history.counter],
    {
      frameCounter = frame.frameCounter + 1
    }
  )

  if (frameData.hitstunnable) then
    table.assign(
      self.history.frames[self.history.counter],
      {
        hitstun = frame.hitstun - 1
      }
    )
  end
end

function Character:UpdateFrameIndex()
  local animation <const> = self.animations[self:GetFilteredStateForAnimation()]
  local frame <const> = self.history.frames[self.history.counter]
  local nextFrameIndex = frame.frameIndex

  if (not self:HasAnimationEnded()) then
    nextFrameIndex += 1
  elseif (self:HasAnimationEnded() and animation.data.loops) then
    nextFrameIndex = 1
  end

  table.assign(
    self.history.frames[self.history.counter],
    {
      frameCounter = 1,
      frameIndex = nextFrameIndex,
    }
  )
end

function Character:UpdateFrozenSprite()
  local filteredState <const> = self:GetFilteredStateForAnimation()
  local frame <const> = self.history.frames[self.history.counter]

  self.imagetable = self.imagetables[filteredState]
  self:SetFrameImage()
  self:moveTo(frame.position.x, frame.position.y)
end

function Character:UpdatePhysics()
  local frame <const> = self.history.frames[self.history.counter]
  local isAirborne <const> = frame.state & charStates.AIRBORNE ~= 0
  local newVelocity <const> = {
    x = frame.velocity.x,
    y = frame.velocity.y,
  }

  if (isAirborne) then
    -- Apply gravity
    newVelocity.y += self.gravity
  end

  table.assign(
    self.history.frames[self.history.counter],
    {
      velocity = newVelocity
    }
  )
  self:DerivePhysicsFromCurrentFrame()
end

function Character:UpdatePosition()
  local frame <const> = self.history.frames[self.history.counter]
  local newPosition <const> = {
    x = self.x + frame.velocity.x,
    y = self.y + frame.velocity.y,
  }

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