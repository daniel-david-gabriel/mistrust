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
	if controls:isConfirm(input) then
		local killAction = KillAction(self.citizenSelected)
		if game.actPhase:canAddAction(killAction) then
			game.actPhase:addAction(killAction)
			game.actPhase.selectedTab = ""
		else
			--error?
		end
	else
		Tab.processControls(self, input)
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
