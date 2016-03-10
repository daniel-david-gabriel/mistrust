HuntSummary = {}
HuntSummary.__index = HuntSummary

setmetatable(HuntSummary, {
  __index = HuntSummary,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function HuntSummary:_init()
	self.background = love.graphics.newImage("media/menu/spellbookForFlare.png")
end

function HuntSummary.new(self)

end

function HuntSummary.draw(self)
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local imageWidth = self.background:getWidth()
	local imageHeight = self.background:getHeight()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.background, 0, 0, 0, width / imageWidth, height / imageHeight)

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.printf("Hunt Summary", 50, 30, 700, "center")
end

function HuntSummary.processControls(self, input)
	if controls:isMenu(input) or controls:isConfirm(input) then
		toState = mainMenu
		--next stage
	end
end

function HuntSummary.keyreleased(self, key )

end

function HuntSummary.mousepressed(self, x, y, button)
	--
end

function HuntSummary.update(self, dt)
	--music:playMusic("gameOver")
end

