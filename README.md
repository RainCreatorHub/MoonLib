# Rain Library V2

### Load
``` lua
local RainLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/OrionLibV2/refs/heads/main/OrionLibV2.lua"))()
```

### window
``` lua
local window = RainLib:MakeWindow({
    Title = "My Cheat GUI",
    SubTitle = "wow"
})
```

### tab
``` lua
local Tab = window:MakeTab({
    Name = "Tab 1"
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

### Dropdown ( Not Found )
``` lua
local Dropdown = Tab:AddDropdown({
    Name = "Perks",
    Description = "Choose your perks",
    Values = {"Hi", "Hii", "Hiii"},
    Default = {"Hi"},
    Multi = false,
    Callback = function(value)
        print("Selected Mode: .. tostring(value))
    end
})
```

## example of use
``` lua
-- Load
local RainLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/OrionLibV2/refs/heads/main/OrionLibV2.lua"))()

-- window
local window = RainLib:MakeWindow({
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
    Callback = function(value)
      if value == true then
        print("Toggle: on)
      end
      if value == false then
        print("Toggle: off")
      end
    end
})
```
