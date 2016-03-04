require("lua/game/town")
require("lua/save")

Game = {}
Game.__index = Game

setmetatable(Game, {
  __index = Game,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Game:_init()

end

function Game.new(self)
	self.town = Town()	
	self.town:new()
	
end

function Game.load(self, save)
	self.town = Town()
	self.town:load(save:load())
end

function Game.draw(self)
	
end

function Game.keypressed(self, key)
	if key == keyBindings:getMenu() or key == keyBindings:getTool() then
		local save = Save("save.dat")
		save:save()
	end
end

function Game.keyreleased(self, key )

end

function Game.mousepressed(self, x, y, button)
	--noop
end

function Game.update(self, dt)
	
end

function Game.loadMaps(self)
	
end

