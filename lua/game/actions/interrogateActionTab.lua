require("lua/game/actions/interrogateAction")

InterrogateActionTab = {}
InterrogateActionTab.__index = InterrogateActionTab

setmetatable(InterrogateActionTab, {
  __index = Tab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function InterrogateActionTab:_init()
	Tab._init(self)
end

function InterrogateActionTab.draw(self)
	Tab.draw(self)
end

function InterrogateActionTab.processControls(self, input)
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
		local interrogateAction = InterrogateAction(self.citizenSelected)
		if game.actPhase:canAddAction(interrogateAction) then
			game.actPhase:addAction(interrogateAction)
			game.actPhase.selectedTab = ""
		else
			--error?
		end
	end
end

function InterrogateActionTab.keyreleased(self, key )
	--
end

function InterrogateActionTab.mousepressed(self, x, y, button)
	--noop
end

function InterrogateActionTab.update(self, dt)

end

