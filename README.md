# OrionLibV2 - GUI Library for Roblox

OrionLibV2 is a customizable and responsive GUI library designed for Roblox, supporting both PC and mobile devices. It provides a sleek interface with features like tabs, buttons, toggles, labels, and a dynamic dropdown menu with text truncation for long values.

## Features
- **Cross-Platform Support**: Optimized for PC (mouse) and mobile (touch) devices.
- **Responsive Design**: Scales dynamically based on screen size.
- **Customizable Components**: Includes tabs, sections, buttons, toggles, labels, and dropdowns.
- **Dropdown Enhancements**: Rounded borders, matching container color, and text truncation for values over 10 characters.
- **Smooth Animations**: Tween transitions for a polished user experience.

## Installation

### executor
``` lua
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/RainCreatorHub/OrionLibV2/refs/heads/main/OrionLibV2.lua'))()
```
### Roblox studio
``` lua
local OrionLib = require(game.ReplicatedStorage.OrionLibV2)
```

## Usage

### Creating a Window
Create a main window with a title and subtitle:
``` lua
local Window = OrionLib:MakeWindow({
    Title = "Minha Interface",
    SubTitle = "Exemplo de Uso"
})
```

### Adding a Tab
Add a tab to organize your GUI elements:
``` lua
local Tab = Window:MakeTab({
    Name = "Configurações"
})
```

### Adding a Section
Add a section within a tab to group related elements:
``` lua
local section = Tab:AddSection({
    Name = "Opções"
})
```

### Adding a Label
Add a label with a title and content:
``` lua
local Label = Tab:AddLabel({
    Name = "Informação",
    Content = "Este é um texto de exemplo para o label."
})
```

### Adding a Button
Add a button with a callback function:
``` lua
local Button = Tab:AddButton({
    Name = "Teste Botão",
    Callback = function()
        print("Botão clicado!")
    end
})
```

### Adding a Toggle
Add a toggle with a callback function:
``` lua
local Toggle = Tab:AddToggle({
    Name = "Ativar Opção",
    Description = "Ola",
    Default = false,
    Callback = function(Value)
        print("Toggle está: " .. tostring(Value))
    end
})
```

### Adding a Dropdown
Create a dropdown with customizable options and callbacks:
``` lua
local Dropdown = Tab:AddDropdown({
    Name = "Selecione uma Opção",
    Default = "Opção 1",
    Values = {"Opção 1", "Opção 2 muito longa", "Opção 3 ainda mais longa texto de teste", "Opção 4 curta"},
    Multi = false,
    Callback = function(Value)
        print("Selecionado: " .. tostring(Value))
    end
})
```

## License
This library is provided as-is for educational and personal use. Feel free to modify and adapt it for your Roblox projects.

## Last Updated
Wednesday, June, 19, 2025, 01:15
