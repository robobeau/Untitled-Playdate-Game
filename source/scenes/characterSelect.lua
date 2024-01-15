import 'characters/Kim/kim'

-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local gfx <const> = pd.graphics
local img <const> = gfx.image
local rec <const> = geo.rect
local snd <const> = pd.sound
local ui <const> = pd.ui
local vid <const> = gfx.video

-- Temp. character objects
local Andy <const> = {
  menuImagePath = 'images/characters/AndyMenu',
  name = 'Andy',
  nameImagePath = 'images/characters/AndyName',
  portraitImagePath = 'images/characters/AndyPortrait',
}
local Geese <const> = {
  menuImagePath = 'images/characters/GeeseMenu',
  name = 'Geese',
  nameImagePath = 'images/characters/GeeseName',
  portraitImagePath = 'images/characters/GeesePortrait',
}
local JetAxel <const> = {
  menuImagePath = 'images/characters/JetAxelMenu',
  name = 'Jet Axel',
  nameImagePath = 'images/characters/JetAxelName',
  portraitImagePath = 'images/characters/JetAxelPortrait',
}
local Joe <const> = {
  menuImagePath = 'images/characters/JoeMenu',
  name = 'Joe',
  nameImagePath = 'images/characters/JoeName',
  portraitImagePath = 'images/characters/JoePortrait',
}
local Li <const> = {
  menuImagePath = 'images/characters/LiMenu',
  name = 'Li',
  nameImagePath = 'images/characters/LiName',
  portraitImagePath = 'images/characters/LiPortrait',
}
local Mai <const> = {
  menuImagePath = 'images/characters/MaiMenu',
  name = 'Mai',
  nameImagePath = 'images/characters/MaiName',
  portraitImagePath = 'images/characters/MaiPortrait',
}
local Rick <const> = {
  menuImagePath = 'images/characters/RickMenu',
  name = 'Rick',
  nameImagePath = 'images/characters/RickName',
  portraitImagePath = 'images/characters/RickPortrait',
}
local Sandwichard <const> = {
  menuImagePath = 'images/characters/RichMenu',
  name = 'Sandwichard',
  nameImagePath = 'images/characters/RichName',
  portraitImagePath = 'images/characters/RichPortrait',
}
local Terry <const> = {
  menuImagePath = 'images/characters/TerryMenu',
  name = 'Terry',
  nameImagePath = 'images/characters/TerryName',
  portraitImagePath = 'images/characters/TerryPortrait',
}

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
    self.soundFX.cursor:play(1)
    self.gridview:selectNextRow(true)
  elseif (buttonState.hasPressedLeft) then
    self.soundFX.cursor:play(1)
    self.gridview:selectPreviousColumn(true)
  elseif (buttonState.hasPressedRight) then
    self.soundFX.cursor:play(1)
    self.gridview:selectNextColumn(true)
  elseif (buttonState.hasPressedUp) then
    self.soundFX.cursor:play(1)
    self.gridview:selectPreviousRow(true)
  end

  -- 
  if (buttonState.hasPressedA) then
    local section <const>,
          row <const>,
          column <const> = self.gridview:getSelection()
    local listItem <const> = self.characterList[row][column]

    if (listItem.selectable) then
      local config <const> = {
        character1Class = listItem.character
      }

      self.soundFX.selection:play(1)

      sceneLoader:Start(function ()
        sceneManager:resetAndEnter(FightScene, config)
      end)
    end
  end
end

function CharacterSelectScene:draw()
  self.gridviewImage:clear(gfx.kColorClear)

  self:DrawBackground()
  self:DrawCharacter()
  self:DrawGrid()
  self:DrawDisclaimers()

  self.gridviewImage:drawIgnoringOffset(0, 0)
end

function CharacterSelectScene:DrawBackground()
  self.backgroundVideo.file:renderFrame(self.backgroundVideo.frame)
end

