-- Madonox
-- 2022

local AeroScript = {}

AeroScript.imports = { -- List of imported services.
	Services = {
		DataService = true;
	};
	
	Classes = {
		Variable = true;
	};
}

AeroScript.run = function(importedServices,importedClasses)
	local DataService = importedServices.DataService
	
	DataService.storeData("key goes here",true)
	task.delay(3,function()
		DataService.storeData("key goes here",false)
	end)
	task.delay(5,function()
		print(DataService.getData("key goes here"))
	end)
end

return AeroScript
