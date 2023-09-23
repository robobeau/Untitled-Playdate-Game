import 'CoreLibs/animation'
import 'CoreLibs/animator'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'

import 'frameData'
import 'inputs'
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
  -- 16777216
  -- 33554432
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
  'Transition',
}

local loadingStates <const> = {
  ACTIVE = 1,
  IDLE = 2,
  LOADED = 4,
  LOADING = 8,
}
local defaults <const> = {
  animations = {},
  canDoubleJump = false,
  canRun = false,
  controllable = false,
  counter = 1,
  debug = false,
  emptyCollisionSprites = {},
  gravity = 1,
  health = 1000,
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
  loadedStates = 1,
  loadingState = loadingStates.IDLE,
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
  statesList = charStatesList,
  stun = 1000,
}
local firstFrame <const> = {
  buttonState = {},
  center = poi.new(0, 0),
  checks = {
    isAttacking = false,
    isAirborne = false,
    isBack = false,
    isBeginning = false,
    isCrouching = false,
    isDashing = false,
    isEnding = false,
    isForward = false,
    isHurt = false,
    isJumping = false,
    isKicking = false,
    isMoving = false,
    isPunching = false,
    isRunning = false,
    IsSpecialing = false,
    isStanding = true,
    isTransitioning = false,
  },
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

class('Character', defaults).extends(spr)

function Character:collisionResponse(other)
  local otherGroupMask <const> = other:getGroupMask()
  local collidedWithPushbox <const> = otherGroupMask & collisionTypes.PUSHBOX ~= 0

  if (collidedWithPushbox) then
    return spr.kCollisionTypeOverlap
  end

  return spr.kCollisionTypeFreeze
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
  self.loadedStates = 1
  self.loadingState = loadingStates.IDLE
  self.name = config.name or self.name
  self.opponent = config.opponent or self.opponent
  self.soundFX = {
    ['genericOnBlock'] = self:SetSoundFX('/sounds/block_medium_01.wav'),
    ['genericOnHit'] = self:SetSoundFX('/sounds/face_hit_small_43.wav'),
    ['genericOnWhiff'] = self:SetSoundFX('/sounds/kick_short_whoosh_01.wav'),
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

function Character:update()
  local frame <const> = self.history.frames[self.history.counter]

  self:Debug('Next State', frame.nextState)

  if (
    self.loadingState == loadingStates.IDLE or
    self.loadingState == loadingStates.LOADING
  ) then
    self:Load()

    return
  end


  if (self.loadingState == loadingStates.LOADED) then
    self.loadingState = loadingStates.ACTIVE

    self:Reset()

    return
  end

  -- local frame <const> = self.history.frames[frameIndex or self.history.counter]

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
  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.ATTACK) == 0) then
    return
  end

  if (frame.buttonState.hasPressedB) then
    local newState = charStates.KICK

    if (frame.checks.isAirborne) then
      newState |= charStates.AIRBORNE

      -- if (frame.checks.isBack) then
      --   newState |= charStates.BACK
      -- elseif (frame.checks.isForward) then
      --   newState |= charStates.FORWARD
      -- end

      if (math.abs(frame.velocity.x) > 0) then
        newState |= charStates.FORWARD
      end

      if (frame.checks.isRunning) then
        newState |= charStates.RUN
      elseif (frame.checks.isDashing) then
        newState |= charStates.DASH
      end
    elseif (frame.checks.isCrouching) then
      newState |= charStates.CROUCH
    else
      newState |= charStates.STAND

      if (frame.checks.isBack) then
        newState |= charStates.BACK
      elseif (frame.checks.isForward) then
        newState |= charStates.FORWARD
      end
    end

    self:SetState(newState)

    return true
  end

  if (frame.buttonState.hasPressedA) then
    local newState = charStates.PUNCH

    if (frame.checks.isAirborne) then
      newState |= charStates.AIRBORNE

      if (frame.buttonState.isPressingBack) then
        newState |= charStates.BACK
      elseif (frame.buttonState.isPressingForward) then
        newState |= charStates.FORWARD
      end

      if (frame.checks.isRunning) then
        newState |= charStates.RUN
      elseif (frame.checks.isDashing) then
        newState |= charStates.DASH
      end
    elseif (frame.checks.isCrouching) then
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

  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.BLOCK) == 0) then
    return false
  end

  if (frame.buttonState.isPressingBack) then
    local newState = charStates.BLOCK

    if (frame.checks.isAirborne) then
      newState |= charStates.AIRBORNE
    elseif (frame.checks.isCrouching) then
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

