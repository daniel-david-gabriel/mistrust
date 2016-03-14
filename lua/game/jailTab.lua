JailTab = {}
JailTab.__index = JailTab

setmetatable(JailTab, {
  __index = Tab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function JailTab:_init()
	self:resetSelection()
end

function JailTab.draw(self)
	Tab.draw(self)
end

function JailTab.processControls(self, input)
	if controls:isUp(input) then
		if self.rowDisplayed > 1 and self.rowSelected == 1 then
			self.rowDisplayed = self.rowDisplayed - 1
			self.citizenSelected = self.citizenSelected - 1
		elseif self.rowSelected > 1 then
			self.rowSelected = self.rowSelected - 1
			self.citizenSelected = self.citizenSelected - 1
		end
	elseif controls:isDown(input) then
		if self.citizenSelected < table.getn(game.town.jail) and self.rowSelected == 3 then
			self.rowDisplayed = self.rowDisplayed + 1
			self.citizenSelected = self.citizenSelected + 1
		elseif self.rowSelected < 3 then
			self.rowSelected = self.rowSelected + 1
			self.citizenSelected = self.citizenSelected + 1
		end
	elseif controls:isConfirm(input) then
		print(game.town.jail[self.citizenSelected].name)
	end
end

function JailTab.keyreleased(self, key )
	--
end

function JailTab.mousepressed(self, x, y, button)
	--noop
end

function JailTab.update(self, dt)

end
