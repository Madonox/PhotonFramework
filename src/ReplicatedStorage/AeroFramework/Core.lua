-- Madonox
-- 2022

local AeroFramework = {}
AeroFramework._internal = {}
AeroFramework.running = false
local RunService = game:GetService("RunService")

local function import(dir,startFunction,isNameLower,...)
	local res = {}
	for _,module in ipairs(dir:GetChildren()) do
		if module:IsA("ModuleScript") then
			local req = require(module)
			if typeof(req) == "table" then
				if req[startFunction] then
					req[startFunction](...)
				end
			end
			if isNameLower == true then
				res[string.lower(module.Name)] = req
			else
				res[module.Name] = req
			end
		end
	end
	return res
end

function AeroFramework.start()
	if AeroFramework.running == false then
		AeroFramework.running = true
		local services = import(script.Parent.Internal.Services,"init",false)
		local classes = import(script.Parent.Internal.Classes,"init",false,services)
		local resources = {}
		for _,resourceContainer in ipairs(script.Parent.Internal.Resources:GetChildren()) do
			resources[resourceContainer.Name] = import(resourceContainer,"init",false,services,classes)
		end
		
		local externalClasses = import(script.Parent.Classes,"init",false,services)
		
		AeroFramework._internal.services = services
		AeroFramework._internal.classes = {table.unpack(classes),table.unpack(externalClasses)}
		AeroFramework._internal.resources = resources
		
		for _,scr in ipairs(script.Parent.Scripts:GetChildren()) do
			AeroFramework.registerScript(scr)
		end
	end
end

function AeroFramework.registerScript(ins)
	if AeroFramework.running == true then
		if ins:IsA("ModuleScript") then
			local req = require(ins)
			if typeof(req) == "table" then
				if req.run and req.imports then
					AeroFramework._internal.resources.Modules.Compiler.runScript(req)
				end
			end
		end
	else
		warn("Cannot execute AeroScript, AeroFramework is not running.")
	end
end
function AeroFramework.executeRaw(data)
	if AeroFramework.running == true then
		if typeof(data) == "table" then
			if data.run and data.imports then
				AeroFramework._internal.resources.Modules.Compiler.runScript(data)
			end
		end
	else
		warn("Cannot execute AeroScript, AeroFramework is not running.")
	end
end

function AeroFramework.getService(name)
	if AeroFramework.running == true then
		if AeroFramework._internal.services[name] then
			return AeroFramework._internal.services[name]
		else
			warn("Cannot find service "..name..".")
		end
	else
		warn("Cannot get service, AeroFramework is not running.")
	end
end

function AeroFramework.getClass(name)
	if AeroFramework.running == true then
		if AeroFramework._internal.classes[name] then
			return AeroFramework._internal.classes[name]
		else
			warn("Cannot find class "..name..".")
		end
	else
		warn("Cannot get service, AeroFramework is not running.")
	end
end

return AeroFramework
