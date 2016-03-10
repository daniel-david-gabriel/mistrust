require("lua/game/quest")
require("lua/game/citizen")

Town = {}
Town.__index = Town

setmetatable(Town, {
  __index = Town,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Town:_init()
	self.name = ""
	self.townSize = 0
	self.day = 0

	self.citizens = {}
	self.morgue = {}
	self.quests = {}
	self.jail = {}
end

function Town.new(self)
	self.name = "My Town"
	self.townSize = 25
	self.day = 1

	local nameGenerator = NameGenerator()
	local faceGenerator = FaceGenerator()
	local occupationGenerator = OccupationGenerator()

	self.citizens = {}
	self.morgue = {}
	self.jail = {}

	for i=1,self.townSize do
		self.citizens[i] = Citizen()
		self.citizens[i]:generate(nameGenerator, faceGenerator, occupationGenerator)
	end

	self.quests = {}
	local quest = Quest()
	quest:generate()
	table.insert(self.quests, quest)
end

function Town.load(self, townSize, day)

end
