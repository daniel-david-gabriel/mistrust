InterrogateAction = {}
InterrogateAction.__index = InterrogateAction

setmetatable(InterrogateAction, {
  __index = InterrogateAction,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function InterrogateAction:_init(citizen)
	self.citizenToKill = citizen
end

function InterrogateAction.act(self)
	local citizen = game.town.citizens[self.citizenToKill]
print(citizen.name)
	if citizen.taint == 1 and citizen.knows == 1 then
		citizen.suspicious = citizen.suspicious + 20
	elseif citizen.taint == 1 and citizen.knows ~= 1 then
		citizen.suspicious = citizen.suspicious + 50
	else
		citizen.suspicious = citizen.suspicious + 10
	end

	local resultString = "I interrogated " .. citizen.name .. " today. I have adjusted their suspicion level accordingly."
	table.insert(game.resultsPhase.results, resultString)
end
