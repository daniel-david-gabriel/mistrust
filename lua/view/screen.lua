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
	--love.graphics.setBackgroundColor(background["red"], background["green"], background["blue"], 255)
	love.graphics.draw(images:getImage("parchment"), 0, 0, 0, love.graphics.getWidth() / images:getImage("parchment"):getWidth(), love.graphics.getHeight() / images:getImage("parchment"):getHeight())

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

function Screen.drawPortrait(self, x, y, citizen, alpha)
	alpha = alpha or 255

	local width = 128
	local height = 128

	local background = images:getImage("background")
	love.graphics.setColor(background["red"], background["green"], background["blue"], alpha)
	love.graphics.rectangle("fill", x, y, width, height)

	love.graphics.setColor(255, 255, 255, alpha)

	local faces = images:getImage("faces")
	local face = nil
	if citizen.sex == 0 then
		face = faces["females"]
	else
		face = faces["males"]
	end

	love.graphics.draw(face["heads"][citizen.face.head], x, y, 0, 2, 2)
	love.graphics.draw(face["eyes"][citizen.face.eyes], x, y, 0, 2, 2)
	love.graphics.draw(face["hairs"][citizen.face.hair], x, y, 0, 2, 2)
	love.graphics.draw(face["mouths"][citizen.face.mouth], x, y, 0, 2, 2)
	love.graphics.draw(face["accessories"][citizen.face.accessories], x, y, 0, 2, 2)

	local upperLeft = background["tiles"]["upperLeft"]
	local upper = background["tiles"]["upper"]
	local upperRight = background["tiles"]["upperRight"]

	local left = background["tiles"]["left"]
	local right =  background["tiles"]["right"]

	local lowerLeft = background["tiles"]["lowerLeft"]
	local lower =  background["tiles"]["lower"]
	local lowerRight = background["tiles"]["lowerRight"]

	love.graphics.draw(upper, x, y, 0, width / upper:getWidth(), 2)
	love.graphics.draw(lower, x, y + height - (lower:getHeight()*2), 0, width / upper:getWidth(), 2)

	love.graphics.draw(left, x, y, 0, 2, height / left:getHeight())
	love.graphics.draw(right, x + width - (right:getWidth()*2), y, 0, 2, height / right:getHeight())
	
	love.graphics.draw(upperLeft, x, y, 0, 2, 2)
	love.graphics.draw(upperRight, x + width - (upperRight:getWidth()*2), y, 0, 2, 2)
	love.graphics.draw(lowerLeft, x, y + height - (lowerLeft:getHeight()*2), 0, 2, 2)
	love.graphics.draw(lowerRight, x + width - (lowerRight:getWidth()*2), y + height - (lowerRight:getHeight()*2), 0, 2, 2)

	if citizen.suspicious == 50 then
		love.graphics.draw(images:getImage("suspicious"), x + width - images:getImage("suspicious"):getWidth(), y + height - images:getImage("suspicious"):getHeight(), 0, 2, 2)
	elseif citizen.suspicious >= 100 then
		love.graphics.draw(images:getImage("marked"), x + width - images:getImage("marked"):getWidth(), y + height - images:getImage("marked"):getHeight(), 0, 2, 2)
	end
end

function Screen.drawCursor(self, x, y)
	love.graphics.setColor(255, 255, 255, 255)

	local cursor = images:getImage("cursor")

	love.graphics.draw(cursor, x, y, 0, 0.5, 0.5)
end

function Screen.drawButton(self, x, y, text)

end

