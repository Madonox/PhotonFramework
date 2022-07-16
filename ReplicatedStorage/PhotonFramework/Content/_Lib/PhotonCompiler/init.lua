-- Madonox
-- 2022

local ImportManager = require(script:WaitForChild("ImportManager"))

local PhotonCompiler = {}
PhotonCompiler.Objects = {}

function PhotonCompiler:Initialize(container)
	self.Objects = container
end

function PhotonCompiler:RunScript(raw)
	if typeof(raw) == "table" then
		task.spawn(function()
			local success,err = pcall(function()
					raw:Run(ImportManager(self.Objects.Services.Container,raw.Imports))
			end)
			if not success then
				warn("PhotonScript execution error: "..err.."\n"..debug.traceback("Error traceback: "))
			end
		end)
	else
		warn("Invalid PhotonScript execution type.")
	end
end

return PhotonCompiler