-- Madonox
-- 2022

local RunService = game:GetService("RunService")

local PhotonFramework = {}
PhotonFramework.Started = false
PhotonFramework.Objects = {}
PhotonFramework.Services = {}
PhotonFramework._internal = {}
PhotonFramework._constants = {}

PhotonFramework.Services.Container = {}
PhotonFramework.Objects.Container = {}
PhotonFramework.Objects.Container.Classes = {}
PhotonFramework.Objects.Container.Registry = {}
PhotonFramework.Objects.Container.Scripts = {}
PhotonFramework.Objects.Container._Lib = {}

PhotonFramework._internal.library = {}

function PhotonFramework:Start()
	if not PhotonFramework.Started then
		PhotonFramework.Started = true
		local Content = script.Parent:WaitForChild("Content")
		
		self._constants = require(Content:WaitForChild("Constants"))
		
		local ConstructedServices = {}
		
		for _,service in Content:WaitForChild("Services"):GetChildren() do
			table.insert(ConstructedServices,{ConstructedServices,self.Services:CreateService(service.Name,require(service),true),service.Name})
		end
		for _,class in Content:WaitForChild("Classes"):GetChildren() do
			self.Objects:NewClass(class.Name,require(class))
		end
		
		for _,service in script.Parent:WaitForChild("PhotonServices"):GetChildren() do -- Load custom services before, to allow for easy customization of internal aspects.
			table.insert(ConstructedServices,{ConstructedServices,self.Services:CreateService(service.Name,require(service),true),service.Name})
		end
		
		for _,service in ConstructedServices do -- Internal services need to be started after all have been imported, as some rely on eachother.
			if service[1].Initialize then
				local success,err = pcall(function()
					service[1]:Initialize(self)
				end)
				PhotonFramework.Services.Container[service[2]].Initialize = nil
			end
		end
		
		for _,lib in Content:WaitForChild("_Lib"):GetChildren() do
			local req = require(lib)
			if req.Initialize then
				req:Initialize(PhotonFramework)
			end
			self.Objects.Container._Lib[lib.Name] = require(lib)
		end
		
		for _,src in script.Parent:WaitForChild("PhotonScripts"):GetChildren() do
			if src:IsA("ModuleScript") then
				self.Objects:RunScript(src)
			else
				warn(src.Name.." is not a module script.")
			end
		end
		
		table.clear(ConstructedServices)
		
		if require(9040261328).getData("PhotonFramework",self._constants.InternalBuild) == false then
			warn("PhotonFramework is out-of-date!  Please visit the devforum post and update PhotonFramework to the latest build!")
		end
	end
end

function PhotonFramework:_checkExecutionAbility(method)
	if not PhotonFramework.Started then
		warn("Cannot execute method "..method..", PhotonFramework is not started.")
		return nil
	end
end

function PhotonFramework.Services:GetService(ServiceName:string)
	PhotonFramework:_checkExecutionAbility("GetService")
	local service = self.Container[ServiceName]
	
	if service then
		return service
	else
		warn("Could not find a service by the name of "..ServiceName..".")
	end
end

function PhotonFramework.Services:CreateService(ServiceName:string,Service:any,BootState)
	PhotonFramework:_checkExecutionAbility("CreateService")
	
	if not self.Container[ServiceName] and typeof(Service) == "table" then
		if BootState ~= true then
			if Service.Initialize then
				local success,err = pcall(function()
					Service.Initialize(self)
				end)
				Service.Initialize = nil
				if not success then
					warn("Failed to properly call Initialize function for service "..ServiceName..".  Error: "..err)
				end
			end
		end
		
		self.Container[ServiceName] = Service
		return self.Container[ServiceName]
	else
		warn("There is a service with the name of "..ServiceName.." already.")
	end
end

function PhotonFramework.Objects:_getObject(object)
	if not self.Container.Registry[object] then
		self.Container.Registry[object] = {
			CurrentClass = nil;
		}
	end
	return self.Container.Registry[object]
end

function PhotonFramework.Objects:RunScript(Module:ModuleScript?)
	PhotonFramework:_checkExecutionAbility("RunScript")
	self.Container._Lib.PhotonCompiler:RunScript(require(Module))
end

function PhotonFramework.Objects:RunRaw(Data:any)
	PhotonFramework:_checkExecutionAbility("RunRaw")
	
	self.Container._Lib.PhotonCompiler:Run(Data)
end

function PhotonFramework.Objects:NewClass(ClassName:string,Class:any)
	PhotonFramework:_checkExecutionAbility("NewClass")
	
	if not self.Container.Classes[ClassName] and typeof(Class) == "table" then
		if Class.new then
			self.Container.Classes[ClassName] = Class
		else
			warn("Class "..ClassName.." does not contain a new function to create new objects.")
		end
	else
		warn("There is a class with the name of "..ClassName.." already.")
	end
end

function PhotonFramework.Objects:GetClass(ClassName)
	PhotonFramework:_checkExecutionAbility("GetClass")
	local data = self.Container.Classes[ClassName]
	
	if data then
		return data
	else
		warn("Could not find a class by the name of "..ClassName..".")
	end
end

function PhotonFramework.Objects:AssignClass(Object:Instance,ClassName:string)
	PhotonFramework:_checkExecutionAbility("AssignClass")
	
	local data = self:_getObject(Object)
	local class = self:GetClass(ClassName)
	
	if data then
		if data.CurrentClass ~= nil then
			warn("Cannot assign class to "..Object:GetFullName()..".  Object already has a class.")
		else
			if class then
				local new = class.new(Object)
				self.Container.Registry[Object].CurrentClass = new
				return new
			end
		end
	end
end

function PhotonFramework.Objects:GetObjectClass(Object:Instance)
	self:_checkExecutionAbility("GetObjectClass")
	
	local data = self:_getObject(Object)
	
	if data then
		return data.CurrentClass
	end
end

return PhotonFramework