function Character:CheckDashBackInput()
  local frame <const> = self.history.frames[self.history.counter]

  if (frame.buttonState.isPressingBack) then
    local buttonStates <const> = {}
    local frameCount <const> = 10
    local start <const> = math.max(#self.history.frames - frameCount - 1, 1)
    local stop <const> = math.max(#self.history.frames - 1, 1)

    for i = start, stop, 1 do
      table.insert(buttonStates, self.history.frames[i].buttonState)
    end

    return Inputs:CheckDashBackInput(buttonStates)
  end
end

function Character:CheckDashForwardInput()
  local frame <const> = self.history.frames[self.history.counter]

  if (frame.buttonState.isPressingForward) then
    local buttonStates <const> = {}
    local frameCount <const> = 10
    local start <const> = math.max(#self.history.frames - frameCount - 1, 1)
    local stop <const> = math.max(#self.history.frames - 1, 1)

    for i = start, stop, 1 do
      table.insert(buttonStates, self.history.frames[i].buttonState)
    end

    return Inputs:CheckDashForwardInput(buttonStates)
  end
end

function Character:CheckJumpInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.JUMP) == 0) then
    return false
  end

  if (not frame.checks.isJumping) then
    if (frame.buttonState.isPressingUp) then
      local newState = charStates.JUMP | charStates.BEGIN

      if (frame.buttonState.isPressingBack) then
        newState |= charStates.BACK

        if (frame.checks.isRunning) then
          newState |= charStates.RUN
        end
      elseif (frame.buttonState.isPressingForward) then
        newState |= charStates.FORWARD

        if (frame.checks.isRunning) then
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

  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.MOVE) == 0) then
    return false
  end

  if (not frame.checks.isCrouching) then
    -- Dash/Run check
    if (not frame.checks.isDashing and not frame.checks.isRunning) then
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
    if (not frame.checks.isDashing and not frame.checks.isMoving and not frame.checks.isRunning) then
      if (frame.buttonState.isPressingBack) then
        self:SetState(charStates.MOVE | charStates.BACK)

        return true
      elseif (frame.buttonState.isPressingForward) then
        self:SetState(charStates.MOVE | charStates.FORWARD)

        return true
      end
    end

    -- Crouch check
    if (not frame.checks.isDashing) then
      if (frame.buttonState.isPressingDown) then
        self:SetState(charStates.CROUCH)

        return true
      end
    end

    -- Stand checks
    if (frame.checks.isMoving or frame.checks.isRunning) then
      if (frame.buttonState.hasReleasedBack) then
        self:SetState(charStates.STAND)

        return true
      elseif (frame.buttonState.hasReleasedForward) then
        self:SetState(charStates.STAND)

        return true
      end
    end
  else
    -- Stand check
    if (frame.buttonState.hasReleasedDown) then
      self:SetState(charStates.STAND)

      return true
    end
  end
end

function Character:CheckSpecialInputs()
  -- Overload this on each character's class!
end

function Character:CreateCollisionSprites(objects)
  local center = nil
  local collisions <const> = {
    Hitboxes = {},
    Hurtboxes = {},
    Pushbox = nil,
  }

  for _, object in ipairs(objects) do
    local properties <const> = ConvertCustomPropertiesToTable(object.properties or {})

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
    elseif (object.type == 'Pushbox') then
      collisions['Pushbox'] = {
        collideRect = rec.new(object.x, object.y, object.width, object.height),
        name = object.name, -- For debugging ;)
        properties = properties,
      }
    end
  end

  return center, collisions
