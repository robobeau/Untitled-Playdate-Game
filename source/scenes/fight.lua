
import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import '../ball'
import '../characters/Kim/kim'
import '../collisionTypes'
-- import '../loader'
-- import '../main'
import '../math'
import '../meter'
import '../roomy-playdate'
import '../stage'
import '../timer'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics

class('FightScene').extends(Room)

function FightScene:draw()
  -- Do something!
end

function FightScene:enter(previous, ...)
  -- print('FightScene', 'Enter')

  -- pd.display.setRefreshRate(1)

  -- sceneLoader:Start(function ()
    self:Init()
  -- end)
end

function FightScene:Init()
  self.theBall = Ball({
    startingPosition = {
      x = 200,
      y = 30,
    },
    type = ballTypes.TENNISBALL,
  })

  local opponent <const> = gfx.sprite.new()
        opponent:moveTo(300, 220)
        opponent:add()

  self.kim = Kim({
    controllable = true,
    debug = true,
    -- opponent = opponent,
    startingDirection = charDirections.RIGHT,
    startingPosition = {
      x = 100,
      y = 220,
    }
  })
  self.kim2 = Kim({
    controllable = false,
    debug = false,
    startingDirection = charDirections.LEFT,
    startingPosition = {
      x = 300,
      y = 220,
    }
  })

  -- OPPONENTS
  self.kim.opponent = self.kim2
  self.kim2.opponent = self.kim

  self.stage = Stage({
    character = self.kim,
    -- opponent = kim2,
    id = stages.CLIFTON,
  })

  -- LIFEBARS
  self.lifebar = Meter({
    amount = self.kim.health,
    direction = meterDirections.LEFT,
    label = "KIM",
    meterRect = geo.rect.new(20, 10, 150, 16),
    total = self.kim.health,
  })
  self.lifebar2 = Meter({
    amount = self.kim2.health,
    direction = meterDirections.RIGHT,
    label = "KIM",
    meterRect = geo.rect.new(380, 10, 150, 16),
    total = self.kim2.health,
  })
  self.lifebar:setZIndex(100)
  self.lifebar2:setZIndex(100)

  self.kim.OnHealthChange = (function (health)
    self.lifebar:SetAmount(health)
  end)
  self.kim2.OnHealthChange = (function (health)
    self.lifebar2:SetAmount(health)
  end)

  self.timer = Timer({
    limit = 99,
    position = {
      x = 200,
      y = 25,
    }
  })
  self.timer:setZIndex(100)

  -- ADD SPRITES
  self.kim:add()
  self.kim2:add()
  self.lifebar:add()
  self.lifebar2:add()
  -- theBall:add()
  self.timer:add()
  self.timer:Start()

  local menu <const> = pd.getSystemMenu()
        menu:addMenuItem("Reset", function ()
          self:Reset()
        end)

  pd.setMenuImage(gfx.image.new('images/Controls'))

  sceneLoader:Stop()
end

function FightScene:leave(next, ...)
  -- print('FightScene', 'Leave')

  -- TODO: Run "Cleanup()" on each sprite, if applicable.
  self.kim:remove()
  self.kim2:remove()
  -- theBall:remove()
  self.timer:remove()
end

function FightScene:pause()
  -- print('FightScene', 'Pause')
end

function FightScene:Reset()
  self.kim:Reset()
  self.kim2:Reset()
  -- theBall:Reset()
  self.timer:Reset()
end

function FightScene:resume()
  -- print('FightScene', 'Resume')
end

function FightScene:update(dt)
  -- print('FightScene', 'Update')

  -- if (
  --   sceneLoader.state == loaderStates.STARTING or
  --   sceneLoader.state == loaderStates.STOPPING
  -- ) then
  --   print('yielding')
  --   -- coroutine.yield()
  -- end

  self.stage:update()
end