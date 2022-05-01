-- Madonox
-- 2022

local class = {}
class.__index = class

function class.new()
	local self = setmetatable({},class)
	self.connections = {}
	return self
end

function class:Fire(...)
	for _,connection in ipairs(self.connections) do
		connection(...)
	end
end
function class:Connect(callback)
	table.insert(self.connections,callback)
	local ref = table.find(self.connections,callback)
	return function()
		table.remove(self.connections,ref)
	end
end
function class:Destroy()
	table.clear(self.connections)
	table.clear(self)
end

return class