function CharacterSelectScene:DrawCharacter()
  local section <const>,
        row <const>,
        column <const> = self.gridview:getSelection()
  local listItem <const> = self.characterList[row][column]

  if (listItem) then
    -- listItem.images.name:clear(gfx.kColorClear)

    -- Draw name
    -- gfx.pushContext(listItem.images.name)
    --   gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    --   self.font:drawTextAligned(listItem.character.name:upper(), 0, 0, kTextAlignment.left)
    -- gfx.popContext()

    gfx.pushContext(self.gridviewImage)
      -- local nameImageScaled <const> = listItem.images.name:scaledImage(3)
      -- local namePosition <const> = {
      --   x = 20,
      --   y = 200,
      -- }
      local portraitImageScaled <const> = listItem.images.portrait:scaledImage(1)
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
      -- gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
      -- nameImageScaled:draw(namePosition.x - 1, namePosition.y - 1)
      -- nameImageScaled:draw(namePosition.x - 1, namePosition.y + 1)
      -- nameImageScaled:draw(namePosition.x + 1, namePosition.y - 1)
      -- nameImageScaled:draw(namePosition.x + 1, namePosition.y + 1)

      -- -- Draw name
      -- gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
      -- nameImageScaled:draw(namePosition.x, namePosition.y)

      local namePosition <const> = {
        x = 10,
        y = 200
      }
      listItem.images.name2:drawAnchored(namePosition.x, namePosition.y, 0, 0.5)
    gfx.popContext()
  end
end

function CharacterSelectScene:DrawDisclaimers()
  gfx.pushContext(self.gridviewImage)
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.drawTextAligned(
      '*None* of these characters will be in the final game',
      390,
      0,
      kTextAlignment.right
    )
    gfx.drawTextAligned(
      'Also, this screen is mocked _LOL_',
      390,
      gfx.getSystemFont():getHeight(),
      kTextAlignment.right
    )
  gfx.popContext()
end

function CharacterSelectScene:DrawGrid()
  gfx.pushContext(self.gridviewImage)
    self.gridview:drawInRect(200, 100, 400, 240)
  gfx.popContext()
end

function CharacterSelectScene:enter(previous, ...)
  self:Init()

  if (sceneLoader.state == loaderStates.ACTIVE) then
    sceneLoader:Stop()
  end
end

function CharacterSelectScene:Init()
  local video <const> = vid.new('videos/FireBackground.pdv')

  self.backgroundMusic = snd.fileplayer.new('music/Hip Menus - Loop 1.mp3')
  self.backgroundMusic:setVolume(0.5)
  self.backgroundMusic:play(0)
  self.backgroundVideo = {
    file = video,
    frame = 1,
    frames = video:getFrameCount()
  }
  self.backgroundVideo.file:useScreenContext()
  self.displayRect = pd.display.getRect()
  self.font = fonts.SuperMonacoGP
  self.soundFX = {
    cursor = snd.sampleplayer.new('sounds/24H.wav'),
    selection = snd.sampleplayer.new('sounds/22H.wav')
  }

  self:InitCharacterList()
  self:InitGrid()
end

