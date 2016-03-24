MorgueTab = {}
MorgueTab.__index = MorgueTab

setmetatable(MorgueTab, {
  __index = Tab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function MorgueTab:_init()
	Tab._init(self)
end

function MorgueTab.draw(self)
	Tab.draw(self)
end

function MorgueTab.processControls(self, input)
	if controls:isUp(input) then
		if self.rowDisplayed > 1 and self.rowSelected == 1 then
			self.rowDisplayed = self.rowDisplayed - 1
			self.citizenSelected = self.citizenSelected - 1
		elseif self.rowSelected > 1 then
			self.rowSelected = self.rowSelected - 1
			self.citizenSelected = self.citizenSelected - 1
		end
	elseif controls:isDown(input) then
		if self.citizenSelected < table.getn(game.town.morgue) and self.rowSelected == 3 then
			self.rowDisplayed = self.rowDisplayed + 1
			self.citizenSelected = self.citizenSelected + 1
		elseif self.rowSelected < 3 then
			self.rowSelected = self.rowSelected + 1
			self.citizenSelected = self.citizenSelected + 1
		end
	elseif controls:isConfirm(input) then
		print(game.town.morgue[self.citizenSelected].name)
	end
end

function MorgueTab.keyreleased(self, key )
	--
end

function MorgueTab.mousepressed(self, x, y, button)
	--noop
end

function MorgueTab.update(self, dt)

end
