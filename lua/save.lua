Save = {}
Save.__index = Save

setmetatable(Save, {
  __index = Save,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Save:_init(saveFile)
	self.saveFilename = saveFile
end

function Save.save(self)
	local saveData = "foo"

	love.filesystem.write(self.saveFilename, saveData)
end


function Save.load(self)
	local loadData = love.filesystem.lines(self.saveFilename)
	
end
