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
	local width = 750
	local height = 550
	local xOffset = 120
	local yOffset = 75

	love.graphics.draw(images:getImage("summaryBackground"), 25, 25, 0, width / images:getImage("summaryBackground"):getWidth(), height / images:getImage("summaryBackground"):getHeight())

	for k,citizen in pairs(game.town.citizens) do
		if citizen.alive == 1 and k >= self.rowDisplayed and k < self.rowDisplayed + 3 then
			screen:drawPortrait(xOffset, yOffset, game.town.citizens[k], alpha)
			local detailsString = "Name: " .. game.town.citizens[k].name .. " Occupation: " .. game.town.citizens[k].occupation .. "\n"
			detailsString = detailsString .. "Suspicion Level: " .. game.town.citizens[k].suspicious
			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.printf(detailsString, 250, yOffset, love.graphics.getWidth() - 400, "left")
			yOffset = yOffset + 140
		end
	end

	local selectionX = 75
	local selectionY = 140 * self.rowSelected
	screen:drawCursor(selectionX, selectionY)

	--draw scroll marker
	local marker = images:getImage("unchecked")
	local step = (height-110) / table.getn(game.town.citizens)
	local y = 75 + (step*(self.rowDisplayed-1))
	love.graphics.draw(marker, width - 70, y)

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

