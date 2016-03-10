ReleaseAction = {}
ReleaseAction.__index = ReleaseAction

setmetatable(ReleaseAction, {
  __index = ReleaseAction,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function ReleaseAction:_init(citizen)
	self.citizenToRelease = citizen
end

function ReleaseAction.act(self)
	local citizen = game.town.jail[self.citizenToRelease]
print(citizen.name)

		game.town.jail[self.citizenToRelease].jailed = 0


	local resultString = "I released " .. citizen.name .. " today. They have been returned to the town unharmed."
	table.insert(game.resultsPhase.results, resultString)
end