-- import 'CoreLibs/animation'
-- import 'CoreLibs/animator'
-- import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'character'
import 'inputs'

-- Convenience variables
local pd <const> = playdate

local kimStatesList <const> = {
  'CrescentMoonSlash',
  'DiveKick',
  'FlashKick',
  'KickNeutralChain',
}
local defaults <const> = {
  assetsList = table.move(charStatesList, 1, #charStatesList, #kimStatesList + 1, kimStatesList),
  canRun = true,
  jumpHeight = charJumpHeights.SHORT,
  menuImagePath = 'characters/Kim/images/KimPortraitMenu',
  name = 'Kim',
  nameImagePath = 'characters/Kim/images/KimName',
  portraitImagePath = 'characters/Kim/images/KimPortrait',
  speeds = {
    dash = {
      back = charSpeeds.FASTEST,
      forward = charSpeeds.FASTEST,
    },
    move = {
      back = charSpeeds.SLOW,
      forward = charSpeeds.NORMAL,
    },
    run = charSpeeds.FASTEST,
  },
}

class('Kim', defaults).extends(Character)

Kim.AnimationObjects = {
  Airborne = import 'animations/KimAirborne.lua',
  Block = import 'animations/KimBlock.lua',
  BlockAirborne = import 'animations/KimBlockAirborne.lua',
  BlockCrouch = import 'animations/KimBlockCrouch.lua',
  CrescentMoonSlash = import 'animations/KimCrescentMoonSlash.lua',
  Crouch = import 'animations/KimCrouch.lua',
  DashBack = import 'animations/KimDashBack.lua',
  DashForward = import 'animations/KimDashForward.lua',
  DiveKick = import 'animations/KimDiveKick.lua',
  Entrance = import 'animations/KimEntrance.lua',
  FlashKick = import 'animations/KimFlashKick.lua',
  Hurt = import 'animations/KimHurt.lua',
  HurtAirborne = import 'animations/KimHurtAirborne.lua',
  HurtAirborneEnd = import 'animations/KimHurtAirborneEnd.lua',
  HurtBegin = import 'animations/KimHurtBegin.lua',
  HurtCrouch = import 'animations/KimHurtCrouch.lua',
  HurtEnd = import 'animations/KimHurtEnd.lua',
  HurtHigh = import 'animations/KimHurtHigh.lua',
  HurtMid = import 'animations/KimHurtMid.lua',
  HurtThrow = import 'animations/KimHurtThrow.lua',
  JumpBack = import 'animations/KimJumpBack.lua',
  JumpForward = import 'animations/KimJumpForward.lua',
  JumpNeutral = import 'animations/KimJumpNeutral.lua',
  KickBack = import 'animations/KimKickBack.lua',
  KickCrouch = import 'animations/KimKickCrouch.lua',
  KickForward = import 'animations/KimKickForward.lua',
  KickJumpForward = import 'animations/KimKickJumpForward.lua',
  KickJumpNeutral = import 'animations/KimKickJumpNeutral.lua',
  KickNeutral = import 'animations/KimKickNeutral.lua',
  KickNeutralChain = import 'animations/KimKickNeutralChain.lua',
  Knockdown = import 'animations/KimKnockdown.lua',
  MoveBack = import 'animations/KimMoveBack.lua',
  MoveForward = import 'animations/KimMoveForward.lua',
  PunchCrouch = import 'animations/KimPunchCrouch.lua',
  PunchForward = import 'animations/KimPunchForward.lua',
  PunchJumpForward = import 'animations/KimPunchJumpForward.lua',
  Rise = import 'animations/KimRise.lua',
  Run = import 'animations/KimRun.lua',
  Stand = import 'animations/KimStand.lua',
  Throw = import 'animations/KimThrow.lua',
  ThrowBegin = import 'animations/KimThrowBegin.lua',
  Transition = import 'animations/KimTransition.lua',
}

function Kim:CheckChainInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(self.ram.frameIndex)

  -- If we can't perform a chain, exit early.
  if (not frameData.checks.isChainCancellable) then
    return
  end

  local hasPressedB <const> = frame.buttonState.pressed & pd.kButtonB ~= 0

  if (hasPressedB) then
    local newState = charStates.CHAIN | charStates.KICK | charStates.STAND

    self:SetState(newState)

    return true
  end

  Kim.super.CheckChainInputs(self)
end

function Kim:CheckCrescentMoonKickInput()
  local frame <const> = self.history.frames[self.history.counter]
  local hasPressedB <const> = frame.buttonState.pressed & pd.kButtonB ~= 0
  local hasReleasedB <const> = frame.buttonState.released & pd.kButtonB ~= 0

  if (hasPressedB or hasReleasedB) then
    local frameCount <const> = 15
    local start <const> = math.max(#self.history.frames - frameCount, 1)
    local stop <const> = math.max(#self.history.frames, 1)
    local buttonStates <const> = table.map(
      self.history.frames,
      function (f) return f.buttonState end,
      start,
      stop
    )

    return Inputs:CheckQuarterCircleInput(buttonStates, inputDirections.BACK, self.ram.direction)
  end
end

function Kim:CheckFlyingSliceInput()
  local frame <const> = self.history.frames[self.history.counter]
  local hasPressedB <const> = frame.buttonState.pressed & pd.kButtonB ~= 0
  local hasPressedUp <const> = frame.buttonState.pressed & pd.kButtonUp ~= 0
  local hasReleasedB <const> = frame.buttonState.released & pd.kButtonB ~= 0
  local hasReleasedUp <const> = frame.buttonState.released & pd.kButtonUp ~= 0
  local isPressingUp <const> = frame.buttonState.current & pd.kButtonUp ~= 0

  if (
    (hasPressedB or hasReleasedB) and
    (hasPressedUp or hasReleasedUp or isPressingUp)
  ) then
    local chargeFrames <const> = 30
    local frameCount <const> = chargeFrames + 5
    local start <const> = #self.history.frames - frameCount
    local stop <const> = #self.history.frames
    local buttonStates <const> = table.map(
      self.history.frames,
      function (f) return f.buttonState end,
      start,
      stop
    )

    return Inputs:CheckChargeDownInput(buttonStates, chargeFrames, self.ram.direction)
  end
end

function Kim:CheckSpecialInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(self.ram.frameIndex)

  -- If we can't perform a special move, exit early.
  if (not frameData.checks.isSpecialCancellable) then
    return
  end

  local isAirborne <const> = self.ram.state & charStates.AIRBORNE ~= 0

  if (isAirborne) then
    local hasPressedB <const> = frame.buttonState.pressed & pd.kButtonB ~= 0
    local isPressingDown <const> = frame.buttonState.current & pd.kButtonDown ~= 0

    if (hasPressedB and isPressingDown) then
      self:SetState(charStates.SPECIAL | charStates.AIRBORNE | charStates.DOWN)

      return true
    end
  else
    if (self:CheckCrescentMoonKickInput()) then
      self:SetState(charStates.SPECIAL | charStates.BACK)

      return true
    end

    if (self:CheckFlyingSliceInput()) then
      self:SetState(charStates.SPECIAL | charStates.AIRBORNE | charStates.UP)

      return true
    end
  end

  Kim.super.CheckSpecialInputs(self)
end

function Kim:SetAnimations()
  -- Chain Moves
  self.animations[charStates.KICK | charStates.CHAIN | charStates.STAND] = self.hydratedAnimations['KickNeutralChain']

  -- Special Moves
  self.animations[charStates.SPECIAL | charStates.AIRBORNE | charStates.UP] = self.hydratedAnimations['FlashKick']
  self.animations[charStates.SPECIAL | charStates.AIRBORNE | charStates.DOWN] = self.hydratedAnimations['DiveKick']
  self.animations[charStates.SPECIAL | charStates.BACK] = self.hydratedAnimations['CrescentMoonSlash']

  Kim.super.SetAnimations(self)
end

function Kim:SetImagetables()
  -- Chain Moves
  self.imagetables[charStates.KICK | charStates.CHAIN | charStates.STAND] = self.hydratedImagetables['KickNeutralChain']

  -- Special Moves
  self.imagetables[charStates.SPECIAL | charStates.AIRBORNE | charStates.UP] = self.hydratedImagetables['FlashKick']
  self.imagetables[charStates.SPECIAL | charStates.AIRBORNE | charStates.DOWN] = self.hydratedImagetables['DiveKick']
  self.imagetables[charStates.SPECIAL | charStates.BACK] = self.hydratedImagetables['CrescentMoonSlash']

  Kim.super.SetImagetables(self)
end