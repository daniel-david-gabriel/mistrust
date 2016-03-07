MainMenu = {}
MainMenu.__index = MainMenu

setmetatable(MainMenu, {
  __index = MainMenu,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function MainMenu:_init()
	self.background = love.graphics.newImage("media/menu/darkBackground.png")
	self.title = love.graphics.newImage("media/menu/title.png")

        self.cloud = love.graphics.newImage("media/core/cloud.png")
        self.numberOfClouds = 0
        self.maxClouds = 1000
	self.cloudAlpha = 0
        self.cloudPositions = {}
	self.cloudTimer = 0

	self.submenuCount = 5
	self.selection = 1
	
	self.menuText = ""
	self.menuText = self.menuText .. "New Game\n"
	self.menuText = self.menuText .. "Load Game\n"
	self.menuText = self.menuText .. "Options\n"
	self.menuText = self.menuText .. "Credits\n"
	self.menuText = self.menuText .. "Quit"

	--prepopulate clouds
	for i=1,100 do
		if self.numberOfClouds < self.maxClouds then
			self.cloudPositions[love.math.random(600) - 40] = love.math.random(800)
			self.numberOfClouds = self.numberOfClouds + 1
        	end
	end
	
end

function MainMenu.draw(self)
	--love.graphics.setColor(51, 153, 102, 255)
	--love.graphics.rectangle("fill", 0, 0, 800, 600)

	--determine scaling for background image
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local imageWidth = self.background:getWidth()
	local imageHeight = self.background:getHeight()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.background, 0, 0, 0, width / imageWidth, height / imageHeight)
	
	for k,v in pairs(self.cloudPositions) do
		love.graphics.setColor(255, 255, 255, self.cloudAlpha)
		love.graphics.draw(self.cloud, v, k)
                self.cloudPositions[k] = v - 1
                if self.cloudPositions[k] <= -100 then
			table.remove(self.cloudPositions, k)
			self.numberOfClouds = self.numberOfClouds - 1
                end
	end

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.printf(self.menuText, love.graphics.getWidth()/4, love.graphics.getHeight()/2, love.graphics.getWidth()/2, "center")

	love.graphics.draw(self.title, 0, 0)

	--love.graphics.rectangle("fill", 575, 50 + 50 *self.selection, 25, 25)
	screen:drawCursor(295, 270 + 32*self.selection)
end

function MainMenu.keypressed(self, key)
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
			game:new()
			toState = game
		elseif self.selection == 2 then
			game:load(Save("save.dat"))
			toState = game
		elseif self.selection == 3 then
			--options
		elseif self.selection == 4 then
			--credits
		elseif self.selection == 5 then
			love.event.push("quit")
		end
	else
		--
	end
end

function MainMenu.keyreleased(self, key)
	--
end

function MainMenu.mousepressed(self, x, y, button)
	--
end

function MainMenu.update(self, dt)
	music:playMusic("prelude")

	if self.cloudTimer <= 0 then
		if self.numberOfClouds < self.maxClouds then
			self.cloudPositions[love.math.random(600) - 40] = 800
			self.numberOfClouds = self.numberOfClouds + 1
                        self.cloudTimer = love.math.random(100)
        	end
	else
		self.cloudTimer = self.cloudTimer - (dt * 1000)
	end

	if self.cloudAlpha < 16 then
		self.cloudAlpha = self.cloudAlpha + 1
	end
end
