require("lua/game/face")

FaceGenerator = {}
FaceGenerator.__index = FaceGenerator

setmetatable(FaceGenerator, {
  __index = FaceGenerator,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function FaceGenerator:_init()

end

function FaceGenerator.generate(self, sex)
	
	local faceTable = {}
	if sex == 0 then
		faceTable = images:getImage("faces")["females"]
	else
		faceTable = images:getImage("faces")["males"]
	end

	local head = love.math.random(1,table.getn(faceTable["heads"]))
	local eyes = love.math.random(1,table.getn(faceTable["eyes"]))
	local mouth = love.math.random(1,table.getn(faceTable["mouths"]))
	local hair = love.math.random(1,table.getn(faceTable["hairs"]))
	local accessories = love.math.random(1,table.getn(faceTable["accessories"]))

	return Face(head, eyes, mouth, hair, accessories)
end
