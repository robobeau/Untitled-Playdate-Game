class('Move')

function Move:init(aerial, cancellable, inputCheck)
  self.aerial = aerial or false
  self.cancellable = cancellable or false
  self.inputCheck = inputCheck or {}
end
