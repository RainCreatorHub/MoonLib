local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

local RainLib = {
    Version = "1.2.5",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(25, 25, 25),
            Accent = Color3.fromRGB(60, 160, 255),
            Text = Color3.fromRGB(240, 240, 240),
            Secondary = Color3.fromRGB(45, 45, 45),
            Disabled = Color3.fromRGB(90, 90, 90)
        },
        Light = {
            Background = Color3.fromRGB(245, 245, 245),
            Accent = Color3.fromRGB(0, 120, 215),
            Text = Color3.fromRGB(30, 30, 30),
            Secondary = Color3.fromRGB(220, 220, 220),
            Disabled = Color3.fromRGB(150, 150, 150)
        },
        light = {
            Background = Color3.fromRGB(255, 250, 240),
            Accent = Color3.fromRGB(100, 200, 150),
            Text = Color3.fromRGB(50, 50, 50),
            Secondary = Color3.fromRGB(230, 230, 235),
            Disabled = Color3.fromRGB(180, 180, 180)
        }
    },
    CurrentTheme = nil,
    CreatedFolders = {},
    GUIState = { Windows = {} },
    ScreenGui = Instance.new("ScreenGui")
}

RainLib.ScreenGui.Name = "RainLibGUI"
RainLib.ScreenGui.Parent = LocalPlayer.PlayerGui
RainLib.ScreenGui.ResetOnSpawn = false

local function tween(obj, tweenInfo, properties)
    TweenService:Create(obj, tweenInfo, properties):Play()
end

local function createContainer(parent, size)
    local container = parent.Parent
    if container:IsA("ScrollingFrame") then
        container.CanvasSize = container.CanvasSize + UDim2.new(0, 0, 0, size.Y.Offset + 8)
    end
end

function RainLib:CreateFolder(folderName)
    if not self.CreatedFolders[folderName] then
        pcall(function() makefolder(folderName) end)
        self.CreatedFolders[folderName] = true
    end
end

function RainLib:SaveSettings(folderName, settings)
    self:CreateFolder(folderName)
    pcall(function()
        writefile(folderName .. "/Settings.json", HttpService:JSONEncode(settings))
    end)
end

function RainLib:LoadSettings(folderName)
    self:CreateFolder(folderName)
    local success, result = pcall(function()
        return HttpService:JSONDecode(readfile(folderName .. "/Settings.json"))
    end)
    return success and result or nil
end

function RainLib:SaveFlag(folderName, flag, value)
    if not flag or not isfolder(folderName) then return end
    local settings = self:LoadSettings(folderName) or { Flags = {}, Theme = "Dark" }
    settings.Flags[flag] = value
    self:SaveSettings(folderName, settings)
end

function RainLib:GetFlag(folderName, flag, default)
    if not flag or not isfolder(folderName) then return default end
    local settings = self:LoadSettings(folderName)
    if settings and settings.Flags[flag] ~= nil then
        return settings.Flags[flag]
    end
    return default
end

function RainLib:Notify(window, options)
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 200, 0, 60)
    notification.Position = UDim2.new(1, -210, 1, -70)
    notification.BackgroundColor3 = self.CurrentTheme.Background
    notification.Parent = window.Notifications

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = notification

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 20)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.Text = options.Title or "Notification"
    title.TextColor3 = self.CurrentTheme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1
    title.Parent = notification

    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1, -10, 0, 30)
    content.Position = UDim2.new(0, 5, 0, 25)
    content.Text = options.Content or ""
    content.TextColor3 = self.CurrentTheme.Text
    content.Font = Enum.Font.SourceSans
    content.TextSize = 12
    content.TextXAlignment = Enum.TextXAlignment.Left
    content.TextWrapped = true
    content.BackgroundTransparency = 1
    content.Parent = notification

    tween(notification, TweenInfo.new(0.3), { Position = UDim2.new(1, -210, 1, -80) })
    task.spawn(function()
        task.wait(options.Duration or 5)
        tween(notification, TweenInfo.new(0.3), { Position = UDim2.new(1, 0, 1, -80) })
        task.wait(0.3)
        notification:Destroy()
    end)
end

function RainLib:Destroy()
    self.ScreenGui:Destroy()
    self.GUIState = { Windows = {} }
end

function RainLib:RecreateGUI()
    for _, windowState in ipairs(self.GUIState.Windows) do
        local window = self:Window(windowState.Options)
        for _, tabState in ipairs(windowState.Tabs) do
            local tab = window:Tab({ Title = tabState.Name, Icon = tabState.Icon })
            for _, element in ipairs(tabState.Elements) do
                if element.Type == "Section" then
                    tab:AddSection(element.Options)
                elseif element.Type == "Paragraph" then
                    tab:AddParagraph(element.Options)
                elseif element.Type == "Button" then
                    tab:AddButton(element.Key, element.Options)
                elseif element.Type == "Toggle" then
                    tab:AddToggle(element.Key, element.Options)
                elseif element.Type == "Slider" then
                    tab:AddSlider(element.Key, element.Options)
                elseif element.Type == "Dropdown" then
                    tab:AddDropdown(element.Key, element.Options)
                elseif element.Type == "Keybind" then
                    tab:AddKeybind(element.Key, element.Options)
                elseif element.Type == "Colorpicker" then
                    tab:AddColorpicker(element.Key, element.Options)
                elseif element.Type == "Input" then
                    tab:AddInput(element.Key, element.Options)
                elseif element.Type == "Dialog" then
                    tab:AddDialog(element.Options)
                end
            end
        end
    end
