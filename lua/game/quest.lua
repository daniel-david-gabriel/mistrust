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
	self.name = ""
	self.giver = 0
	self.dueDate = 0

	self.checksToPass = {}
end

function Quest.generate(self)
	self.name = "My Quest Name"
	self.giver = 10
	self.dueDate = 25

	self.checksToPass = {}
	--for 1 to random
	local check = Check()
	check:generate(skills["perception"], difficulty["easy"], 0)
	table.insert(self.checksToPass, check)
end


