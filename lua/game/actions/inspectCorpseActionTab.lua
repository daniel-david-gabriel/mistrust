require("lua/game/actions/inspectCorpseAction")

InspectCorpseActionTab = {}
InspectCorpseActionTab.__index = InspectCorpseActionTab

setmetatable(InspectCorpseActionTab, {
  __index = Tab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function InspectCorpseActionTab:_init()
	Tab._init(self)
end

function InspectCorpseActionTab.draw(self)
	Tab.draw(self)
	--if inspected, draw inspected marker over portrait
end

function InspectCorpseActionTab.processControls(self, input)
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
	elseif controls:isConfirm(input) then --disallow if corpse already inspected
		local inspectCorpseAction = InspectCorpseAction(self.citizenSelected)
		if game.actPhase:canAddAction(inspectCorpseAction) then
			game.actPhase:addAction(inspectCorpseAction)
			game.actPhase.selectedTab = ""
		else
			--error?
		end
	end
end

function InspectCorpseActionTab.keyreleased(self, key)
	--
end

function InspectCorpseActionTab.mousepressed(self, x, y, button)
	--noop
end

function InspectCorpseActionTab.update(self, dt)

end

