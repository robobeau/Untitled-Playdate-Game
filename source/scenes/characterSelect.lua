import 'characters/Kim/kim'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics
local ui <const> = pd.ui

class('CharacterSelectScene').extends(Room)

function CharacterSelectScene:CheckInputs()
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
    sceneLoader:Start(function ()
      sceneManager:enter(FightScene)
    end)
  end
end

function CharacterSelectScene:draw()
  print('CharacterSelectScene', 'Draw')

  local section <const>,
        row <const>,
        column <const> = self.gridview:getSelection()
  local character <const> = self.characterList[row][column]
  local gridviewImage <const> = gfx.image.new(400, 240)

  -- Draw the background
  gfx.pushContext(gridviewImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, 400, 240)

    self.background:draw(0, 0)
  gfx.popContext()

  -- Draw the selected character
  if (character) then
    print('Text width', character.name, self.font:getTextWidth(character.name))
    print('Text height', self.font:getHeight())

    local characterNameImage <const> = gfx.image.new(
      self.font:getTextWidth(character.name),
      self.font:getHeight(),
      gfx.kColorClear
    )
    local characterPortraitImage <const> = character.portraitImage:scaledImage(1)

    gfx.pushContext(characterNameImage)
      gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
      self.font:drawTextAligned(string.upper(character.name), 0, 0, kTextAlignment.left)
    gfx.popContext()

    gfx.pushContext(gridviewImage)
      local characterNameImageScaled <const> = characterNameImage:scaledImage(3)
      local characterNamePosition <const> = {
        x = 20,
        y = 200,
      }
      local characterPortraitPosition <const> = {
        x = 0,
        y = 240 - characterPortraitImage.height
      }

      -- Draw character portrait
      gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
      characterPortraitImage:draw(characterPortraitPosition.x - 1, characterPortraitPosition.y - 1)
      characterPortraitImage:draw(characterPortraitPosition.x - 1, characterPortraitPosition.y + 1)
      characterPortraitImage:draw(characterPortraitPosition.x + 1, characterPortraitPosition.y - 1)
      characterPortraitImage:draw(characterPortraitPosition.x + 1, characterPortraitPosition.y + 1)

      gfx.setImageDrawMode(gfx.kDrawModeCopy)
      characterPortraitImage:draw(0, 240 - characterPortraitImage.height)

      -- Draw character name
      gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
      characterNameImageScaled:draw(characterNamePosition.x - 1, characterNamePosition.y - 1)
      characterNameImageScaled:draw(characterNamePosition.x - 1, characterNamePosition.y + 1)
      characterNameImageScaled:draw(characterNamePosition.x + 1, characterNamePosition.y - 1)
      characterNameImageScaled:draw(characterNamePosition.x + 1, characterNamePosition.y + 1)

      gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
      characterNameImageScaled:draw(characterNamePosition.x, characterNamePosition.y)
    gfx.popContext()
  end

  gfx.pushContext(gridviewImage)
    -- if (self.gridview.needsDisplay) then
    self.gridview:drawInRect(200, 100, 400, 240)
    -- end
  gfx.popContext()

  self.gridviewSprite:setImage(gridviewImage)
end

function CharacterSelectScene:enter(previous, ...)
  -- print('CharacterSelectScene', 'Enter')

  local fireBGImageTable <const> = gfx.imagetable.new('images/characterSelect/FireBG')

  self.background = gfx.animation.loop.new(100, fireBGImageTable)
  self.font = gfx.font.new('fonts/Super Monaco GP')
  self.font:setTracking(0)

  self:InitCharacterList()
  self:InitGrid()
end

function CharacterSelectScene:InitCharacterList()
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

function CharacterSelectScene:InitGrid()
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
    gfx.fillRect(x + 2 , y + 2, width - 4, height - 4)

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

    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(x + 2, y + 2, width - 4, height - 4)

    if (selected) then
      gfx.drawRect(x, y, width, height)

      gfx.setColor(gfx.kColorWhite)
      gfx.drawRect(x + 1, y + 1, width - 2, height - 2)
    end
  end

  self.gridviewSprite = gfx.sprite.new()
  self.gridviewSprite:setCenter(0, 0)
  self.gridviewSprite:add()
end

function CharacterSelectScene:leave(next, ...)
  -- print('CharacterSelectScene', 'Leave', next)

  self.background = nil
  self.gridviewSprite:remove()
end

function CharacterSelectScene:pause()
  -- print('CharacterSelectScene', 'Pause')
end

function CharacterSelectScene:resume()
  -- print('CharacterSelectScene', 'Resume')
end

function CharacterSelectScene:update(dt)
  -- print('CharacterSelectScene', 'Update', dt)

  self:CheckInputs()
  self:draw()
end