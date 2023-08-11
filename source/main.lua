import 'roomy-playdate'

import 'CoreLibs/animation'
import 'CoreLibs/graphics'
import 'CoreLibs/object'
import 'CoreLibs/sprites'
import "CoreLibs/timer"
import 'CoreLibs/ui'
import 'CoreLibs/utilities/sampler'

import 'collisions/collision'
import 'collisions/hitbox'
import 'collisions/hurtbox'
import 'loader'
import 'scenes/characterSelect'
import 'scenes/fight'
import 'utils'

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics

sceneLoader = Loader()
sceneManager = Manager()

function init()
  sceneLoader:add()
  sceneManager:push(FightScene)
end

-- function pd.cranked(change, acceleratedChange)
--   kim.frozen = true
--   kim2.frozen = true

--   if (timer) then
--     timer:remove()
--   end

--   timer = pd.timer.new(
--     500,
--     function()
--       kim.frozen = false
--       kim2.frozen = false
--     end
--   )
-- end

function pd.update()
  local dt

  -- print('Playdate Update', sceneLoader.state)

  if (
    sceneLoader.state == loaderStates.STARTING or
    sceneLoader.state == loaderStates.STOPPING
  ) then
    -- print('yielding')

    dt = coroutine.yield()
  end

  pd.timer.updateTimers()
  gfx.sprite.update()

  sceneManager:emit('update', dt)
end

init()
