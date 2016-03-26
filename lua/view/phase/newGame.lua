NewGame = {}
NewGame.__index = NewGame


setmetatable(NewGame, {
  __index = NewGame,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function NewGame:_init()
	self.background = love.graphics.newImage("media/menu/darkBackground.png")
	self.sfx = "menu"

	self.selections = {
		["confirm"]       = UIElement("confirm", 685, 560, "inspectCorpseAction", "confirm", "back", "confirm",
									  function(self) self.readyToStart = true end, "buttonBackground", "buttonHighlight", "Confirm", 10, 5),
	}
	self.selected = self.selections["confirm"]

	self.readyToStart = false
end

function NewGame.draw(self)
	--determine scaling for background image
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local imageWidth = self.background:getWidth()
	local imageHeight = self.background:getHeight()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.background, 0, 0, 0, width / imageWidth, height / imageHeight)

	for _,uiElement in pairs(self.selections) do
		if uiElement == self.selected then
			love.graphics.draw(images:getImage(uiElement.highlight), uiElement.x, uiElement.y)
		else
			love.graphics.draw(images:getImage(uiElement.image), uiElement.x, uiElement.y)
		end
		love.graphics.print(uiElement.text, uiElement.x + uiElement.textXOffset, uiElement.y + uiElement.textYOffset)
	end
end

function NewGame.processControls(self, input)

	if controls:isConfirm(input) then
		self.selected.confirm(self)
	end
end

function NewGame.keyreleased(self, key)
	--
end

function NewGame.mousepressed(self, x, y, button)
	--
end

function NewGame.update(self, dt)
	if self.readyToStart == true then
		game:new()
		toState = game
	end
end

