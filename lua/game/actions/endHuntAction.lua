EndHuntAction = {}
EndHuntAction.__index = EndHuntAction

setmetatable(EndHuntAction, {
  __index = Action,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function EndHuntAction:_init()
  Action._init(self, game.player.actions)
end

function EndHuntAction.act(self)

	game.resultsPhase.toState = game.huntSummary

	local resultString = "I have decided to end my hun in " .. game.town.name .. ". I should await the results of my report to the church."
	local result = Result(0, 0, resultString)
  table.insert(game.resultsPhase.results, result)
end
