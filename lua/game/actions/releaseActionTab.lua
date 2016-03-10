require("lua/game/actions/releaseAction")

ReleaseActionTab = {}
ReleaseActionTab.__index = ReleaseActionTab

setmetatable(ReleaseActionTab, {
  __index = ReleaseActionTab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function ReleaseActionTab:_init()
	self.rowDisplayed = 1
	self.rowSelected = 1
	self.citizenSelected = 1
end

function ReleaseActionTab.new(self)

end

function ReleaseActionTab.draw(self)
	local xOffset = 50
	local yOffset = 50

	for k,citizen in pairs(game.town.jail) do
		if citizen.alive == 1 and k >= self.rowDisplayed and k < self.rowDisplayed + 3 then
			screen:drawPortrait(xOffset, yOffset, citizen, alpha)
			local detailsString = "Name: " ..citizen.name .. " Occupation: " .. citizen.occupation .. "\n"
			detailsString = detailsString .. "Suspicion Level: " .. citizen.suspicious
			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.printf(detailsString, 200, yOffset, love.graphics.getWidth() - 200, "left")
			yOffset = yOffset + 150
		end
	end

	local selectionX = 50
	local selectionY = 150 * self.rowSelected
	screen:drawCursor(selectionX, selectionY)
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
print(self.citizenSelected)
print(game.town.jail[self.citizenSelected].name)
		table.insert(game.actPhase.actionsToExecute, ReleaseAction(self.citizenSelected))
		game.actPhase.selectedTab = ""
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

