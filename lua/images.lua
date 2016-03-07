Images = {}
Images.__index = Images


setmetatable(Images, {
  __index = Images,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Images:_init()
	love.graphics.setDefaultFilter("nearest")

	self.images = {}

	self.images["background"] = self:loadBackgroundTiles()

	self.images["cursor"] = love.graphics.newImage("media/menu/cursor.png")
end

function Images.getImage(self, imageName)
	return self.images[imageName]
end

function Images.loadBackgroundTiles(self)
	local pieces = {}

	pieces["red"] = 78
	pieces["green"] = 74
	pieces["blue"] = 78

	local tiles = {}

	tiles["upperLeft"] = love.graphics.newImage("media/menu/upperLeft.png")
	tiles["upper"] = love.graphics.newImage("media/menu/upper.png")
	tiles["upperRight"] = love.graphics.newImage("media/menu/upperRight.png")

	tiles["left"] = love.graphics.newImage("media/menu/left.png")
	tiles["right"] = love.graphics.newImage("media/menu/right.png")

	tiles["lowerLeft"] = love.graphics.newImage("media/menu/lowerLeft.png")
	tiles["lower"] = love.graphics.newImage("media/menu/lower.png")
	tiles["lowerRight"] = love.graphics.newImage("media/menu/lowerRight.png")

	pieces["tiles"] = tiles

	return pieces
end

