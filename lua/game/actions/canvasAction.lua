CanvasAction = {}
CanvasAction.__index = CanvasAction

setmetatable(CanvasAction, {
  __index = Action,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function CanvasAction:_init()
	Action._init(self, 1)
end

function CanvasAction.act(self)
	local suspiciousIndividuals = 0
	local riotChange = 0
	local trustChange = 0
	for _,citizen in pairs(game.town.citizens) do
		if citizen:isAgent() then
			citizen.suspicious = citizen.suspicious + love.math.random(1,5)
			riotChange = riotChange + love.math.random(0,1)
			--game.player.riot = game.player.riot + riotIncrement
		elseif citizen:isTainted() then
			citizen.suspicious = citizen.suspicious + love.math.random(1,15)
			trustChange = trustChange - love.math.random(0,1)
			--game.player.trust = game.player.trust - trustDecrement
			suspiciousIndividuals = suspiciousIndividuals + 1
		else
			citizen.suspicious = citizen.suspicious + love.math.random(1,5)
		end

		
	end

	local resultString = ""
	if suspiciousIndividuals > 0 then
		resultString = resultString .. "I canvased the town and encountered a number of suspicious indivuduals."
	else
		resultString = resultString .. "I canvased the town and encountered no suspicious individuals. Either the town is clean, or the agents remain hidden."
	end

	local result = Result(trustChange, riotChange, resultString)
	table.insert(game.resultsPhase.results, result)
end