end

function RainLib:SetTheme(themeName)
    if not self.Themes[themeName] then
        warn("[RainLib] Tema '" .. tostring(themeName) .. "' não encontrado! Usando Dark.")
        themeName = "Dark"
    end

    self.CurrentTheme = self.Themes[themeName]

    for _, window in ipairs(self.ScreenGui:GetChildren()) do
        if window:IsA("Frame") and window.Name ~= "Notifications" then
            tween(window, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Background })

            local titleBar = window.TitleBar
            tween(titleBar, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Secondary })
            for _, child in ipairs(titleBar:GetChildren()) do
                if child:IsA("TextLabel") or child:IsA("TextButton") then
                    tween(child, TweenInfo.new(0.3), { TextColor3 = self.CurrentTheme.Text })
                end
                if child.Name == "MinimizeBtn" then
                    tween(child, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Accent })
                end
            end

            local tabContainer = window.TabContainer
            tween(tabContainer, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Secondary })
            tween(tabContainer.TabIndicator, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Accent })

            local playerFrame = tabContainer:FindFirstChild("PlayerFrame")
            if playerFrame then
                tween(playerFrame, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Secondary })
                for _, child in ipairs(playerFrame:GetChildren()) do
                    if child:IsA("TextLabel") then
                        tween(child, TweenInfo.new(0.3), { TextColor3 = self.CurrentTheme.Text })
                    end
                end
            end

            for _, tabButton in ipairs(tabContainer:GetChildren()) do
                if tabButton:IsA("TextButton") then
                    local content = window:FindFirstChild(tabButton.Name .. "_Content")
                    tween(tabButton, TweenInfo.new(0.3), {
                        BackgroundColor3 = content and content.Visible and self.CurrentTheme.Accent or self.CurrentTheme.Secondary,
                        TextColor3 = self.CurrentTheme.Text
                    })
                    for _, child in ipairs(tabButton:GetChildren()) do
                        if child:IsA("TextLabel") then
                            tween(child, TweenInfo.new(0.3), { TextColor3 = self.CurrentTheme.Text })
                        end
                    end
                end
            end

            for _, content in ipairs(window:GetChildren()) do
                if content:IsA("ScrollingFrame") then
                    for _, element in ipairs(content.Container:GetChildren()) do
                        if element:IsA("Frame") and element:GetChildren()[1] then
                            local child = element:GetChildren()[1]
                            if child.Name:match("Section") or child.Name:match("Paragraph") then
                                tween(child, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Secondary })
                                for _, label in ipairs(child:GetChildren()) do
                                    if label:IsA("TextLabel") then
                                        tween(label, TweenInfo.new(0.3), { TextColor3 = self.CurrentTheme.Text })
                                    end
                                end
                            elseif child.Name:match("Button") then
                                tween(child, TweenInfo.new(0.3), {
                                    BackgroundColor3 = self.CurrentTheme.Accent,
                                    TextColor3 = self.CurrentTheme.Text
                                })
                                local stroke = child:FindFirstChildOfClass("UIStroke")
                                if stroke then
                                    tween(stroke, TweenInfo.new(0.3), { Color = self.CurrentTheme.Accent:Lerp(Color3.fromRGB(0, 0, 0), 0.2) })
                                end
                            elseif child.Name:match("Toggle") then
                                tween(child, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Secondary })
                                for _, subchild in ipairs(child:GetChildren()) do
                                    if subchild:IsA("TextLabel") then
                                        tween(subchild, TweenInfo.new(0.3), { TextColor3 = self.CurrentTheme.Text })
                                    elseif subchild.Name == "Indicator" then
                                        tween(subchild, TweenInfo.new(0.3), {
                                            BackgroundColor3 = subchild.Size.X.Offset > 18 and self.CurrentTheme.Accent or self.CurrentTheme.Disabled
                                        })
                                    end
                                end
                            elseif child.Name:match("Slider") then
                                tween(child, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Secondary })
                                for _, subchild in ipairs(child:GetChildren()) do
                                    if subchild:IsA("TextLabel") then
                                        tween(subchild, TweenInfo.new(0.3), { TextColor3 = self.CurrentTheme.Text })
                                    elseif subchild.Name == "Bar" then
                                        tween(subchild, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Disabled })
                                        tween(subchild.Fill, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Accent })
                                    end
                                end
                            elseif child.Name:match("Dropdown") or child.Name:match("Keybind") or child.Name:match("Input") then
                                tween(child, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Secondary })
                                for _, subchild in ipairs(child:GetChildren()) do
                                    if subchild:IsA("TextLabel") or subchild:IsA("TextButton") or subchild:IsA("TextBox") then
                                        tween(subchild, TweenInfo.new(0.3), { TextColor3 = self.CurrentTheme.Text })
                                    end
                                    if subchild:IsA("TextButton") or subchild:IsA("TextBox") then
                                        tween(subchild, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Disabled })
                                    end
                                    if subchild.Name == "ListFrame" then
                                        tween(subchild, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Secondary })
                                        for _, item in ipairs(subchild:GetChildren()) do
                                            if item:IsA("TextButton") then
                                                tween(item, TweenInfo.new(0.3), {
                                                    BackgroundColor3 = self.CurrentTheme.Secondary,
                                                    TextColor3 = self.CurrentTheme.Text
                                                })
                                            end
                                        end
                                    end
                                end
                            elseif child.Name:match("Colorpicker") then
                                tween(child, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Secondary })
                                for _, subchild in ipairs(child:GetChildren()) do
                                    if subchild:IsA("TextLabel") then
                                        tween(subchild, TweenInfo.new(0.3), { TextColor3 = self.CurrentTheme.Text })
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    local notifications = self.ScreenGui.Notifications
    for _, notification in ipairs(notifications:GetChildren()) do
        if notification:IsA("Frame") then
            tween(notification, TweenInfo.new(0.3), { BackgroundColor3 = self.CurrentTheme.Background })
            for _, label in ipairs(notification:GetChildren()) do
                if label:IsA("TextLabel") then
                    tween(label, TweenInfo.new(0.3), { TextColor3 = self.CurrentTheme.Text })
                end
            end
        end
    end

    for _, windowState in ipairs(self.GUIState.Windows) do
        if windowState.Options.SaveSettings then
            local settings = self:LoadSettings(windowState.Options.ConfigFolder) or { Theme = "Dark" }
            settings.Theme = themeName
            self:SaveSettings(windowState.Options.ConfigFolder, settings)
        end
    end

    print("[RainLib] Tema alterado para: " .. themeName)
