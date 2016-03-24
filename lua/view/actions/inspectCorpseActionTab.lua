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
	if controls:isConfirm(input) then
		local inspectCorpseAction = InspectCorpseAction(self.citizenSelected)
		if game.actPhase:canAddAction(inspectCorpseAction) then
			game.actPhase:addAction(inspectCorpseAction)
			game.actPhase.selectedTab = ""
		else
			--error?
		end
	else
		Tab.processControls(self, input)
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

