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
import 'math'
import 'stage'

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics

function init()
  -- pd.display.setRefreshRate(5)

  -- characterMenu = CharacterMenu()

  theBall = Ball({
    startingPosition = {
      x = 200,
      y = 20,
    },
    type = ballTypes.TENNISBALL,
  })
  theBall:add()

  kim = Kim({
    opponent = theBall,
    startingPosition = {
      x = 100,
      y = 230,
    }
  })
  kim:add()

  stage = Stage({
    character = kim,
    id = stages.CLIFTON,
  })

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
