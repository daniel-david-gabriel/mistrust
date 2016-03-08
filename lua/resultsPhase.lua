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
	self.selections = {
		["okButton"] = "okButton"
	}
	self.selected = self.selections["okButton"]

	self.maskImage = love.graphics.newImage("media/menu/preparationPhaseMask.png")
	self.okButton = love.graphics.newImage("media/menu/okButton.png")

	self.results = {}

	self.readyToPrepare = false
end

function ResultsPhase.new(self)

end

function ResultsPhase.draw(self)
	screen:drawPhaseBackground()

	--love.graphics.draw(self.okButton, 695, 560)
	if self.selected == "okButton" then
		love.graphics.draw(images:getImage("buttonHighlight"), 695, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 695, 560, 0, 2, 2)
	end
	love.graphics.print("OK", 705, 560)

	local selectionX = 0
	local selectionY = 0

	if self.selected == "okButton" then
		selectionX = 685
		selectionY = 560
	end

	screen:drawCursor(selectionX, selectionY)

	love.graphics.setColor(0, 0, 0, 255)
	local resultString = ""
	resultString = resultString .. "Results of Day: " .. game.town.day - 1 .. "\n"
	resultString = resultString .. "Town of: " .. game.town.name .. ", Population: " .. table.getn(game.town.citizens) .. "\n\n"
	resultString = resultString .. "Tainted Killed: " .. game.player.taintedKilled .. "\n"
	resultString = resultString .. "Agents Killed: " .. game.player.agentsKilled .. "\n"
	resultString = resultString .. "Innocent Killed: " .. game.player.innocentsKilled .. "\n\n"
	
	for _,result in pairs(self.results) do
		resultString = resultString .. result .. "\n"
	end
	love.graphics.printf(resultString, 50, 30, 700, "left")
end

function ResultsPhase.processControls(self, input)
	if controls:isMenu(input) or controls:isConfirm(input) then
		if self.selected == "okButton" then
			self.readyToPrepare = true
		end
	end
end

function ResultsPhase.keyreleased(self, key )

end

function ResultsPhase.mousepressed(self, x, y, button)
	--
end

function ResultsPhase.update(self, dt)
	if self.readyToPrepare then
		self.readyToPrepare = false
		toState = game.preparationPhase
		self.results = {}
	end
end

function ResultsPhase.loadMaps(self)
	
end

