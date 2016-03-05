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
	self.offset = 0

	self.selections = {
		["town"] = "town",
		["quests"] = "quests",
		["party"] = "party",
		["menuButton"] = "menuButton",
		["saveButton"] = "saveButton",
		["beginButton"] = "beginButton"
	}
	self.selected = self.selections["beginButton"]

	self.maskImage = love.graphics.newImage("media/menu/preparationPhaseMask.png")
	self.menuButton = love.graphics.newImage("media/menu/menuButton.png")
	self.saveButton = love.graphics.newImage("media/menu/saveButton.png")
	self.beginButton = love.graphics.newImage("media/menu/beginButton.png")
end

function PreparationPhase.new(self)

end

function PreparationPhase.draw(self)
	local y = 40
	for _,citizen in pairs(game.town.citizens) do
		love.graphics.setColor(255, 255, 255, 255)
		local citizenString = citizen.name .. " " .. citizen.sex .. " Taint: " .. citizen.taint
		love.graphics.print(citizenString, 60, y - self.offset)
		y = y + 20
	end

	love.graphics.draw(self.maskImage, 0, 0)

	love.graphics.draw(self.menuButton, 25, 560)
	love.graphics.draw(self.saveButton, 360, 560)
	love.graphics.draw(self.beginButton, 695, 560)

	love.graphics.setColor(0, 0, 0, 255)
	local statusString = self.selections[self.selected] .. " Day: " .. game.town.day
	love.graphics.print(statusString, 10, 5)

	local selectionX = 0
	local selectionY = 0
	love.graphics.setColor(0, 0, 0, 255)

	if self.selected == "beginButton" then
		selectionX = 685
		selectionY = 560
	elseif self.selected == "saveButton" then
		selectionX = 350
		selectionY = 560
	elseif self.selected == "menuButton" then
		selectionX = 5
		selectionY = 560
	end

	love.graphics.rectangle("fill", selectionX, selectionY, 25, 25)
end

function PreparationPhase.keypressed(self, key)
	if key == keyBindings:getUp() then
		self.offset = self.offset - 20
	elseif key == keyBindings:getDown() then
		self.offset = self.offset + 20
	elseif key == keyBindings:getLeft() then
		if self.selected == "beginButton" then
			self.selected = self.selections["saveButton"]
		elseif self.selected == "saveButton" then
			self.selected = self.selections["menuButton"]
		end
	elseif key == keyBindings:getRight() then	
		if self.selected == "menuButton" then
			self.selected = self.selections["saveButton"]
		elseif self.selected == "saveButton" then
			self.selected = self.selections["beginButton"]
		end
	elseif key == keyBindings:getMenu() or key == keyBindings:getTool() then
		if self.selected == "menuButton" then
			toState = mainMenu
		elseif self.selected == "saveButton" then
			--go to save menu?
			game:save()
		elseif self.selected == "beginButton" then
			toState = game.actPhase
		end
	end
end

function PreparationPhase.keyreleased(self, key )

end

function PreparationPhase.mousepressed(self, x, y, button)
	--noop
end

function PreparationPhase.update(self, dt)
	
end

function PreparationPhase.loadMaps(self)
	
end

