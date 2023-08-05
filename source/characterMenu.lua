import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/ui'

import 'characters/Kim/kim'
import 'main'
import 'scenes/fight'

-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics
local geo <const> = pd.geometry
local ui <const> = pd.ui

local defaults <const> = {}

class('CharacterMenu', defaults).extends()

function CharacterMenu:CheckInputs()
  local current <const>, pressed <const>, released <const> = table.unpack({ pd.getButtonState() })
  local buttonState = {
    hasPressedA = pressed & pd.kButtonA ~= 0,
    hasPressedB = pressed & pd.kButtonB ~= 0,
    hasPressedDown = pressed & pd.kButtonDown ~= 0,
    hasPressedLeft = pressed & pd.kButtonLeft ~= 0,
    hasPressedRight = pressed & pd.kButtonRight ~= 0,
    hasPressedUp = pressed & pd.kButtonUp ~= 0,
    hasReleasedA = released & pd.kButtonA ~= 0,
    hasReleasedB = released & pd.kButtonB ~= 0,
    hasReleasedDown = released & pd.kButtonDown ~= 0,
    hasReleasedLeft = released & pd.kButtonLeft ~= 0,
    hasReleasedRight = released & pd.kButtonRight ~= 0,
    hasReleasedUp = released & pd.kButtonUp ~= 0,
    isPressingA = current & pd.kButtonA ~= 0,
    isPressingB = current & pd.kButtonB ~= 0,
    isPressingDown = current & pd.kButtonDown ~= 0,
    isPressingLeft = current & pd.kButtonLeft ~= 0,
    isPressingRight = current & pd.kButtonRight ~= 0,
    isPressingUp = current & pd.kButtonUp ~= 0,
  }

  -- Selection
  if (buttonState.hasPressedDown) then
    self.gridview:selectNextRow()
  elseif (buttonState.hasPressedLeft) then
    self.gridview:selectPreviousColumn()
  elseif (buttonState.hasPressedRight) then
    self.gridview:selectNextColumn()
  elseif (buttonState.hasPressedUp) then
    self.gridview:selectPreviousRow()
  end

  -- 
  if (buttonState.hasPressedA) then
    sceneManager:enter(FightScene)
  end
end

function CharacterMenu:Draw()
  print('CharacterMenu', 'Draw()')

  local section <const>,
        row <const>,
        column <const> = self.gridview:getSelection()
  local character <const> = self.characterList[row][column]
  local gridviewImage <const> = gfx.image.new(400, 240)

  gfx.pushContext(gridviewImage)
    if (character ~= nil) then
      local scaledImage <const> = character.portraitImage:scaledImage(1)
            scaledImage:draw(0, 240 - scaledImage.height)
    end

    self.gridview:drawInRect(200, 100, 400, 240)
  gfx.popContext()

  self.gridviewSprite:setImage(gridviewImage)
end

function CharacterMenu:init(scene)
  self.scene = scene

  self:InitCharacterList()
  self:InitGrid()
end

function CharacterMenu:InitCharacterList()
  self.characterList = {
    {
      Kim(),
      {
        hidden = false,
        name = 'Terry',
        menuImage = gfx.image.new('images/characters/TerryMenu'),
        portraitImage = gfx.image.new('images/characters/TerryPortrait'),
      },
      {
        hidden = false,
        name = 'Andy',
        menuImage = gfx.image.new('images/characters/AndyMenu'),
        portraitImage = gfx.image.new('images/characters/AndyPortrait'),
      },
      {
        hidden = false,
        name = 'Joe',
        menuImage = gfx.image.new('images/characters/JoeMenu'),
        portraitImage = gfx.image.new('images/characters/JoePortrait'),
      },
      {
        hidden = true,
        name = 'Jet Axel',
        menuImage = gfx.image.new('images/characters/JetAxelMenu'),
        portraitImage = gfx.image.new('images/characters/JetAxelPortrait'),
      },
    },
    {
      {
        hidden = false,
        name = 'Li',
        menuImage = gfx.image.new('images/characters/LiMenu'),
        portraitImage = gfx.image.new('images/characters/LiPortrait'),
      },
      {
        hidden = false,
        name = 'Geese',
        menuImage = gfx.image.new('images/characters/GeeseMenu'),
        portraitImage = gfx.image.new('images/characters/GeesePortrait'),
      },
      {
        hidden = false,
        name = 'Rick',
        menuImage = gfx.image.new('images/characters/RickMenu'),
        portraitImage = gfx.image.new('images/characters/RickPortrait'),
      },
      {
        hidden = false,
        name = 'Mai',
        menuImage = gfx.image.new('images/characters/MaiMenu'),
        portraitImage = gfx.image.new('images/characters/MaiPortrait'),
      },
      {
        hidden = true,
        name = 'Rich',
        menuImage = gfx.image.new('images/characters/RichMenu'),
        portraitImage = gfx.image.new('images/characters/RichPortrait'),
      },
    }
  }
end

function CharacterMenu:InitGrid()
  self.gridview = ui.gridview.new(32, 32)
  -- For background image
  -- self.gridview:setContentInset(5, 5, 5, 5)
  -- self.gridview:setCellPadding(1, 1, 1, 1)
  self.gridview:setNumberOfColumns(5)
  self.gridview:setNumberOfRows(2)

  local characterList = self.characterList

  function self.gridview:drawCell(section, row, column, selected, x, y, width, height)
    local character <const> = characterList[row][column]

    -- print(character.name)

    if (character.hidden and not selected) then
      return
    end

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(x, y, width, height)

    if (character ~= nil) then
      local centeredPosition <const> = {
        x = (character.menuImage.width - width) / 2,
        y = (character.menuImage.height - height) / 2
      }
      local sourceRect <const> = geo.rect.new(
        centeredPosition.x + 4,
        centeredPosition.y + 4,
        width - 4,
        height - 4
      )

      character.menuImage:draw(
        x + 2,
        y + 2,
        playdate.graphics.kImageUnflipped,
        sourceRect
      )
    end

    -- gfx.drawRect(x, y, width, height)
    -- gfx.drawRect(x + 1, y + 1, width - 2, height - 2)

    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(x + 2, y + 2, width - 4, height - 4)

    if (selected) then
      gfx.drawRect(x, y, width, height)
    end
  end

  self.gridviewSprite = gfx.sprite.new()
  self.gridviewSprite:setCenter(0, 0)
  self.gridviewSprite:add()
end

function CharacterMenu:Update()
  self:CheckInputs()

  if (self.gridview.needsDisplay) then
    self:Draw()
  end
end