
# AeroFramework

## NetworkService
NetworkService is a service made to make server-client communication simple, easy, and secure.  While the framework handles all the backend work and security, you can begin to easily create methods and setup many connections in minutes.
## Raw API:

| Method | Argument(s) | Notes |
|--|--|--|
| bind | MethodName:String, Callback:Function |
| fire | Target(s):Instance/String, Method:String, ... | The `target` method is only used when the server is firing a client method, and the `...` represents arguments to pass.  If you wish to fire multiple targets at once, supply a table instead of an instance for the `target` argument. |
## NetworkService.bind:
This method allows you to create a binding under NetworkService, whether that be on the server or client.  These allow the other end to communicate to and from.
```lua
local NetworkService = AeroFramework.getService("NetworkService")
NetworkService.bind("method name here",function(player,other_arguments,etc,etc2)
	-- Please note, the player argument will only be supplied if the binding is server-sided.
	-- Do stuff here.
end)
```
## NetworkService.fire:
This method lets you trigger a binding, either on the server or client.  
```lua
local NetworkService = AeroFramework.getService("NetworkService")
local argument_3 = 123
NetworkService.fire(game.Players.SomePlayer,"method name here","argument 1",{"argument 2"},argument_3)
--[[Notice:
You only need to supply a player or table of players if your calling the fire method on the server.
]]
```

---
[← Return to home page](https://madonox.github.io/AeroFramework/)
