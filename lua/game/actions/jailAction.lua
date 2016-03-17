JailAction = {}
JailAction.__index = JailAction

setmetatable(JailAction, {
  __index = Action,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function JailAction:_init(citizen)
    Action._init(self, 1)
	self.citizenToJail = citizen
end

function JailAction.act(self)

--if jail is full do something else?


	local citizen = game.town.citizens[self.citizenToJail]
  local trustChange = 0
  local riotChange = 0

	game.town.citizens[self.citizenToJail].jailed = 1

  trustChange = trustChange - love.math.random(0,1)
  --game.player.trust = game.player.trust - trustDecrement

	local resultString = "I indicted " .. citizen.name .. " today. They have been placed into custody until I choose to release them or I end my hunt."
	local result = Result(trustChange, riotChange, resultString)
  table.insert(game.resultsPhase.results, result)
end
