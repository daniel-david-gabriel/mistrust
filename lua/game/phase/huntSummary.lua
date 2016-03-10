HuntSummary = {}
HuntSummary.__index = HuntSummary

setmetatable(HuntSummary, {
  __index = HuntSummary,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function HuntSummary:_init()
	self.background = love.graphics.newImage("media/menu/spellbookForFlare.png")
end

function HuntSummary.new(self)

end

function HuntSummary.draw(self)
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local imageWidth = self.background:getWidth()
	local imageHeight = self.background:getHeight()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	love.graphics.draw(self.background, 0, 0, 0, width / imageWidth, height / imageHeight)

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.printf("Hunt Summary", 50, 30, 700, "center")

	love.graphics.setColor(0, 0, 0, 255)

	local rows = ""
	rows = rows .. "Days Spent: \n"
	rows = rows .. "Tainted Jailed: \n"
	rows = rows .. "\tAgents Jailed: \n"
	rows = rows .. "Innocents Jailed: \n"
	love.graphics.printf(rows, 100, 75, 300, "left")

	local dayScore = 1000
	if game.town.day > (game.town.townSize / 2) then
		local penalty = math.floor(game.town.day - (game.town.townSize / 2)) * 50
		dayScore = dayScore - penalty
		if dayScore < 0 then
			dayScore = 0
		end
	end

	local taintedJailed = 0
	local agentsJailed = 0
	local innocentsJailed = 0

	for _,citizen in pairs(game.town.jail) do
		if citizen:isTainted() then
			taintedJailed = taintedJailed + 1
		else
			innocentsJailed = innocentsJailed + 1
		end
		if citizen:isAgent() then
			agentsJailed = agentsJailed + 1
		end
	end

	local taintedScore = taintedJailed * 100
	local agentScore = agentsJailed * 50
	local innocentsScore = innocentsJailed * 200

	local values = ""
	values = values .. "+ " .. dayScore .."\n"
	values = values .. "+ " .. taintedScore .. "\n"
	values = values .. "+ " .. agentScore .. "\n"
	values = values .. "- " .. innocentsScore .. "\n"
	love.graphics.printf(values, 425, 75, 300, "left")

	--total
	local total = dayScore + taintedScore + agentScore - innocentsScore
	love.graphics.printf("Total: " .. total, 425, 450, 300, "center")
end

function HuntSummary.processControls(self, input)
	if controls:isMenu(input) or controls:isConfirm(input) then
		toState = mainMenu
		--next stage
	end
end

function HuntSummary.keyreleased(self, key )

end

function HuntSummary.mousepressed(self, x, y, button)
	--
end

function HuntSummary.update(self, dt)
	music:playMusic("cutscene")
end

