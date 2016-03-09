Credits = {}
Credits.__index = Credits


setmetatable(Credits, {
  __index = Credits,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Credits:_init()
	self.background = love.graphics.newImage("media/menu/darkBackground.png")
	self.sfx = "menu"

	self.yOffset = 20

	self.credits = love.filesystem.read("media/credits.txt")
end

function Credits.draw(self)
	--determine scaling for background image
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local imageWidth = self.background:getWidth()
	local imageHeight = self.background:getHeight()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.background, 0, 0, 0, width / imageWidth, height / imageHeight)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.printf(self.credits, 20, self.yOffset, love.graphics.getWidth() - 40, "left")
end

function Credits.processControls(self, input)
	if controls:isBack(input) then
		toState = mainMenu
		soundEffects:playSoundEffect(self.sfx)
	elseif controls:isUp(input) then
		self.yOffset = self.yOffset + 10
	elseif controls:isDown(input) then
		self.yOffset = self.yOffset - 10
	end
end

function Credits.keyreleased(self, key)
	--
end

function Credits.mousepressed(self, x, y, button)
	--
end

function Credits.update(self, dt)

end

