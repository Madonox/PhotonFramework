-- Madonox
-- 2022

local PhotonFramework = {}
PhotonFramework._internal = {}
PhotonFramework.running = false
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

function PhotonFramework.start()
	if PhotonFramework.running == false then
		PhotonFramework.running = true
		local services = import(script.Parent.Internal.Services,"init",false)
		local classes = import(script.Parent.Internal.Classes,"init",false,services)
		local resources = {}
		for _,resourceContainer in ipairs(script.Parent.Internal.Resources:GetChildren()) do
			resources[resourceContainer.Name] = import(resourceContainer,"init",false,services,classes)
		end
		
		local externalClasses = import(script.Parent.Classes,"init",false,services)
		
		PhotonFramework._internal.services = services
		PhotonFramework._internal.classes = {table.unpack(classes),table.unpack(externalClasses)}
		PhotonFramework._internal.resources = resources
		
		for _,scr in ipairs(script.Parent.Scripts:GetChildren()) do
			PhotonFramework.registerScript(scr)
		end
		
		if RunService:IsServer() then
			local UpdateData = require(9040261328) -- Check for updates in framework.
			if UpdateData.getData("PhotonFramework",script.Parent.Internal.Resources.Build.Value) == false then
				warn("PhotonFramework is out-of-date!  Please see the DevForum post and download the latest version as soon as possible!")
			end
		else
			script.Parent.Internal.Resources.Build:Destroy()
		end
	end
end

function PhotonFramework.registerScript(ins)
	if PhotonFramework.running == true then
		if ins:IsA("ModuleScript") then
			local req = require(ins)
			if typeof(req) == "table" then
				if req.run and req.imports then
					PhotonFramework._internal.resources.Modules.Compiler.runScript(req)
				end
			end
		end
	else
		warn("Cannot execute PhotonScript, PhotonFramework is not running.")
	end
end
function PhotonFramework.executeRaw(data)
	if PhotonFramework.running == true then
		if typeof(data) == "table" then
			if data.run and data.imports then
				PhotonFramework._internal.resources.Modules.Compiler.runScript(data)
			end
		end
	else
		warn("Cannot execute PhotonScript, PhotonFramework is not running.")
	end
end

function PhotonFramework.getService(name)
	if PhotonFramework.running == true then
		if PhotonFramework._internal.services[name] then
			return PhotonFramework._internal.services[name]
		else
			warn("Cannot find service "..name..".")
		end
	else
		warn("Cannot get service, PhotonFramework is not running.")
	end
end

function PhotonFramework.getClass(name)
	if PhotonFramework.running == true then
		if PhotonFramework._internal.classes[name] then
			return PhotonFramework._internal.classes[name]
		else
			warn("Cannot find class "..name..".")
		end
	else
		warn("Cannot get service, PhotonFramework is not running.")
	end
end

return PhotonFramework