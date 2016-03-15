UIElement = {}
UIElement.__index = UIElement

setmetatable(UIElement, {
  __index = UIElement,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function UIElement:_init(name, x, y, up, down, left, right, confirm, image, highlight, text, textXOffset, textYOffset, cost)
	self.name = name
	
	self.x = x
	self.y = y
	
	self.up = up
	self.down = down
	self.left = left
	self.right = right
	
	self.confirm = confirm
	
	self.image = image
	self.highlight = highlight

	self.text = text
	self.textXOffset = textXOffset
	self.textYOffset = textYOffset

	if cost then
		self.cost = cost
	else
		self.cost = 0
	end
end
