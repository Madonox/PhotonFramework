
# PhotonFramework

## Getting started:
In order to begin using PhotonFramework, you must firstly insert the model into `ReplicatedStorage`.  The model can be acquired [here](https://www.roblox.com/library/9520924964/PhotonFramework).  Once the model is inserted, we can begin to use it!

## Initializing the framework:
Once we have our model inserted, we will want to begin using it.  Before we can begin using it however, we must first start it.  This can be done quite simply, and a demo code bit is supplied below.
```lua
local PhotonFramework = require(game.ReplicatedStorage.PhotonFramework.Core)
PhotonFramework.start()
```
**Notice:** PhotonFramework must be started on **both** the client and server, or else unexpected behavior may occur.
## Executing code when the framework starts:
If you wish to bind code to when the framework starts, you can use the `onStart` method.  Below is an example.
```lua
local PhotonFramework = require(game.ReplicatedStorage.PhotonFramework.Core)
PhotonFramework.onStart(function()
	print("Framework started")
end)
```
**Notice: ** if this is called after the framework starts, it will simply execute the code directly.
## Creating your first PhotonScript:
PhotonScripts can be executed in two different ways.
The first way would be to create a `ModuleScript` inside of the PhotonFramework folder's `Scripts` folder.  These scripts are executed when the framework is started, and will be executed on both the server and client.  The module will look like this:
```lua
local PhotonScript = {}
PhotonScript.imports = {
	Services = {
		SharedService = true;  -- Bool value states if service should be imported.
	};
	Classes = {};
}

PhotonScript.run = function(importedServices,importedClasses)
	local sharedService = importedServices.SharedService
end

return PhotonScript
```

The second way of executing a script would be to call the function `PhotonFramework.executeRaw` function.  The basis is nearly the same, but instead of the table being contained inside of a module script, it is just directly supplied.  Below is a code example.
```lua
-- This code would be executed in either a ServerScript or LocalScript.
local rawPhotonScript = {}
rawPhotonScript.imports = {
	Services = {
		SharedService = true;  -- Bool value states if service should be imported.
	};
	Classes = {};
}
rawPhotonScript.run = function(importedServices,importedClasses)
	local sharedService = importedServices.SharedService
	return true
end

PhotonFramework.executeRaw(rawPhotonScript)
```
## Interacting with PhotonFramework outside of PhotonScripts:
In order to keep flexibility within the framework, services and classes can be used outside of the PhotonFramework environment.  In order to get a service, you would simply use the `PhotonFramework.getService` method, and to get a class, you would use the `PhotonFramework.getClass` method.  Please note, custom classes may be supplied to the framework, which can be accessed by PhotonScripts and the `getClass` method.

## Service Documentation:
PhotonFramework offers a plethora of services that you can use and interact with.  These services are documented below.

| Service Name | Documentation Link |
|--|--
| CreateService | [https://madonox.github.io/PhotonFramework/service-docs/CreateService](https://madonox.github.io/PhotonFramework/service-docs/CreateService) |
| DataService | [https://madonox.github.io/PhotonFramework/service-docs/DataService](https://madonox.github.io/PhotonFramework/service-docs/DataService) |
| NetworkService | [https://madonox.github.io/PhotonFramework/service-docs/NetworkService](https://madonox.github.io/PhotonFramework/service-docs/DataService) |
| ProcessService | [https://madonox.github.io/PhotonFramework/service-docs/ProcessService](https://madonox.github.io/PhotonFramework/service-docs/ProcessService) |
| SharedService | [https://madonox.github.io/PhotonFramework/service-docs/SharedService](https://madonox.github.io/PhotonFramework/service-docs/SharedService) |
| UIService | [https://madonox.github.io/PhotonFramework/service-docs/UIService](https://madonox.github.io/PhotonFramework/service-docs/UIService) |


---
[← Return to home page](https://madonox.github.io/PhotonFramework/)
