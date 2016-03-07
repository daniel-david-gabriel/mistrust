Screen = {}
Screen.__index = Screen

setmetatable(Screen, {
  __index = Screen,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Screen:_init()

end

function Screen.drawPhaseBackground(self)
	love.graphics.setColor(255, 255, 255, 255)

	local background = images:getImage("background")
	love.graphics.setBackgroundColor(background["red"], background["green"], background["blue"], 255)

	local upperLeft = background["tiles"]["upperLeft"]
	local upper = background["tiles"]["upper"]
	local upperRight = background["tiles"]["upperRight"]

	local left = background["tiles"]["left"]
	local right =  background["tiles"]["right"]

	local lowerLeft = background["tiles"]["lowerLeft"]
	local lower =  background["tiles"]["lower"]
	local lowerRight = background["tiles"]["lowerRight"]

	local numberHorizontalTiles = (love.graphics.getWidth() / upper:getWidth())
	local xOffset = 0
	for i=1,numberHorizontalTiles do
		love.graphics.draw(upper, 0 + xOffset, 0, 0, 2, 2)
		love.graphics.draw(lower, 0 + xOffset, love.graphics.getHeight() - (lower:getHeight()*2), 0, 2, 2)
		xOffset = xOffset + upper:getWidth()
	end


	local numberVerticalTiles = (love.graphics.getHeight() / left:getHeight())
	local yOffset = 0
	for i=1,numberVerticalTiles do
		love.graphics.draw(left, 0, 0 + yOffset, 0, 2, 2)
		love.graphics.draw(right, love.graphics.getWidth() - (right:getWidth()*2), 0 + yOffset, 0, 2, 2)
		yOffset = yOffset + left:getHeight()
	end
	
	love.graphics.draw(upperLeft, 0, 0, 0, 2, 2)
	love.graphics.draw(upperRight, love.graphics.getWidth() - (upperRight:getWidth()*2), 0, 0, 2, 2)
	love.graphics.draw(lowerLeft, 0, love.graphics.getHeight() - (lowerLeft:getHeight()*2), 0, 2, 2)
	love.graphics.draw(lowerRight, love.graphics.getWidth() - (lowerRight:getWidth()*2), love.graphics.getHeight() - (lowerRight:getHeight()*2), 0, 2, 2)
end

function Screen.drawCursor(self, x, y)
	love.graphics.setColor(255, 255, 255, 255)

	local cursor = images:getImage("cursor")

	love.graphics.draw(cursor, x, y, 0, 0.5, 0.5)
end