end

-- function Character:draw(x, y, width, height)
--   local frame <const> = self.history.frames[self.history.counter]

--   self.imagetable[frame.frameIndex]:draw(0, 0, self:GetFlip())
-- end

-- For debugging ;)
function Character:Debug(...)
  if (self.debug) then
    printTable(...)
  end
end

function Character:DeriveImageTableFromState()
  local filteredState <const> = self:GetFilteredStateForAnimation()

  table.assign(
    self.history.frames[self.history.counter],
    {
      -- TODO: Why 0...?
      frameCounter = 0,
      frameIndex = 1,
    }
  )

  self.imagetable = self.imagetables[filteredState]
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

  -- A hitbox's properties determine the physics for the Hurt state.
  if (frame.checks.isHurt) then
    return
  end

  local newVelocity <const> = {
    x = frame.velocity.x,
    y = frame.velocity.y,
  }

  -- self:Debug(newVelocity.x, newVelocity.y)

  -- X Velocity

  if (frame.checks.isTransitioning) then
    newVelocity.x = 0
  elseif (frame.checks.isDashing) then
    newVelocity.x = self:GetDashVelocity()
  elseif (frame.checks.isJumping) then
    if (frame.checks.isRunning) then
      newVelocity.x = self:GetRunVelocity()
    elseif (frame.checks.isBack or frame.checks.isForward) then
      newVelocity.x = self:GetMoveVelocity()
    else
      -- Do nothing!
    end
  elseif (frame.checks.isRunning) then
    newVelocity.x = self:GetRunVelocity()
  elseif (frame.checks.isMoving) then
    newVelocity.x = self:GetMoveVelocity()
  elseif (not frame.checks.isAirborne) then
    newVelocity.x = 0
  end

  -- Y Velocity

  if (frame.checks.isTransitioning) then
    newVelocity.y = 0
  elseif (frame.checks.isJumping) then
    newVelocity.y = -self.jumpHeight
  elseif (not frame.checks.isAirborne) then
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

function Character:GetAnimationLoops(frameIndex)
  local animation <const> = self.animations[self:GetFilteredStateForAnimation(frameIndex)]

  return animation.data.loops
end

