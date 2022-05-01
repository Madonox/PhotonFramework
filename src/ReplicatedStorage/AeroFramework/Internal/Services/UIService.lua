-- Madonox
-- 2022

local service = {}
service.variables = {}

local RunService = game:GetService("RunService")

local function localCreate(ins,properties)
	local i = Instance.new(ins)
	for property,value in pairs(properties) do
		i[property] = value
	end
	return i
end

--[[
CreateAspect demo:
CreateAspect("Frame",{
	Properties = {
	BackgroundColor3, etc
	};
	
	Connections = {
		MouseEnter, etc
	};
	
	Children = {
		Child instances.
	};
})
]]

function service.CreateAspect(ElementName,data)
	local uiInstance = localCreate(ElementName,data.Properties)
	for connectionName,callback in pairs(data.Connections) do
		uiInstance[connectionName]:Connect(callback)
	end
	
	for _,child in ipairs(data.Children) do
		child.Parent = uiInstance
	end
	return uiInstance
end

function service.createNode(GuiType,properties)
	local gui = localCreate(GuiType,properties)
	return gui
end

function service.constructNode(Node,parent)
	if RunService:IsServer() then
		Node.Parent = script.Parent.Parent.Resources.ResourceDump
		service.variables.remoteEvent:FireAllClients(Node,parent or "local")
	else
		Node.Parent = parent or game.Players.LocalPlayer.PlayerGui
		return Node
	end
end

function service.init()
	if RunService:IsServer() then
		service.variables.remoteEvent = localCreate("RemoteEvent",{
			Name = "Replicate_UIService";
			Parent = script.Parent.Parent.Resources.ResourceDump;
		})
	else
		local localPlayer = game.Players.LocalPlayer
		script.Parent.Parent.Resources.ResourceDump:WaitForChild("Replicate_UIService").OnClientEvent:Connect(function(gui,parent)
			if parent == "local" then
				gui.Parent = localPlayer.PlayerGui
			else
				gui.Parent = parent
			end
		end)
	end
	
	service.init = nil
end

return service