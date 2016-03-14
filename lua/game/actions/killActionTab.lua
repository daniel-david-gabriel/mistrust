require("lua/game/actions/killAction")

KillActionTab = {}
KillActionTab.__index = KillActionTab

setmetatable(KillActionTab, {
  __index = Tab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function KillActionTab:_init()
	Tab._init(self)
end

function KillActionTab.draw(self)
	Tab.draw(self)
end

function KillActionTab.processControls(self, input)
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
		table.insert(game.actPhase.actionsToExecute, KillAction(self.citizenSelected))
		game.actPhase.selectedTab = ""
		game.actPhase.actionsTaken = game.actPhase.actionsTaken + 1
	end
end

function KillActionTab.keyreleased(self, key )
	--
end

function KillActionTab.mousepressed(self, x, y, button)
	--noop
end

function KillActionTab.update(self, dt)

end
