NameGenerator = {}
NameGenerator.__index = NameGenerator

setmetatable(NameGenerator, {
  __index = NameGenerator,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function NameGenerator:_init()
	local femaleNamesLines = love.filesystem.lines("media/names/femaleForenames")
	self.femaleNames = {}
	for line in femaleNamesLines do
		table.insert(self.femaleNames, line)
	end

	local maleNamesLines = love.filesystem.lines("media/names/maleForenames")
	self.maleNames = {}
	for line in maleNamesLines do
		table.insert(self.maleNames, line)
	end

	local surnamesLines = love.filesystem.lines("media/names/surnames")
	self.surnames = {}
	for line in surnamesLines do
		table.insert(self.surnames, line)
	end
end

function NameGenerator.generate(self, sex)

	local forename
	local surname

	if sex == 1 then
		forename = self.maleNames[love.math.random(table.getn(self.maleNames))]
	else
		forename = self.femaleNames[love.math.random(table.getn(self.femaleNames))]
	end

	surname = self.surnames[love.math.random(table.getn(self.surnames))]
	
	return forename .. " " .. surname
end
