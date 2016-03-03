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

function Game.draw(self)
	
end

function Game.keypressed(self, key)
	
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

function Game.load(self, save)
	
end
