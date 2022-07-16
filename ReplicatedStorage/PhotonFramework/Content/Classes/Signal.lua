-- Madonox
-- 2022

local Class = {}
Class.__index = Class

function Class.new(Object)
	local self = setmetatable({},Class)
	self.Connections = {}
	self.Object = Object
	self.Object.Destroying:Connect(function()
		self:Destroy()
	end)
	return self
end

function Class:Connect(callback)
	table.insert(self.Connections,callback)
end
function Class:Fire(...)
	local wrapped = {...}
	for _,connection in self.Connections do
		local success,err = pcall(function()
			connection(table.unpack(wrapped))
		end)
		if not success then
			warn("PhotonFramework Signal error: "..err)
		end
	end
end
function Class:Destroy()
	if self.Object then
		self.Object:Destroy()
	end
	table.clear(self.Connections)
	table.clear(self)
	self = nil
	return nil
end

return Class