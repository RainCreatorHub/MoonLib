-- RainLibV2 - By RainCreatorHub
-- v1.0

local RainLibV2 = {}
RainLibV2.__index = RainLibV2

local library = {
    Tabs = {},
    ActiveTab = nil,
    Objects = {},
}

local Drawing = Drawing

-- Core function to create drawings
local function createDraw(type, props)
    local obj = Drawing.new(type)
    for prop, val in pairs(props) do
        obj[prop] = val
    end
    table.insert(library.Objects, obj)
    return obj
end

-- Function to create the main window
function RainLibV2:CreateWindow(title)
    library.MainTitle = createDraw("Text", {
        Text = title or "RainLibV2",
        Size = 24,
        Color = Color3.fromRGB(255, 255, 255),
        Position = Vector2.new(50, 50),
        Center = false,
        Outline = true,
        Visible = true,
    })
    return self
end

-- Function to create a tab
function RainLibV2:CreateTab(name)
    local tab = {
        Name = name,
        Buttons = {},
        Toggles = {},
        Sliders = {},
        Labels = {},
    }

    table.insert(library.Tabs, tab)

    -- Example tab button draw
    tab.Button = createDraw("Text", {
        Text = name,
        Size = 20,
        Color = Color3.fromRGB(200, 200, 200),
        Position = Vector2.new(50, 80 + (#library.Tabs * 25)),
        Outline = true,
        Visible = true,
    })

    -- Set active tab if none
    if not library.ActiveTab then
        library.ActiveTab = tab
    end

    return tab
end

-- Add Button to a tab
function RainLibV2:AddButton(tab, text, callback)
    local btn = createDraw("Text", {
        Text = "[ " .. text .. " ]",
        Size = 18,
        Color = Color3.fromRGB(255, 255, 255),
        Position = Vector2.new(100, 120 + (#tab.Buttons * 25)),
        Outline = true,
        Visible = true,
    })
    table.insert(tab.Buttons, btn)
    -- You can bind input events here
end

-- Function to clear UI (optional)
function RainLibV2:Clear()
    for _, obj in pairs(library.Objects) do
        obj:Remove()
    end
end

return RainLibV2
