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

function Citizen:_init(nameGenerator, faceGenerator)
	self.name = nameGenerator:generate(sex)
	self.sex = love.math.random(1)
	self.face = faceGenerator:generate(sex)

	self.taint = 0
	self.knows = 0
end
