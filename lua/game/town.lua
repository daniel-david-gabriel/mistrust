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

end

function Town.new(self)
	self.townSize = 50
	self.day = 1

	local nameGenerator = NameGenerator()
	local faceGenerator = FaceGenerator()

	self.citizens = {}

	for i=1,self.townSize do
		self.citizens[i] = Citizen(nameGenerator, faceGenerator)
	end

	self.quests = {}
	table.insert(self.quests, Quest())
end

function Town.load(self, townSize, day)

end
