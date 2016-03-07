require("lua/utils")

Save = {}
Save.__index = Save

setmetatable(Save, {
  __index = Save,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Save:_init(saveFile)
	self.saveFilename = saveFile
end

function Save.save(self, town, player)
	local saveData = ""

	--Save generic town information
	saveData = saveData .. "TOWNNAME\t" .. town.name .. "\r\n"
	saveData = saveData .. "TOWNSIZE\t" .. town.townSize .. "\r\n"
	saveData = saveData .. "TOWNDAY\t" .. town.day .. "\r\n"

	--Save Player stats
	saveData = saveData .. "PLAYER\r\n"
	saveData = saveData .. player.name .. "\t" .. player.sex .. "\t" .. player.taint .. "\t" .. player.knows .. "\t"
	saveData = saveData .. player.face.head .. "\t" .. player.face.eyes .. "\t" .. player.face.mouth .. "\t" .. player.face.hair .. "\t" .. player.face.accessories .. "\t"
	for k,v in pairs(skills) do
		saveData = saveData .. player.skills[k] .. "\t"
	end
	saveData = saveData .. player.actions .. "\t" .. player.taintedKilled .. "\t" .. player.agentsKilled .. "\t" .. player.innocentsKilled
	saveData = saveData .. "\r\n"

	--Save citizens
	saveData = saveData .. "CITIZENS\r\n"
	for k,citizen in pairs(town.citizens) do
		saveData = saveData .. citizen.name .. "\t" .. citizen.sex .. "\t" .. citizen.taint .. "\t" .. citizen.knows .. "\t" .. citizen.suspicious .. "\t"
		saveData = saveData .. citizen.face.head .. "\t" .. citizen.face.eyes .. "\t" .. citizen.face.mouth .. "\t" .. citizen.face.hair .. "\t" .. citizen.face.accessories .. "\t"

		for k,v in pairs(skills) do
			saveData = saveData .. citizen.skills[k] .. "\t"
		end
		saveData = saveData .. "\r\n"
	end

	--Save active quests
	for k,quest in pairs(town.quests) do
		saveData = saveData .. "QUEST\r\n"
		saveData = saveData .. quest.name .. "\t" .. quest.giver .. "\t" .. quest.dueDate .. "\r\n"

		saveData = saveData .. "CHECKS\r\n"
		for k, check in pairs(quest.checksToPass) do
			saveData = saveData .. check.skill .. "\t" .. check.difficulty .. "\r\n"
		end
		saveData = saveData .. "QUESTEND\r\n"
	end

	love.filesystem.write(self.saveFilename, saveData)
end


function Save.load(self)
	local town = Town()
	local player = Player()

	local loadData = love.filesystem.lines(self.saveFilename)
	local loadCitizens = false
	local loadQuests = false
	local loadChecks = false
	local loadPlayer = false

	local currentQuest = nil

	for line in loadData do
		local lineTokens = split(line, "[^\t]+")
		if lineTokens[1] == "TOWNNAME" then
			town.name = lineTokens[2]
		elseif lineTokens[1] == "TOWNSIZE" then
			town.townSize = tonumber(lineTokens[2])
		elseif lineTokens[1] == "TOWNDAY" then
			town.day = tonumber(lineTokens[2])
		elseif lineTokens[1] == "CITIZENS" then
			loadCitizens = true
			loadQuests = false
			loadChecks = false
			loadPlayer = false
		elseif lineTokens[1] == "QUEST" then
			loadCitizens = false
			loadQuests = true
			loadChecks = false
			loadPlayer = false
		elseif lineTokens[1] == "QUESTEND" then
			table.insert(town.quests, currentQuest)
			currentQuest = nil

			loadCitizens = false
			loadQuests = false
			loadChecks = false
			loadPlayer = false
		elseif lineTokens[1] == "CHECKS" then
			loadCitizens = false
			loadQuests = false
			loadChecks = true
			loadPlayer = false
		elseif lineTokens[1] == "PLAYER" then
			loadCitizens = false
			loadQuests = false
			loadChecks = false
			loadPlayer = true
		else
			if loadCitizens then
				local citizen = Citizen()
				citizen.name = lineTokens[1]
				citizen.sex = tonumber(lineTokens[2])
				citizen.taint = tonumber(lineTokens[3])
				citizen.knows = tonumber(lineTokens[4])
				citizen.suspicious = tonumber(lineTokens[5])

				citizen.face = Face(tonumber(lineTokens[6]), tonumber(lineTokens[7]), tonumber(lineTokens[8]), tonumber(lineTokens[9]), tonumber(lineTokens[10]))

				local tokenIndex = 11
				for k,v in pairs(skills) do
					citizen.skills[k] = tonumber(lineTokens[tokenIndex])
					tokenIndex = tokenIndex + 1
				end

				table.insert(town.citizens, citizen)
			elseif loadQuests then
				currentQuest = Quest()
				currentQuest.name = lineTokens[1]
				currentQuest.giver = tonumber(lineTokens[2])
				currentQuest.dueDate = tonumber(lineTokens[3])
			elseif loadChecks then
				local check = Check()
				check.skill = lineTokens[1]
				check.difficulty = tonumber(lineTokens[2])

				table.insert(currentQuest.checksToPass, check)
			elseif loadPlayer then
				player.name = lineTokens[1]
				player.sex = tonumber(lineTokens[2])
				player.taint = tonumber(lineTokens[3])
				player.knows = tonumber(lineTokens[4])

				player.face = Face(tonumber(lineTokens[5]), tonumber(lineTokens[6]), tonumber(lineTokens[7]), tonumber(lineTokens[8]), tonumber(lineTokens[9]))

				local tokenIndex = 10
				for k,v in pairs(skills) do
					player.skills[k] = tonumber(lineTokens[tokenIndex])
					tokenIndex = tokenIndex + 1
				end

				player.actions = tonumber(lineTokens[tokenIndex])
				player.taintedKilled = tonumber(lineTokens[tokenIndex+1])
				player.agentsKilled = tonumber(lineTokens[tokenIndex+2])
				player.innocentsKilled = tonumber(lineTokens[tokenIndex+3])
			end
		end
	end

	return town, player
end
