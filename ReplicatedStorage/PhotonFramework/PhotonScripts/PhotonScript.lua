-- Madonox
-- 2022

local PhotonScript = {}

PhotonScript.Imports = {
	"InstanceService";
}

function PhotonScript:Run(imports)
	local InstanceService = imports.InstanceService
	
	InstanceService:Create("Part",{
		Anchored = true;
		Material = Enum.Material.Neon;
		Parent = workspace;
	},function(part)
		while task.wait() do
			part.CFrame = part.CFrame*CFrame.Angles(0,math.rad(1),0)
		end
	end)
end

return PhotonScript