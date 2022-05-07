
# PhotonFramework

## UIService
UIService is a more complex service, made to allow users to create complex and interactive UI quite simply.  While the service may appear to be a more performance impacting system, it is not.  The service is actually still quite lightweight, and would only cause performance errors based on memory leaks created by users.
## Raw API:

| Method | Argument(s) | Notes |
|--|--|--|
| CreateAspect | ElementClass:String, Data:Table |The `data` table may contain three subtables, with but the `Properties` subtable being optional.  The first of these tables is `Properties`, which contain the properties of the element.  The second of these tables is `Connections`, which contain the connections attached to this element.  The final table, `Children` contains all children of the UI element.  You may supply external UI elements for the Children table, as the UIService is made to be able to work with pre-existing UI.
| createNode | GuiType:String, Properties:Table |
| constructNode | GuiInstance:Instance, Parent:Instance/Nil |This method can be called on the server, and will replicate the UI to clients as well.  Additionally, if the `parent` is set to nil, it will place the UI in PlayerGui, whether called on the client or server.
## UIService.CreateAspect:
This method allows you to create a UI element, for use either within a UIService constructed node, or externally.  This method features a plethora of customization options, and a demo is provided below.
```lua
local UIService = PhotonFramework.getService("UIService")
local uiAspect = UIService.CreateAspect("Frame",{
	Properties = {
		BackgroundTransparency = 0.5;
		BackgroundColor3 = Color3.new(1,0,0);
	};
	Connections = {
		MouseEnter = function(...)
		print(...)
		end;
	};
	Children = {
		UIService.CreateAspect("TextLabel",{
			Properties = {
				Text = "Hello World!";
			};
		});
		
		path.to.external.ui.element;
	};
})
```
## UIService.createNode:
This method creates a GUI container for UI, and can be shown with the `constructNode` method.
```lua
local UIService = PhotonFramework.getService("UIService")
local uiNode = UIService.createNode("ScreenGui",{
	ResetOnSpawn = false;
})
uiAspect.Parent = uiNode
```
## UIService.constructNode:
This method allows you to "show" the UI that you have created.  The method is quite simple, and can be used to render UI from the server to client.
```lua
local UIService = PhotonFramework.getService("UIService")
UIService.constructNode(uiNode,"local") -- Providing "local" as a parent on the server replicates the UI to all clients, and displays it as a ScreenGui.
-- You can also just supply a directory and the UI will go there.
```

---
[← Return to home page](https://madonox.github.io/PhotonFramework/)
