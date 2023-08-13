import 'characters/Kim/kim'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics
local img <const> = gfx.image
local rec <const> = geo.rect
local spr <const> = gfx.sprite
local ui <const> = pd.ui

class('CharacterSelectScene').extends(Room)

function CharacterSelectScene:CheckInputs()
  local current <const>, pressed <const>, released <const> = table.unpack({ pd.getButtonState() })
  local buttonState <const> = {
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
  -- print('CharacterSelectScene', 'Draw')

  self.gridviewImage:clear(gfx.kColorClear)

  self:DrawBackground()
  self:DrawCharacter()
  self:DrawGrid()

  self.gridviewSprite:setImage(self.gridviewImage)
end

function CharacterSelectScene:DrawBackground()
  gfx.pushContext(self.gridviewImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, 400, 240)

    self.backgroundAnimationLoop:draw(0, 0)
  gfx.popContext()
end

function CharacterSelectScene:DrawCharacter()
  local section <const>,
        row <const>,
        column <const> = self.gridview:getSelection()
  local character <const> = self.characterList[row][column]

  if (character) then
    -- print('Text width', character.name, self.font:getTextWidth(character.name))
    -- print('Text height', self.font:getHeight())

    character.nameImage:clear(gfx.kColorClear)

    -- Draw name
    gfx.pushContext(character.nameImage)
      gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
      self.font:drawTextAligned(string.upper(character.name), 0, 0, kTextAlignment.left)
    gfx.popContext()

    gfx.pushContext(self.gridviewImage)
      local nameImageScaled <const> = character.nameImage:scaledImage(3)
      local namePosition <const> = {
        x = 20,
        y = 200,
      }
      local portraitImageScaled <const> = character.portraitImage:scaledImage(1)
      local portraitPosition <const> = {
        x = 0,
        y = 240 - portraitImageScaled.height
      }

      -- Draw portrait's stroke
      gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
      portraitImageScaled:draw(portraitPosition.x - 1, portraitPosition.y - 1)
      portraitImageScaled:draw(portraitPosition.x - 1, portraitPosition.y + 1)
      portraitImageScaled:draw(portraitPosition.x + 1, portraitPosition.y - 1)
      portraitImageScaled:draw(portraitPosition.x + 1, portraitPosition.y + 1)

      -- Draw portrait
      gfx.setImageDrawMode(gfx.kDrawModeCopy)
      portraitImageScaled:draw(0, 240 - portraitImageScaled.height)

      -- Draw name's stroke
      gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
      nameImageScaled:draw(namePosition.x - 1, namePosition.y - 1)
      nameImageScaled:draw(namePosition.x - 1, namePosition.y + 1)
      nameImageScaled:draw(namePosition.x + 1, namePosition.y - 1)
      nameImageScaled:draw(namePosition.x + 1, namePosition.y + 1)

      -- Draw name
      gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
      nameImageScaled:draw(namePosition.x, namePosition.y)
    gfx.popContext()
  end
end

function CharacterSelectScene:DrawGrid()
  gfx.pushContext(self.gridviewImage)
    -- if (self.gridview.needsDisplay) then
    self.gridview:drawInRect(200, 100, 400, 240)
    -- end
  gfx.popContext()
end

function CharacterSelectScene:enter(previous, ...)
  -- print('CharacterSelectScene', 'Enter')

  local fireBGImageTable <const> = gfx.imagetable.new('images/characterSelect/FireBG')

  self.backgroundAnimationLoop = gfx.animation.loop.new(100, fireBGImageTable)
  self.font = gfx.font.new('fonts/Super Monaco GP')
  self.font:setTracking(0)

  self:InitCharacterList()
  self:InitGrid()
end

function CharacterSelectScene:InitCharacterList()
  local fontHeight <const> = self.font:getHeight()
  local kim <const> = Kim()
        kim.nameImage = img.new(
          self.font:getTextWidth(kim.name),
          fontHeight,
          gfx.kColorClear
        )

  self.characterList = {
    {
      kim,
      {
        hidden = false,
        name = 'Terry',
        nameImage = img.new(
          self.font:getTextWidth('Terry'),
          fontHeight,
          gfx.kColorClear
        ),
        menuImage = img.new('images/characters/TerryMenu'),
        portraitImage = img.new('images/characters/TerryPortrait'),
      },
      {
        hidden = false,
        name = 'Andy',
        nameImage = img.new(
          self.font:getTextWidth('Andy'),
          fontHeight,
          gfx.kColorClear
        ),
        menuImage = img.new('images/characters/AndyMenu'),
        portraitImage = img.new('images/characters/AndyPortrait'),
      },
      {
        hidden = false,
        name = 'Joe',
        nameImage = img.new(
          self.font:getTextWidth('Joe'),
          fontHeight,
          gfx.kColorClear
        ),
        menuImage = img.new('images/characters/JoeMenu'),
        portraitImage = img.new('images/characters/JoePortrait'),
      },
      {
        hidden = true,
        name = 'Jet Axel',
        nameImage = img.new(
          self.font:getTextWidth('Jet Axel'),
          fontHeight,
          gfx.kColorClear
        ),
        menuImage = img.new('images/characters/JetAxelMenu'),
        portraitImage = img.new('images/characters/JetAxelPortrait'),
      },
    },
    {
      {
        hidden = false,
        name = 'Li',
        nameImage = img.new(
          self.font:getTextWidth('Li'),
          fontHeight,
          gfx.kColorClear
        ),
        menuImage = img.new('images/characters/LiMenu'),
        portraitImage = img.new('images/characters/LiPortrait'),
      },
      {
        hidden = false,
        name = 'Geese',
        nameImage = img.new(
          self.font:getTextWidth('Geese'),
          fontHeight,
          gfx.kColorClear
        ),
        menuImage = img.new('images/characters/GeeseMenu'),
        portraitImage = img.new('images/characters/GeesePortrait'),
      },
      {
        hidden = false,
        name = 'Rick',
        nameImage = img.new(
          self.font:getTextWidth('Rick'),
          fontHeight,
          gfx.kColorClear
        ),
        menuImage = img.new('images/characters/RickMenu'),
        portraitImage = img.new('images/characters/RickPortrait'),
      },
      {
        hidden = false,
        name = 'Mai',
        nameImage = img.new(
          self.font:getTextWidth('Mai'),
          fontHeight,
          gfx.kColorClear
        ),
        menuImage = img.new('images/characters/MaiMenu'),
        portraitImage = img.new('images/characters/MaiPortrait'),
      },
      {
        hidden = true,
        name = 'Rich',
        nameImage = img.new(
          self.font:getTextWidth('Rich'),
          fontHeight,
          gfx.kColorClear
        ),
        menuImage = img.new('images/characters/RichMenu'),
        portraitImage = img.new('images/characters/RichPortrait'),
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
  self.gridviewImage = img.new(400, 240)

  local characterList <const> = self.characterList

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
      local sourceRect <const> = rec.new(
        centeredPosition.x + 4,
        centeredPosition.y + 4,
        width - 4,
        height - 4
      )

      character.menuImage:draw(
        x + 2,
        y + 2,
        gfx.kImageUnflipped,
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

  self.gridviewSprite = spr.new()
  self.gridviewSprite:setCollisionsEnabled(false)
  self.gridviewSprite:setCenter(0, 0)
  self.gridviewSprite:setUpdatesEnabled(false)
  self.gridviewSprite:add()
end

function CharacterSelectScene:leave(next, ...)
  -- print('CharacterSelectScene', 'Leave', next)

  self.backgroundAnimationLoop = nil
  self.font = nil
  self.gridview = nil
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