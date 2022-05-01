-- Madonox
-- 2022

local service = {}
service.variables = {}
service.networkConnections = {}
local RunService = game:GetService("RunService")

function service.init()
	if RunService:IsServer() then
		service.variables.remoteEvent = Instance.new("RemoteEvent")
		service.variables.remoteEvent.Name = "NetworkEvent"
		service.variables.remoteEvent.Parent = script.Parent.Parent.Resources.ResourceDump
		service.variables.remoteEvent.OnServerEvent:Connect(function(player,method,...)
			if service.networkConnections[method] then
				service.networkConnections[method](player,...)
			end
		end)
	else
		service.variables.remoteEvent = script.Parent.Parent.Resources.ResourceDump:WaitForChild("NetworkEvent")
		service.variables.remoteEvent.OnClientEvent:Connect(function(method,...)
			if service.networkConnections[method] then
				service.networkConnections[method](...)
			end
		end)
	end
	service.init = nil
end

function service.bind(methodName,callback)
	if not service.networkConnections[methodName] then
		service.networkConnections[methodName] = callback
	else
		warn("Cannot overwrite network methods, name: "..methodName)
	end
end

function service.fire(...)
	local args = {...}
	if RunService:IsServer() then
		if typeof(args[1]) == "table" then
			for _,player in ipairs(args[1]) do
				service.variables.remoteEvent:FireClient(player,table.unpack(args,2))
			end
		else
			service.variables.remoteEvent:FireClient(args[1],table.unpack(args,2))
		end
	else
		service.variables.remoteEvent:FireServer(table.unpack(args,2))
	end
end

return service