require("lua/game/actions/killAction")

KillActionTab = {}
KillActionTab.__index = KillActionTab

setmetatable(KillActionTab, {
  __index = KillActionTab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function KillActionTab:_init()
	self.rowDisplayed = 1
	self.rowSelected = 1
	self.citizenSelected = 1
end

function KillActionTab.new(self)

end

function KillActionTab.draw(self)
	local xOffset = 50
	local yOffset = 50

	for k,citizen in pairs(game.town.citizens) do
		if k >= self.rowDisplayed and k < self.rowDisplayed + 3 then
			screen:drawPortrait(xOffset, yOffset, game.town.citizens[k], alpha)
			local detailsString = "Name: " .. game.town.citizens[k].name .. " Occupation: " .. game.town.citizens[k].occupation .. "\n"
			detailsString = detailsString .. "Suspicion Level: " .. game.town.citizens[k].suspicious
			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.printf(detailsString, 200, yOffset, love.graphics.getWidth() - 200, "left")
			yOffset = yOffset + 150
		end
	end

	local selectionX = 50
	local selectionY = 150 * self.rowSelected
	screen:drawCursor(selectionX, selectionY)
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

