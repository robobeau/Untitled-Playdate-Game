-- Convenience variables
local pd <const> = playdate

inputDirections = {
  BACK = 1,
  DOWN = 2,
  FORWARD = 4,
  UP = 8,
}

class('Inputs').extends()

function Inputs:CheckChargeInput(buttonStates, direction, chargeFrames, charDirection)
  local chargeTarget <const> = chargeFrames or pd.display.getRefreshRate()
  local chargeCounter = 0

  for i = #buttonStates, 1, -1 do
    local buttonState <const> = buttonStates[i]
    local backInput <const> = charDirection == charDirections.LEFT
      and pd.kButtonRight
      or pd.kButtonLeft
    local isPressingBack <const> = buttonState.current & backInput ~= 0
    local isPressingDown <const> = buttonState.current & pd.kButtonDown ~= 0
    local isPressing <const> = {
      [inputDirections.BACK] = isPressingBack,
      [inputDirections.DOWN] = isPressingDown,
    }
    local isPressingDirection <const> = isPressing[direction]

    if (isPressingDirection) then
      chargeCounter += 1
    end

    if (chargeCounter >= chargeTarget) then
      return true
    end
  end
end

function Inputs:CheckChargeBackInput(buttonStates, chargeFrames, charDirection)
  return self:CheckChargeInput(buttonStates, inputDirections.BACK, chargeFrames, charDirection)
end

function Inputs:CheckChargeDownInput(buttonStates, chargeFrames, charDirection)
  return self:CheckChargeInput(buttonStates, inputDirections.DOWN, chargeFrames, charDirection)
end

function Inputs:CheckDashInput(buttonStates, direction, charDirection)
  local backInput <const> = charDirection == charDirections.LEFT
    and pd.kButtonRight
    or pd.kButtonLeft
  local forwardInput <const> = charDirection == charDirections.LEFT
    and pd.kButtonLeft
    or pd.kButtonRight
  local latestButtonState <const> = buttonStates[#buttonStates]
  local isPressingBack <const> = latestButtonState.current & backInput ~= 0
  local isPressingForward <const> = latestButtonState.current & forwardInput ~= 0
  local latestIsPressing <const> = {
    [inputDirections.BACK] = isPressingBack,
    [inputDirections.FORWARD] = isPressingForward,
  }
  local latestIsPressingDirection <const> = latestIsPressing[direction]

  if (latestIsPressingDirection) then
    local counter = 0

    for i = #buttonStates - 1, 1, -1 do
      local buttonState <const> = buttonStates[i]
      local hasPressedBack <const> = buttonState.pressed & backInput ~= 0
      local hasPressedForward <const> = buttonState.pressed & forwardInput ~= 0
      local hasPressed <const> = {
        [inputDirections.BACK] = hasPressedBack,
        [inputDirections.FORWARD] = hasPressedForward,
      }
      local hasPressedDirection <const> = hasPressed[direction]

      if (hasPressedDirection) then
        counter += 1
      end

      if (counter >= 2) then
        return true
      end
    end
  end
end

function Inputs:CheckDashBackInput(buttonStates, charDirection)
  return self:CheckDashInput(buttonStates, inputDirections.BACK, charDirection)
end

function Inputs:CheckDashForwardInput(buttonStates, charDirection)
  return self:CheckDashInput(buttonStates, inputDirections.FORWARD, charDirection)
end

function Inputs:CheckQCBInput(buttonStates, charDirection)
  return self:CheckQuarterCircleInput(buttonStates, inputDirections.BACK, charDirection)
end

function Inputs:CheckQCFInput(buttonStates, charDirection)
  return self:CheckQuarterCircleInput(buttonStates, inputDirections.FORWARD, charDirection)
end

function Inputs:CheckQuarterCircleInput(buttonStates, direction, charDirection)
  local backInput <const> = charDirection == charDirections.LEFT
    and pd.kButtonRight
    or pd.kButtonLeft
  local forwardInput <const> = charDirection == charDirections.LEFT
    and pd.kButtonLeft
    or pd.kButtonRight
  local checks <const> = {
    hasInputtedDown = false,
    hasInputtedDiagonal = false,
    hasInputtedFinalDirection = false,
  }

  for i = #buttonStates, 1, -1 do
    local buttonState <const> = buttonStates[i]
    local hasPressedBack <const> = buttonState.pressed & backInput ~= 0
    local hasPressedForward <const> = buttonState.pressed & forwardInput ~= 0
    local hasPressed <const> = {
      [inputDirections.BACK] = hasPressedBack,
      [inputDirections.FORWARD] = hasPressedForward,
    }
    local hasPressedDirection <const> = hasPressed[direction]
    local hasPressedDown <const> = buttonState.pressed & pd.kButtonDown ~= 0
    local isPressingBack <const> = buttonState.current & backInput ~= 0
    local isPressingForward <const> = buttonState.current & forwardInput ~= 0
    local isPressing <const> = {
      [inputDirections.BACK] = isPressingBack,
      [inputDirections.FORWARD] = isPressingForward,
    }
    local isPressingDirection <const> = isPressing[direction]
    local isPressingDown <const> = buttonState.current & pd.kButtonDown ~= 0

    if (checks.hasInputtedFinalDirection) then
      if (checks.hasInputtedDiagonal) then
        if (checks.hasInputtedDown) then
          return true
        else
          if (
            (hasPressedDown or isPressingDown) and
            not isPressingDirection
          ) then
            checks.hasInputtedDown = true
          end
        end
      else
        if (isPressingDirection and isPressingDown) then
          checks.hasInputtedDiagonal = true
        end
      end
    else
      if (
        (hasPressedDirection or isPressingDirection) and
        not isPressingDown
      ) then
        checks.hasInputtedFinalDirection = true
      end
    end
  end
end