require("lua/music")
require("lua/images")

LoadingScreen = {}
LoadingScreen.__index = LoadingScreen

setmetatable(LoadingScreen, {
  __index = LoadingScreen,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function LoadingScreen:_init()
	self.loading = true
	self.loadingText = "Loading Images..."
	self.background = love.graphics.newImage("media/menu/darkBackground.png")
	self.backgroundAlpha = 128
end

function LoadingScreen.draw(self)
	love.graphics.setColor(255, 255, 255, self.backgroundAlpha)
	love.graphics.draw(self.background, 0, 0)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.printf(self.loadingText, 0, love.graphics.getHeight()/2 - 20, love.graphics.getWidth(), "center")
end

function LoadingScreen.processControls(self, input)
	--
end

function LoadingScreen.keyreleased(self, key)
	--
end

function LoadingScreen.mousepressed(self, x, y, button)
	--
end

function LoadingScreen.update(self, dt)
	if not images then
		images = Images()
		self.loadingText = "Loading Music..."
	elseif not music then
		music = Music()
		self.loadingText = "Done!"
		self.loading = false
	end

	if not self.loading then
		if self.backgroundAlpha < 255 then
			self.backgroundAlpha = self.backgroundAlpha + 4
			if self.backgroundAlpha > 255 then
				self.backgroundAlpha = 255
			end
		else
			if images and music then
				toState = mainMenu
			end
		end
	end
end

