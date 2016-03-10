EndHuntAction = {}
EndHuntAction.__index = EndHuntAction

setmetatable(EndHuntAction, {
  __index = EndHuntAction,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function EndHuntAction:_init(citizen)
	self.citizenToKill = citizen
end

function EndHuntAction.act(self)

	game.resultsPhase.toState = game.huntSummary

	local resultString = "I have decided to end my hun in " .. game.town.name .. ". I should await the results of my report to the church."
	table.insert(game.resultsPhase.results, resultString)
end
