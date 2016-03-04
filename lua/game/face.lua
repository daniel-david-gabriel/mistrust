Face = {}
Face.__index = Face

setmetatable(Face, {
  __index = Face,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Face:_init(faceShape, eyes, nose, mouth)
	self.faceShape = faceShape
	self.eyes = eyes
	self.nose = nose
	self.mouth = mouth
end