function CharacterSelectScene:InitCharacterList()
  local fontHeight <const> = self.font:getHeight()

  self.characterList = {
    {
      {
        character = Kim,
        hidden = false,
        images = {
          menu = img.new(Kim.menuImagePath),
          name = img.new(self.font:getTextWidth(Kim.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(Kim.nameImagePath),
          portrait = img.new(Kim.portraitImagePath),
        },
        selectable = true,
      },
      {
        character = Terry,
        hidden = false,
        images = {
          menu = img.new(Terry.menuImagePath),
          name = img.new(self.font:getTextWidth(Terry.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(Terry.nameImagePath),
          portrait = img.new(Terry.portraitImagePath),
        },
        selectable = false,
      },
      {
        character = Andy,
        hidden = false,
        images = {
          menu = img.new(Andy.menuImagePath),
          name = img.new(self.font:getTextWidth(Andy.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(Andy.nameImagePath),
          portrait = img.new(Andy.portraitImagePath),
        },
        selectable = false,
      },
      {
        character = Joe,
        hidden = false,
        images = {
          menu = img.new(Joe.menuImagePath),
          name = img.new(self.font:getTextWidth(Joe.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(Joe.nameImagePath),
          portrait = img.new(Joe.portraitImagePath),
        },
        selectable = false,
      },
      {
        character = JetAxel,
        hidden = true,
        images = {
          menu = img.new(JetAxel.menuImagePath),
          name = img.new(self.font:getTextWidth(JetAxel.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(JetAxel.nameImagePath),
          portrait = img.new(JetAxel.portraitImagePath),
        },
        selectable = false,
      },
    },
    {
      {
        character = Li,
        hidden = false,
        images = {
          menu = img.new(Li.menuImagePath),
          name = img.new(self.font:getTextWidth(Li.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(Li.nameImagePath),
          portrait = img.new(Li.portraitImagePath),
        },
        selectable = false,
      },
      {
        character = Geese,
        hidden = false,
        images = {
          menu = img.new(Geese.menuImagePath),
          name = img.new(self.font:getTextWidth(Geese.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(Geese.nameImagePath),
          portrait = img.new(Geese.portraitImagePath),
        },
        selectable = false,
      },
      {
        character = Rick,
        hidden = false,
        images = {
          menu = img.new(Rick.menuImagePath),
          name = img.new(self.font:getTextWidth(Rick.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(Rick.nameImagePath),
          portrait = img.new(Rick.portraitImagePath),
        },
        selectable = false,
      },
      {
        character = Mai,
        hidden = false,
        images = {
          menu = img.new(Mai.menuImagePath),
          name = img.new(self.font:getTextWidth(Mai.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(Mai.nameImagePath),
          portrait = img.new(Mai.portraitImagePath),
        },
        selectable = false,
      },
      {
        character = Sandwichard,
        hidden = true,
        images = {
          menu = img.new(Sandwichard.menuImagePath),
          name = img.new(self.font:getTextWidth(Sandwichard.name:upper()), fontHeight, gfx.kColorClear),
          name2 = img.new(Sandwichard.nameImagePath),
          portrait = img.new(Sandwichard.portraitImagePath),
        },
        selectable = false,
      },
    }
  }
end

function CharacterSelectScene:InitGrid()
  self.gridview = ui.gridview.new(32, 32)
  self.gridview:setNumberOfColumns(5)
  self.gridview:setNumberOfRows(2)
  self.gridviewImage = img.new(400, 240)

  local characterList <const> = self.characterList

  function self.gridview:drawCell(section, row, column, highlighted, x, y, width, height)
    local listItem <const> = characterList[row][column]

    if (listItem.hidden and not highlighted) then
      return
    end

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(x + 2 , y + 2, width - 4, height - 4)

    local centeredPosition <const> = {
      x = (listItem.images.menu.width - width) / 2,
      y = (listItem.images.menu.height - height) / 2
    }
    local sourceRect <const> = rec.new(
      centeredPosition.x + 4,
      centeredPosition.y + 4,
      width - 4,
      height - 4
    )

    listItem.images.menu:draw(
      x + 2,
      y + 2,
      gfx.kImageUnflipped,
      sourceRect
    )

    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(x + 2, y + 2, width - 4, height - 4)

    if (highlighted) then
      gfx.setColor(gfx.kColorBlack)
      gfx.drawRect(x, y, width, height)

      gfx.setColor(gfx.kColorWhite)
      gfx.drawRect(x + 1, y + 1, width - 2, height - 2)

      if (not listItem.selectable) then
        gfx.setColor(gfx.kColorBlack)
        gfx.drawLine(x + 2, y + 2, x + width - 4, y + height - 4)
        gfx.drawLine(x + 2, y + height - 4, x + width - 4, y + 2)
      end
    end
  end
end

function CharacterSelectScene:leave(next, ...)
  self:Teardown()
end

function CharacterSelectScene:pause()
  self.backgroundMusic:stop()
end

function CharacterSelectScene:resume()
  self.backgroundMusic:play(0)
end

function CharacterSelectScene:Teardown()
  self.backgroundMusic:stop()
  self.backgroundMusic = nil
  self.backgroundVideo = nil
  self.displayRect = nil
  self.font = nil
  self.gridview = nil
  self.gridviewImage:clear(gfx.kColorClear)
end

function CharacterSelectScene:update(dt)
  self.backgroundVideo.frame += 1

  if (self.backgroundVideo.frame > self.backgroundVideo.frames) then
    self.backgroundVideo.frame = 1
  end

  self:CheckInputs()
end