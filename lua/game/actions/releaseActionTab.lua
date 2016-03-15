require("lua/game/actions/releaseAction")

ReleaseActionTab = {}
ReleaseActionTab.__index = ReleaseActionTab

setmetatable(ReleaseActionTab, {
  __index = Tab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function ReleaseActionTab:_init()
	Tab._init(self)
end

function ReleaseActionTab.draw(self)
	Tab.draw(self)
end

function ReleaseActionTab.processControls(self, input)
	if controls:isUp(input) then
		if self.rowDisplayed > 1 and self.rowSelected == 1 then
			self.rowDisplayed = self.rowDisplayed - 1
			self.citizenSelected = self.citizenSelected - 1
		elseif self.rowSelected > 1 then
			self.rowSelected = self.rowSelected - 1
			self.citizenSelected = self.citizenSelected - 1
		end
	elseif controls:isDown(input) then
		if self.citizenSelected < table.getn(game.town.citizens) and self.rowSelected == 3 then
			self.rowDisplayed = self.rowDisplayed + 1
			self.citizenSelected = self.citizenSelected + 1
		elseif self.rowSelected < 3 then
			self.rowSelected = self.rowSelected + 1
			self.citizenSelected = self.citizenSelected + 1
		end
	elseif controls:isConfirm(input) then
		local releaseAction = ReleaseAction(self.citizenSelected)
		if game.actPhase:canAddAction(releaseAction) then
			game.actPhase:addAction(releaseAction)
			game.actPhase.selectedTab = ""
		else
			--error?
		end
	end
end

function ReleaseActionTab.keyreleased(self, key )
	--
end

function ReleaseActionTab.mousepressed(self, x, y, button)
	--noop
end

function ReleaseActionTab.update(self, dt)

end
