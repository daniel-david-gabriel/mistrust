OccupationGenerator = {}
OccupationGenerator.__index = OccupationGenerator

setmetatable(OccupationGenerator, {
  __index = OccupationGenerator,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function OccupationGenerator:_init()
	local occupationsFile = love.filesystem.lines("media/occupations")
	self.occupations = {}
	for line in occupationsFile do
		table.insert(self.occupations, line)
	end
end

function OccupationGenerator.generate(self)
	return self.occupations[love.math.random(table.getn(self.occupations))]
end
