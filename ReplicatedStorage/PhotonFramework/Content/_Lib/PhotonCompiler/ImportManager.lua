-- Madonox
-- 2022

return function(sources:any,imports:any)
	local response = {}
	for name,data in sources do
		if table.find(imports,name) then
			response[name] = data
		end
	end
	return response
end