local cancellableStates <const> = {
  ATTACK = 1,
  BLOCK = 2,
  CHAIN = 4,
  JUMP = 8,
  MOVE = 16,
  SPECIAL = 32,
  SUPER = 64,
}

local defaults <const> = {
  cancellable = 0,
  duration = 0, -- Nil?
  hitstunnable = false,
  loops = false,
  nextState = nil,
  soundFX = nil,
  -- velocityX = 0, -- Nil?
  -- velocityY = 0, -- Nil?
}

class('FrameData', defaults).extends()

function FrameData:init(config)
  self.cancellable = config.cancellable or self.cancellable
  self.duration = config.frameDuration or self.duration
  self.hitstunnable = config.hitstunnable or self.hitstunnable
  self.loops = config.loops or self.loops
  self.nextState = config.nextState or self.nextState
  self.soundFX = config.soundFX or self.soundFX
  self.velocityX = config.velocityX or self.velocityX
  self.velocityY = config.velocityY or self.velocityY
end

function FrameData:IsAttackCancellable()
  return self.cancellable & cancellableStates.ATTACK ~= 0
end

function FrameData:IsBlockCancellable()
  return self.cancellable & cancellableStates.BLOCK ~= 0
end

function FrameData:IsChainCancellable()
  return self.cancellable & cancellableStates.CHAIN ~= 0
end

function FrameData:IsHitstunnable()
  return self.hitstunnable
end

function FrameData:IsJumpCancellable()
  return self.cancellable & cancellableStates.JUMP ~= 0
end

function FrameData:IsMoveCancellable()
  return self.cancellable & cancellableStates.MOVE ~= 0
end

function FrameData:IsSpecialCancellable()
  return self.cancellable & cancellableStates.SPECIAL ~= 0
end

function FrameData:IsSuperCancellable()
  return self.cancellable & cancellableStates.SUPER ~= 0
end