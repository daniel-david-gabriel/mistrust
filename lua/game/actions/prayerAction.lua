PrayerAction = {}
PrayerAction.__index = PrayerAction

setmetatable(PrayerAction, {
  __index = Action,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

prayers = {
	{name="incitement", description="By the power of The Sealer, Tainted and even Agents will be compelled to reveal themselves to you in interrogations.", cost=2},
	{name="community", description="By the power of The Sealer, innocent members of the town will not distrust you while canvasing.", cost=1},
	{name="mercy", description="By the Power of The Sealer, you will not suffer riot increase when executing an Agent.", cost=1},
	{name="greaterMercy", description="By the power of The Sealer, you will not suffer riot increase when executing an Agent, nor will you suffer trust decrease from killing an innocent.", cost=2},
	{name="supressTaint", description="Invocing the power of The First Seal, you may supress the taint in one party member for 3 days. If the party member is an Agent, it will have a chance to fail.", cost=1},
}

function PrayerAction:_init(prayer)
	Action._init(self, prayers[prayer].cost)
	self.prayer = prayer
end

function PrayerAction.act(self)
	--different actions per prayer

	local resultString = prayers[self.prayer].description
	local result = Result(0, 0, resultString)
	table.insert(game.resultsPhase.results, result)
end
