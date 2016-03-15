require("lua/game/actions/killActionTab")
require("lua/game/actions/interrogateActionTab")
require("lua/game/actions/jailActionTab")
require("lua/game/actions/releaseActionTab")
require("lua/game/actions/endHuntAction")
require("lua/game/actions/canvasAction")
require("lua/game/actions/inspectCorpseActionTab")

ActPhase = {}
ActPhase.__index = ActPhase

setmetatable(ActPhase, {
  __index = ActPhase,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function ActPhase:_init()
	self.sfx = "menu"

	self.selections = {
		["back"]          = UIElement("back", 5, 560, "prayerAction", "back", "back", "confirm",
									  function() toState = game.preparationPhase end, "buttonBackground", "buttonHighlight", "Back", 10, 5),
		["confirm"]       = UIElement("confirm", 685, 560, "inspectCorpseAction", "confirm", "back", "confirm",
									  function() game.actPhase.readyToExecute = true end, "buttonBackground", "buttonHighlight", "Confirm", 10, 5),
		["killAction"]    = UIElement("killAction", 25, 150, "killAction", "canvasAction", "killAction", "interrogateAction",
									  function() game.actPhase.selectedTab = "killAction" end, "actionBackground", "actionHighlight", "Kill", 50, 40),
		["canvasAction"]  = UIElement("canvasAction", 25, 250, "killAction", "endHuntAction", "canvasAction", "jailAction",
									  function() local canvasAction = CanvasAction() if game.actPhase:canAddAction(canvasAction) then game.actPhase:addAction(canvasAction)	else end end, "actionBackground", "actionHighlight", "Canvas Town", 50, 40),
		["endHuntAction"] = UIElement("endHuntAction", 25, 350, "canvasAction", "prayerAction", "endHuntAction", "releaseAction",
									  function() local endHuntAction = EndHuntAction() if game.actPhase:canAddAction(endHuntAction) then game.actPhase:addAction(endHuntAction)	else end end, "actionBackground", "actionHighlight", "End Hunt", 50, 40),
		["interrogateAction"] = UIElement("interrogateAction", 400, 150, "interrogateAction", "jailAction", "killAction", "interrogateAction",
									  function() game.actPhase.selectedTab = "interrogateAction" end, "actionBackground", "actionHighlight", "Interrogate", 50, 40),
		["jailAction"] = UIElement("jailAction", 400, 250, "interrogateAction", "releaseAction", "canvasAction", "jailAction",
									  function() game.actPhase.selectedTab = "jailAction" end, "actionBackground", "actionHighlight", "Indict", 50, 40),
		["releaseAction"] = UIElement("releaseAction", 400, 350, "jailAction", "inspectCorpseAction", "endHuntAction", "releaseAction",
									  function() game.actPhase.selectedTab = "releaseAction" end, "actionBackground", "actionHighlight", "Release", 50, 40),

		["prayerAction"] = UIElement("prayerAction", 25, 450, "endHuntAction", "back", "prayerAction", "inspectCorpseAction",
									  function() game.actPhase.selectedTab = "" end, "actionBackground", "actionHighlight", "Pray", 50, 40),
		["inspectCorpseAction"] = UIElement("inspectCorpseAction", 400, 450, "releaseAction", "confirm", "prayerAction", "inspectCorpseAction",
									  function() game.actPhase.selectedTab = "inspectCorpseAction" end, "actionBackground", "actionHighlight", "Inspect Corpse", 50, 40),

	}
	self.selected = self.selections["confirm"]

	self.selectedTab = ""
	self.killActionTab = KillActionTab()
	self.interrogateActionTab = InterrogateActionTab()
	self.jailActionTab = JailActionTab()
	self.releaseActionTab = ReleaseActionTab()
	self.inspectCorpseActionTab = InspectCorpseActionTab()

	self.readyToExecute = false
	self.actionsToExecute = {}
	self.actionsTaken = 0
end

function ActPhase.new(self)

end

function ActPhase.draw(self)
	screen:drawPhaseBackground()

	screen:drawPortrait(10, 10, game.player)
	local xOffset = 138
	for i=1,game.player.actions do
		love.graphics.draw(images:getImage("unchecked"), xOffset, 10)
		xOffset = xOffset + images:getImage("unchecked"):getWidth()
	end
	xOffset = 138
	for i=1,self.actionsTaken do
		love.graphics.draw(images:getImage("checked"), xOffset, 10)
		xOffset = xOffset + images:getImage("checked"):getWidth()
	end

	for _,uiElement in pairs(self.selections) do
			if uiElement == self.selected then
				love.graphics.draw(images:getImage(uiElement.highlight), uiElement.x, uiElement.y)
			else
				love.graphics.draw(images:getImage(uiElement.image), uiElement.x, uiElement.y)
			end
			love.graphics.print(uiElement.text, uiElement.x + uiElement.textXOffset, uiElement.y + uiElement.textYOffset)
	end

	if self.selectedTab == "" then
		screen:drawCursor(self.selected.x, self.selected.y)
	elseif self.selectedTab == "killAction" then
		self.killActionTab:draw()
	elseif self.selectedTab == "interrogateAction" then
		self.interrogateActionTab:draw()
	elseif self.selectedTab == "jailAction" then
		self.jailActionTab:draw()
	elseif self.selectedTab == "releaseAction" then
		self.releaseActionTab:draw()
	elseif self.selectedTab == "inspectCorpseAction" then
		self.inspectCorpseActionTab:draw()
	end
end

function ActPhase.processControls(self, input)
	if self.selectedTab ~= "" then
		if controls:isBack(input) then
			self.selectedTab = ""
		elseif self.selectedTab == "killAction" then
			self.killActionTab:processControls(input)
		elseif self.selectedTab == "interrogateAction" then
			self.interrogateActionTab:processControls(input)
		elseif self.selectedTab == "jailAction" then
			self.jailActionTab:processControls(input)
		elseif self.selectedTab == "releaseAction" then
			self.releaseActionTab:processControls(input)
		elseif self.selectedTab == "inspectCorpseAction" then
			self.inspectCorpseActionTab:processControls(input)
		end
	else
		if controls:isLeft(input) then
			self.selected = self.selections[self.selected.left]
		elseif controls:isRight(input) then	
			self.selected = self.selections[self.selected.right]
		elseif controls:isUp(input) then
			self.selected = self.selections[self.selected.up]
		elseif controls:isDown(input) then
			self.selected = self.selections[self.selected.down]
		elseif controls:isConfirm(input) then
			if self.selected.name == "back" or self.selected.name == "confirm" then
				self.selected.confirm()
			elseif self.selected.cost <= game.player.actions - self.actionsTaken then
				self.selected.confirm()
			else
				--play error sound?
			end
		elseif controls:isBack(input) then
			local action = table.remove(self.actionsToExecute)
			self.actionsTaken = self.actionsTaken - action.cost
			-- play remove sound?
		end
		soundEffects:playSoundEffect(self.sfx)
	end
end

function ActPhase.keyreleased(self, key )
	--
end

function ActPhase.mousepressed(self, x, y, button)
	--
end

function ActPhase.update(self, dt)
	if self.readyToExecute then
		self.readyToExecute = false
		toState = game.resultsPhase

		game.town.day = game.town.day + 1
		--Go through each action selected and perform it
		for _,action in pairs(self.actionsToExecute) do
			action:act()
		end

		self.actionsToExecute = {}
		self.actionsTaken = 0
	end
end

function ActPhase.canAddAction(self, action)
	return action.cost <= game.player.actions - self.actionsTaken
end

function ActPhase.addAction(self, action)
	table.insert(self.actionsToExecute, action)
	self.actionsTaken = self.actionsTaken + action.cost
end
