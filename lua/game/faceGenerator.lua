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
	return Face(1, 2, 3, 4)
end
