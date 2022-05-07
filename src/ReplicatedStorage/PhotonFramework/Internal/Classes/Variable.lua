-- Madonox
-- 2022

local class = {}

local signalClass = require(script.Parent.Signal)

function class.init(services)
	class.services = services
end

function class.new(value,variableCallback)
	local self = setmetatable({},{
		__index = class;
		__call = variableCallback;
	})
	
	self.ValueChanged = signalClass.new()
	self.Value = value
	return self
end

function class:SetValue(value)
	local oldValue = self.Value
	rawset(self,"Value",value)
	self.ValueChanged:Fire(oldValue,value)
end

return class