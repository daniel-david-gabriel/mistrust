require("lua/game/actions/prayerAction")

PrayerActionTab = {}
PrayerActionTab.__index = PrayerActionTab

setmetatable(PrayerActionTab, {
  __index = PrayerActionTab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function PrayerActionTab:_init()
	self:resetSelection()
	self.list = prayers
end

function PrayerActionTab.draw(self)
	local width = 750
	local height = 550
	local xOffset = 120
	local yOffset = 75

	local backgroundImage = images:getImage("summaryBackground")

	love.graphics.draw(backgroundImage, 25, 25, 0, width / backgroundImage:getWidth(), height / backgroundImage:getHeight())

	for k,prayer in pairs(self.list) do
		if k >= self.rowDisplayed and k < self.rowDisplayed + 3 then
			--screen:drawPortrait(xOffset, yOffset, self.list[k], alpha)
			local detailsString = "Name: " .. prayer.name .. " Description: " .. prayer.description .. "\n"
			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.printf(detailsString, 150, yOffset, love.graphics.getWidth() - 300, "left")
			yOffset = yOffset + 140
		end
	end

	local selectionX = 75
	local selectionY = 140 * self.rowSelected
	screen:drawCursor(selectionX, selectionY)

	--draw scroll marker
	local marker = images:getImage("unchecked")
	local step = (height-110) / table.getn(self.list)
	local y = 75 + (step*(self.rowDisplayed-1))
	love.graphics.draw(marker, width - 70, y)
end

function PrayerActionTab.processControls(self, input)
	if controls:isUp(input) then
		if self.rowDisplayed > 1 and self.rowSelected == 1 then
			self.rowDisplayed = self.rowDisplayed - 1
			self.prayerSelected = self.prayerSelected - 1
		elseif self.rowSelected > 1 then
			self.rowSelected = self.rowSelected - 1
			self.prayerSelected = self.prayerSelected - 1
		end
	elseif controls:isDown(input) then
		if self.prayerSelected < table.getn(self.list) and self.rowSelected == 3 then
			self.rowDisplayed = self.rowDisplayed + 1
			self.prayerSelected = self.prayerSelected + 1
		elseif self.rowSelected < 3 then
			self.rowSelected = self.rowSelected + 1
			self.prayerSelected = self.prayerSelected + 1
		end
	elseif controls:isConfirm(input) then
		local prayerAction = PrayerAction(self.prayerSelected)
		if game.actPhase:canAddAction(prayerAction) then
			game.actPhase:addAction(prayerAction)
			game.actPhase.selectedTab = ""
		else
			--error?
		end
	end
end

function PrayerActionTab.keyreleased(self, key )
	--
end

function PrayerActionTab.mousepressed(self, x, y, button)
	--noop
end

function PrayerActionTab.update(self, dt)

end

function PrayerActionTab.resetSelection(self)
	self.rowDisplayed = 1
	self.rowSelected = 1
	self.prayerSelected = 1
end
