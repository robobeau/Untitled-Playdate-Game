local defaults <const> = {
  counter = 1,
  frames = {
    {}
  },
}

class('History', defaults).extends()

function History:GetFrame(index)
  return self.frames[index or self.counter]
end

function History:init()
  -- Do nothing, I guess!
end

function History:MutateTick(properties, index)
  local current = self:GetFrame(index)

  if (current == nil) then
    current = {}
  end

  for k in pairs(properties) do
    current[k] = properties[k]
  end
end

function History:Reset()
  self.counter = 0
  self.frames = {}
end

function History:Tick()
  local next <const> = table.deepcopy(self.frames[self.counter])

  self.counter += 1

  self.frames[self.counter] = next
end