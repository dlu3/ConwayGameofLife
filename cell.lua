Cell = {isAlive = false}
Cell.__index = Cell

function Cell:new()
  local object = {}
  setmetatable(object, Cell)
  Cell.__index = Cell
  return object
end

-- invert state
function Cell:changeState()
  self.isAlive = not self.isAlive
end

-- get state
function Cell:getState()
  return self.isAlive
end