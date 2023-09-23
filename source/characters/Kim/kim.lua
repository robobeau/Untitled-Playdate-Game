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
  canRun = true,
  -- health = 950,
  jumpHeight = charJumpHeights.SHORT,
  menuImagePath = 'characters/Kim/images/KimPortraitMenu',
  name = 'Kim',
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
  statesList = table.move(charStatesList, 1, #charStatesList, #kimStatesList + 1, kimStatesList)
}

class('Kim', defaults).extends(Character)

function Kim:CheckChainInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  -- If we can't perform a chain, exit early.
  if (not frameData.cancellable or (frameData.cancellable & cancellableStates.CHAIN) == 0) then
    return
  end

  if (frame.buttonState.hasPressedB) then
    local newState = charStates.CHAIN | charStates.KICK | charStates.STAND

    self:SetState(newState)

    return true
  end

  Kim.super.CheckChainInputs(self)
end

function Kim:CheckCrescentMoonKickInput()
  local frame <const> = self.history.frames[self.history.counter]

  if (frame.buttonState.hasPressedB or frame.buttonState.hasReleasedB) then
    local buttonStates <const> = {}
    local frameCount <const> = 15
    local start <const> = math.max(#self.history.frames - frameCount - 1, 1)
    local stop <const> = math.max(#self.history.frames - 1, 1)

    for i = start, stop, 1 do
      table.insert(buttonStates, self.history.frames[i].buttonState)
    end

    return Inputs:CheckQuarterCircleInput(buttonStates, inputDirections.BACK)
  end
end

function Kim:CheckFlyingSliceInput()
  local frame <const> = self.history.frames[self.history.counter]

  if (
    (
      frame.buttonState.hasPressedB or
      frame.buttonState.hasReleasedB
    ) and
    (
      frame.buttonState.hasPressedUp or
      frame.buttonState.hasReleasedUp or
      frame.buttonState.isPressingUp
    )
  ) then
    local buttonStates <const> = {}
    local milliseconds <const> = 30
    local frameCount <const> = milliseconds + 1
    local start <const> = #self.history.frames - frameCount - 1
    local stop <const> = #self.history.frames - 1

    for i = start, stop, 1 do
      table.insert(buttonStates, self.history.frames[i].buttonState)
    end

    return Inputs:CheckChargeDownInput(buttonStates, milliseconds)
  end
end

function Kim:CheckSpecialInputs()
  local frame <const> = self.history.frames[self.history.counter]
  local frameData <const> = self:GetFrameData(frame.frameIndex)

  -- If we can't perform a special move, exit early.
  if (not frameData.cancellable or frameData.cancellable & cancellableStates.SPECIAL == 0) then
    return
  end

  if (frame.checks.isAirborne) then
    if (frame.buttonState.hasPressedB and frame.buttonState.isPressingDown) then
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
  self.animations[charStates.KICK | charStates.CHAIN | charStates.STAND] = self.hydratedAnimations['KickNeutralChain'];

  -- Special Moves
  self.animations[charStates.SPECIAL | charStates.AIRBORNE | charStates.UP] = self.hydratedAnimations['FlashKick'];
  self.animations[charStates.SPECIAL | charStates.AIRBORNE | charStates.DOWN] = self.hydratedAnimations['DiveKick'];
  self.animations[charStates.SPECIAL | charStates.BACK] = self.hydratedAnimations['CrescentMoonSlash'];

  Kim.super.SetAnimations(self)
end

function Kim:SetImagetables()
  -- Chain Moves
  self.imagetables[charStates.KICK | charStates.CHAIN | charStates.STAND] = self.hydratedImagetables['KickNeutralChain'];

  -- Special Moves
  self.imagetables[charStates.SPECIAL | charStates.AIRBORNE | charStates.UP] = self.hydratedImagetables['FlashKick'];
  self.imagetables[charStates.SPECIAL | charStates.AIRBORNE | charStates.DOWN] = self.hydratedImagetables['DiveKick'];
  self.imagetables[charStates.SPECIAL | charStates.BACK] = self.hydratedImagetables['CrescentMoonSlash'];

  Kim.super.SetImagetables(self)
end