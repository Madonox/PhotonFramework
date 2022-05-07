
# AeroFramework

## ProcessService
ProcessService is an advanced service made to make executing multiple functions easy.  In the service's current state, it does not offer much functionality, but with later updates, it should offer much more functionality.
## Raw API:

| Method | Argument(s) | Notes |
|--|--|--|
| compileFunctions | FunctionsArray:Table |Each entry in the table must be a function.
| executeFunctions | CompiledFunctionsArray:Table,... |The `...` represents supplied arguments.
## ProcessService.compileFunctions:
This method allows you to compile functions for execution.
```lua
local ProcessService = AeroFramework.getService("ProcessService")
local compiledFunctions = ProcessService.compileFunctions({
	function(argument_1,arg2)
		print(argument_1,arg2)
	end;
	function(...)
		print(...)
	end;
})
```
## ProcessService.executeFunctions:
This method allows you to execute compiled functions.
```lua
local ProcessService = AeroFramework.getService("ProcessService")
ProcessService.executeFunctions(compiledFunctions)
```

---
[← Return to home page](https://madonox.github.io/AeroFramework/)
