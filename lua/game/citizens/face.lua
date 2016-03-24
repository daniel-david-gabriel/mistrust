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

function Face:_init(head, eyes, mouth, hair, accessories)
	self.head = head
	self.eyes = eyes
	self.mouth = mouth
	self.hair = hair
	self.accessories = accessories
end
