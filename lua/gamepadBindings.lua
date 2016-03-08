GamepadBindings = {}
GamepadBindings.__index = GamepadBindings


setmetatable(GamepadBindings, {
  __index = GamepadBindings,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function GamepadBindings:_init()
	self.bindingsFilename = "gamepadBindings.dat"
	self.bindings = {}

	--Prepopulate bindings with defaults in case of incomplete bindings file
	self.bindings["quit"] = "escape"
	self.bindings["up"] = "w"
	self.bindings["down"] = "s"
	self.bindings["left"] = "a"
	self.bindings["right"] = "d"
	self.bindings["menu"] = "return"
	self.bindings["confirm"] = "space"
	self.bindings["back"] = "lshift"

	if love.filesystem.exists(self.bindingsFilename) then
		self:loadBindings()
	end
end

function GamepadBindings.getQuit(self)
	return self.bindings["quit"]
end

function GamepadBindings.getUp(self)
	return self.bindings["up"]
end

function GamepadBindings.getDown(self)
	return self.bindings["down"]
end

function GamepadBindings.getLeft(self)
	return self.bindings["left"]
end

function GamepadBindings.getRight(self)
	return self.bindings["right"]
end

function GamepadBindings.getMenu(self)
	return self.bindings["menu"]
end

function GamepadBindings.getBack(self)
	return self.bindings["back"]
end

function GamepadBindings.getConfirm(self)
	return self.bindings["confirm"]
end

function GamepadBindings.loadBindings(self)
	local bindingsFileLines = love.filesystem.lines(self.bindingsFilename)

	for line in bindingsFileLines do
		local lineTokens = split(line, "%S+")
		--inspect first token for valid value?

		self.bindings[lineTokens[1]] = lineTokens[2]
	end
end

function GamepadBindings.saveBindings(self)
	local savedBindings = ""
	for k,v in pairs(self.bindings) do
		savedBindings = savedBindings .. k .. " " .. v .. "\r\n"
	end

	love.filesystem.write(self.bindingsFilename, savedBindings)
end








