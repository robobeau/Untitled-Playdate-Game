import 'utils'

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics

local defaults = {
  sprites = {},
}

class('Stage', defaults).extends()

stages = {
  BEACH = 'Beach',
  CLIFTON = 'Clifton',
  LAWSON = 'Lawson',
  SHIBUYA = 'Shibuya',
}

function Stage:CleanUp()
  gfx.sprite.removeSprites(self.sprites)
end

function Stage:CreateBounds()
  local width <const>, height <const> = pd.display.getSize()
  local stageSprite <const> = self:GetStageSprite()
  self.maxDrawOffset = {
    x = 0,
    y = 0,
  }
  self.minDrawOffset = {
    x = width - stageSprite.width,
    y = height - stageSprite.height,
  }

  local ceiling <const> = gfx.sprite.new()
        ceiling:setCenter(0, 0)
        ceiling:setCollideRect(0, 0, stageSprite.width, 10)
        ceiling:setGroupMask(collisionTypes.FLOOR)
        ceiling:setSize(stageSprite.width, 10)
        ceiling:moveTo(0, 0)
        ceiling:add()

  local floor <const> = gfx.sprite.new()
        floor:setCenter(0, 0)
        floor:setCollideRect(0, 0, stageSprite.width, 10)
        floor:setGroupMask(collisionTypes.FLOOR)
        floor:setSize(stageSprite.width, 10)
        floor:moveTo(0, stageSprite.height - 10)
        floor:add()

  local leftWall <const> = gfx.sprite.new()
        leftWall:setCenter(0, 0)
        leftWall:setCollideRect(0, 0, 10, stageSprite.height)
        leftWall:setGroupMask(collisionTypes.WALL)
        leftWall:setSize(10, stageSprite.height)
        leftWall:moveTo(0, 0)
        leftWall:add()

  local rightWall <const> = gfx.sprite.new()
        rightWall:setCenter(0, 0)
        rightWall:setCollideRect(0, 0, 10, stageSprite.height)
        rightWall:setGroupMask(collisionTypes.WALL)
        rightWall:setSize(10, stageSprite.height)
        rightWall:moveTo(stageSprite.width - 10, 0)
        rightWall:add()

    table.insert(self.sprites, ceiling)
    table.insert(self.sprites, floor)
    table.insert(self.sprites, leftWall)
    table.insert(self.sprites, rightWall)
end

function Stage:GetStageSprite()
  return self.sprites[1]
end

function Stage:init(config)
  self.bounds = {}
  self.character = config.character
  self.id = config.id or stages.CLIFTON

  self:Load()
  self:CreateBounds()

  -- Play stage music
end

function Stage:GetMinMaxBounds()
end

function Stage:Load()
  local lua <const> = self:LoadTMJ()

  for i, layer in ipairs(lua.layers) do
    local imagePath = layer.image
          -- Chop off the "../" and ".png"
          imagePath = string.gsub(imagePath, '%.%./', '')
          imagePath = string.gsub(imagePath, '%.png', '')
    local image <const> = gfx.image.new(imagePath)
    local sprite <const> = gfx.sprite.new(image)
          sprite:setCenter(0, 0)
          sprite:moveTo(layer.offsetx or 0, layer.offsety or 0)
          sprite:setZIndex(i - 100)
          sprite:add()

    table.insert(self.sprites, sprite)
  end

  local stageSprite <const> = self:GetStageSprite()
  local width <const>, height <const> = pd.display.getSize()
  local drawOffset <const> = {
    x = (width - stageSprite.width) / 2, -- Middle
    y = (height - stageSprite.height) / 2, -- Floor
  }

  gfx.setDrawOffset(drawOffset.x, drawOffset.y)
  -- gfx.setDrawOffset(0, 0)
end

function Stage:LoadTMJ()
  return json.decodeFile('tsj/Stages/' .. self.id .. '.tmj')
end

function Stage:UpdateDrawOffset()
  local x <const>, y <const> = gfx.getDrawOffset()
  local offsetPosition <const> = {
    x = x + self.character.x,
    y = y + self.character.y,
  }
  local characterSpeed <const> = self.character:GetCurrentSpeed()
  local drawOffsetVelocity <const> = {
    x = offsetPosition.x < 100 and characterSpeed
      or offsetPosition.x > 300 and -characterSpeed
      or 0,
    y = offsetPosition.y < 100 and characterSpeed
      or offsetPosition.y > 140 and -characterSpeed
      or 0,
  }
  local drawOffset <const> = {
    x = math.clamp(
      x + drawOffsetVelocity.x,
      self.minDrawOffset.x,
      self.maxDrawOffset.x
    ),
    y = math.clamp(
      y + drawOffsetVelocity.y,
      self.minDrawOffset.y,
      self.maxDrawOffset.y
    )
  }

  gfx.setDrawOffset(drawOffset.x, drawOffset.y)
end

function Stage:update()
  self:UpdateDrawOffset()
end