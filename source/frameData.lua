local cancellableStates <const> = {
  ATTACK = 1,
  BLOCK = 2,
  CHAIN = 4,
  JUMP = 8,
  MOVE = 16,
  SPECIAL = 32,
  SUPER = 64,
  THROW = 128,
}

local defaults <const> = {
  cancellable = 0,
  duration = 0, -- Nil?
  loops = false,
  nextState = nil,
  soundFX = nil,
  -- velocityX = 0, -- Nil?
  -- velocityY = 0, -- Nil?
}

class('FrameData', defaults).extends()

function FrameData:init(config)
  self.cancellable = config.cancellable or self.cancellable
  self.checks = {
    isAttackCancellable = self.cancellable & cancellableStates.ATTACK ~= 0,
    isBlockCancellable = self.cancellable & cancellableStates.BLOCK ~= 0,
    isChainCancellable = self.cancellable & cancellableStates.CHAIN ~= 0,
    isJumpCancellable = self.cancellable & cancellableStates.JUMP ~= 0,
    isMoveCancellable = self.cancellable & cancellableStates.MOVE ~= 0,
    isSpecialCancellable = self.cancellable & cancellableStates.SPECIAL ~= 0,
    isSuperCancellable = self.cancellable & cancellableStates.SUPER ~= 0,
    isThrowCancellable = self.cancellable & cancellableStates.THROW ~= 0,
  }
  self.duration = config.duration or self.duration
  self.loops = config.loops or self.loops
  self.nextState = config.nextState or self.nextState
  self.soundFX = config.soundFX or self.soundFX
  self.velocityX = config.velocityX or self.velocityX
  self.velocityY = config.velocityY or self.velocityY
end