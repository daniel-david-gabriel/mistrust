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
	self.citizenIndex = 1
	self.rowDisplayed = 1

	self.selections = {
		["town"]   = {name="town", x=10, y=10, up="town", down="menu", left="town", right="morgue",
		              confirm=function() game.preparationPhase.selectedTab = "town" end},
		["morgue"] = {name="morgue", x=120, y=10, up="morgue", down="save", left="town", right="party",
		              confirm=function() game.preparationPhase.selectedTab = "morgue" end},
		["party"]  = {name="party", x=230, y=10, up="party", down="begin", left="morgue", right="party",
		              confirm=function() game.preparationPhase.selectedTab = "party" end},
		["menu"]   = {name="menu", x=5, y=560, up="town", down="menu", left="menu", right="save",
					  confirm=function() toState = mainMenu end},
		["save"]   = {name="save", x=350, y=560, up="morgue", down="save", left="menu", right="begin",
		              confirm=function() game:save() end},
		["begin"]  = {name="begin", x=685, y=560, up="party", down="begin", left="save", right="begin",
		              confirm=function() toState = game.actPhase end},
	}
	self.selected = self.selections["begin"]
	self.selectedTab = ""
	self.lastSelectedTab = "town"

	self.townTab = TownTab()
	self.morgueTab = MorgueTab()

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

	if self.selected.name == "menu" then
		love.graphics.draw(images:getImage("buttonHighlight"), 25, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 25, 560, 0, 2, 2)
	end
	love.graphics.print("Menu", 35, 560)
	if self.selected.name == "save" then
		love.graphics.draw(images:getImage("buttonHighlight"), 360, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 360, 560, 0, 2, 2)
	end
	love.graphics.print("Save", 370, 560)
	if self.selected.name == "begin" then
		love.graphics.draw(images:getImage("buttonHighlight"), 695, 560, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 695, 560, 0, 2, 2)
	end
	love.graphics.print("Begin", 705, 560)

	
	if self.selected.name == "town" then
		love.graphics.draw(images:getImage("buttonHighlight"), 10, 10, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 10, 10, 0, 2, 2)
	end
	love.graphics.print("Town", 20, 10)
	if self.selected.name == "morgue" then
		love.graphics.draw(images:getImage("buttonHighlight"), 10 + images:getImage("buttonHighlight"):getWidth()*2, 10, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 10 + images:getImage("buttonHighlight"):getWidth()*2, 10, 0, 2, 2)
	end
	love.graphics.print("Morgue", 20 + images:getImage("buttonHighlight"):getWidth()*2, 10)
	if self.selected.name == "party" then
		love.graphics.draw(images:getImage("buttonHighlight"), 10 + images:getImage("buttonHighlight"):getWidth()*4, 10, 0, 2, 2)
	else
		love.graphics.draw(images:getImage("buttonBackground"), 10 + images:getImage("buttonHighlight"):getWidth()*4, 10, 0, 2, 2)
	end
	love.graphics.print("Party", 20 + images:getImage("buttonHighlight"):getWidth()*4, 10)

	if self.selectedTab == "" then
		screen:drawCursor(self.selected.x, self.selected.y)
	end
	
	if self.selectedTab == "town" then
		self.townTab:draw()
	elseif self.selectedTab == "morgue" then
		self.morgueTab:draw()
	elseif self.selectedTab == "party" then

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

