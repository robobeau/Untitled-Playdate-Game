local defaults <const> = {
  counter = 1,
  frames = {},
}

class('History', defaults).extends()

function History:GetFrame(index)
  local frameIndex <const> = index or self.counter
  local frame = self.frames[frameIndex]

  if (frame == nil) then
    self.frames[frameIndex] = {}

    frame = self.frames[frameIndex]
  end

  return frame
end

function History:init(properties)
  self.firstFrame = properties ~= nil
    and table.deepcopy(properties)
    or {}

  self:MutateFrame(self.firstFrame, self.counter)
end

function History:MutateFrame(properties, frame)
  local current = self:GetFrame(frame or self.counter)

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