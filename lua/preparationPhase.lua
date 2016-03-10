require("lua/game/townTab")
require("lua/game/morgueTab")

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
	self.sfx = "menu"

	self.citizenIndex = 1
	self.rowDisplayed = 1

	self.selections = {
		["town"]   = UIElement("town", 10, 10, "town", "menu", "town", "morgue", function() game.preparationPhase.selectedTab = "town" end, "buttonBackground", "buttonHighlight", "Town", 10, 5),
		["morgue"] = UIElement("morgue", 120, 10, "morgue", "save", "town", "party", function() game.preparationPhase.selectedTab = "morgue" end, "buttonBackground", "buttonHighlight", "Morgue", 10, 5),
		["party"]  = UIElement("party", 230, 10, "party", "begin", "morgue", "party", function() game.preparationPhase.selectedTab = "party" end, "buttonBackground", "buttonHighlight", "Party", 10, 5),
		["menu"]   = UIElement("menu", 5, 560, "town", "menu", "menu", "save", function() toState = mainMenu end, "buttonBackground", "buttonHighlight", "Menu", 10, 5),
		["save"]   = UIElement("save", 350, 560, "morgue", "save", "menu", "begin", function() game:save() end, "buttonBackground", "buttonHighlight", "Save", 10, 5),
		["begin"]  = UIElement("begin", 685, 560, "party", "begin", "save", "begin", function() toState = game.actPhase end, "buttonBackground", "buttonHighlight", "Begin", 10, 5),
	}
	self.selected = self.selections["begin"]
	self.selectedTab = ""
	self.lastSelectedTab = "town"

	self.townTab = TownTab()
	self.morgueTab = MorgueTab()
end

function PreparationPhase.new(self)

end

function PreparationPhase.draw(self)

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
	elseif self.selectedTab == "town" then
		self.townTab:draw()
	elseif self.selectedTab == "morgue" then
		self.morgueTab:draw()
	elseif self.selectedTab == "party" then
		--
	else
		if self.lastSelectedTab == "town" then
			self.townTab:draw()
			--overlay gray out?
		elseif self.lastSelectedTab == "morgue" then
			self.townTab:draw()
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
			elseif self.selectedTab == "morgue" then
				self.morgueTab:processControls(input)
			end
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
		soundEffects:playSoundEffect(self.sfx)
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

