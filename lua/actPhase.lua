require("lua/game/actions/killAction")
require("lua/game/actions/canvasAction")

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
		["executeButton"] = "executeButton",
		["killAction"] = "killAction",
		["canvasAction"] = "canvasAction"
	}
	self.selected = self.selections["executeButton"]

	self.maskImage = love.graphics.newImage("media/menu/preparationPhaseMask.png")
	self.backButton = love.graphics.newImage("media/menu/backButton.png")
	self.executeButton = love.graphics.newImage("media/menu/executeButton.png")

	self.readyToExecute = false
	self.actionsToExecute = {}
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

	love.graphics.setColor(0, 0, 0, 255)
	local statusString = self.selections[self.selected] .. " Day: " .. game.town.day
	love.graphics.print(statusString, 10, 5)
end

function ActPhase.keypressed(self, key)
	if key == keyBindings:getLeft() then
		if self.selected == "executeButton" then
			self.selected = self.selections["backButton"]
		end
	elseif key == keyBindings:getRight() then	
		if self.selected == "backButton" then
			self.selected = self.selections["executeButton"]
		elseif self.selected == "killAction" then
			self.selected = self.selections["canvasAction"]
		end
	elseif key == keyBindings:getUp() then	
		if self.selected == "executeButton" or self.selected == "backButton" then
			self.selected = self.selections["killAction"]
		end
	elseif key == keyBindings:getDown() then
		if self.selected == "killAction" or self.selected == "canvasAction" then
			self.selected = self.selections["backButton"]
		end
	elseif key == keyBindings:getMenu() or key == keyBindings:getTool() then
		if self.selected == "backButton" then
			toState = game.preparationPhase
		elseif self.selected == "executeButton" then
			self.readyToExecute = true
		elseif self.selected == "killAction" then
			if table.getn(self.actionsToExecute) < game.player.actions then
				if table.getn(game.town.citizens) > 0 then
					local citizen = nil
					for k,v in pairs(game.town.citizens) do
						citizen = k
						break
					end
					table.insert(self.actionsToExecute, KillAction(citizen))
				else
					print("No one left in town to kill")
				end
			else
				print("Can't take more actions today")
			end
		elseif self.selected == "canvasAction" then
			table.insert(self.actionsToExecute, CanvasAction())
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
		for _,action in pairs(self.actionsToExecute) do
			action:act()
		end

		self.actionsToExecute = {}
	end
end

