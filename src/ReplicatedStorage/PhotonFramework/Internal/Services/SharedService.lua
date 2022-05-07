-- Madonox
-- 2022

local RunService = game:GetService("RunService")
local replicationRemote = script.Parent.Parent.Remotes.UpdateShared

local service = {}
service.variables = {}

function service.get(key)
	return service.variables[key]
end
function service.init()
	if RunService:IsClient() then
		replicationRemote.OnClientEvent:Connect(function(key,value)
			service.variables[key] = value
		end)
		service.variables = script.Parent.Parent.Remotes.GetShared:InvokeServer()
	else
		script.Parent.Parent.Remotes.GetShared.OnServerInvoke = function(player)
			return service.variables
		end
	end
	service.init = nil
end
function service.update(key,value)
	if RunService:IsServer() then
		service.variables[key] = value
		replicationRemote:FireAllClients(key,value)
	else
		service.variables[key] = value
	end
end

return service