-- Convenience variables
local pd <const> = playdate

inputDirections = {
  BACK = 1,
  DOWN = 2,
  FORWARD = 4,
  UP = 8,
}

class('Inputs').extends()

function Inputs:CheckChargeInput(buttonStates, direction, milliseconds)
  local chargeTarget <const> = milliseconds or 45
  local chargeCounter = 0

  for i = #buttonStates, 1, -1 do
    local buttonState <const> = buttonStates[i]
    local isPressing <const> = {
      [inputDirections.BACK] = buttonState.isPressingBack,
      [inputDirections.DOWN] = buttonState.isPressingDown,
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

function Inputs:CheckChargeBackInput(buttonStates, milliseconds)
  return self:CheckChargeInput(buttonStates, inputDirections.BACK, milliseconds)
end

function Inputs:CheckChargeDownInput(buttonStates, milliseconds)
  return self:CheckChargeInput(buttonStates, inputDirections.DOWN, milliseconds)
end

function Inputs:CheckDashInput(buttonStates, direction)
  local latestButtonState <const> = buttonStates[#buttonStates]
  local latestIsPressing <const> = {
    [inputDirections.BACK] = latestButtonState.isPressingBack,
    [inputDirections.FORWARD] = latestButtonState.isPressingForward,
  }
  local latestIsPressingDirection <const> = latestIsPressing[direction]

  if (latestIsPressingDirection) then
    local counter = 0

    for i = #buttonStates - 1, 1, -1 do
      local buttonState <const> = buttonStates[i]
      local hasPressed <const> = {
        [inputDirections.BACK] = buttonState.hasPressedBack,
        [inputDirections.FORWARD] = buttonState.hasPressedForward,
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

function Inputs:CheckDashBackInput(buttonStates)
  return self:CheckDashInput(buttonStates, inputDirections.BACK)
end

function Inputs:CheckDashForwardInput(buttonStates)
  return self:CheckDashInput(buttonStates, inputDirections.FORWARD)
end

function Inputs:CheckQCBInput(buttonStates)
  return self:CheckQuarterCircleInput(buttonStates, inputDirections.BACK)
end

function Inputs:CheckQCFInput(buttonStates)
  return self:CheckQuarterCircleInput(buttonStates, inputDirections.FORWARD)
end

function Inputs:CheckQuarterCircleInput(buttonStates, direction)
  local checks <const> = {
    hasInputtedDown = false,
    hasInputtedDiagonal = false,
    hasInputtedFinalDirection = false,
  }

  for i = #buttonStates, 1, -1 do
    local buttonState <const> = buttonStates[i]
    local hasPressed <const> = {
      [inputDirections.BACK] = buttonState.hasPressedBack,
      [inputDirections.FORWARD] = buttonState.hasPressedForward,
    }
    local hasPressedDirection <const> = hasPressed[direction]
    local isPressing <const> = {
      [inputDirections.BACK] = buttonState.isPressingBack,
      [inputDirections.FORWARD] = buttonState.isPressingForward,
    }
    local isPressingDirection <const> = isPressing[direction]

    if (checks.hasInputtedFinalDirection) then
      if (checks.hasInputtedDiagonal) then
        if (checks.hasInputtedDown) then
          return true
        else
          if (
            (buttonState.hasPressedDown or buttonState.isPressingDown) and
            not isPressingDirection
          ) then
            checks.hasInputtedDown = true
          end
        end
      else
        if (isPressingDirection and buttonState.isPressingDown) then
          checks.hasInputtedDiagonal = true
        end
      end
    else
      if (
        (hasPressedDirection or isPressingDirection) and
        not buttonState.isPressingDown
      ) then
        checks.hasInputtedFinalDirection = true
      end
    end
  end
end