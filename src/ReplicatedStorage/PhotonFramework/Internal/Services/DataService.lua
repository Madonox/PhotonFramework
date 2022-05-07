-- Madonox
-- 2022

local service = {}
service.variables = {}
service.storedData = {}

function service.storeData(key,value)
	service.storedData[key] = value
end
function service.getData(key)
	return service.storedData[key]
end

return service