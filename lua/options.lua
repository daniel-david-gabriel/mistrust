require("lua/menu/videoOptions")

Options = {}
Options.__index = Options


setmetatable(Options, {
  __index = Options,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Options:_init()
	self.background = love.graphics.newImage("media/menu/darkBackground.png")

	self.videoOptions = VideoOptions()

	self.displayFPS = false
	self.sound = false
	self.debug = false

	self.submenuCount = 5
	self.selection = 1
	
	self.menuText = ""
	self.menuText = self.menuText .. "Video\n"
	self.menuText = self.menuText .. "Sound\n"
	self.menuText = self.menuText .. "Controls\n"
	self.menuText = self.menuText .. "Debug\n"
	self.menuText = self.menuText .. "Back"
end

function Options.draw(self)
	--determine scaling for background image
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local imageWidth = self.background:getWidth()
	local imageHeight = self.background:getHeight()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.background, 0, 0, 0, width / imageWidth, height / imageHeight)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.printf(self.menuText, love.graphics.getWidth()/4, love.graphics.getHeight()/2, love.graphics.getWidth()/2, "center")

	screen:drawCursor(295, 270 + 32*self.selection)
end

function Options.processControls(self, input)
	if controls:isUp(input) then

		if self.selection > 1 then
			self.selection = self.selection - 1
			--soundEffects:playSoundEffect(self.sfx)
		end
	elseif controls:isDown(input) then
		if self.selection < self.submenuCount then
			self.selection = self.selection + 1
			--soundEffects:playSoundEffect(self.sfx)
		end
	elseif controls:isMenu(input) or controls:isConfirm(input) then
		if self.selection == 1 then
			toState = self.videoOptions
		elseif self.selection == 2 then
			--[[self.sound = not self.sound
			if not self.sound then
				music:stopAllSounds()
			end]]--
		elseif self.selection == 3 then

		elseif self.selection == 4 then
			self.displayFPS = not self.displayFPS
			self.debug = not self.debug			
			--self.fullscreen = not self.fullscreen
			--love.window.setFullscreen(self.fullscreen)
		elseif self.selection == 5 then
			toState = mainMenu
		end
	else
		--
	end
end

function Options.keyreleased(self, key)
	--
end

function Options.mousepressed(self, x, y, button)
	--
end

function Options.update(self, dt)

end

