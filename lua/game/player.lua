require("lua/game/citizen")

Player = {}
Player.__index = Player


setmetatable(Player, {
  __index = Citizen,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Player:_init()
	Citizen._init(self)

	self.name = "My Player"
	self.sex = 0
	self.face = FaceGenerator():generate(self.sex)

	self.taint = 0
	self.knows = 0

	for k,v in pairs(skills) do
		self.skills[k] = love.math.random(100)
	end

	self.actions = 3

	self.trust = 80
	self.riot = 0
	
	self.taintedKilled = 0
	self.agentsKilled = 0
	self.innocentsKilled = 0

	self.prayersKnown = {}
end
