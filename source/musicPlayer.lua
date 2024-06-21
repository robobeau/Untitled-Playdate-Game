-- Convenience variables
local pd <const> = playdate
local snd <const> = pd.sound

fightSongs = {
  DowntownStreets = {
    artist = 'Voltz Supreme',
    filePath = 'music/Stage - Downtown Streets - Early Rounds Loop',
    loopRange = {
      start = 0,
      stop = 103.641,
    },
    title = 'Downtown Streets',
  },
  DrunkenMaster = {
    artist = 'Voltz Supreme',
    filePath = 'music/Stage - Metropolis Grime - Loop',
    loopRange = {
      start = 0,
      stop = 139.637,
    },
    title = 'Metropolis Grime',
  },
  MetropolisGrime = {
    artist = 'Voltz Supreme',
    filePath = 'music/Stage - The Drunken Master - Loop',
    loopRange = {
      start = 0,
      stop = 156.279,
    },
    title = 'The Drunken Master',
  },
}
fightPlaylist = {
  fightSongs.DowntownStreets,
  fightSongs.DrunkenMaster,
  fightSongs.MetropolisGrime,
}

menuSongs = {
  CharacterSelect = {
    artist = 'Voltz Supreme',
    filePath = 'music/Hip Menus - Loop 1',
    loopRange = {
      start = 0,
      stop = 29.539,
    },
    title = 'Hip Menus',
  },
}
menuPlaylist = {
  menuSongs.CharacterSelect,
}

local defaults = {
  announces = false,
  autoPlay = false,
  loops = false,
  playCount = 0,
  player = nil,
  playlist = nil,
  playlistIndex = 0,
  shuffle = false,
  volume = 0.5,
}

class('MusicPlayer', defaults).extends()

-- function MusicPlayer:Draw()
-- end

function MusicPlayer:init(config)
  self.announces = config.announces or self.announces
  self.autoPlay = config.autoPlay or self.autoPlay
  self.loops = config.loops or self.loops
  self.playlist = config.playlist or fightPlaylist
  self.shuffle = config.shuffle or self.shuffle
  self.volume = config.volume or self.volume
end

function MusicPlayer:InitPlayer(song)
  self.player = snd.fileplayer.new(song.filePath)
  self.player:setLoopRange(song.loopRange.start, song.loopRange.stop)
  self.player:setVolume(self.volume)
end

function MusicPlayer:IsPlaying()
  return self.player and self.player:isPlaying() or false
end

function MusicPlayer:LoadSong(song)
  if (self.player) then
    self.player:stop()
    self.player:load(song.filePath)
    self.player:setLoopRange(song.loopRange.start, song.loopRange.stop)
  else
    self:InitPlayer(song)
  end

  if (self.playCount <= #self.playlist) then
    self.player:setFinishCallback(function ()
      self:OnFinish()
    end)
  end
end

function MusicPlayer:OnFinish()
  self:UpdatePlayCount()

  if (self.playCount < #self.playlist) then
    self:Play()
  else
    self:Stop()
  end
end

function MusicPlayer:Pause()
  self.player:pause()
end

function MusicPlayer:Play()
  self:QueueUpNextSong()

  self.player:play(1)
end

function MusicPlayer:QueueUpNextSong()
  self:UpdatePlaylistIndex()
  self:LoadSong(self.playlist[self.playlistIndex])
end

function MusicPlayer:Stop()
  if (self:IsPlaying()) then
    self.player:setFinishCallback(nil)
    self.player:stop()
  end

  self.playCount = 0
  self.playlistIndex = 0
end

function MusicPlayer:Teardown()
  self:Stop()

  self.player = nil
  self.playlist = nil
end

-- function MusicPlayer:Update()
--   if (self.announces) then
    
--   end
-- end

function MusicPlayer:UpdatePlayCount()
  self.playCount += 1

  if (self.loops and self.playCount > #self.playlist) then
    self.playCount = 0
  end
end

function MusicPlayer:UpdatePlaylistIndex()
  if (self.shuffle) then
    local prevIndex <const> = self.playlistIndex

    self.playlistIndex = math.random(#self.playlist)

    if (self.playlistIndex == prevIndex) then
      self:UpdatePlaylistIndex()
    end
  else
    self.playlistIndex += 1

    if (self.playlistIndex > #self.playlist) then
      self.playlistIndex = 1
    end
  end
end