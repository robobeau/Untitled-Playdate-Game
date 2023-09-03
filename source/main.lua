import 'CoreLibs/animation'
import 'CoreLibs/graphics'
import 'CoreLibs/object'
import 'CoreLibs/sprites'
import "CoreLibs/timer"
import 'CoreLibs/ui'
import 'CoreLibs/utilities/sampler'

import 'roomy-playdate'

import 'collisions/collision'
import 'collisions/hitbox'
import 'collisions/hurtbox'
import 'loader'
import 'math'
import 'roomy-playdate'
import 'scenes/characterSelect'
import 'scenes/fight'
import 'table'
import 'utils'

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics
local img <const> = gfx.image
local spr <const> = gfx.sprite

debugImage = img.new(15, 15)
sceneLoader = Loader()
sceneManager = Manager()

function init()
  -- pd.display.setRefreshRate(1)

  sceneManager:enter(CharacterSelectScene)
end

function pd.update()
  local dt

  pd.timer.updateTimers()
  gfx.sprite.update()

  sceneManager:emit('update', dt)
  sceneManager:emit('draw', dt)
  sceneLoader:Update()

  -- Debug
  gfx.pushContext(debugImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, 15, 15)

    gfx.setColor(gfx.kColorBlack)
    gfx.drawText('*' .. spr.spriteCount() .. '*', 0, 0)
  gfx.popContext()

  debugImage:drawIgnoringOffset(0, 13)
  pd.drawFPS(0, 0)
end

init()
