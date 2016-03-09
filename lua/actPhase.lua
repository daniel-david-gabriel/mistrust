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
		["back"]         = {name="back", x=5, y=560, up="killAction", down="back", left="back", right="confirm",
		                    confirm=function() toState = game.preparationPhase end},
		["confirm"]      = {name="confirm", x=685, y=560, up="killAction", down="confirm", left="back", right="confirm",
							confirm=function() game.actPhase.readyToExecute = true end},
		["killAction"]   = {name="killAction", x=25, y=128, up="canvasAction", down="back", left="killAction", right="killAction",
							confirm=function() game.actPhase.selectedTab = "killAction" end},
		["canvasAction"] = {name="canvasAction", x=25, y=25, up="canvasAction", down="killAction", left="canvasAction", right="canvasAction",
							confirm=function() table.insert(game.actPhase.actionsToExecute, CanvasAction()) end}
	}
	self.selected = self.selections["confirm"]

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

	if self.selected.name == "back" then
		love.graphics.draw(images:getImage("buttonHighlight"), 25, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 25, 560, 0, 2, 2)
	end
	love.graphics.print("Back", 35, 560)

	if self.selected.name == "confirm" then
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

	if self.selectedTab == "" then
		screen:drawCursor(self.selected.x, self.selected.y)
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
