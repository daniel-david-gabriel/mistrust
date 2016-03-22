Tab = {}
Tab.__index = Tab

setmetatable(Tab, {
  __index = Tab,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Tab:_init()
	self:resetSelection()

	self.list = nil
end

function Tab.draw(self)
	
	local width = 750
	local height = 550
	local xOffset = 120
	local yOffset = 75

	local backgroundImage = images:getImage("summaryBackground")

	love.graphics.draw(backgroundImage, 25, 25, 0, width / backgroundImage:getWidth(), height / backgroundImage:getHeight())

	for k,citizen in pairs(self.list) do
		if k >= self.rowDisplayed and k < self.rowDisplayed + 3 then
			screen:drawPortrait(xOffset, yOffset, self.list[k], alpha)
			local detailsString = "Name: " .. self.list[k].name .. " Occupation: " .. self.list[k].occupation .. "\n"
			detailsString = detailsString .. "Suspicion Level: " .. self.list[k].suspicious
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
	local step = (height-110) / table.getn(self.list)
	local y = 75 + (step*(self.rowDisplayed-1))
	love.graphics.draw(marker, width - 70, y)
end

function Tab.processControls(self, input)
	if controls:isUp(input) then
		if self.rowDisplayed > 1 and self.rowSelected == 1 then
			self.rowDisplayed = self.rowDisplayed - 1
			self.citizenSelected = self.citizenSelected - 1
		elseif self.rowSelected > 1 then
			self.rowSelected = self.rowSelected - 1
			self.citizenSelected = self.citizenSelected - 1
		end
	elseif controls:isDown(input) then
		if self.citizenSelected < table.getn(self.list) and self.rowSelected == 3 then
			self.rowDisplayed = self.rowDisplayed + 1
			self.citizenSelected = self.citizenSelected + 1
		elseif self.rowSelected < 3 then
			self.rowSelected = self.rowSelected + 1
			self.citizenSelected = self.citizenSelected + 1
		end
	end
end

function Tab.resetSelection(self)
	self.rowDisplayed = 1
	self.rowSelected = 1
	self.citizenSelected = 1
end
