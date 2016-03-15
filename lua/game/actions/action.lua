Action = {}
Action.__index = Action

setmetatable(Action, {
  __index = Action,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Action:_init(cost)
	self.cost = cost
end
