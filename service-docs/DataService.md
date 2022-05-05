# AeroFramework

## DataService
DataService is a quite simple service, made with the purpose of being able to share data across scripts easily.  The service allows for real-time variable updating and syncing and is lightweight.
## Raw API:
The raw API contains base methods with their arguments.
| Method | Argument(s) | Notes |
|--|--|--|
| storeData | Key:String, Data:Any |
| getData | Key:String |
## DataService.storeData:
This method allows you to update data within the service, as seen above, this method is quite open about arguments.
```lua
local DataService = AeroFramework.getService("DataService")
DataService.storeData("key goes here",{"anything can go here"})
```
## DataService.getData:
This method allows you to read data from the service.  One thing to be wary of is that keys are case-sensitive.
```lua
local DataService = AeroFramework.getService("DataService")
print(DataService.getData("key goes here"))
```

---
[← Return to home page](https://madonox.github.io/AeroFramework/)
