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

function Save.save(self, town)
	local saveData = ""

	--Save generic town information
	saveData = saveData .. "TOWNNAME\t" .. town.name .. "\r\n"
	saveData = saveData .. "TOWNSIZE\t" .. town.townSize .. "\r\n"
	saveData = saveData .. "TOWNDAY\t" .. town.day .. "\r\n"

	--Save citizens
	saveData = saveData .. "CITIZENS\r\n"
	for k,citizen in pairs(town.citizens) do
		saveData = saveData .. citizen.name .. "\t" .. citizen.sex .. "\t" .. citizen.taint .. "\t" .. citizen.knows .. "\t"
		saveData = saveData .. citizen.face.faceShape .. "\t" .. citizen.face.eyes .. "\t" .. citizen.face.nose .. "\t" .. citizen.face.mouth .. "\t"
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

	local loadData = love.filesystem.lines(self.saveFilename)
	local loadCitizens = false
	local loadQuests = false
	local loadChecks = false

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
		elseif lineTokens[1] == "QUEST" then
			loadCitizens = false
			loadQuests = true
			loadChecks = false
		elseif lineTokens[1] == "QUESTEND" then
			table.insert(town.quests, currentQuest)
			currentQuest = nil

			loadCitizens = false
			loadQuests = false
			loadChecks = false
		elseif lineTokens[1] == "CHECKS" then
			loadCitizens = false
			loadQuests = false
			loadChecks = true
		else
			if loadCitizens then
				local citizen = Citizen()
				citizen.name = lineTokens[1]
				citizen.sex = tonumber(lineTokens[2])
				citizen.taint = tonumber(lineTokens[3])
				citizen.knows = tonumber(lineTokens[4])

				citizen.face = Face(tonumber(lineTokens[5]), tonumber(lineTokens[6]), tonumber(lineTokens[7]), tonumber(lineTokens[8]))

				local tokenIndex = 9
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
			end
		end
	end

	return town
end
