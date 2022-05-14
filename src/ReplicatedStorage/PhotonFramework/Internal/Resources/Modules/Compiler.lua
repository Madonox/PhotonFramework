-- Madonox
-- 2022

local Compiler = {}

function Compiler.init(services,classes)
	Compiler.services = services
	Compiler.classes = classes
	Compiler.init = nil
end

function Compiler.runScript(source,...)
	local compactArgs = {...}
	coroutine.wrap(function()
		local fenvData = {}
		local classData = {}
		local canRun = true
		for service,enabled in pairs(source.imports.Services) do
			if enabled == true then
				if Compiler.services[service] then
					fenvData[service] = Compiler.services[service]
				else
					warn("PhotonFramework compiler error: Cannot find service "..service)
					canRun = false
					break
				end
			end
		end
		for class,enabled in pairs(source.imports.Classes) do
			if enabled == true then
				if Compiler.classes[class] then
					classData[class] = Compiler.classes[class]
				else
					warn("PhotonFramework compiler error: Cannot find class "..class)
					canRun = false
					break
				end
			end
		end
		if canRun == true then
			local success,err = pcall(function()
				source.run(fenvData,classData,table.unpack(compactArgs))
			end)
			if not success then
				warn("PhotonFramework script execution error: "..err)
			end
		end
	end)()
end

return Compiler