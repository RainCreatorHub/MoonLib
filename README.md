# Orion Library V2

### Load
``` lua
local OrionLibV2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/OrionLibV2/refs/heads/main/OrionLibV2.lua"))()
```

### window
``` lua
local window = OrionLibV2:MakeWindow({
    Title = "My Cheat GUI",
    SubTitle = "wow"
})
```

### tab
``` lua
local Tab = window:MakeTab({
    Name = "Tab 1",
    Icon = "User"
})
```

### section
``` lua
local section = Tab:AddSection({
    Name = "Section 1"
})
```

### Label
``` lua
local Label = Tab:AddLabel({
    Name = "Label",
    Content = "Label description!"
})
```

### Button
``` lua
local Button = Tab:AddButton({
    Name = "Button!",
    Callback = function()
     print("Hello, world")
    end
})
```

### Toggle
``` lua
local Toggle = Tab:AddToggle({
    Name = "Toggle",
    Description = "toggle description!",
    Default = false,
    Callback = function(state)
        print("Toggle: " .. tostring(state))
    end
})
```

## example of use
``` lua
-- Load
local OrionLibV2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/OrionLibV2/refs/heads/main/OrionLibV2.lua"))()

-- window
local window = OrionLibV2:MakeWindow({
    Title = "My Cheat GUI",
    SubTitle = "wow"
})

-- Tab
local Tab1 = window:MakeTab({
    Name = "Tab 1"
})

-- Section
local section = Tab1:AddSection({
    Name = "Section 1"
})

-- Label
local Label = Tab1:AddLabel({
    Name = "Label",
    Content = "Label description!"
})

-- Button
local Button = Tab1:AddButton({
    Name = "Button!",
    Callback = function()
     print("Hello, world")
    end
})

-- Toggle
local Toggle = Tab1:AddToggle({
    Name = "Toggle",
    Description = "toggle description!",
    Default = false,
    Callback = function(state)
        print("Toggle: " .. tostring(state))
    end
})
```
