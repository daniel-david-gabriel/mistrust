require("lua/game/town")
require("lua/preparationPhase")
require("lua/actPhase")
require("lua/resultsPhase")
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
	self.preparationPhase = PreparationPhase()
	self.actPhase = ActPhase()
	self.resultsPhase = ResultsPhase()
end

function Game.new(self)
	self.town = Town()	
	self.town:new()
end

function Game.load(self, save)
	self.town = save:load()
end

function Game.save(self)
	local save = Save("save.dat")
	save:save(self.town)
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
	toState = self.preparationPhase
end

function Game.loadMaps(self)
	
end

