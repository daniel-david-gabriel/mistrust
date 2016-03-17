ReleaseAction = {}
ReleaseAction.__index = ReleaseAction

setmetatable(ReleaseAction, {
  __index = Action,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function ReleaseAction:_init(citizen)
    Action._init(self, 1)
	self.citizenToRelease = citizen
end

function ReleaseAction.act(self)
	local citizen = game.town.jail[self.citizenToRelease]
  local trustChange = 0
  local riotChange = 0

	game.town.jail[self.citizenToRelease].jailed = 0

  trustChange = trustChange + 1
  --game.player.trust = game.player.trust + trustIncrement


	local resultString = "I released " .. citizen.name .. " today. They have been returned to the town unharmed."
	local result = Result(trustChange, riotChange, resultString)
  table.insert(game.resultsPhase.results, result)
end
