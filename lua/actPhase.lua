ActPhase = {}
ActPhase.__index = ActPhase

setmetatable(ActPhase, {
  __index = ActPhase,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function ActPhase:_init()

	self.selections = {
		["backButton"] = "backButton",
		["executeButton"] = "executeButton"
	}
	self.selected = self.selections["executeButton"]

	self.maskImage = love.graphics.newImage("media/menu/preparationPhaseMask.png")
	self.backButton = love.graphics.newImage("media/menu/backButton.png")
	self.executeButton = love.graphics.newImage("media/menu/executeButton.png")

	self.readyToExecute = false

end

function ActPhase.new(self)

end

function ActPhase.draw(self)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.maskImage, 0, 0)

	love.graphics.draw(self.backButton, 25, 560)
	love.graphics.draw(self.executeButton, 695, 560)

	local selectionX = 0
	local selectionY = 0
	love.graphics.setColor(0, 0, 0, 255)

	if self.selected == "executeButton" then
		selectionX = 685
		selectionY = 560
	elseif self.selected == "backButton" then
		selectionX = 5
		selectionY = 560
	end

	love.graphics.rectangle("fill", selectionX, selectionY, 25, 25)
end

function ActPhase.keypressed(self, key)
	if key == keyBindings:getLeft() then
		if self.selected == "executeButton" then
			self.selected = self.selections["backButton"]
		end
	elseif key == keyBindings:getRight() then	
		if self.selected == "backButton" then
			self.selected = self.selections["executeButton"]
		end
	elseif key == keyBindings:getMenu() or key == keyBindings:getTool() then
		if self.selected == "backButton" then
			toState = game.preparationPhase
		elseif self.selected == "executeButton" then
			self.readyToExecute = true
		end
	end
end

function ActPhase.keyreleased(self, key )

end

function ActPhase.mousepressed(self, x, y, button)
	--noop
end

function ActPhase.update(self, dt)
	if self.readyToExecute then
		self.readyToExecute = false
		toState = game.resultsPhase

		game.town.day = game.town.day + 1
		--Go through each action selected and perform it
		
	end
end

function ActPhase.loadMaps(self)
	
end

