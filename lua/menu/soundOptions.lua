SoundOptions = {}
SoundOptions.__index = SoundOptions


setmetatable(SoundOptions, {
  __index = SoundOptions,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function SoundOptions:_init()
	self.background = love.graphics.newImage("media/menu/darkBackground.png")
	self.sfx = "menu"

	self.soundOptionsFilename = "soundOptions.dat"

	if love.filesystem.exists(self.soundOptionsFilename) then
		local videoOptions = love.filesystem.lines(self.soundOptionsFilename)
		for line in videoOptions do
			local lineTokens = split(line, "[^\t]+")
			self.masterVolume = tonumber(lineTokens[1])
			self.bgmVolume = tonumber(lineTokens[2])
			self.sfxVolume = tonumber(lineTokens[3])
		end
	else
		self.masterVolume = 1.0
		self.bgmVolume = 1.0
		self.sfxVolume = 1.0
	end

	self.submenuCount = 4
	self.selection = 1
	
	self.menuText = self:generateMenuText()
end

function SoundOptions.generateMenuText(self)
	local menuText = ""
	menuText = menuText .. "Master: " .. self.masterVolume .. "\n"
	menuText = menuText .. "BGM: " .. self.bgmVolume .. "\n"
	menuText = menuText .. "SFX: " .. self.sfxVolume .. "\n"
	menuText = menuText .. "Back"

	return menuText
end

function SoundOptions.draw(self)
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

function SoundOptions.processControls(self, input)
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
			self.masterVolume = self.masterVolume - 0.1
			if self.masterVolume < 0.05 then --Use 0.05 instead of 0.0 because FLOATING POINT MATH
				self.masterVolume = 0.0
			end
		elseif self.selection == 2 then
			self.bgmVolume = self.bgmVolume - 0.1
			if self.bgmVolume < 0.05 then
				self.bgmVolume = 0.0
			end
		elseif self.selection == 3 then
			self.sfxVolume = self.sfxVolume - 0.1
			if self.sfxVolume < 0.05 then
				self.sfxVolume = 0.0
			end
		end
		music:applyVolume()
		soundEffects:playSoundEffect(self.sfx)
		self.menuText = self:generateMenuText()
	elseif controls:isRight(input) then
		if self.selection == 1 then
			self.masterVolume = self.masterVolume + 0.1
			if self.masterVolume >= 1.0 then
				self.masterVolume = 1.0
			end
		elseif self.selection == 2 then
			self.bgmVolume = self.bgmVolume + 0.1
			if self.bgmVolume >= 1.0 then
				self.bgmVolume = 1.0
			end
		elseif self.selection == 3 then
			self.sfxVolume = self.sfxVolume + 0.1
			if self.sfxVolume >= 1.0 then
				self.sfxVolume = 1.0
			end
		end
		music:applyVolume()
		soundEffects:playSoundEffect(self.sfx)
		self.menuText = self:generateMenuText()
	elseif controls:isMenu(input) or controls:isConfirm(input) then
		if self.selection == 4 then
			--save changes back to file
			local saveData = ""
			saveData = saveData .. self.masterVolume .. "\t" .. self.bgmVolume .. "\t" .. self.sfxVolume
			love.filesystem.write(self.soundOptionsFilename, saveData)

			toState = options
		end
	else
		--
	end
end

function SoundOptions.keyreleased(self, key)
	--
end

function SoundOptions.mousepressed(self, x, y, button)
	--
end

function SoundOptions.update(self, dt)

end

