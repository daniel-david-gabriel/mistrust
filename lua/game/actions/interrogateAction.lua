InterrogateAction = {}
InterrogateAction.__index = InterrogateAction

setmetatable(InterrogateAction, {
  __index = Action,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function InterrogateAction:_init(citizen)
	Action._init(self, 1)
	self.citizenToInterrogate = citizen
end

function InterrogateAction.act(self)
	local citizen = game.town.citizens[self.citizenToInterrogate]

	if citizen:isAgent() then
		citizen.suspicious = citizen.suspicious + 10 + love.math.random(0,10)
		--This will eventually be an opposed check
		local riotIncrement = love.math.random(0,1)
		game.player.riot = game.player.riot + riotIncrement
	elseif citizen:isTainted() then
		citizen.suspicious = citizen.suspicious + 10 + love.math.random(5,20)
	else
		citizen.suspicious = citizen.suspicious + love.math.random(0,10)
	end

	local trustDecrement = love.math.random(0,1)
	game.player.trust = game.player.trust - trustDecrement

	local resultString = "I interrogated " .. citizen.name .. " today. I have adjusted their suspicion level accordingly."
	table.insert(game.resultsPhase.results, resultString)
end
