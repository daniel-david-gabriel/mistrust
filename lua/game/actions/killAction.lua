KillAction = {}
KillAction.__index = KillAction

setmetatable(KillAction, {
  __index = KillAction,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function KillAction:_init(citizen)
	self.citizenToKill = citizen
end

function KillAction.act(self)
	local citizen = game.town.citizens[self.citizenToKill]
print(citizen.name)
	if citizen.taint == 1 then
		game.player.taintedKilled = game.player.taintedKilled + 1

		if citizen.knows == 1 then
			game.player.agentsKilled = game.player.agentsKilled + 1
		end
	else
		game.player.innocentsKilled = game.player.innocentsKilled + 1
	end

	--table.remove(game.town.citizens, self.citizenToKill)
	game.town.citizens[self.citizenToKill].alive = 0

	local resultString = "I ordered the execution of " .. citizen.name .. " today. Upon inspection of the corpse, we discovered "
	
	if citizen.sex == 0 then
		resultString = resultString .. "she"
	else
		resultString = resultString .. "he"
	end

	if citizen.taint == 0 then
		resultString = resultString .. " was only an innocent. May God have mercy on their soul."
		--game over
		game.resultsPhase.toState = game.gameOver
	else
		if citizen.knows == 0 then
			resultString = resultString .. " was indeed corrupted by the taint."
		else
			resultString = resultString .. " was not only corrupted by the taint, but had embraced it."
		end
	end
	table.insert(game.resultsPhase.results, resultString)
end
