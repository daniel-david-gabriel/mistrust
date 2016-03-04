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

skills = {
	["perception"]="perception",
	["intimidation"]="intimidation",
	["bluff"]="bluff",
	["diplomacy"]="diplomacy"
}

difficulty = {
	["veryEasy"]=10,
	["easy"]=20,
	["average"]=30,
	["hard"]=40,
	["veryHard"]=50
}

function Check:_init()
	self.skill = ""
	self.difficulty = 0
end

function Check.generate(self, skill, difficulty, variance)
	self.skill = skill
	self.difficulty = difficulty + love.math.random(variance)
end


