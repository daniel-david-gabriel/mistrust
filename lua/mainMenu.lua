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
        self.cloud = love.graphics.newImage("media/cloud.png")
        self.numberOfClouds = 0
        self.maxClouds = 20
        self.cloudPositions = {}
	self.cloudTimer = 0

	self.submenus = {}
	self.submenuCount = 1

	self.selection = 1
	self.submenus[self.submenuCount] = "New Game"
	self.submenuCount = self.submenuCount + 1

	if love.filesystem.exists("save.dat") then
		self.selection = 2
		self.submenus[self.submenuCount] = "Load Game"
		self.submenuCount = self.submenuCount + 1
	end

	self.submenus[self.submenuCount] = "Controls"
	self.submenuCount = self.submenuCount + 1

	self.submenus[self.submenuCount] = "Options"
	self.submenuCount = self.submenuCount + 1

	self.submenus[self.submenuCount] = "Quit"
	
end

function MainMenu.draw(self)
	love.graphics.setColor(51, 153, 102, 255)
	love.graphics.rectangle("fill", 0, 0, 800, 600)
	
	for k,v in pairs(self.cloudPositions) do
		love.graphics.setColor(255, 255, 255, 128)
		love.graphics.draw(self.cloud, v, k)
                self.cloudPositions[k] = v - 1
                if self.cloudPositions[k] <= -100 then
			table.remove(self.cloudPositions, k)
			self.numberOfClouds = self.numberOfClouds - 1
                end
	end

	love.graphics.setColor(0, 0, 0, 255)
	for k,v in pairs(self.submenus) do
		love.graphics.print(v, 600, 50 + k*50)
	end

	love.graphics.rectangle("fill", 575, 50 + 50 *self.selection, 25, 25)
end

function MainMenu.keypressed(self, key)
print(keyBindings:getUp())
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
		if self.submenus[self.selection] == "New Game" then
			toState = game
		elseif self.submenus[self.selection] == "Load Game" then
			game:load(Save("save.dat"))
			toState = game
		elseif self.submenus[self.selection] == "Controls" then
			toState = Controls()
		elseif self.submenus[self.selection] == "Options" then
			toState = OptionsMenu()
		elseif self.submenus[self.selection] == "Quit" then
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
	if self.cloudTimer <= 0 then
		if self.numberOfClouds < self.maxClouds then
			self.cloudPositions[love.math.random(600) - 40] = 800
			self.numberOfClouds = self.numberOfClouds + 1
                        self.cloudTimer = love.math.random(100)
        	end
	else
		self.cloudTimer = self.cloudTimer - (dt * 1000)
	end
end
