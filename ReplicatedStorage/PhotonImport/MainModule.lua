-- Madonox
-- 2022

-- Used to import / get PhotonFramework.  Checks if it exists already, etc.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService = game:GetService("InsertService")

return function()
	if ReplicatedStorage:FindFirstChild("PhotonFramework") then
		return require(ReplicatedStorage:WaitForChild("PhotonFramework"):WaitForChild("PhotonFramework")),true
	else
		local model
		local success,err = pcall(function()
			model = InsertService:LoadAsset(9520924964)
		end)
		
		if not success then
			error("Failed to get PhotonFramework.  Error: "..err)
			return nil,false
		end
		
		if model then
			local req = require(model:WaitForChild("PhotonFramework"):WaitForChild("PhotonFramework"))
			model:WaitForChild("PhotonFramework").Parent = ReplicatedStorage
			req:Start()
			model:Destroy()
			return req,false
		end
	end
end