-- Madonox
-- 2022

local AeroScript = {}

AeroScript.imports = { -- List of imported services.
	Services = {
		SharedService = true;
	};
	
	Classes = {
		Variable = true;
	};
}

AeroScript.run = function(importedServices,importedClasses)
	local SharedService = importedServices.SharedService
	
	SharedService.update("DemoValue",true)
	print(SharedService.get("DemoValue"))
	
	local var = importedClasses.Variable.new("test",function()
		print("called")
	end)
	var()
	var.ValueChanged:Connect(function(oldValue,newValue)
		print(oldValue)
		print(newValue)
	end)
	var:SetValue("test 2")
end

return AeroScript