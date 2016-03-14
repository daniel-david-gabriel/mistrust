require("lua/game/tab")
require("lua/game/town")
require("lua/game/player")
require("lua/menu/uiElement")
require("lua/game/phase/preparationPhase")
require("lua/game/phase/actPhase")
require("lua/game/phase/resultsPhase")
require("lua/game/phase/gameOver")
require("lua/game/phase/huntSummary")
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
	self.resultsPhase.toState = self.preparationPhase

	self.huntSummary = HuntSummary()
	self.gameOver = GameOver()
end

function Game.new(self)
	self.town = Town()	
	self.town:new()

	self.player = Player()

	self.town:updateTownList()
	self.town:updateMorgueList()
	self.town:updateJailList()
end

function Game.load(self, save)
	self.town, self.player = save:load()

	self.town:updateTownList()
	self.town:updateMorgueList()
	self.town:updateJailList()
end

function Game.save(self)
	local save = Save("save.dat")
	save:save(self.town, self.player)
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

