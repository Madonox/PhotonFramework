# AeroFramework

## Getting started:
In order to begin using AeroFramework, you must firstly insert the model into `ReplicatedStorage`.  The model can be acquired [here](https://www.roblox.com/library/9520924964).  Once the model is inserted, we can begin to use it!

## Initializing the framework:
Once we have our model inserted, we will want to begin using it.  Before we can begin using it however, we must first start it.  This can be done quite simply, and a demo code bit is supplied below.
```lua
local AeroFramework = require(game.ReplicatedStorage.AeroFramework.Core)
AeroFramework.start()
```
**Notice:** AeroFramework must be started on **both** the client and server, or else unexpected behavior may occur.
## Creating your first AeroScript:
AeroScripts can be executed in two different ways.
The first way would be to create a `ModuleScript` inside of the AeroFramework folder's `Scripts` folder.  These scripts are executed when the framework is started, and will be executed on both the server and client.  The module will look like this:
```lua
local AeroScript = {}
AeroScript.imports = {
	Services = {
		SharedService = true;  -- Bool value states if service should be imported.
	};
	Classes = {};
}

AeroScript.run = function(importedServices,importedClasses)
	local sharedService = importedServices.SharedService
end

return AeroScript
```

The second way of executing a script would be to call the function `AeroFramework.executeRaw` function.  The basis is nearly the same, but instead of the table being contained inside of a module script, it is just directly supplied.  Below is a code example.
```lua
-- This code would be executed in either a ServerScript or LocalScript.
local rawAeroScript = {}
rawAeroScript.imports = {
	Services = {
		SharedService = true;  -- Bool value states if service should be imported.
	};
	Classes = {};
}
rawAeroScript.run = function(importedServices,importedClasses)
	local sharedService = importedServices.SharedService
	return true
end

AeroFramework.executeRaw(rawAeroScript)
```
## Interacting with AeroFramework outside of AeroScripts:
In order to keep flexibility within the framework, services and classes can be used outside of the AeroFramework environment.  In order to get a service, you would simply use the `AeroFramework.getService` method, and to get a class, you would use the `AeroFramework.getClass` method.  Please note, custom classes may be supplied to the framework, which can be accessed by AeroScripts and the `getClass` method.

## Service Documentation:
AeroFramework offers a plethora of services that you can use and interact with.  These services are documented below.
| Service Name | Documentation Link |
|--|--|
| `CreateService` |  |
| `DataService` |  |
| `NetworkService` |  |
| `ProcessService` |  |
| `SharedService` |  |
| `UIService` |  |


---
[← Return to home page](https://madonox.github.io/AeroFramework/)
