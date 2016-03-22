InspectCorpseAction = {}
InspectCorpseAction.__index = InspectCorpseAction

setmetatable(InspectCorpseAction, {
  __index = Action,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function InspectCorpseAction:_init(citizen)
	Action._init(self, 1)
	self.citizenToInspect = citizen
end

function InspectCorpseAction.act(self)
	local citizen = game.town.morgue[self.citizenToInspect]
	local riotChange = 0
	local trustChange = 0

	--If it's been inspected, do nothing?

	citizen.bodyInspected = 1

	if citizen:isAgent() then
		riotChange = riotChange - love.math.random(1,5)
		--game.player.riot = game.player.riot - riotDecrement
		trustChange = trustChange + love.math.random(1,5)
		--game.player.trust = game.player.trust + trustIncrement
	elseif citizen:isTainted() then
		riotChange = riotChange - love.math.random(1,5)
		--game.player.riot = game.player.riot - riotDecrement
	else
		trustChange = trustChange - love.math.random(0,5)
		--game.player.trust = game.player.trust - trustDecrement
	end

	local resultString = "I inspected the body of " .. citizen.name .. " today." --Put different results for innocent/tainted/agent
	local result = Result(trustChange, riotChange, resultString)
	table.insert(game.resultsPhase.results, result)
end
