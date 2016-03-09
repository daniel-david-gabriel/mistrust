require("lua/game/actions/killActionTab")
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

	self.selectedTab = ""
	self.killActionTab = KillActionTab()

	self.readyToExecute = false
	self.actionsToExecute = {}
end

function ActPhase.new(self)

end

function ActPhase.draw(self)
	screen:drawPhaseBackground()

	if self.selected == "backButton" then
		love.graphics.draw(images:getImage("buttonHighlight"), 25, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 25, 560, 0, 2, 2)
	end
	love.graphics.print("Back", 35, 560)

	if self.selected == "executeButton" then
		love.graphics.draw(images:getImage("buttonHighlight"), 695, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 695, 560, 0, 2, 2)
	end
	love.graphics.print("Execute", 705, 560)

	local actionTemplate = love.graphics.newImage("media/menu/actionTemplate.png")
	love.graphics.draw(actionTemplate, 20, 20, 0, 2, 2)
	love.graphics.draw(actionTemplate, 20, 20 + actionTemplate:getHeight()*2, 0, 2, 2)
	love.graphics.print("Canvas", 30, 30)
	love.graphics.print("Kill", 30, 30 + actionTemplate:getHeight()*2)

	local selectionX = -1
	local selectionY = -1

	if self.selectedTab == "" then
		if self.selected == "executeButton" then
			selectionX = 685
			selectionY = 560
		elseif self.selected == "backButton" then
			selectionX = 5
			selectionY = 560
		elseif self.selected == "canvasAction" then
			selectionX = 25
			selectionY = 25
		elseif self.selected == "killAction" then
			selectionX = 25
			selectionY = 25 + actionTemplate:getHeight()*2
		end
	end

	if selectionX >= 0 and selectionY >= 0 then
		screen:drawCursor(selectionX, selectionY)
	end

	if self.selectedTab == "killAction" then
		self.killActionTab:draw()
	end
end

function ActPhase.processControls(self, input)
	if self.selectedTab ~= "" then
		if controls:isBack(input) then
			self.selectedTab = ""
		elseif self.selectedTab == "killAction" then
			self.killActionTab:processControls(input)
		end
	else
		if controls:isLeft(input) then
			if self.selected == "executeButton" then
				self.selected = self.selections["backButton"]
			end
		elseif controls:isRight(input) then	
			if self.selected == "backButton" then
				self.selected = self.selections["executeButton"]
			end
		elseif controls:isUp(input) then	
			if self.selected == "executeButton" or self.selected == "backButton" then
				self.selected = self.selections["killAction"]
			elseif self.selected == "killAction" then
				self.selected = self.selections["canvasAction"]
			end
		elseif controls:isDown(input) then
			if self.selected == "canvasAction" then
				self.selected = self.selections["killAction"]
			elseif self.selected == "killAction" then
				self.selected = self.selections["backButton"]
			end
		elseif controls:isMenu(input) or controls:isConfirm(input) then
			if self.selected == "backButton" then
				toState = game.preparationPhase
			elseif self.selected == "executeButton" then
				self.readyToExecute = true
			elseif self.selected == "killAction" then
				self.selectedTab = "killAction"
			elseif self.selected == "canvasAction" then
				if table.getn(self.actionsToExecute) < game.player.actions then
					table.insert(self.actionsToExecute, CanvasAction())
				else
					print("Can't take more actions today")
				end
			end
		end
	end
end

function ActPhase.keyreleased(self, key )
	--
end

function ActPhase.mousepressed(self, x, y, button)
	--
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

