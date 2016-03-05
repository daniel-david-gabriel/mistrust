Citizen = {}
Citizen.__index = Citizen

setmetatable(Citizen, {
  __index = Citizen,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Citizen:_init()
	self.name = ""
	self.sex = 0
	self.occupation = ""
	self.face = nil

	self.taint = 0
	self.knows = 0

	self.suspicious = 0

	self.skills = {}
end

function Citizen.generate(self, nameGenerator, faceGenerator)
	self.name = nameGenerator:generate(sex)
	self.sex = love.math.random(0, 1)
	self.face = faceGenerator:generate(sex)

	self.taint = love.math.random(0, 1)
	self.knows = love.math.random(0, 1)

	for k,v in pairs(skills) do
		self.skills[k] = love.math.random(100)
	end
end
