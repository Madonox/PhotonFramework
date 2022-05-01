-- Madonox
-- 2022

local service = {}

function service.Create(ins,properties)
	local i = Instance.new(ins)
	for property,value in pairs(properties) do
		i[property] = value
	end
	return i
end

function service.Extends(ins,class)
	if typeof(class) == "table" then
		if class.construct then
			return class.construct(ins)
		else
			warn("Supplied class does not contain a construct function.")
		end
	else
		warn("Supplied class is not a table.")
	end
end

return service