function Character:GetFrameDataLoops(frameIndex)
  local frame <const> = self.history.frames[frameIndex or self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  return frameData.loops
end

function Character:GetLoops(index)
  return self:GetAnimationLoops(index) or self:GetFrameDataLoops(index)
end

-- function Character:GetBackAndForwardInputs()
--   local frame <const> = self.history.frames[self.history.counter]

--   if (frame.direction == charDirections.LEFT) then
--     return pd.kButtonRight, pd.kButtonLeft
--   end

--   return pd.kButtonLeft, pd.kButtonRight
-- end

function Character:GetCenterRelativeToBounds()
  local boundsRect <const> = self:getBoundsRect()
  local frame <const> = self.history.frames[self.history.counter]
  local animationFrame <const> = self:GetAnimationFrame(frame.frameIndex)
  local isFlipped <const> = frame.direction == charDirections.LEFT
  local offset <const> = {
    x = isFlipped
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

  if (frame.checks.isRunning) then
    return self:GetRunSpeed()
  elseif (frame.checks.isDashing) then
    return self:GetDashSpeed()
  end

  return self:GetMoveSpeed()
end

function Character:GetDashSpeed()
  local frame <const> = self.history.frames[self.history.counter]

  if (frame.checks.isBack) then
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
  local frame <const> = self.history.frames[frameIndex or self.history.counter]
  local statesToRemove = 0

  -- Attacking is not visually affected by dashing... yet.
  -- Jumping is not visually affected by dashing.
  if (frame.checks.isAttacking or frame.checks.isJumping) then
    statesToRemove |= charStates.DASH | charStates.RUN | charStates.MOVE
  end

  -- There's currently only one possible transition animation,
  -- so we don't need to distinguish between back/forward movement.
  if (frame.checks.isBeginning or frame.checks.isEnding) then
    statesToRemove |= charStates.BACK | charStates.FORWARD
  end

  return frame.state &~ statesToRemove
end

function Character:GetFlip(frameIndex)
  local frame <const> = self.history.frames[frameIndex or self.history.counter]
  local isFlipped <const> = frame.direction == charDirections.LEFT

  return isFlipped and gfx.kImageFlippedX or gfx.kImageUnflipped
end

function Character:GetFlipSign(frameIndex)
  local frame <const> = self.history.frames[frameIndex or self.history.counter]
  local isFlipped <const> = frame.direction == charDirections.LEFT

  return isFlipped and -1 or 1
end

function Character:GetFrameData(animationFrameIndex, historyFrameIndex)
  local frame <const> = self:GetAnimationFrame(animationFrameIndex, historyFrameIndex)

  return frame.data
end

function Character:GetHit(hitbox)
  self:Debug('Character:GetHit()')

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

  self:GetHurt()

  spr.removeSprites({ hitbox })
end

function Character:GetHitByBall(hurtbox, ball)
  local frame <const> = self.history.frames[self.history.counter]
  local newState = charStates.HURT

  if (frame.checks.isAirborne) then
    newState |= charStates.AIRBORNE
  elseif (frame.checks.isMoving or frame.checks.isStanding or frame.checks.isTransitioning) then
    newState |= charStates.STAND
  elseif (frame.checks.isCrouching) then
    newState |= charStates.CROUCH
  else
    newState |= charStates.STAND
  end

  local frame <const> = self.history.frames[self.history.counter]
  local health <const> = frame.health - 100

  -- self:Debug(health)

  table.assign(
    self.history.frames[self.history.counter],
    {
      health = health
    }
  )
  self.OnHealthChange(health)
  self:SetState(newState)

  spr.removeSprites({ hurtbox })
end

function Character:GetHurt()
  local frame <const> = self.history.frames[self.history.counter]
  local newState = charStates.HURT

  if (frame.checks.isAirborne) then
    newState |= charStates.AIRBORNE
  elseif (frame.checks.isCrouching) then
    newState |= charStates.CROUCH
  else
    newState |= charStates.STAND
  end

  self:SetState(newState)
end

function Character:GetRunSpeed()
  return self.speeds.run
end

function Character:GetRunVelocity()
  return self:NormalizeHorizontalVelocity(self:GetRunSpeed())
end

function Character:GetMoveSpeed()
  local frame <const> = self.history.frames[self.history.counter]

  if (frame.checks.isBack) then
    return self.speeds.move.back
  end

  return self.speeds.move.forward
end

function Character:GetMoveVelocity()
  return self:NormalizeHorizontalVelocity(self:GetMoveSpeed())
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

  spr.removeSprites({ hitbox })
end

function Character:HandleBallCollision(collision)
  -- self:Debug('HandleBallCollision', collision.name)

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
  local collidedWithBall <const> = otherGroupMask & collisionTypes.BALL ~= 0
  local collidedWithPushbox <const> = otherGroupMask & collisionTypes.PUSHBOX ~= 0

  if (collidedWithBall) then
    self:HandleBallCollision(collision)
  elseif (collidedWithPushbox) then
    self:HandlePushboxCollision(collision)
  end
end

function Character:HandlePushboxCollision(collision)
  local character <const> = collision.sprite
  local opponent <const> = collision.other

  -- self:Debug('--------------- Pushbox Collision ---------------')
  -- self:Debug('Current Position', self.x, self.y)

  -- local frame <const> = self.history.frames[self.history.counter]
  -- local newVelocity <const> = {
  --   x = frame.velocity.x,
  --   y = frame.velocity.y,
  -- }

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

  -- if (collision.normal.x ~= 0) then
  --   if (self:WouldHitAWall(self.x + collision.move.x, self.y)) then
  --     local newPosition <const> = {
  --       x = collision.other.x - collision.move.x,
  --       y = collision.other.y,
  --     }

  --     self:Debug('Would hit a wall!', collision.move.x, newPosition.x)

  --     collision.other:MoveToXY(newPosition.x, newPosition.y)
  --   else
  --     local newPosition <const> = {
  --       x = self.x + collision.move.x,
  --       y = self.y,
  --     }

  --     self:Debug('Will not hit a wall!', collision.move.x, newPosition.x)

  --     self:MoveToXY(newPosition.x, newPosition.y)
  --   end
  -- end

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
        -- self:Debug('hasCrossedOver', hasCrossedOver)

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

  -- if (collision.normal.y ~= 0) then
    -- Do nothing!
  -- end

  -- table.assign(
  --   self.history.frames[self.history.counter],
  --   {
  --     velocity = newVelocity
  --   }
  -- )

  -- self:Debug('---------------------------------------------')
end

function Character:HandleWallCollision(collision)
  local frame <const> = self.history.frames[self.history.counter]
  local newVelocity <const> = {
    x = frame.velocity.x,
    y = frame.velocity.y,
  }

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

  table.assign(
    self.history.frames[self.history.counter],
    {
      velocity = newVelocity
    }
  )

  -- self:Debug('---------------------------------------------')
end

function Character:HandleJumpEnd()
  local frame <const> = self.history.frames[self.history.counter]

  -- TODO: We may not need this anymore?
  if (frame.checks.isTransitioning) then
    return
  end

  if (frame.checks.isHurt) then
    self:SetState(charStates.HURT | charStates.AIRBORNE | charStates.END)
  else
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
  local animationData <const> = ConvertCustomPropertiesToTable(animation.properties or {})
  local frames <const> = {}

  for i, frame in ipairs(animation.tiles) do
    local frameData <const> = ConvertCustomPropertiesToTable(frame.properties or {})
    local center <const>, collisions <const> = self:CreateCollisionSprites(frame.objectgroup.objects)

    for j, hitbox in ipairs(collisions.Hitboxes) do
      if (frameData.soundFX) then
        if (frameData.soundFX.onBlock) then
          hitbox.soundFX.onBlock = self:SetSoundFX(frameData.soundFX.onBlock)
        end

        if (frameData.soundFX.onHit) then
          hitbox.soundFX.onHit = self:SetSoundFX(frameData.soundFX.onHit)
        end

        if (frameData.soundFX.onWhiff) then
          hitbox.soundFX.onWhiff = self:SetSoundFX(frameData.soundFX.onWhiff)
        end
      else
        hitbox.soundFX.onBlock = self.soundFX['genericOnBlock']
        hitbox.soundFX.onHit = self.soundFX['genericOnHit']
        hitbox.soundFX.onWhiff = self.soundFX['genericOnWhiff']
      end
    end

    -- if (frameData.soundFX) then
      -- if (frameData.soundFX.onBlock) then
      --   local soundFX <const> = self:SetSoundFX(frameData.soundFX.onBlock)

      --   for j, hitbox in ipairs(collisions.Hitboxes) do
      --     hitbox.soundFX.onBlock = soundFX
      --   end
      -- end

      -- if (frameData.soundFX.onHit) then
      --   local soundFX <const> = self:SetSoundFX(frameData.soundFX.onHit)

      --   for j, hitbox in ipairs(collisions.Hitboxes) do
      --     hitbox.soundFX.onHit = soundFX
      --   end
      -- end

      -- if (frameData.soundFX.onWhiff) then
      --   self:SetSoundFX(frameData.soundFX.onWhiff)
      -- end
    -- end

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
  local imagetable <const> = gfx.imagetable.new(#animation.frames)

  -- coroutine.yield()

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
      image = img.new(imagePath)
      images[imagePath] = image
    end

    imagetable:setImage(i, image)
  end

  return imagetable
end

function Character:IsActive()
  return self.loadingState == loadingStates.ACTIVE
end

function Character:IsFalling(frameIndex)
  local frame <const> = self.history.frames[frameIndex or self.history.counter]

  -- Since gravity is always being applied, we need to check above it.
  return frame.checks.isAirborne and frame.velocity.y > self.gravity
end

function Character:IsLoading()
  return self.loadingState == loadingStates.LOADING
end

function Character:IsLoaded()
  return self.loadingState == loadingStates.LOADED
end

function Character:Load()
  if (self.loadingState == loadingStates.IDLE) then
    self.loadingState = loadingStates.LOADING
  end

  if (self.loadedStates > #self.statesList) then
    self.loadingState = loadingStates.LOADED

    self:SetAssets()
  else
    self:LoadAnimations()
    self:LoadImagetables()

    self.loadedStates += 1
  end
end

function Character:LoadAnimations()
  local animationName <const> = self.statesList[self.loadedStates]
  local animation <const> = self:LoadTSJ(animationName)

  self.hydratedAnimations[animationName] = self:HydrateAnimation(animation)
end

function Character:LoadImagetables()
  local animationName <const> = self.statesList[self.loadedStates]
  local hydratedAnimation <const> = self.hydratedAnimations[animationName]

  self.hydratedImagetables[animationName] = self:HydrateImageTable(hydratedAnimation)
end

function Character:LoadTSJ(state)
  -- TODO: Trim whitespace for "self.name"
  local filePath <const> = 'characters/' .. self.name .. '/TSJs/' .. self.name .. state .. '.tsj'

  return json.decodeFile(filePath)
end

function Character:MoveToXY(x, y)
  -- self:Debug('MoveToXY', x, y)
  -- self:Debug('originalPosition', self.x, self.y)

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

  -- self:Debug('----------------------------------------')
end

function Character:MoveToXYWithCollisions(x, y)
  -- self:Debug('MoveToXYWithCollisions', x, y)

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

  -- self:Debug('========================================')
end

function Character:NormalizeHorizontalVelocity(speed)
  local frame <const> = self.history.frames[self.history.counter]
  local flipSign <const> = self:GetFlipSign()
  local moveSign <const> = frame.checks.isBack and -1 or 1

  return speed * flipSign * moveSign
end

function Character:PrepareForNextLoop()
  local nextFrame <const> = table.deepcopy(self.history.frames[self.history.counter])

  self.history.counter += 1
  self.history.frames[self.history.counter] = nextFrame

  self:UpdateCounters()
  self:UpdateFrameIndex()
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

  -- Hurting
  self.animations[charStates.HURT | charStates.AIRBORNE] = self.hydratedAnimations['HurtAirborne']
  self.animations[charStates.HURT | charStates.AIRBORNE | charStates.END] = self.hydratedAnimations['HurtAirborneEnd']
  self.animations[charStates.HURT | charStates.CROUCH] = self.hydratedAnimations['HurtCrouch']
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
end

function Character:SetAssets()
  self:SetAnimations()
  self:SetImagetables()

  self.menuImage = img.new(self.menuImagePath)
  self.portraitImage = img.new(self.portraitImagePath)
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

  -- Hurting
  self.imagetables[charStates.HURT | charStates.AIRBORNE] = self.hydratedImagetables['HurtAirborne']
  self.imagetables[charStates.HURT | charStates.AIRBORNE | charStates.END] = self.hydratedImagetables['HurtAirborneEnd']
  self.imagetables[charStates.HURT | charStates.CROUCH] = self.hydratedImagetables['HurtCrouch']
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

  -- local boundsRect <const> = self:getBoundsRect():copy()
        -- boundsRect.x = boundsRect.width == 0
        --   and self.x - (nextImage.width / 2)
        --   or boundsRect.x
        -- boundsRect.y = boundsRect.width == 0
        --   and self.y - nextImage.height
        --   or boundsRect.y
        -- boundsRect.height = nextImage.height
        -- boundsRect.width = nextImage.width

  -- self:setBounds(boundsRect)

  local nextCenter <const> = self:GetCenterRelativeToBounds()
  local prevFrame <const> = self.history.frames[self.history.counter - 1] or {}
  local prevCenter <const> = prevFrame.center or nextCenter

  local xDelta <const> = prevCenter.x - nextCenter.x
  local yDelta <const> = prevCenter.y - nextCenter.y

  -- self:setBounds(boundsRect:offsetBy(xDelta * self:GetFlipSign(), yDelta))
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
        boundsRect.x = 0 -- TODO: Why do I have do this, again...?
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
  soundFXPath = string.gsub(soundFXPath, '%.wav', '')

  print(soundFXPath)

  if (not self.soundFX[soundFXPath]) then
    self.soundFX[soundFXPath] = pd.sound.sampleplayer.new(soundFXPath)
  end

  return self.soundFX[soundFXPath]
end

function Character:SetState(state)
  -- local frame <const> = self.history.frames[self.history.counter]

  -- self:Debug('SetState()', state, keyset[state], frame.velocity.x)

  table.assign(
    self.history.frames[self.history.counter],
    {
      checks = {
        isAttacking = state & charStates.KICK ~= 0 or state & charStates.PUNCH ~= 0 or state & charStates.SPECIAL ~= 0,
        isAirborne = state & charStates.AIRBORNE ~= 0,
        isBack = state & charStates.BACK ~= 0,
        isBeginning = state & charStates.BEGIN ~= 0,
        isCrouching = state & charStates.CROUCH ~= 0,
        isDashing = state & charStates.DASH ~= 0,
        isEnding = state & charStates.END ~= 0,
        isForward = state & charStates.FORWARD ~= 0,
        isHurt = state & charStates.HURT ~= 0,
        isJumping = state & charStates.JUMP ~= 0,
        isKicking = state & charStates.KICK ~= 0,
        isPunching = state & charStates.PUNCH ~= 0,
        isRunning = state & charStates.RUN ~= 0,
        IsSpecialing = state & charStates.SPECIAL ~= 0,
        isStanding = state & charStates.STAND ~= 0,
        isTransitioning = state & charStates.BEGIN ~= 0 or state & charStates.END ~= 0,
        isMoving = state & charStates.MOVE ~= 0,
      },
      state = state,
    }
  )

  self:DeriveImageTableFromState()
  self:SetAnimationFrame()
  self:DerivePhysicsFromState()
  -- self:markDirty()
end

function Character:Teardown()
  -- TODO: Clear every single image in "self.imagetables"
  spr.removeSprites(self.emptyCollisionSprites)
end

function Character:TransitionState()
  local frame <const> = self.history.frames[self.history.counter]

  if (self:HasDirectionChanged()) then
    if (frame.checks.isMoving) then
      if (frame.checks.isForward) then
        self:SetState(charStates.MOVE | charStates.BACK)
      else
        self:SetState(charStates.MOVE | charStates.FORWARD)
      end
    end
  end

  if (not self:HasAnimationFrameEnded() or not self:HasAnimationEnded()) then
    return
  end

  local loops <const> = self:GetLoops()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)
  local nextState <const> = frame.nextState or frameData.nextState

  if (nextState ~= nil) then
    table.assign(
      self.history.frames[self.history.counter],
      {
        nextState = nil
      }
    )

    self:SetState(nextState)

    return
  end

  -- Beginning and ending checks should come first

  if (frame.checks.isBeginning) then
    local statesToRemove <const> = charStates.BEGIN

    if (frame.checks.isJumping) then
      local newState = frame.state &~ statesToRemove
            newState |= charStates.AIRBORNE

      self:SetState(newState)

      return
    end

    local newState <const> = frame.state &~ statesToRemove

    self:SetState(newState)

    return
  end

  if (frame.checks.isEnding) then
    local statesToRemove <const> = charStates.END

    if (frame.checks.isDashing) then
      self:SetState(charStates.STAND)

      return
    end

    if (frame.checks.isHurt) then
      self:SetState(charStates.KNOCKDOWN)

      return
    end

    if (frame.checks.isJumping) then
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
  local frame <const> = self.history.frames[self.history.counter]
  local backInput <const> = frame.direction == charDirections.LEFT
    and pd.kButtonRight
    or pd.kButtonLeft
  local forwardInput <const> = frame.direction == charDirections.LEFT
    and pd.kButtonLeft
    or pd.kButtonRight
  local current <const>, pressed <const>, released <const> = table.unpack({ pd.getButtonState() })

  table.assign(
    self.history.frames[self.history.counter],
    {
      buttonState = {
        current = current,
        pressed = pressed,
        released = released,

        -- Has pressed
        hasPressedA = pressed & pd.kButtonA ~= 0,
        hasPressedB = pressed & pd.kButtonB ~= 0,
        hasPressedBack = pressed & backInput ~= 0,
        hasPressedDown = pressed & pd.kButtonDown ~= 0,
        hasPressedForward = pressed & forwardInput ~= 0,
        hasPressedLeft = pressed & pd.kButtonLeft ~= 0,
        hasPressedRight = pressed & pd.kButtonRight ~= 0,
        hasPressedUp = pressed & pd.kButtonUp ~= 0,

        -- Has released
        hasReleasedA = released & pd.kButtonA ~= 0,
        hasReleasedB = released & pd.kButtonB ~= 0,
        hasReleasedBack = released & backInput ~= 0,
        hasReleasedDown = released & pd.kButtonDown ~= 0,
        hasReleasedForward = released & forwardInput ~= 0,
        hasReleasedLeft = released & pd.kButtonLeft ~= 0,
        hasReleasedRight = released & pd.kButtonRight ~= 0,
        hasReleasedUp = released & pd.kButtonUp ~= 0,

        -- Is pressing
        isPressingA = current & pd.kButtonA ~= 0,
        isPressingB = current & pd.kButtonB ~= 0,
        isPressingBack = current & backInput ~= 0,
        isPressingDown = current & pd.kButtonDown ~= 0,
        isPressingForward = current & forwardInput ~= 0,
        isPressingLeft = current & pd.kButtonLeft ~= 0,
        isPressingRight = current & pd.kButtonRight ~= 0,
        isPressingUp = current & pd.kButtonUp ~= 0,
      }
    }
  )
end

function Character:UpdateDirection()
  local frame <const> = self.history.frames[self.history.counter]
  local opponentCenter <const> = self.opponent:getBoundsRect():centerPoint()
  local selfCenter <const> = self:getBoundsRect():centerPoint()

  if (frame.checks.isAttacking or frame.checks.isAirborne or frame.checks.isRunning) then
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

  if (frameData.histunnable) then
    table.assign(
      self.history.frames[self.history.counter],
      {
        hitstun = frame.hitstun - 1
      }
    )
  end
end

-- function Character:ShouldUpdateFrameIndex()
--   local frame <const> = self.history.frames[self.history.counter]
--   local frameData <const> = self:GetFrameData(frame.frameIndex)

--   return frame.frameCounter > frameData.duration
-- end

function Character:UpdateFrameIndex()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)
  local isHitstunned <const> = frameData.histunnable and frame.hitstun > 0
  local shouldUpdateFrameIndex <const> = frame.frameCounter > frameData.duration

  if (isHitstunned or not shouldUpdateFrameIndex) then
    return
  end

  local nextFrame <const> = self.history.frames[self.history.counter]
  local animation <const> = self.animations[self:GetFilteredStateForAnimation(frame.frameIndex)]
  local nextFrameIndex = nextFrame.frameIndex

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
  -- self:markDirty()
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
  local newVelocity <const> = {
    x = frame.velocity.x,
    y = frame.velocity.y,
  }

  if (frame.checks.isAirborne) then
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