-- import 'CoreLibs/animation'
-- import 'CoreLibs/animator'
-- import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'character'
import 'inputs'

-- Convenience variables
local pd <const> = playdate

local defaults <const> = {
  canRun = true,
  -- dashSpeed = 10,
  -- health = 950,
  jumpHeight = charJumpHeights.SHORT,
  name = 'Kim',
  speeds = {
    dash = {
      back = charSpeeds.FASTEST,
      forward = charSpeeds.FASTEST,
    },
    run = charSpeeds.FASTEST,
    walk = {
      back = charSpeeds.SLOW,
      forward = charSpeeds.NORMAL,
    },
  },
}

class('Kim', defaults).extends(Character)

function Kim:init(config)
  Kim.super.init(self, config)
end

function Kim:CheckChainInputs()
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  -- If we can't perform a chain, exit early.
  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.CHAIN) == 0) then
    return
  end

  local current <const>, pressed <const>, released <const> = table.unpack(frame.buttonState)
  local hasPressedB <const> = pressed & pd.kButtonB ~= 0

  if (hasPressedB) then
    local newState = charStates.CHAIN | charStates.KICK | charStates.STAND

    self:SetState(newState)

    return true
  end

  Kim.super.CheckChainInputs(self)
end

function Kim:CheckSpecialInputs()
  local frame <const> = self:GetHistoryFrame()
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  -- If we can't perform a special move, exit early.
  if (not frameData.cancellable or frameData.cancellable & cancellableStates.SPECIAL == 0) then
    return
  end

  if (
    self:IsAirborne()
    and Inputs:CheckSpecialDownInput(self)
  ) then
    self:SetState(charStates.SPECIAL | charStates.AIRBORNE | charStates.DOWN)

    return true
  end

  if (not self:IsAirborne()) then
    if (Inputs:CheckSpecialUpInput(self)) then
      self:SetState(charStates.SPECIAL | charStates.AIRBORNE | charStates.UP)

      return true
    end

    if (Inputs:CheckTatsuInput(self)) then
      self:SetState(charStates.SPECIAL | charStates.BACK)

      return true
    end
  end

  Kim.super.CheckSpecialInputs(self)
end

function Kim:DerivePhysicsFromState()
  Kim.super.DerivePhysicsFromState(self)
end

function Kim:LoadAnimations()
  Kim.super.LoadAnimations(self)

  -- Chain Moves
  self.animations[charStates.KICK | charStates.CHAIN | charStates.STAND] = self:HydrateAnimation(self:LoadTSJ('KickNeutralChain'));

  -- Special Moves
  self.animations[charStates.SPECIAL | charStates.AIRBORNE | charStates.UP] = self:HydrateAnimation(self:LoadTSJ('FlashKick'));
  self.animations[charStates.SPECIAL | charStates.AIRBORNE | charStates.DOWN] = self:HydrateAnimation(self:LoadTSJ('DiveKick'));
  self.animations[charStates.SPECIAL | charStates.BACK] = self:HydrateAnimation(self:LoadTSJ('CrescentMoonSlash'));
end
