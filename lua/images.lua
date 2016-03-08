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
	self.images["buttonBackground"] = love.graphics.newImage("media/menu/buttonBackground.png")
	self.images["buttonHighlight"] = love.graphics.newImage("media/menu/buttonHighlight.png")

	self.images["faces"] = self:loadFaces()
end

function Images.getImage(self, imageName)
	return self.images[imageName]
end

function Images.loadBackgroundTiles(self)
	local pieces = {}

	pieces["red"] = 255 --78
	pieces["green"] = 249 --74
	pieces["blue"] = 179 --78

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

function Images.loadFaces(self)
	local faces = {}

	local males = {}

	local maleHeads = {}
	local maleHeadFiles = love.filesystem.getDirectoryItems("media/faces/male/heads/")
	for _,file in ipairs(maleHeadFiles) do
		table.insert(maleHeads, love.graphics.newImage("media/faces/male/heads/" .. file))
	end

	local maleEyes = {}
	local maleEyesFiles = love.filesystem.getDirectoryItems("media/faces/male/eyes/")
	for _,file in ipairs(maleEyesFiles) do
		table.insert(maleEyes, love.graphics.newImage("media/faces/male/eyes/" .. file))
	end

	local maleHair = {}
	local maleHairFiles = love.filesystem.getDirectoryItems("media/faces/male/hair/")
	for _,file in ipairs(maleHairFiles) do
		table.insert(maleHair, love.graphics.newImage("media/faces/male/hair/" .. file))
	end

	local maleMouths = {}
	local maleMouthsFiles = love.filesystem.getDirectoryItems("media/faces/male/mouths/")
	for _,file in ipairs(maleMouthsFiles) do
		table.insert(maleMouths, love.graphics.newImage("media/faces/male/mouths/" .. file))
	end

	local maleAccessories = {}
	local maleAccessoriesFiles = love.filesystem.getDirectoryItems("media/faces/male/accessories/")
	for _,file in ipairs(maleAccessoriesFiles) do
		table.insert(maleAccessories, love.graphics.newImage("media/faces/male/accessories/" .. file))
	end

	males["heads"] = maleHeads
	males["eyes"] = maleEyes
	males["hairs"] = maleHair
	males["mouths"] = maleMouths
	males["accessories"] = maleAccessories

	local females = {}

	local femaleHeads = {}
	local femaleHeadFiles = love.filesystem.getDirectoryItems("media/faces/female/heads/")
	for _,file in ipairs(femaleHeadFiles) do
		table.insert(femaleHeads, love.graphics.newImage("media/faces/female/heads/" .. file))
	end

	local femaleEyes = {}
	local femaleEyesFiles = love.filesystem.getDirectoryItems("media/faces/female/eyes/")
	for _,file in ipairs(femaleEyesFiles) do
		table.insert(femaleEyes, love.graphics.newImage("media/faces/female/eyes/" .. file))
	end

	local femaleHair = {}
	local femaleHairFiles = love.filesystem.getDirectoryItems("media/faces/female/hair/")
	for _,file in ipairs(femaleHairFiles) do
		table.insert(femaleHair, love.graphics.newImage("media/faces/female/hair/" .. file))
	end

	local femaleMouths = {}
	local femaleMouthsFiles = love.filesystem.getDirectoryItems("media/faces/female/mouths/")
	for _,file in ipairs(femaleMouthsFiles) do
		table.insert(femaleMouths, love.graphics.newImage("media/faces/female/mouths/" .. file))
	end

	local femaleAccessories = {}
	local femaleAccessoriesFiles = love.filesystem.getDirectoryItems("media/faces/female/accessories/")
	for _,file in ipairs(femaleAccessoriesFiles) do
		table.insert(femaleAccessories, love.graphics.newImage("media/faces/female/accessories/" .. file))
	end

	females["heads"] = femaleHeads
	females["eyes"] = femaleEyes
	females["hairs"] = femaleHair
	females["mouths"] = femaleMouths
	females["accessories"] = femaleAccessories

	faces["males"] = males
	faces["females"] = females

	return faces
end

