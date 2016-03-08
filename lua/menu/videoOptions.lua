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

	self.videoOptionsFilename = "videoOptions.dat"

	self.windowSizes = {
		["640x480"] = "640x480",
		["800x600"] = "800x600"
	}

	if love.filesystem.exists(self.videoOptionsFilename) then
		local videoOptions = love.filesystem.lines(self.videoOptionsFilename)
		for line in videoOptions do
			local lineTokens = split(line, "[^\t]+")
			self.windowSize = lineTokens[1]
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
		self.windowSize = self.windowSizes["800x600"]
		self.fullscreen = false
		self.vsync = false
	end

	self.submenuCount = 4
	self.selection = 1
	
	self.menuText = ""
	self.menuText = self.menuText .. "Window Size\n"
	self.menuText = self.menuText .. "Fullscreen\n"
	self.menuText = self.menuText .. "VSync\n"
	self.menuText = self.menuText .. "Back"
end

function VideoOptions.draw(self)
	--love.graphics.setColor(51, 153, 102, 255)
	--love.graphics.rectangle("fill", 0, 0, 800, 600)

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

function VideoOptions.keypressed(self, key)
	if key == keyBindings:getUp() then

		if self.selection > 1 then
			self.selection = self.selection - 1
			--soundEffects:playSoundEffect(self.sfx)
		end
	elseif key == keyBindings:getDown() then
		if self.selection < self.submenuCount then
			self.selection = self.selection + 1
			--soundEffects:playSoundEffect(self.sfx)
		end
	elseif key == keyBindings:getMenu() or key == keyBindings:getTool() then
		if self.selection == 1 then
			--window size
		elseif self.selection == 2 then
			self.fullscreen = not self.fullscreen
			love.window.setFullscreen(self.fullscreen)
			if not self.fullscreen then
				local lineTokens = split(self.windowSize, "[^x]+")
				love.window.setMode(tonumber(lineTokens[1]), tonumber(lineTokens[2]))
			end
		elseif self.selection == 3 then
			--vsync
		elseif self.selection == 4 then
			--save changes back to file
			local saveData = ""
			saveData = saveData .. self.windowSize .. "\t" .. tostring(self.fullscreen) .. "\t" .. tostring(self.vsync)
			love.filesystem.write(self.videoOptionsFilename, saveData)

			toState = options
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

