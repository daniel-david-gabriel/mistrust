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

	citizen.bodyInspected = 1

	if citizen:isAgent() then
		local riotDecrement = love.math.random(1,5)
		game.player.riot = game.player.riot - riotDecrement
		local trustIncrement = love.math.random(1,5)
		game.player.trust = game.player.trust + trustIncrement
	elseif citizen:isTainted() then
		local riotDecrement = love.math.random(1,5)
		game.player.riot = game.player.riot - riotDecrement
	else
		local trustDecrement = love.math.random(0,5)
		game.player.trust = game.player.trust - trustDecrement
	end

	local resultString = "I inspected the body of " .. citizen.name .. " today."
	--Put different results for innocent/tainted/agent
	table.insert(game.resultsPhase.results, resultString)
end
