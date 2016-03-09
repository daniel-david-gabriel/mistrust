VideoOptions = {}
VideoOptions.__index = VideoOptions


setmetatable(VideoOptions, {
  __index = VideoOptions,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function VideoOptions:_init()
	self.background = love.graphics.newImage("media/menu/darkBackground.png")
	self.sfx = "menu"
	self.videoOptionsFilename = "videoOptions.dat"

	self.windowSizes = {"640x480", "800x600", "1024x768", "1152x720", "1152x864",
			"1280x800", "1280x960", "1280x1024", "1446x900", "1680x1050"
	}

	if love.filesystem.exists(self.videoOptionsFilename) then
		local videoOptions = love.filesystem.lines(self.videoOptionsFilename)
		for line in videoOptions do
			local lineTokens = split(line, "[^\t]+")
			self.windowSizeIndex = tonumber(lineTokens[1])
			if lineTokens[2] == "true" then
				self.fullscreen = true 
			else 
				self.fullscreen = false
			end
			if lineTokens[3] == "true" then
				self.vsync = true
			else
				self.vsync = false
			end
		end
	else
		self.windowSizeIndex = 2
		self.fullscreen = false
		self.vsync = true
	end

	self.submenuCount = 4
	self.selection = 1
	
	self.menuText = self:generateMenuText()
end

function VideoOptions.generateMenuText(self)
	local menuText = ""
	menuText = menuText .. "Window Size: " .. self.windowSizes[self.windowSizeIndex] .. "\n"
	menuText = menuText .. "Fullscreen: " .. tostring(self.fullscreen) .. "\n"
	menuText = menuText .. "VSync: " .. tostring(self.vsync) .. "\n"
	menuText = menuText .. "Back"

	return menuText
end

function VideoOptions.draw(self)

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

function VideoOptions.processControls(self, input)
	if controls:isUp(input) then
		if self.selection > 1 then
			self.selection = self.selection - 1
			soundEffects:playSoundEffect(self.sfx)
		end
	elseif controls:isDown(input) then
		if self.selection < self.submenuCount then
			self.selection = self.selection + 1
			soundEffects:playSoundEffect(self.sfx)
		end
	elseif controls:isLeft(input) then
		if self.selection == 1 then
			if self.windowSizeIndex > 1 then
				self.windowSizeIndex = self.windowSizeIndex - 1
			end
			self.menuText = self:generateMenuText()
		end
	elseif controls:isRight(input) then
		if self.selection == 1 then
			if self.windowSizeIndex < table.getn(self.windowSizes) then
				self.windowSizeIndex = self.windowSizeIndex + 1
			end
			self.menuText = self:generateMenuText()
		end
	elseif controls:isMenu(input) or controls:isConfirm(input) then
		if self.selection == 1 then
			local lineTokens = split(self.windowSizes[self.windowSizeIndex], "[^x]+")
			local flags = {}
			flags.fullscreen = self.fullscreen
			flags.vsync = self.vsync
			love.window.setMode(tonumber(lineTokens[1]), tonumber(lineTokens[2]), flags)
			self.menuText = self:generateMenuText()
		elseif self.selection == 2 then
			self.fullscreen = not self.fullscreen
			local lineTokens = split(self.windowSizes[self.windowSizeIndex], "[^x]+")
			local flags = {}
			flags.fullscreen = self.fullscreen
			flags.vsync = self.vsync
			love.window.setMode(tonumber(lineTokens[1]), tonumber(lineTokens[2]), flags)
			self.menuText = self:generateMenuText()
		elseif self.selection == 3 then
			self.vsync = not self.vsync
			local lineTokens = split(self.windowSizes[self.windowSizeIndex], "[^x]+")
			local flags = {}
			flags.fullscreen = self.fullscreen
			flags.vsync = self.vsync
			love.window.setMode(tonumber(lineTokens[1]), tonumber(lineTokens[2]), flags)
			self.menuText = self:generateMenuText()
		elseif self.selection == 4 then
			--save changes back to file
			local saveData = ""
			saveData = saveData .. self.windowSizeIndex .. "\t" .. tostring(self.fullscreen) .. "\t" .. tostring(self.vsync)
			love.filesystem.write(self.videoOptionsFilename, saveData)

			toState = options
			soundEffects:playSoundEffect(self.sfx)
		end
	else
		--
	end
end

function VideoOptions.keyreleased(self, key)
	--
end

function VideoOptions.mousepressed(self, x, y, button)
	--
end

function VideoOptions.update(self, dt)

end

