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
		if citizen.taint == 1 then
			citizen.suspicious = citizen.suspicious + 50
			suspiciousIndividuals = suspiciousIndividuals + 1
		end
	end

	local resultString = "I canvased the town and encountered " .. suspiciousIndividuals .. " suspicious individuals."
	table.insert(game.resultsPhase.results, resultString)
end

