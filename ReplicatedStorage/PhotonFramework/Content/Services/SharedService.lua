-- Madonox
-- 2022

local Service = {}
Service.Values = {}

function Service:UpdateValue(key:any,value:any)
	self.Values[key] = value
end

function Service:GetValue(key:any)
	return self.Values[key]
end

return Service