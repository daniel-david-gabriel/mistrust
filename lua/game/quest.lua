require("lua/game/check")

Quest = {}
Quest.__index = Quest

setmetatable(Quest, {
  __index = Quest,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Quest:_init()
	self.name = "My Quest Name"
	self.giver = 10
	self.dueDate = 25

	self.checksToPass = {}
	--for 1 to random
	table.insert(self.checksToPass, Check())
end


