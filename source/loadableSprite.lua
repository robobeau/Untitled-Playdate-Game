-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics
local spr <const> = gfx.sprite

loadingStates = {
  ACTIVE = 1,
  IDLE = 2,
  LOADED = 4,
  LOADING = 8,
}

local defaults <const> = {
  assetIndex = 1,
  assetsList = {},
  loadingState = loadingStates.IDLE,
}

class('LoadableSprite', defaults).extends(spr)

function LoadableSprite:init(options)
  LoadableSprite.super.init(self)
end

function LoadableSprite:IsActive()
  return self.loadingState == loadingStates.ACTIVE
end

function LoadableSprite:IsLoading()
  return self.loadingState == loadingStates.LOADING
end

function LoadableSprite:IsLoaded()
  return self.loadingState == loadingStates.LOADED
end

function LoadableSprite:LoadAsset()
  -- Overload this on each sprite's class!
end

function LoadableSprite:OnLoaded()
  -- Overload this on each sprite's class!
end

function LoadableSprite:update()
  if (self.loadingState == loadingStates.IDLE) then
    self.loadingState = loadingStates.LOADING
  end

  if (self.loadingState == loadingStates.LOADING) then
    self:LoadAsset()

    self.assetIndex += 1

    if (self.assetIndex > #self.assetsList) then
      self.loadingState = loadingStates.LOADED
    end
  end

  if (self.loadingState == loadingStates.LOADED) then
    self:OnLoaded()

    self.loadingState = loadingStates.ACTIVE
  end
end