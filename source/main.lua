-- import "CoreLibs/crank"
-- import "CoreLibs/frameTimer"
import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import 'ball'
import 'characters/kim'
import 'characterMenu'
import 'collisionTypes'
import 'meter'
import 'math'
import 'stage'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics

function init()
  -- pd.display.setRefreshRate(1)

  -- characterMenu = CharacterMenu()

  -- theBall = Ball({
  --   startingPosition = {
  --     x = 200,
  --     y = 20,
  --   },
  --   type = ballTypes.TENNISBALL,
  -- })
  -- theBall:add()

  local opponent <const> = gfx.sprite.new()
        opponent:moveTo(300, 220)
        opponent:add()

  kim = Kim({
    controllable = true,
    debuggable = true,
    name = 'Kim',
    -- opponent = opponent,
    startingDirection = charDirections.RIGHT,
    startingPosition = {
      x = 100,
      y = 220,
    }
  })
  kim2 = Kim({
    controllable = false,
    debuggable = false,
    name = 'Kim2',
    startingDirection = charDirections.LEFT,
    startingPosition = {
      x = 300,
      y = 220,
    }
  })

  -- OPPONENTS
  kim.opponent = kim2
  kim2.opponent = kim

  stage = Stage({
    character = kim,
    -- opponent = kim2,
    id = stages.CLIFTON,
  })

  -- LIFEBARS
  -- lifebar = Meter({
  --   amount = kim.health,
  --   direction = meterDirections.LEFT,
  --   meterRect = geo.rect.new(10, 10, 120, 16),
  --   total = kim.health,
  -- })
  -- lifebar:setZIndex(100)

  -- kim.OnHealthChange = (
  --   function (health)
  --     print(health)
  --     lifebar:SetAmount(health)
  --   end
  -- )

  -- lifebar2 = Meter({
  --   amount = kim2.health,
  --   direction = meterDirections.RIGHT,
  --   meterRect = geo.rect.new(390, 10, 120, 16),
  --   total = kim2.health,
  -- })
  -- lifebar2:setZIndex(100)

  -- kim2.OnHealthChange = (
  --   function (health)
  --     print(health)
  --     lifebar2:SetAmount(health)
  --   end
  -- )

  -- ADD SPRITES
  kim:add()
  kim2:add()
  -- lifebar:add()
  -- lifebar2:add()

  local menu <const> = pd.getSystemMenu()

  menu:addMenuItem(
    "Reset",
    function ()
      kim:Reset()
      theBall:Reset()
    end
  )

  pd.setMenuImage(gfx.image.new('images/Controls'))
end

function pd.cranked(change, acceleratedChange)
  kim.frozen = true

  if (timer) then
    timer:remove()
  end

  timer = pd.timer.new(
    500,
    function()
      kim.frozen = false
    end
  )
end

function pd.update()
  pd.timer.updateTimers()
  gfx.sprite.update()
  stage:update()

  -- characterMenu:Update()

  -- print('===== UPDATE BITCH =====')

  -- gfx.drawText("refresh rate: " .. pd.display.getRefreshRate(), 0, 60)
  -- pd.drawFPS(0, 0)
end

init()
