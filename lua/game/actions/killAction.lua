KillAction = {}
KillAction.__index = KillAction

setmetatable(KillAction, {
  __index = Action,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function KillAction:_init(citizen)
	Action._init(self, 2)
	self.citizenToKill = citizen
end

function KillAction.act(self)
	local citizen = game.town.citizens[self.citizenToKill]

	if citizen:isAgent() then
		game.player.agentsKilled = game.player.agentsKilled + 1
		--This will eventually be an opposed check
		local riotIncrement = love.math.random(0,5)
		game.player.riot = game.player.riot + riotIncrement
	elseif citizen:isTainted() then
		game.player.taintedKilled = game.player.taintedKilled + 1

	else
		game.player.innocentsKilled = game.player.innocentsKilled + 1
		local trustDecrement = love.math.random(0,5)
		game.player.trust = game.player.trust - trustDecrement
	end
	game.town.citizens[self.citizenToKill].alive = 0

	local resultString = "I ordered the execution of " .. citizen.name .. " today. We will have to inspect the body to confirm our suspicions."
	table.insert(game.resultsPhase.results, resultString)
end
