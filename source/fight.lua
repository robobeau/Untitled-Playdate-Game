class('Fight').extends()

local defaults = {
  round = 1
}

function Fight:init(config)
  self.lifebars = config.lifebars
  self.players = config.players
  self.stage = config.stage
end

function Fight:Start()
  
end