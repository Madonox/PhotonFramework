-- Madonox
-- 2022

local random = math.random

local Service = {}
Service.Generated = {}

local characters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",1,2,3,4,5,6,7,8,9,0}
local length = #characters

function Service:GenerateUUID(Length:number)
	local response = ""
	for i=1,Length do
		response = response..characters[random(1,length)]
	end
	if self.Generated[response] then
		response = self:GenerateUUID(Length)
	else
		table.insert(self.Generated,response)
	end
	return response
end

function Service:GenerateUUIDCustomCharacters(Length:number,CharacterList:any)
	if typeof(CharacterList) == "table" then
		local response = ""
		local localLength = #CharacterList
		for i=1,Length do
			response = response..CharacterList[random(1,localLength)]
		end
		if self.Generated[response] then
			response = self:GenerateUUIDCustomCharacters(Length,CharacterList)
		else
			table.insert(self.Generated,response)
		end
		return response
	else
		warn("Invalid CharacterList, list must be a table.")
	end
end

return Service