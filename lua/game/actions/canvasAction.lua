CanvasAction = {}
CanvasAction.__index = CanvasAction

setmetatable(CanvasAction, {
  __index = CanvasAction,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function CanvasAction:_init()
end

function CanvasAction.act(self)
	local suspiciousIndividuals = 0
	for _,citizen in pairs(game.town.citizens) do
		if citizen:isAgent() then
			citizen.suspicious = citizen.suspicious + love.math.random(1,5)
			local riotIncrement = love.math.random(0,1)
			game.player.riot = game.player.riot + riotIncrement
		elseif citizen:isTainted() then
			citizen.suspicious = citizen.suspicious + love.math.random(1,15)
			local trustDecrement = love.math.random(0,1)
			game.player.trust = game.player.trust - trustDecrement
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
	table.insert(game.resultsPhase.results, resultString)
end
