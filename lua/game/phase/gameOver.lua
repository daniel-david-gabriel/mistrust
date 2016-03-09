GameOver = {}
GameOver.__index = GameOver

setmetatable(GameOver, {
  __index = GameOver,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function GameOver:_init()
	self.background = love.graphics.newImage("media/menu/bloodyWall.png")
end

function GameOver.new(self)

end

function GameOver.draw(self)
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local imageWidth = self.background:getWidth()
	local imageHeight = self.background:getHeight()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.background, 0, 0, 0, width / imageWidth, height / imageHeight)

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.printf("Game Over", 50, 30, 700, "center")
end

function GameOver.processControls(self, input)
	if controls:isMenu(input) or controls:isConfirm(input) then
		toState = mainMenu
	end
end

function GameOver.keyreleased(self, key )

end

function GameOver.mousepressed(self, x, y, button)
	--
end

function GameOver.update(self, dt)
	music:playMusic("gameOver")
end

