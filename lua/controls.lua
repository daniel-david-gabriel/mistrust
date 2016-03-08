require("lua/keyBindings")
require("lua/gamepadBindings")

Controls = {}
Controls.__index = Controls

setmetatable(Controls, {
  __index = Controls,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Controls:_init()
	self.keyBindings = KeyBindings()
	self.gamepadBindings = GamepadBindings()
end

function Controls.isQuit(self, input)
	return input == self.keyBindings:getQuit() or input == self.gamepadBindings:getQuit()
end

function Controls.isUp(self, input)
	return input == self.keyBindings:getUp() or input == self.gamepadBindings:getUp()
end

function Controls.isDown(self, input)
	return input == self.keyBindings:getDown() or input == self.gamepadBindings:getDown()
end

function Controls.isLeft(self, input)
	return input == self.keyBindings:getLeft() or input == self.gamepadBindings:getLeft()
end

function Controls.isRight(self, input)
	return input == self.keyBindings:getRight() or input == self.gamepadBindings:getRight()
end

function Controls.isMenu(self, input)
	return input == self.keyBindings:getMenu() or input == self.gamepadBindings:getMenu()
end

function Controls.isBack(self, input)
	return input == self.keyBindings:getBack() or input == self.gamepadBindings:getBack()
end

function Controls.isConfirm(self, input)
	return input == self.keyBindings:getConfirm() or input == self.gamepadBindings:getConfirm()
end

