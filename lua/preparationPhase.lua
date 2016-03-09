require("lua/game/townTab")

PreparationPhase = {}
PreparationPhase.__index = PreparationPhase

setmetatable(PreparationPhase, {
  __index = PreparationPhase,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function PreparationPhase:_init()
	self.citizenIndex = 1
	self.rowDisplayed = 1

	self.selections = {
		["town"] = "town",
		["quests"] = "quests",
		["party"] = "party",
		["menuButton"] = "menuButton",
		["saveButton"] = "saveButton",
		["beginButton"] = "beginButton"
	}
	self.selected = self.selections["beginButton"]
	self.selectedTab = ""
	self.lastSelectedTab = "town"

	self.townTab = TownTab()

	self.maskImage = love.graphics.newImage("media/menu/preparationPhaseMask.png")
	self.menuButton = love.graphics.newImage("media/menu/menuButton.png")
	self.saveButton = love.graphics.newImage("media/menu/saveButton.png")
	self.beginButton = love.graphics.newImage("media/menu/beginButton.png")
end

function PreparationPhase.new(self)

end

function PreparationPhase.draw(self)

	screen:drawPhaseBackground()

	love.graphics.setColor(255, 255, 255, 255)

	if self.selected == "menuButton" then
		love.graphics.draw(images:getImage("buttonHighlight"), 25, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 25, 560, 0, 2, 2)
	end
	love.graphics.print("Menu", 35, 560)
	if self.selected == "saveButton" then
		love.graphics.draw(images:getImage("buttonHighlight"), 360, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 360, 560, 0, 2, 2)
	end
	love.graphics.print("Save", 370, 560)
	if self.selected == "beginButton" then
		love.graphics.draw(images:getImage("buttonHighlight"), 695, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 695, 560, 0, 2, 2)
	end
	love.graphics.print("Begin", 705, 560)

	
	if self.selected == "town" then
		love.graphics.draw(images:getImage("buttonHighlight"), 10, 10, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 10, 10, 0, 2, 2)
	end
	love.graphics.print("Town", 20, 10)
	if self.selected == "quests" then
		love.graphics.draw(images:getImage("buttonHighlight"), 10 + images:getImage("buttonHighlight"):getWidth()*2, 10, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 10 + images:getImage("buttonHighlight"):getWidth()*2, 10, 0, 2, 2)
	end
	love.graphics.print("Quests", 20 + images:getImage("buttonHighlight"):getWidth()*2, 10)
	if self.selected == "party" then
		love.graphics.draw(images:getImage("buttonHighlight"), 10 + images:getImage("buttonHighlight"):getWidth()*4, 10, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 10 + images:getImage("buttonHighlight"):getWidth()*4, 10, 0, 2, 2)
	end
	love.graphics.print("Party", 20 + images:getImage("buttonHighlight"):getWidth()*4, 10)

	local selectionX = -1
	local selectionY = -1

	if self.selectedTab == "" then
		if self.selected == "beginButton" then
			selectionX = 685
			selectionY = 560
		elseif self.selected == "saveButton" then
			selectionX = 350
			selectionY = 560
		elseif self.selected == "menuButton" then
			selectionX = 5
			selectionY = 560
		elseif self.selected == "town" then
			selectionX = 10
			selectionY = 10		
		elseif self.selected == "quests" then
			selectionX = 10+images:getImage("buttonHighlight"):getWidth()*2
			selectionY = 10
		elseif self.selected == "party" then
			selectionX = 10+images:getImage("buttonHighlight"):getWidth()*4
			selectionY = 10
		end
	end

	if selectionX >= 0 and selectionY >= 0 then
		screen:drawCursor(selectionX, selectionY)
	end

	if self.selectedTab == "town" then
		self.townTab:draw()
	elseif self.selectedTab == "quest" then

	elseif self.selectedTab == "party" then

	else
		if self.lastSelectedTab == "town" then
			self.townTab:draw()
			--overlay gray out?
		end
	end
end

function PreparationPhase.processControls(self, input)
	if self.selectedTab ~= "" then
		if controls:isBack(input) then
			self.lastSelectedTab = self.selectedTab
			self.selectedTab = ""
		else
			if self.selectedTab == "town" then
				self.townTab:processControls(input)
			end
		end
	else
		if controls:isMenu(input) or controls:isConfirm(input) then
			if self.selected == "menuButton" then
				toState = mainMenu
			elseif self.selected == "saveButton" then
				--go to save menu?
				game:save()
			elseif self.selected == "beginButton" then
				toState = game.actPhase
			elseif self.selected == "town" then
				self.selectedTab = self.selections["town"]
			elseif self.selected == "quests" then
				self.selectedTab = self.selections["quests"]
			elseif self.selected == "party" then
				self.selectedTab = self.selections["party"]
			end
		elseif controls:isUp(input) then
			if self.selected == "beginButton" or self.selected == "saveButton" or self.selected == "menuButton" then
				self.selected = self.selections["town"]
			end
		elseif controls:isDown(input) then
			if self.selected == "town" or self.selected == "quests" or self.selected == "party" then
				self.selected = self.selections["beginButton"]
			end
		elseif controls:isLeft(input) then
			if self.selected == "beginButton" then
				self.selected = self.selections["saveButton"]
			elseif self.selected == "saveButton" then
				self.selected = self.selections["menuButton"]
			elseif self.selected == "party" then
				self.selected = self.selections["quests"]
			elseif self.selected == "quests" then
				self.selected = self.selections["town"]
			end
		elseif controls:isRight(input) then	
			if self.selected == "menuButton" then
				self.selected = self.selections["saveButton"]
			elseif self.selected == "saveButton" then
				self.selected = self.selections["beginButton"]
			elseif self.selected == "town" then
				self.selected = self.selections["quests"]
			elseif self.selected == "quests" then
				self.selected = self.selections["party"]
			end
		end
	end
end

function PreparationPhase.keyreleased(self, key )
	--
end

function PreparationPhase.mousepressed(self, x, y, button)
	--noop
end

function PreparationPhase.update(self, dt)
	music:playMusic("main")
end

