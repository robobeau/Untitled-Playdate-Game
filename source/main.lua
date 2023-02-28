-- import "CoreLibs/crank"
-- import "CoreLibs/frameTimer"
import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import 'ball'
import 'characters/kim'
import 'collisionTypes'

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics

-- local theBall = nil

function init()
  -- pd.display.setRefreshRate(1)
  -- pd.display.setScale(2)
  -- pd.display.setOffset(0, -0)

  -- local floorImage = gfx.image.new('images/floor')
  local beachImage = gfx.image.new('images/BGBeach')

  -- local bgBeachSprite <const> = gfx.sprite.new(beachImage)

  gfx.sprite.setBackgroundDrawingCallback(
    function(x, y, width, height)
      -- x,y,width,height is the updated area in sprite-local coordinates
      -- The clip rect is already set to this area, so we don't need to set it ourselves
      beachImage:draw(0, 0)
    end
  )

  ceiling = gfx.sprite.new()
  ceiling:setCenter(0, 0)
  ceiling:setCollideRect(0, 0, 380, 60)
  ceiling:setGroupMask(collisionTypes.FLOOR)
  ceiling:moveTo(10, -50)
  ceiling:add()

  leftWall = gfx.sprite.new()
  leftWall:setCenter(0, 0)
  leftWall:setCollideRect(0, 0, 60, 240)
  leftWall:setGroupMask(collisionTypes.WALL)
  leftWall:moveTo(-50, 0)
  leftWall:add()

  rightWall = gfx.sprite.new()
  rightWall:setCenter(0, 0)
  rightWall:setCollideRect(0, 0, 60, 240)
  rightWall:setGroupMask(collisionTypes.WALL)
  rightWall:moveTo(390, 0)
  rightWall:add()

  floor = gfx.sprite.new()
  floor:setCenter(0, 0)
  floor:setCollideRect(0, 0, 380, 60)
  floor:setGroupMask(collisionTypes.FLOOR)
  floor:moveTo(10, 230)
  floor:add()

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

  -- print('===== UPDATE BITCH =====')

  -- gfx.drawText("refresh rate: " .. pd.display.getRefreshRate(), 0, 60)
  -- pd.drawFPS(0, 0)
end

init()
