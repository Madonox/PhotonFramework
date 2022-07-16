-- Madonox
-- 2022

local Service = {}

function Service:Create(ClassName:string,Properties:any,Callback)
	local object = Instance.new(ClassName)
	for property,value in Properties do
		object[property] = value
	end
	if Callback then
		Callback(object)
	end
	return object
end

return Service