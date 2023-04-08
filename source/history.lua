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

function History:init(properties)
  self.firstFrame = table.deepcopy(properties) or {}

  self:MutateFrame(self.firstFrame, self.counter)
end

function History:MutateFrame(properties, frame)
  local current = self:GetFrame(frame)

  if (current == nil) then
    current = {}
  end

  for k in pairs(properties) do
    current[k] = properties[k]
  end
end

function History:Reset()
  self.counter = 1
  self.frames = {}

  self:MutateFrame(self.firstFrame, self.counter)
end

function History:Tick()
  local next <const> = table.deepcopy(self.frames[self.counter])

  self.counter += 1

  self.frames[self.counter] = next
end