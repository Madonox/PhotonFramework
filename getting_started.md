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

---
[← Return to home page](https://madonox.github.io/AeroFramework/)
