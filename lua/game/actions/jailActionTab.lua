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
	if controls:isConfirm(input) then
		local jailAction = JailAction(self.citizenSelected)
		if game.actPhase:canAddAction(jailAction) then
			game.actPhase:addAction(jailAction)
			game.actPhase.selectedTab = ""
		else
			--error?
		end
	else
		Tab.processControls(self, input)
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