end

function RainLib:Window(options)
    local window = { Tabs = {}, Notifications = Instance.new("Frame") }
    options = options or {}
    window.Options = {
        Title = options.Title or "Rain Lib",
        SubTitle = options.SubTitle or "",
        Position = options.Position or UDim2.new(0.5, -250, 0.5, -175),
        Theme = options.Theme or "Dark",
        MinimizeKey = options.MinimizeKey or Enum.KeyCode.LeftControl,
        SaveSettings = options.SaveSettings or false,
        ConfigFolder = options.ConfigFolder or "RainConfig"
    }

    if window.Options.SaveSettings then
        self:CreateFolder(window.Options.ConfigFolder)
        local settings = self:LoadSettings(window.Options.ConfigFolder) or { Theme = "Dark" }
        self.CurrentTheme = self.Themes[settings.Theme] or self.Themes.Dark
    else
        self.CurrentTheme = self.Themes[window.Options.Theme] or self.Themes.Dark
    end

    window.Notifications.Name = "Notifications"
    window.Notifications.Size = UDim2.new(1, 0, 1, 0)
    window.Notifications.BackgroundTransparency = 1
    window.Notifications.Parent = self.ScreenGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = window.Options.Title
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = window.Options.Position
    mainFrame.BackgroundColor3 = self.CurrentTheme.Background
    mainFrame.Parent = self.ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Position = UDim2.new(0, -20, 0, -20)
    shadow.Image = "rbxassetid://2970881687"
    shadow.ImageTransparency = 0.5
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = -1
    shadow.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 60)
    titleBar.BackgroundColor3 = self.CurrentTheme.Secondary
    titleBar.Parent = mainFrame

    local titleBarCorner = Instance.new("UICorner")
    titleBarCorner.CornerRadius = UDim.new(0, 12)
    titleBarCorner.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -60, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.Text = window.Options.Title
    titleLabel.TextColor3 = self.CurrentTheme.Text
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = titleBar

    local subTitleLabel = Instance.new("TextLabel")
    subTitleLabel.Size = UDim2.new(1, -60, 0, 20)
    subTitleLabel.Position = UDim2.new(0, 10, 0, 30)
    subTitleLabel.Text = window.Options.SubTitle
    subTitleLabel.TextColor3 = self.CurrentTheme.Text
    subTitleLabel.Font = Enum.Font.SourceSans
    subTitleLabel.TextSize = 12
    subTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subTitleLabel.BackgroundTransparency = 1
    subTitleLabel.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -30, 0, 10)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = self.CurrentTheme.Text
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 14
    closeButton.Parent = titleBar

    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "MinimizeBtn"
    minimizeBtn.Size = UDim2.new(0, 20, 0, 20)
    minimizeBtn.Position = UDim2.new(1, -55, 0, 10)
    minimizeBtn.BackgroundColor3 = self.CurrentTheme.Accent
    minimizeBtn.Text = "-"
    minimizeBtn.TextColor3 = self.CurrentTheme.Text
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 14
    minimizeBtn.Parent = titleBar

    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 5)
    minimizeCorner.Parent = minimizeBtn

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(0, 120, 1, -60)
    tabContainer.Position = UDim2.new(0, 0, 0, 60)
    tabContainer.BackgroundColor3 = self.CurrentTheme.Secondary
    tabContainer.Parent = mainFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 4)
    tabLayout.Parent = tabContainer

    local tabIndicator = Instance.new("Frame")
    tabIndicator.Name = "TabIndicator"
    tabIndicator.Size = UDim2.new(0, 4, 0, 40)
    tabIndicator.BackgroundColor3 = self.CurrentTheme.Accent
    tabIndicator.BorderSizePixel = 0
    tabIndicator.Parent = tabContainer

    local playerFrame = Instance.new("Frame")
    playerFrame.Name = "PlayerFrame"
    playerFrame.Size = UDim2.new(1, -8, 0, 50)
    playerFrame.Position = UDim2.new(0, 4, 1, -54)
    playerFrame.BackgroundColor3 = self.CurrentTheme.Secondary
    playerFrame.Parent = tabContainer

    local playerCorner = Instance.new("UICorner")
    playerCorner.CornerRadius = UDim.new(0, 6)
    playerCorner.Parent = playerFrame

    local playerImage = Instance.new("ImageLabel")
    playerImage.Size = UDim2.new(0, 40, 0, 40)
    playerImage.Position = UDim2.new(0, 5, 0, 5)
    playerImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=48&height=48&format=png"
    playerImage.BackgroundTransparency = 1
    playerImage.Parent = playerFrame

    local playerName = Instance.new("TextLabel")
    playerName.Size = UDim2.new(1, -50, 1, 0)
    playerName.Position = UDim2.new(0, 45, 0, 0)
    playerName.Text = LocalPlayer.Name
    playerName.TextColor3 = self.CurrentTheme.Text
    playerName.Font = Enum.Font.SourceSans
    playerName.TextSize = 14
    playerName.TextXAlignment = Enum.TextXAlignment.Left
    playerName.TextTruncate = Enum.TextTruncate.AtEnd
    playerName.BackgroundTransparency = 1
    playerName.Parent = playerFrame

    local dragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    RunService.RenderStepped:Connect(function()
        if dragging then
            local mousePos = UserInputService:GetMouseLocation()
            mainFrame.Position = UDim2.new(0, startPos.X.Offset + (mousePos.X - dragStart.X), 0, startPos.Y.Offset + (mousePos.Y - dragStart.Y))
        end
    end)

    closeButton.MouseButton1Click:Connect(function()
        mainFrame:Destroy()
        for i, win in ipairs(self.GUIState.Windows) do
            if win.Options.Title == window.Options.Title then
                table.remove(self.GUIState.Windows, i)
                break
            end
        end
    end)

    local minimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        tween(mainFrame, TweenInfo.new(0.3), { Size = minimized and UDim2.new(0, 500, 0, 60) or UDim2.new(0, 500, 0, 350) })
        minimizeBtn.Text = minimized and "+" or "-"
    end)
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == window.Options.MinimizeKey then
            minimized = not minimized
            tween(mainFrame, TweenInfo.new(0.3), { Size = minimized and UDim2.new(0, 500, 0, 60) or UDim2.new(0, 500, 0, 350) })
            minimizeBtn.Text = minimized and "+" or "-"
        end
    end)

    function window:Tab(options)
        local tab = {
            Name = options.Title or "Tab",
            Elements = {
                Toggles = {},
                Sliders = {},
                Dropdowns = {},
                Keybinds = {},
                Colorpickers = {},
                Inputs = {},
                Buttons = {},
                Sections = {},
                Paragraphs = {},
                Dialogs = {}
            }
        }
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tab.Name
        tabButton.Size = UDim2.new(1, -8, 0, 40)
        tabButton.Position = UDim2.new(0, 4, 0, 4)
        tabButton.BackgroundColor3 = self.CurrentTheme.Secondary
        tabButton.Text = ""
        tabButton.Parent = tabContainer

        local tabButtonCorner = Instance.new("UICorner")
        tabButtonCorner.CornerRadius = UDim.new(0, 6)
        tabButtonCorner.Parent = tabButton

        local tabLabel = Instance.new("TextLabel")
        tabLabel.Size = UDim2.new(1, -40, 1, 0)
        tabLabel.Position = UDim2.new(0, options.Icon and 40 or 10, 0, 0)
        tabLabel.Text = tab.Name
        tabLabel.TextColor3 = self.CurrentTheme.Text
        tabLabel.Font = Enum.Font.SourceSans
        tabLabel.TextSize = 14
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        tabLabel.BackgroundTransparency = 1
        tabLabel.Parent = tabButton

        if options.Icon then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 30, 0, 30)
            icon.Position = UDim2.new(0, 5, 0, 5)
            icon.Image = options.Icon
            icon.BackgroundTransparency = 1
            icon.Parent = tabButton
        end

        local content = Instance.new("ScrollingFrame")
        content.Name = tab.Name .. "_Content"
        content.Size = UDim2.new(1, -120, 1, -60)
        content.Position = UDim2.new(0, 120, 0, 60)
        content.BackgroundTransparency = 1
        content.CanvasSize = UDim2.new(0, 0, 0, 0)
        content.ScrollingDirection = Enum.ScrollingDirection.Y
        content.ScrollBarThickness = 4
        content.Visible = #window.Tabs == 0
        content.Parent = mainFrame

        local contentLayout = Instance.new("UIListLayout")
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 8)
        contentLayout.Parent = content

        local container = Instance.new("Frame")
        container.Name = "Container"
        container.Size = UDim2.new(1, -8, 0, 0)
        container.BackgroundTransparency = 1
        container.Parent = content

        tabButton.MouseButton1Click:Connect(function()
            for _, otherContent in ipairs(mainFrame:GetChildren()) do
                if otherContent:IsA("ScrollingFrame") then
                    otherContent.Visible = false
                end
            end
            for _, otherButton in ipairs(tabContainer:GetChildren()) do
                if otherButton:IsA("TextButton") then
                    tween(otherButton, TweenInfo.new(0.2), { BackgroundColor3 = self.CurrentTheme.Secondary })
                end
            end
            content.Visible = true
            tween(tabButton, TweenInfo.new(0.2), { BackgroundColor3 = self.CurrentTheme.Accent })
            tween(tabIndicator, TweenInfo.new(0.2), { Position = UDim2.new(0, 0, 0, tabButton.Position.Y.Offset) })
        end)

        if #window.Tabs == 0 then
            tween(tabButton, TweenInfo.new(0.2), { BackgroundColor3 = self.CurrentTheme.Accent })
            tween(tabIndicator, TweenInfo.new(0.2), { Position = UDim2.new(0, 0, 0, tabButton.Position.Y.Offset) })
        end

        function tab:AddSection(options)
            options = options or {}
            local sectionSize = UDim2.new(1, -16, 0, 30)
            local frame = Instance.new("Frame")
            frame.Size = sectionSize
            frame.BackgroundColor3 = self.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -10, 1, 0)
            label.Text = options.Title or "Section"
            label.TextColor3 = self.CurrentTheme.Text
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.BackgroundTransparency = 1
            label.Parent = frame

            createContainer(frame, sectionSize)
            self.Elements.Sections[options.Title or "Section_" .. #self.Elements.Sections] = frame
            return frame
        end

        function tab:AddParagraph(options)
            options = options or {}
            local paragraphSize = UDim2.new(1, -16, 0, 60)
            local frame = Instance.new("Frame")
            frame.Size = paragraphSize
            frame.BackgroundColor3 = self.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -10, 0, 20)
            title.Position = UDim2.new(0, 5, 0, 5)
            title.Text = options.Title or "Paragraph"
            title.TextColor3 = self.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.BackgroundTransparency = 1
            title.Parent = frame

            local content = Instance.new("TextLabel")
            content.Size = UDim2.new(1, -10, 0, 30)
            content.Position = UDim2.new(0, 5, 0, 25)
            content.Text = options.Content or ""
            content.TextColor3 = self.CurrentTheme.Text
            content.Font = Enum.Font.SourceSans
            content.TextSize = 12
            content.TextXAlignment = Enum.TextXAlignment.Left
            content.TextWrapped = true
            content.BackgroundTransparency = 1
            content.Parent = frame

            createContainer(frame, paragraphSize)
            self.Elements.Paragraphs[options.Title or "Paragraph_" .. #self.Elements.Paragraphs] = frame
            return frame
        end

        function tab:AddButton(key, options)
            options = options or {}
            local buttonSize = UDim2.new(1, -16, 0, 35)
            local button = {}
            local frame = Instance.new("Frame")
            frame.Size = buttonSize
            frame.BackgroundColor3 = self.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -8, 1, -8)
            btn.Position = UDim2.new(0, 4, 0, 4)
            btn.BackgroundColor3 = self.CurrentTheme.Accent
            btn.Text = options.Title or "Button"
            btn.TextColor3 = self.CurrentTheme.Text
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 14
            btn.Parent = frame

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 5)
            btnCorner.Parent = btn

            local stroke = Instance.new("UIStroke")
            stroke.Color = self.CurrentTheme.Accent:Lerp(Color3.fromRGB(0, 0, 0), 0.2)
            stroke.Thickness = 1
            stroke.Parent = btn

            createContainer(frame, buttonSize)
            btn.MouseButton1Click:Connect(function()
                if options.Callback then
                    options.Callback()
                end
            end)

            self.Elements.Buttons[key] = button
            return button
        end

        function tab:AddToggle(key, options)
            options = options or {}
            local toggleSize = UDim2.new(1, -16, 0, 35)
            local toggle = { Value = options.Default or false }
            local frame = Instance.new("Frame")
            frame.Size = toggleSize
            frame.BackgroundColor3 = self.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -40, 1, 0)
            label.Text = options.Title or "Toggle"
            label.BackgroundTransparency = 1
            label.TextColor3 = self.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local indicator = Instance.new("Frame")
            indicator.Name = "Indicator"
            indicator.Size = UDim2.new(0, 18, 0, 18)
            indicator.Position = UDim2.new(1, -26, 0.5, -9)
            indicator.BackgroundColor3 = toggle.Value and self.CurrentTheme.Accent or self.CurrentTheme.Disabled
            indicator.Parent = frame

            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 9)
            indicatorCorner.Parent = indicator

            if options.Flag and window.Options.SaveSettings then
                toggle.Value = RainLib:GetFlag(window.Options.ConfigFolder, options.Flag, toggle.Value)
                indicator.BackgroundColor3 = toggle.Value and self.CurrentTheme.Accent or self.CurrentTheme.Disabled
            end

            createContainer(frame, toggleSize)
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    toggle.Value = not toggle.Value
                    tween(indicator, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggle.Value and self.CurrentTheme.Accent or self.CurrentTheme.Disabled,
                        Size = UDim2.new(0, toggle.Value and 22 or 18, 0, toggle.Value and 22 or 18),
                        Position = UDim2.new(1, toggle.Value and -30 or -26, 0.5, toggle.Value and -11 or -9)
                    })
                    if options.Callback then
                        options.Callback(toggle.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        RainLib:SaveFlag(window.Options.ConfigFolder, options.Flag, toggle.Value)
                    end
                end
            end)

            self.Elements.Toggles[key] = toggle
            return toggle
        end

        function tab:AddSlider(key, options)
            options = options or {}
            local sliderSize = UDim2.new(1, -16, 0, 35)
            local slider = { Value = options.Default or options.Min or 0 }
            local frame = Instance.new("Frame")
            frame.Size = sliderSize
            frame.BackgroundColor3 = self.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -40, 0, 18)
            label.Text = options.Title or "Slider"
            label.BackgroundTransparency = 1
            label.TextColor3 = self.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 30, 0, 18)
            valueLabel.Position = UDim2.new(1, -34, 0, 0)
            valueLabel.Text = tostring(slider.Value)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = self.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SourceSans
            valueLabel.TextSize = 12
            valueLabel.Parent = frame

            local bar = Instance.new("Frame")
            bar.Name = "Bar"
            bar.Size = UDim2.new(1, -8, 0, 6)
            bar.Position = UDim2.new(0, 4, 0, 22)
            bar.BackgroundColor3 = self.CurrentTheme.Disabled
            bar.Parent = frame

            local fill = Instance.new("Frame")
            fill.Name = "Fill"
            fill.Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)
            fill.BackgroundColor3 = self.CurrentTheme.Accent
            fill.Parent = bar

            local cornerBar = Instance.new("UICorner")
            cornerBar.CornerRadius = UDim.new(0, 3)
            cornerBar.Parent = bar

            local cornerFill = Instance.new("UICorner")
            cornerFill.CornerRadius = UDim.new(0, 3)
            cornerFill.Parent = fill

            if options.Flag and window.Options.SaveSettings then
                slider.Value = RainLib:GetFlag(window.Options.ConfigFolder, options.Flag, slider.Value)
                fill.Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)
                valueLabel.Text = tostring(slider.Value)
            end

            createContainer(frame, sliderSize)
            local dragging
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    tween(bar, TweenInfo.new(0.2), { BackgroundColor3 = self.CurrentTheme.Disabled:Lerp(self.CurrentTheme.Accent, 0.2) })
                end
            end)
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    tween(bar, TweenInfo.new(0.2), { BackgroundColor3 = self.CurrentTheme.Disabled })
                end
            end)
            RunService.RenderStepped:Connect(function()
                if dragging then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = math.clamp((mousePos.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    slider.Value = math.floor((options.Min or 0) + relativeX * ((options.Max or 100) - (options.Min or 0)))
                    if options.Rounding then
                        slider.Value = math.floor(slider.Value / options.Rounding) * options.Rounding
                    end
                    tween(fill, TweenInfo.new(0.1), { Size = UDim2.new(relativeX, 0, 1, 0) })
                    valueLabel.Text = tostring(slider.Value)
                    if options.Callback then
                        options.Callback(slider.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        RainLib:SaveFlag(window.Options.ConfigFolder, options.Flag, slider.Value)
                    end
                end
            end)

            self.Elements.Sliders[key] = slider
            return slider
        end

        function tab:AddDropdown(key, options)
            options = options or {}
            local dropdownSize = UDim2.new(1, -16, 0, 35)
            local dropdown = { Value = options.Default or (options.Items and options.Items[1]) }
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.BackgroundColor3 = self.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -100, 1, 0)
            label.Text = options.Title or "Dropdown"
            label.BackgroundTransparency = 1
            label.TextColor3 = self.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 90, 0, 25)
            button.Position = UDim2.new(1, -95, 0, 5)
            button.BackgroundColor3 = self.CurrentTheme.Disabled
            button.Text = dropdown.Value or "Select"
            button.TextColor3 = self.CurrentTheme.Text
            button.Font = Enum.Font.SourceSans
            button.TextSize = 12
            button.TextWrapped = true
            button.Parent = frame

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 5)
            buttonCorner.Parent = button

            local listFrame = Instance.new("Frame")
            listFrame.Name = "ListFrame"
            listFrame.Size = UDim2.new(0, 90, 0, 0)
            listFrame.Position = UDim2.new(1, -95, 0, 35)
            listFrame.BackgroundColor3 = self.CurrentTheme.Secondary
            listFrame.Visible = false
            listFrame.Parent = frame

            local listCorner = Instance.new("UICorner")
            listCorner.CornerRadius = UDim.new(0, 5)
            listCorner.Parent = listFrame

            local listLayout = Instance.new("UIListLayout")
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder
            listLayout.Parent = listFrame

            if options.Flag and window.Options.SaveSettings then
                dropdown.Value = RainLib:GetFlag(window.Options.ConfigFolder, options.Flag, dropdown.Value)
                button.Text = tostring(dropdown.Value)
            end

            local function updateList()
                listFrame.Size = UDim2.new(0, 90, 0, math.min(#options.Items * 25, 100))
                for _, child in ipairs(listFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                for _, item in ipairs(options.Items or {}) do
                    local itemButton = Instance.new("TextButton")
                    itemButton.Size = UDim2.new(1, 0, 0, 25)
                    itemButton.BackgroundColor3 = self.CurrentTheme.Secondary
                    itemButton.Text = tostring(item)
                    itemButton.TextColor3 = self.CurrentTheme.Text
                    itemButton.Font = Enum.Font.SourceSans
                    itemButton.TextSize = 12
                    itemButton.TextWrapped = true
                    itemButton.Parent = listFrame

                    itemButton.MouseButton1Click:Connect(function()
                        dropdown.Value = item
                        button.Text = tostring(item)
                        listFrame.Visible = false
                        if options.Callback then
                            options.Callback(dropdown.Value)
                        end
                        if options.Flag and window.Options.SaveSettings then
                            RainLib:SaveFlag(window.Options.ConfigFolder, options.Flag, dropdown.Value)
                        end
                    end)
                end
            end
            updateList()

            createContainer(frame, dropdownSize)
            button.MouseButton1Click:Connect(function()
                listFrame.Visible = not listFrame.Visible
                tween(listFrame, TweenInfo.new(0.2), { Size = listFrame.Visible and UDim2.new(0, 90, 0, math.min(#options.Items * 25, 100)) or UDim2.new(0, 90, 0, 0) })
            end)

            self.Elements.Dropdowns[key] = dropdown
            return dropdown
        end

        function tab:AddKeybind(key, options)
            options = options or {}
            local keybindSize = UDim2.new(1, -16, 0, 35)
            local keybind = { Value = options.Default or Enum.KeyCode.Unknown }
            local frame = Instance.new("Frame")
            frame.Size = keybindSize
            frame.BackgroundColor3 = self.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -100, 1, 0)
            label.Text = options.Title or "Keybind"
            label.BackgroundTransparency = 1
            label.TextColor3 = self.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 90, 0, 25)
            button.Position = UDim2.new(1, -95, 0, 5)
            button.BackgroundColor3 = self.CurrentTheme.Disabled
            button.Text = keybind.Value.Name or "None"
            button.TextColor3 = self.CurrentTheme.Text
            button.Font = Enum.Font.SourceSans
            button.TextSize = 12
            button.TextWrapped = true
            button.Parent = frame

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 5)
            buttonCorner.Parent = button

            if options.Flag and window.Options.SaveSettings then
                local savedKey = RainLib:GetFlag(window.Options.ConfigFolder, options.Flag, keybind.Value.Name)
                keybind.Value = Enum.KeyCode[savedKey] or keybind.Value
                button.Text = keybind.Value.Name or "None"
            end

            createContainer(frame, keybindSize)
            local binding
            button.MouseButton1Click:Connect(function()
                button.Text = "..."
                binding = true
            end)
            UserInputService.InputBegan:Connect(function(input)
                if binding and input.KeyCode ~= Enum.KeyCode.Unknown then
                    keybind.Value = input.KeyCode
                    button.Text = keybind.Value.Name
                    binding = false
                    if options.Callback then
                        options.Callback(keybind.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        RainLib:SaveFlag(window.Options.ConfigFolder, options.Flag, keybind.Value.Name)
                    end
                end
            end)

            self.Elements.Keybinds[key] = keybind
            return keybind
        end

        function tab:AddColorpicker(key, options)
            options = options or {}
            local pickerSize = UDim2.new(1, -16, 0, 90)
            local picker = { Value = options.Default or Color3.fromRGB(255, 255, 255) }
            local frame = Instance.new("Frame")
            frame.Size = pickerSize
            frame.BackgroundColor3 = self.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -40, 0, 18)
            label.Text = options.Title or "Colorpicker"
            label.BackgroundTransparency = 1
            label.TextColor3 = self.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local preview = Instance.new("Frame")
            preview.Name = "Preview"
            preview.Size = UDim2.new(0, 25, 0, 25)
            preview.Position = UDim2.new(1, -33, 0, 4)
            preview.BackgroundColor3 = picker.Value
            preview.Parent = frame

            local previewCorner = Instance.new("UICorner")
            previewCorner.CornerRadius = UDim.new(0, 5)
            previewCorner.Parent = preview

            if options.Flag and window.Options.SaveSettings then
                local savedColor = RainLib:GetFlag(window.Options.ConfigFolder, options.Flag, { picker.Value.R, picker.Value.G, picker.Value.B })
                if type(savedColor) == "table" then
                    picker.Value = Color3.new(savedColor[1], savedColor[2], savedColor[3])
                    preview.BackgroundColor3 = picker.Value
                end
            end

            local rSlider = tab:AddSlider(key .. "_R", {
                Title = "R",
                Min = 0,
                Max = 255,
                Default = math.floor(picker.Value.R * 255),
                Callback = function(value)
                    picker.Value = Color3.fromRGB(value, picker.Value.G * 255, picker.Value.B * 255)
                    preview.BackgroundColor3 = picker.Value
                    if options.Callback then
                        options.Callback(picker.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        RainLib:SaveFlag(window.Options.ConfigFolder, options.Flag, { picker.Value.R, picker.Value.G, picker.Value.B })
                    end
                end
            })
            rSlider.Parent.Position = UDim2.new(0, 8, 0, 34)

            local gSlider = tab:AddSlider(key .. "_G", {
                Title = "G",
                Min = 0,
                Max = 255,
                Default = math.floor(picker.Value.G * 255),
                Callback = function(value)
                    picker.Value = Color3.fromRGB(picker.Value.R * 255, value, picker.Value.B * 255)
                    preview.BackgroundColor3 = picker.Value
                    if options.Callback then
                        options.Callback(picker.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        RainLib:SaveFlag(window.Options.ConfigFolder, options.Flag, { picker.Value.R, picker.Value.G, picker.Value.B })
                    end
                end
            })
            gSlider.Parent.Position = UDim2.new(0, 8, 0, 64)

            local bSlider = tab:AddSlider(key .. "_B", {
                Title = "B",
                Min = 0,
                Max = 255,
                Default = math.floor(picker.Value.B * 255),
                Callback = function(value)
                    picker.Value = Color3.fromRGB(picker.Value.R * 255, picker.Value.G * 255, value)
                    preview.BackgroundColor3 = picker.Value
                    if options.Callback then
                        options.Callback(picker.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        RainLib:SaveFlag(window.Options.ConfigFolder, options.Flag, { picker.Value.R, picker.Value.G, picker.Value.B })
                    end
                end
            })
            bSlider.Parent.Position = UDim2.new(0, 8, 0, 94)

            createContainer(frame, pickerSize)
            self.Elements.Colorpickers[key] = picker
            return picker
        end

        function tab:AddInput(key, options)
            options = options or {}
            local inputSize = UDim2.new(1, -16, 0, 35)
            local input = { Value = options.Default or "" }
            local frame = Instance.new("Frame")
            frame.Size = inputSize
            frame.BackgroundColor3 = self.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -100, 1, 0)
            label.Text = options.Title or "Input"
            label.BackgroundTransparency = 1
            label.TextColor3 = self.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local textBox = Instance.new("TextBox")
            textBox.Size = UDim2.new(0, 90, 0, 25)
            textBox.Position = UDim2.new(1, -95, 0, 5)
            textBox.BackgroundColor3 = self.CurrentTheme.Disabled
            textBox.Text = input.Value
            textBox.TextColor3 = self.CurrentTheme.Text
            textBox.Font = Enum.Font.SourceSans
            textBox.TextSize = 12
            textBox.TextWrapped = true
            textBox.Parent = frame

            local textBoxCorner = Instance.new("UICorner")
            textBoxCorner.CornerRadius = UDim.new(0, 5)
            textBoxCorner.Parent = textBox

            if options.Flag and window.Options.SaveSettings then
                input.Value = RainLib:GetFlag(window.Options.ConfigFolder, options.Flag, input.Value)
                textBox.Text = tostring(input.Value)
            end

            createContainer(frame, inputSize)
            textBox.FocusLost:Connect(function()
                input.Value = textBox.Text
                if options.Callback then
                    options.Callback(input.Value)
                end
                if options.Flag and window.Options.SaveSettings then
                    RainLib:SaveFlag(window.Options.ConfigFolder, options.Flag, input.Value)
                end
            end)

            self.Elements.Inputs[key] = input
            return input
        end

        function tab:AddDialog(options)
            options = options or {}
            local dialog = {
                Show = function()
                    local dialogFrame = Instance.new("Frame")
                    dialogFrame.Size = UDim2.new(0, 300, 0, 150)
                    dialogFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
                    dialogFrame.BackgroundColor3 = self.CurrentTheme.Background
                    dialogFrame.Parent = self.ScreenGui

                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(0, 12)
                    corner.Parent = dialogFrame

                    local title = Instance.new("TextLabel")
                    title.Size = UDim2.new(1, -10, 0, 30)
                    title.Position = UDim2.new(0, 5, 0, 5)
                    title.Text = options.Title or "Dialog"
                    title.TextColor3 = self.CurrentTheme.Text
                    title.Font = Enum.Font.GothamBold
                    title.TextSize = 16
                    title.TextXAlignment = Enum.TextXAlignment.Left
                    title.BackgroundTransparency = 1
                    title.Parent = dialogFrame

                    local content = Instance.new("TextLabel")
                    content.Size = UDim2.new(1, -10, 0, 50)
                    content.Position = UDim2.new(0, 5, 0, 40)
                    content.Text = options.Content or ""
                    content.TextColor3 = self.CurrentTheme.Text
                    content.Font = Enum.Font.SourceSans
                    content.TextSize = 14
                    content.TextXAlignment = Enum.TextXAlignment.Left
                    content.TextWrapped = true
                    content.BackgroundTransparency = 1
                    content.Parent = dialogFrame

                    local buttonContainer = Instance.new("Frame")
                    buttonContainer.Size = UDim2.new(1, -10, 0, 30)
                    buttonContainer.Position = UDim2.new(0, 5, 1, -35)
                    buttonContainer.BackgroundTransparency = 1
                    buttonContainer.Parent = dialogFrame

                    local buttonLayout = Instance.new("UIListLayout")
                    buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    buttonLayout.FillDirection = Enum.FillDirection.Horizontal
                    buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                    buttonLayout.Padding = UDim.new(0, 5)
                    buttonLayout.Parent = buttonContainer

                    for _, btn in ipairs(options.Buttons or {}) do
                        local btnFrame = Instance.new("TextButton")
                        btnFrame.Size = UDim2.new(0, 80, 0, 25)
                        btnFrame.BackgroundColor3 = self.CurrentTheme.Accent
                        btnFrame.Text = btn.Text or "Button"
                        btnFrame.TextColor3 = self.CurrentTheme.Text
                        btnFrame.Font = Enum.Font.GothamBold
                        btnFrame.TextSize = 12
                        btnFrame.Parent = buttonContainer

                        local btnCorner = Instance.new("UICorner")
                        btnCorner.CornerRadius = UDim.new(0, 5)
                        btnCorner.Parent = btnFrame

                        btnFrame.MouseButton1Click:Connect(function()
                            if btn.Callback then
                                btn.Callback()
                            end
                            dialogFrame:Destroy()
                        end)
                    end
                end
            }
            self.Elements.Dialogs[options.Title or "Dialog_" .. #self.Elements.Dialogs] = dialog
            return dialog
        end

        table.insert(window.Tabs, tab)
        table.insert(self.GUIState.Windows[#self.GUIState.Windows].Tabs, {
            Name = tab.Name,
            Icon = options.Icon,
            Elements = {}
        })
        return tab
    end

    table.insert(self.GUIState.Windows, { Options = window.Options, Tabs = {} })
    return window
end

return RainLib
