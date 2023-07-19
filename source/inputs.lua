class('Inputs').extends()

-- Convenience variables
local pd <const> = playdate
cache = {}
local directions <const> = {
  BACK = 1,
  FORWARD = 2,
}

function Inputs:CheckBackInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.isPressingBack) then
    return true
  end
end

function Inputs:CheckDashBackInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.isPressingBack) then
    local start <const> = #character.history.frames - 1
    local stop <const> = #character.history.frames - 7

    if (stop >= 1) then
      local counter = 0

      for i = start, stop, -1 do
        local buttonState <const> = self:GetButtonState(character, i)

        if (buttonState.hasPressedBack) then
          counter += 1
        end

        if (counter >= 2) then
          return true
        end
      end
    end
  end
end

function Inputs:CheckDashForwardInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.isPressingForward) then
    local start <const> = #character.history.frames - 1
    local stop <const> = #character.history.frames - 7

    if (stop >= 1) then
      local counter = 0

      for i = start, stop, -1 do
        local buttonState <const> = self:GetButtonState(character, i)

        if (buttonState.hasPressedForward) then
          counter += 1
        end

        if (counter >= 2) then
          return true
        end
      end
    end
  end
end

function Inputs:CheckCrouchInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.isPressingDown) then
    return true
  end
end

function Inputs:CheckJumpInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.isPressingUp) then
    return true
  end
end

function Inputs:CheckFireballInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.hasPressedA or buttonState.hasReleasedA) then
    return self:CheckQuarterCircleInput(character, directions.FORWARD)
  end
end

function Inputs:CheckForwardInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.isPressingForward) then
    return true
  end
end

function Inputs:CheckQuarterCircleInput(character, finalDirection)
  local checks = {
    hasInputtedDown = false,
    hasInputtedDiagonal = false,
    hasInputtedFinalDirection = false,
  }
  local start <const> = #character.history.frames
  local stop <const> = math.max(start - 10, 1)

  for i = start, stop, -1 do
    local buttonState <const> = self:GetButtonState(character, i)
    local hasPressed <const> = {
      [directions.BACK] = buttonState.hasPressedBack,
      [directions.FORWARD] = buttonState.hasPressedForward,
    }
    local hasPressedFinalDirection <const> = hasPressed[finalDirection]
    local isPressing <const> = {
      [directions.BACK] = buttonState.isPressingBack,
      [directions.FORWARD] = buttonState.isPressingForward,
    }
    local isPressingFinalDirection <const> = isPressing[finalDirection]

    if (checks.hasInputtedFinalDirection) then
      if (checks.hasInputtedDiagonal) then
        if (checks.hasInputtedDown) then
          return true
        else
          if (
            (buttonState.hasPressedDown or buttonState.isPressingDown) and
            not isPressingFinalDirection
          ) then
            checks.hasInputtedDown = true
          end
        end
      else
        if (isPressingFinalDirection and buttonState.isPressingDown) then
          checks.hasInputtedDiagonal = true
        end
      end
    else
      if (
        (hasPressedFinalDirection or isPressingFinalDirection) and
        not buttonState.isPressingDown
      ) then
        checks.hasInputtedFinalDirection = true
      end
    end
  end
end

-- Typically used to check if the character is going from crouching to standing
function Inputs:CheckRiseInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.hasReleasedDown) then
    return true
  end
end

function Inputs:CheckRunForwardInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.isPressingForward) then
    local start <const> = #character.history.frames - 1
    local stop <const> = #character.history.frames - 7

    if (stop >= 1) then
      local counter = 0

      for i = start, stop, -1 do
        local buttonState <const> = self:GetButtonState(character, i)

        if (buttonState.hasPressedForward) then
          counter += 1
        end

        if (counter >= 3) then
          return true
        end
      end
    end
  end
end

-- Dive Kick input
function Inputs:CheckSpecialDownInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.hasPressedB and buttonState.isPressingDown) then
    return true
  end
end

-- Flash Kick input
function Inputs:CheckSpecialUpInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.hasPressedB or buttonState.hasReleasedB) then
    local chargeTarget <const> = 30
    local start <const> = #character.history.frames
    local stop <const> = math.max(start - 45, 1)

    local chargeCounter = 0
    local hasPressedUp = false

    for i = start, stop, -1 do
      local buttonState <const> = self:GetButtonState(character, i)

      if (not hasPressedUp) then
        if (
          buttonState.hasPressedUp or
          buttonState.hasReleasedUp or
          buttonState.isPressingUp
        ) then
          hasPressedUp = true
        end
      end

      if (hasPressedUp) then
        if (buttonState.isPressingDown) then
          chargeCounter += 1
        end

        if (chargeCounter >= chargeTarget) then
          return true
        end
      end
    end
  end
end

function Inputs:CheckTatsuInput(character)
  local buttonState <const> = self:GetButtonState(character)

  if (buttonState.hasPressedB or buttonState.hasReleasedB) then
    return self:CheckQuarterCircleInput(character, directions.BACK)
  end
end

function Inputs:GetButtonState(character, index)
  local backInput <const>, forwardInput <const> = character:GetBackAndForwardInputs()
  local counter <const> = index or character.history.counter
  local frame <const> = character.history:GetFrame(counter)
  local current <const>, pressed <const>, released <const> = table.unpack(frame.buttonState)
  -- local cacheKey <const> = "C" .. current .. "P" .. pressed .. "R" .. released .. ""
  -- local cached <const> = cache[cacheKey]

  -- if (cached ~= nil) then
  --   print("Found '" .. cacheKey .. "'!")
  --   return cached
  -- end

  -- print('Not found!')

  local state <const> = {
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

  -- cache[cacheKey] = state

  return state
end
