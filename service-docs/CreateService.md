# AeroFramework

## CreateService
CreateService is a basic service, made to provide simple and easy instance creation, as well as creating instances with custom classes bound to them.
## Raw API:

| Method | Argument(s) | Notes |
|--|--|--|
| Create | InstanceName:String, InstanceProperties:Table |
| Extends | Instance:Instance, Class:Table | The `class` supplied must contain a `.construct` method within it. |
## CreateService.Create:
Probably the most basic method within this framework, the `CreateService.Create` method.  This method will simply create an instance with the given properties supplied.  Below is an example:
```lua
local CreateService = AeroFramework.getService("CreateService")
local newInstance = CreateService.Create("Part",{
	Size = Vector3.new(1,1,1);
	Transparency = 0.5;
	CanCollide = false;
})
```
## CreateService.Extends:
This method allows you to construct a class with a given instance.  While this method may seem a bit useless, it contains checks within it, and will throw a warning instead of just erroring whenever an issue occurs.  Below is an example of usage:
```lua
local CreateService = AeroFramework.getService("CreateService")
local newInstance = CreateService.Create("Part",{
	Size = Vector3.new(1,1,1);
	Transparency = 0.5;
	CanCollide = false;
})
CreateService.Extends(newInstance,someClass) -- someClass must contain a .construct method.
```

---
[← Return to home page](https://madonox.github.io/AeroFramework/)
