Check = {}
Check.__index = Check

setmetatable(Check, {
  __index = Check,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Check:_init()
	self.skill = "perception"
	self.difficulty = 100
end


