require("lua/game/actions/jailAction")

JailActionTab = {}
JailActionTab.__index = JailActionTab

setmetatable(JailActionTab, {
  __index = Tab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function JailActionTab:_init()
	Tab._init(self)
end

function JailActionTab.draw(self)
	Tab.draw(self)
end

function JailActionTab.processControls(self, input)
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
		table.insert(game.actPhase.actionsToExecute, JailAction(self.citizenSelected))
		game.actPhase.selectedTab = ""
		game.actPhase.actionsTaken = game.actPhase.actionsTaken + 1
	end
end

function JailActionTab.keyreleased(self, key )
	--
end

function JailActionTab.mousepressed(self, x, y, button)
	--noop
end

function JailActionTab.update(self, dt)

end
