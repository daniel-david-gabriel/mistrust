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

	love.graphics.draw(self.okButton, 695, 560)

	local selectionX = 0
	local selectionY = 0
	love.graphics.setColor(0, 0, 0, 255)

	if self.selected == "okButton" then
		selectionX = 685
		selectionY = 560
	end

	love.graphics.rectangle("fill", selectionX, selectionY, 25, 25)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Tainted Killed: " .. game.player.taintedKilled, 60, 60)
	love.graphics.print("Agents Killed: " .. game.player.agentsKilled, 60, 80)
	love.graphics.print("Innocent Killed: " .. game.player.innocentsKilled, 60, 100)

	local resultString = ""
	for _,result in pairs(self.results) do
		resultString = resultString .. result .. "\r\n"
	end
	love.graphics.printf(resultString, 60, 120, 700, "left")
end

function ResultsPhase.keypressed(self, key)
	if key == keyBindings:getMenu() or key == keyBindings:getTool() then
		if self.selected == "okButton" then
			self.readyToPrepare = true
		end
	end
end

function ResultsPhase.keyreleased(self, key )

end

function ResultsPhase.mousepressed(self, x, y, button)
	--noop
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

