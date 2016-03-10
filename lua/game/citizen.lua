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
	self.alive = 1
	self.jailed = 0
	
	self.taint = 0
	self.knows = 0
	self.suspicious = 0

	self.face = nil

	self.skills = {}
	self.skillsRevealed = {}
end

function Citizen.generate(self, nameGenerator, faceGenerator, occupationGenerator)
	self.name = nameGenerator:generate(sex)
	self.sex = love.math.random(0, 1)
	self.occupation = occupationGenerator:generate()
	self.face = faceGenerator:generate(sex)

	self.alive = 1
	self.jailed = 0

	self.taint = love.math.random(0, 1)
	self.knows = love.math.random(0, 1)

	for k,v in pairs(skills) do
		self.skills[k] = love.math.random(100)
		self.skillsRevealed[k] = 0
	end
end
