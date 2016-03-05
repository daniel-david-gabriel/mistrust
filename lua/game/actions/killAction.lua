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
	local game = game
	local town = game.town
	local citizens = game.town.citizens
	local citizen = citizens[self.citizenToKill]
	if citizen.taint == 1 then
		game.player.taintedKilled = game.player.taintedKilled + 1
	else
		game.player.innocentsKilled = game.player.innocentsKilled + 1
	end

	table.remove(game.town.citizens, self.citizenToKill)
end
