
# AeroFramework

## SharedService
SharedService is a similar service to DataService, but allows for variable syncing.  In a nutshell, this service allows for the server to update variables on the client with ease.  Please note, this only works for server to clients, as otherwise it would be too big a security risk to add.
## Raw API:

| Method | Argument(s) | Notes |
|--|--|--|
| get | Key:String |
| update | Key:String, Value:Any | If called on the server, all clients will update their variable to this value.  However, if called on the client, only that client will update said value. |
## SharedService.get:
Returns the requested value.
```lua
local SharedService = AeroFramework.getService("SharedService")
print(SharedService.get("some key here"))
```
## SharedService.update:
This method allows you to update a value within the service.
```lua
local SharedService = AeroFramework.getService("SharedService")
SharedService.update("some key here","some value here")
```

---
[← Return to home page](https://madonox.github.io/AeroFramework/)
