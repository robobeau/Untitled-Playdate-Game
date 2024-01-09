import 'utils'

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics
local img <const> = gfx.image
local spr <const> = gfx.sprite

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

  local ceiling <const> = spr.new()
        ceiling:setCenter(0, 0)
        ceiling:moveTo(0, 0)
        ceiling:setCollideRect(0, 0, stageSprite.width, 20)
        ceiling:setCollidesWithGroupsMask(collisionTypes.PUSHBOX)
        ceiling:setGroupMask(collisionTypes.WALL)
        ceiling:setSize(stageSprite.width, 20)
        ceiling:setUpdatesEnabled(false)
        ceiling:add()

  local floor <const> = spr.new()
        floor:setCenter(0, 0)
        floor:moveTo(0, stageSprite.height - 20)
        floor:setCollideRect(0, 0, stageSprite.width, 20)
        floor:setCollidesWithGroupsMask(collisionTypes.PUSHBOX)
        floor:setGroupMask(collisionTypes.WALL)
        floor:setSize(stageSprite.width, 20)
        floor:setUpdatesEnabled(false)
        floor:add()

  local leftWall <const> = spr.new()
        leftWall:setCenter(0, 0)
        leftWall:moveTo(0, 0)
        leftWall:setCollideRect(0, 0, 20, stageSprite.height)
        leftWall:setCollidesWithGroupsMask(collisionTypes.PUSHBOX)
        leftWall:setGroupMask(collisionTypes.WALL)
        leftWall:setSize(20, stageSprite.height)
        leftWall:setUpdatesEnabled(false)
        leftWall:add()

  local rightWall <const> = spr.new()
        rightWall:setCenter(0, 0)
        rightWall:moveTo(stageSprite.width - 20, 0)
        rightWall:setCollideRect(0, 0, 20, stageSprite.height)
        rightWall:setCollidesWithGroupsMask(collisionTypes.PUSHBOX)
        rightWall:setGroupMask(collisionTypes.WALL)
        rightWall:setSize(20, stageSprite.height)
        rightWall:setUpdatesEnabled(false)
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
  self.character1 = config.character1
  self.character2 = config.character2
  self.id = config.id or stages.CLIFTON

  self:Load()
  self:CreateBounds()
  self:InitOffset()
  -- Play stage music
end

function Stage:InitOffset()
  local stageSprite <const> = self:GetStageSprite()
  local width <const>, height <const> = pd.display.getSize()
  local offset <const> = {
    x = -((stageSprite.width - width) / 2),
    y = -(stageSprite.height - height),
  }

  -- printTable(offset)

  gfx.setDrawOffset(offset.x, offset.y)
end

function Stage:Load()
  local tmj <const> = self:LoadTMJ()

  for i, layer in ipairs(tmj.layers) do
    if (layer.visible) then
      local imagePath = layer.image
            -- Chop off the "../" and ".png"
            imagePath = string.gsub(imagePath, '%.%./', '')
            imagePath = string.gsub(imagePath, '%.png', '')
      local image <const> = img.new(imagePath)
      local sprite <const> = spr.new(image)
            sprite:setCenter(0, 0)
            sprite:moveTo(layer.offsetx or 0, layer.offsety or 0)
            sprite:setCollisionsEnabled(false)
            sprite:setUpdatesEnabled(false)
            sprite:setZIndex(i - 100)
            sprite:add()

      table.insert(self.sprites, sprite)
    end
  end

  local stageSprite <const> = self:GetStageSprite()
  local width <const>, height <const> = pd.display.getSize()
  local drawOffset <const> = {
    x = (width - stageSprite.width) / 2, -- Middle
    y = (height - stageSprite.height) / 2, -- Floor
  }

  gfx.setDrawOffset(drawOffset.x, drawOffset.y)
end

function Stage:LoadTMJ()
  return json.decodeFile('tsj/Stages/' .. self.id .. '.tmj')
end

function Stage:Reset()
  self:InitOffset()
end

function Stage:Teardown()
  gfx.sprite.removeSprites(self.sprites)
end

function Stage:UpdateDrawOffset()
  local char1Velocity = 0
  local char2Velocity = 0
  local displayWidth <const>, displayHeight <const> = pd.display.getSize()
  local drawOffsetX <const>, drawOffsetY <const> = gfx.getDrawOffset()
  -- local offsetChar1Position <const> = {
  --   x = self.character1.x,
  --   y = drawOffsetY + self.character1.y,
  -- }
  -- local offsetChar2Position <const> = {
  --   x = self.character2.x,
  --   y = drawOffsetY + self.character2.y,
  -- }
  -- local stage <const> = self:GetStageSprite()
  local offsetCenter <const> = {
    x = math.abs(drawOffsetX) + (displayWidth / 2),
    y = drawOffsetY + (displayHeight / 2),
  }
  local leftThreshold <const> = offsetCenter.x - 100
  local rightThreshold <const> = offsetCenter.x + 100

  if (self.character1.x < leftThreshold) then
    char1Velocity = 5
  elseif (self.character1.x > rightThreshold) then
    char1Velocity = -5
  end

  if (self.character2.x < leftThreshold) then
    char2Velocity = 5
  elseif (self.character2.x > rightThreshold) then
    char2Velocity = -5
  end

  local drawOffsetVelocity <const> = {
    x = char1Velocity + char2Velocity,
    y = 0
  }
  local drawOffset <const> = {
    x = math.clamp(
      drawOffsetX + drawOffsetVelocity.x,
      self.minDrawOffset.x,
      self.maxDrawOffset.x
    ),
    y = math.clamp(
      drawOffsetY + drawOffsetVelocity.y,
      self.minDrawOffset.y,
      self.maxDrawOffset.y
    )
  }

  gfx.setDrawOffset(drawOffset.x, drawOffset.y)
end

function Stage:update()
  self:UpdateDrawOffset()
end