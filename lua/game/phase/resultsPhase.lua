ResultsPhase = {}
ResultsPhase.__index = ResultsPhase

setmetatable(ResultsPhase, {
  __index = ResultsPhase,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function ResultsPhase:_init()
	self.sfx = "menu"

	self.selections = {
		["okButton"] = UIElement("okButton", 685, 560, "okButton", "okButton", "okButton", "okButton", function () ResultsPhase.confirm(game.resultsPhase) end, "buttonBackground", "buttonHighlight", "OK", 10, 5),
	}
	self.selected = self.selections["okButton"]

	self.selectedTab = ""

	self.results = {}
	self.resultShown = 0

	self.readyToPrepare = false
	self.toState = nil
end

function ResultsPhase.new(self)

end

function ResultsPhase.draw(self)
	screen:drawPhaseBackground()

	for _,uiElement in pairs(self.selections) do
			if uiElement == self.selected then
				love.graphics.draw(images:getImage(uiElement.highlight), uiElement.x, uiElement.y)
			else
				love.graphics.draw(images:getImage(uiElement.image), uiElement.x, uiElement.y)
			end
			love.graphics.print(uiElement.text, uiElement.x + uiElement.textXOffset, uiElement.y + uiElement.textYOffset)
	end

	if self.selectedTab == "" then
		screen:drawCursor(self.selected.x, self.selected.y)
	end

	love.graphics.setColor(0, 0, 0, 255)
	local resultString = self:generateResultText()
	love.graphics.printf(resultString, 50, 30, 700, "left")
end

function ResultsPhase.processControls(self, input)
	if controls:isLeft(input) then
		self.selected = self.selections[self.selected.left]
	elseif controls:isRight(input) then	
		self.selected = self.selections[self.selected.right]
	elseif controls:isUp(input) then
		self.selected = self.selections[self.selected.up]
	elseif controls:isDown(input) then
		self.selected = self.selections[self.selected.down]
	elseif controls:isConfirm(input) then
		self.selected.confirm()
	end
	soundEffects:playSoundEffect(self.sfx)
end

function ResultsPhase.keyreleased(self, key )

end

function ResultsPhase.mousepressed(self, x, y, button)
	--
end

function ResultsPhase.update(self, dt)
	if self.readyToPrepare then
		local function getRemainingCitizens(value) return (value.alive == 1 and value.jailed == 0) end

		local remainingCitizens = filter(getRemainingCitizens, game.town.citizens)
		local deadCitizens = filter(function (value) return value.alive == 0 end, game.town.citizens)
		local jailedCitizens = filter(function (value) return value.jailed == 1 end, game.town.citizens)
		local freedCitizens = filter(function (value) return value.jailed == 0 end, game.town.jail)
		local stillJailedCitizens = filter(function (value) return value.jailed == 1 end, game.town.jail)

		for _,citizen in pairs(freedCitizens) do
			table.insert(remainingCitizens, citizen)
		end

		game.town:updateTownList(remainingCitizens)

		--game.town.citizens = remainingCitizens
		
		local jail = {}
		for _,citizen in pairs(stillJailedCitizens) do
			table.insert(jail, citizen)
		end
		for _,citizen in pairs(jailedCitizens) do
			table.insert(jail, citizen)
		end
		game.town:updateJailList(jail)
		--game.town.jail = jail

		local morgue = {}
		for _,citizen in pairs(game.town.morgue) do
			table.insert(morgue, citizen)
		end
		for _,citizen in pairs(deadCitizens) do
			table.insert(morgue, citizen)
		end

		game.town:updateMorgueList(morgue)
		--game.town.morgue = morgue

print(table.getn(game.town.citizens))
print(table.getn(game.town.morgue))
print(table.getn(game.town.jail))

		self.readyToPrepare = false
		toState = self.toState
		self.toState = game.preparationPhase
		self.results = {}
		self.resultShown = 0
	end
end

function ResultsPhase.generateResultText(self)
	local resultString = ""
	resultString = resultString .. "Results of Day: " .. game.town.day - 1 .. "\n"
	resultString = resultString .. "Town of: " .. game.town.name .. ", Population: " .. table.getn(game.town.citizens) .. "\n\n"
	--resultString = resultString .. "Tainted Killed: " .. game.player.taintedKilled .. "\n"
	--resultString = resultString .. "Agents Killed: " .. game.player.agentsKilled .. "\n"
	--resultString = resultString .. "Innocent Killed: " .. game.player.innocentsKilled .. "\n\n"
	resultString = resultString .. "Player Trust: " .. game.player.trust .. "\n"
	resultString = resultString .. "Riot Threshold: " .. game.player.riot .. "\n"
	
	for i,result in pairs(self.results) do
		if i <= self.resultShown then
			resultString = resultString .. result.text .. "\n"
		end
	end
	return resultString
end

function ResultsPhase.confirm(self)
	if self.resultShown < table.getn(self.results) then
		self.resultShown = self.resultShown + 1
		game.player.trust = game.player.trust + self.results[self.resultShown].trust
		game.player.riot = game.player.riot + self.results[self.resultShown].riot

	else
		self.readyToPrepare = true
	end
end
