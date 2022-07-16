-- Madonox
-- 2022

local Service = {}
Service._Imported = {}
Service._allowedClasses = {
	"ScreenGui";
	"BillboardGui";
	"SurfaceGui";
}

function Service:Initialize(PhotonFramework)
	Service._Imported.InstanceService = PhotonFramework.Services:GetService("InstanceService")
end

function Service:Create(ClassType:string)
	if table.find(self._allowedClasses,ClassType) then
		return {
			Container = Instance.new(ClassType);
			Objects = {};
		}
	else
		return nil
	end
end

function Service:Object(object:string,properties:any,children:any,connections:any,callback:any)
	if properties then
		local obj = self._Imported.InstanceService:Create(object,properties)
		
		if connections then
			for connection,callback in connections do
				obj[connection]:Connect(callback)
			end
		end
		if children then
			for _,child in children do
				child.Parent = obj
			end
		end
		if callback then
			local success,err = pcall(function()
				callback(obj)
			end)
			if not success then
				warn("PhotonFramework UIService error: Method: Object, callback property.  Error: "..err)
			end
		end

		return obj
	else
		warn("Cannot create object "..object..".  No properties defined.")
		return nil
	end
end

function Service:Add(object:Instance,tree:any)
	object.Parent = tree.Container
	table.insert(tree.Objects,object)
end

function Service:Render(container:Instance,tree:any)
	tree.Container.Parent = container
	return tree
end

return Service