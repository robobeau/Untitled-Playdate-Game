-- import 'CoreLibs/animation'
-- import 'CoreLibs/animator'
-- import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'character'
import 'inputs'

-- Convenience variables
local pd <const> = playdate

local defaults <const> = {
  -- dashSpeed = 8,
  -- jumpHeight = 12,
  name = 'Kim',
  -- speed = 4,
}

class('Kim', defaults).extends(Character)

function Kim:init(config)
  Kim.super.init(self, config)
end

function Kim:CheckSpecialInputs()
  local frame <const> = self.history:GetFrame()
  local tileProperties <const> = self:GetTileProperties(frame.frameIndex)

  -- If we can't perform a special move, exit early.
  if (not tileProperties.specialCancellable) then
    return
  end

  if (
    self:IsAirborne()
    and Inputs:CheckSpecialDownInput(self)
  ) then
    self:SetState(charStates.SPECIAL | charStates.AIRBORNE | charStates.DOWN)

    return true
  end

  if (
    not self:IsAirborne()
    and Inputs:CheckSpecialUpInput(self)
  ) then
    self:SetState(charStates.SPECIAL | charStates.AIRBORNE | charStates.UP)

    return true
  end

  Kim.super.CheckSpecialInputs(self)
end

function Kim:DerivePhysicsFromState()
  Kim.super.DerivePhysicsFromState(self)
end

function Kim:LoadTilesets()
  Kim.super.LoadTilesets(self)

  -- Special Moves
  self.tilesets[charStates.SPECIAL | charStates.AIRBORNE | charStates.UP] = self:HydrateTileset(self:LoadTSJ('FlashKick'));
  self.tilesets[charStates.SPECIAL | charStates.AIRBORNE | charStates.DOWN] = self:HydrateTileset(self:LoadTSJ('DiveKick'));
end
