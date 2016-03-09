function split(sourceString, pattern)
	local tokens = {}
 	for k, v in string.gmatch(sourceString, pattern) do
		table.insert(tokens, k)
 	end
	return tokens
end

function filter(func, oldTable)
	local newTable = {}
	for _,value in pairs(oldTable) do
		if func(value) then
			table.insert(newTable, value)
		end
	end
	return newTable
end
