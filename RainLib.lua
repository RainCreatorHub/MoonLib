local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

local RainLib = {
    Version = "1.2.3",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(30, 30, 30),
            Accent = Color3.fromRGB(50, 150, 255),
            Text = Color3.fromRGB(255, 255, 255),
            Secondary = Color3.fromRGB(50, 50, 50),
            Disabled = Color3.fromRGB(100, 100, 100)
        }
    },
    Icons = {}, -- Placeholder for icons (can be populated if needed)
    Windows = {},
    CurrentTheme = nil,
    Connections = {},
    CreatedFolders = {}
}

local function tween(obj, info, properties)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.3, Enum.EasingStyle.Sine), properties)
    tween:Play()
    return tween
end

local function MakeDraggable(DragPoint, Main)
    local Dragging, DragInput, MousePos, FramePos = false
    RainLib.Connections[#RainLib.Connections + 1] = DragPoint.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            MousePos = Input.Position
            FramePos = Main.Position
        end
    end)
    RainLib.Connections[#RainLib.Connections + 1] = DragPoint.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            DragInput = Input
        end
    end)
    RainLib.Connections[#RainLib.Connections + 1] = UserInputService.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging then
            local Delta = Input.Position - MousePos
            Main.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
        end
    end)
    RainLib.Connections[#RainLib.Connections + 1] = DragPoint.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
end

local success, err = pcall(function()
    RainLib.ScreenGui = Instance.new("ScreenGui")
    RainLib.ScreenGui.Name = "RainLib"
    RainLib.ScreenGui.Parent = game.CoreGui or LocalPlayer:WaitForChild("PlayerGui", 5)
    RainLib.ScreenGui.ResetOnSpawn = false
    RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    RainLib.CurrentTheme = RainLib.Themes.Dark
end)
if not success then
    warn("[RainLib] Initialization failed: " .. err)
    return nil
end

function RainLib:CreateFolder(folderName)
    if not folderName or folderName == "" then
        warn("[RainLib] Folder name not specified!")
        return false
    end
    if self.CreatedFolders[folderName] then
        print("[RainLib] Folder already registered: " .. folderName)
        return false
    end
    if makefolder and writefile then
        if not isfolder(folderName) then
            makefolder(folderName)
            self.CreatedFolders[folderName] = true
            local settingsPath = folderName .. "/Settings.json"
            local defaultSettings = {
                Theme = "Dark",
                WindowPosition = {X = 0.5, Y = 0.5, XOffset = -210, YOffset = -160},
                MinimizeKey = "LeftControl",
                SaveSettings = false
            }
            writefile(settingsPath, HttpService:JSONEncode(defaultSettings))
            RainLib:Notify(nil, {Title = "Success", Content = "Folder '" .. folderName .. "' created!", Duration = 3})
            return true
        else
            self.CreatedFolders[folderName] = true
            local settingsPath = folderName .. "/Settings.json"
            if not isfile(settingsPath) then
                local defaultSettings = {
                    Theme = "Dark",
                    WindowPosition = {X = 0.5, Y = 0.5, XOffset = -210, YOffset = -160},
                    MinimizeKey = "LeftControl",
                    SaveSettings = false
                }
                writefile(settingsPath, HttpService:JSONEncode(defaultSettings))
            end
            RainLib:Notify(nil, {Title = "Notice", Content = "Folder '" .. folderName .. "' already exists!", Duration = 3})
            return false
        end
    else
        warn("[RainLib] Executor does not support makefolder or writefile!")
        RainLib:Notify(nil, {Title = "Error", Content = "Executor does not support folder creation!", Duration = 3})
        return false
    end
end

function RainLib:Window(options)
    local window = { Windows = {}, Notifications = Instance.new("Frame"), Tabs = {}, Minimized = false }
    options = options or {}
    local defaultOptions = {
        Title = "Rain Lib",
        Position = UDim2.new(0.5, -210, 0.5, -160),
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl,
        SaveSettings = false,
        ConfigFolder = "RainConfig"
    }
    window.Options = {}
    for key, defaultValue in pairs(defaultOptions) do
        window.Options[key] = options[key] or defaultValue
    end
    RainLib.CurrentTheme = RainLib.Themes[window.Options.Theme] or RainLib.Themes.Dark

    window.Notifications.Size = UDim2.new(0, 300, 1, -25)
    window.Notifications.Position = UDim2.new(1, -310, 0, 0)
    window.Notifications.BackgroundTransparency = 1
    window.Notifications.Parent = RainLib.ScreenGui

    if window.Options.SaveSettings then
        RainLib:CreateFolder(window.Options.ConfigFolder)
    end

    local success, err = pcall(function()
        window.MainFrame = Instance.new("Frame")
        window.MainFrame.Size = UDim2.new(0, 420, 0, 320)
        window.MainFrame.Position = window.Options.Position
        window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
        window.MainFrame.Visible = false
        window.MainFrame.Parent = RainLib.ScreenGui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 15)
        corner.Parent = window.MainFrame

        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
        })
        gradient.Rotation = 45
        gradient.Parent = window.MainFrame

        local shadow = Instance.new("UIStroke")
        shadow.Thickness = 3
        shadow.Color = Color3.fromRGB(0, 0, 0)
        shadow.Transparency = 0.5
        shadow.Parent = window.MainFrame

        window.TitleLabel = Instance.new("TextLabel")
        window.TitleLabel.Size = UDim2.new(1, 0, 0, 50)
        window.TitleLabel.BackgroundTransparency = 1
        window.TitleLabel.Text = window.Options.Title
        window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
        window.TitleLabel.Font = Enum.Font.GothamBold
        window.TitleLabel.TextSize = 24
        window.TitleLabel.Parent = window.MainFrame

        window.TabFrame = Instance.new("Frame")
        window.TabFrame.Size = UDim2.new(1, 0, 0, 40)
        window.TabFrame.Position = UDim2.new(0, 0, 0, 50)
        window.TabFrame.BackgroundTransparency = 1
        window.TabFrame.Parent = window.MainFrame

        window.ContentFrame = Instance.new("ScrollingFrame")
        window.ContentFrame.Size = UDim2.new(1, -10, 1, -100)
        window.ContentFrame.Position = UDim2.new(0, 5, 0, 95)
        window.ContentFrame.BackgroundTransparency = 1
        window.ContentFrame.ScrollBarThickness = 5
        window.ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        window.ContentFrame.Parent = window.MainFrame
    end)
    if not success then
        warn("[RainLib] Failed to create window: " .. err)
        return nil
    end

    MakeDraggable(window.MainFrame, window.MainFrame)

    if window.Options.MinimizeKey then
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == window.Options.MinimizeKey and window.MinimizeButton then
                window.MainFrame.Visible = not window.MainFrame.Visible
                window.MinimizeButton.Text = window.MainFrame.Visible and "Close" or "Open"
            end
        end)
    end

    function window:Minimize(options)
        options = options or {}
        local button
        local success, err = pcall(function()
            button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 150, 0, 50)
            button.Position = UDim2.new(0, 10, 0, 10)
            button.Text = options.Text1 or "Open"
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 20
            button.Parent = RainLib.ScreenGui

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = button

            button.MouseButton1Click:Connect(function()
                if window.MainFrame.Visible then
                    tween(window.MainFrame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -210, 0, -160)})
                    tween(window.MainFrame, TweenInfo.new(0.3)).Completed:Connect(function()
                        window.MainFrame.Visible = false
                    end)
                    button.Text = options.Text1 or "Open"
                else
                    window.MainFrame.Visible = true
                    tween(window.MainFrame, TweenInfo.new(0.3), {Position = window.Options.Position})
                    button.Text = options.Text2 or "Close"
                end
            end)

            if options.Draggable ~= false then
                MakeDraggable(button, button)
            end
        end)
        if not success then
            warn("[RainLib] Failed to create minimize button: " .. err)
            return nil
        end
        window.MinimizeButton = button
        return button
    end

    function window:Tab(options)
        local tab = { ElementCount = 0, Elements = {} }
        options = options or {}
        tab.Name = options.Title or "Tab"
        tab.Icon = options.Icon or nil

        tab.Content = Instance.new("ScrollingFrame")
        tab.Content.Size = UDim2.new(1, 0, 1, 0)
        tab.Content.BackgroundTransparency = 1
        tab.Content.Visible = false
        tab.Content.ScrollBarThickness = 5
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        tab.Content.Parent = window.ContentFrame

        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(0, 90, 0, 30)
        tab.Button.Position = UDim2.new(0, #window.Tabs * 95 + 5, 0, 5)
        tab.Button.Text = tab.Icon and "" or tab.Name
        tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        tab.Button.TextColor3 = RainLib.CurrentTheme.Text
        tab.Button.Font = Enum.Font.SourceSansBold
        tab.Button.TextSize = 16
        tab.Button.TextXAlignment = Enum.TextXAlignment.Left
        tab.Button.Parent = window.TabFrame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 5)
        corner.Parent = tab.Button

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Color = RainLib.CurrentTheme.Disabled
        stroke.Parent = tab.Button

        if tab.Icon then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 24, 0, 24)
            icon.Position = UDim2.new(0, 10, 0.5, -12)
            icon.BackgroundTransparency = 1
            icon.Image = RainLib.Icons[tab.Icon] or tab.Icon
            icon.Parent = tab.Button

            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, -40, 1, 0)
            text.Position = UDim2.new(0, 40, 0, 0)
            text.BackgroundTransparency = 1
            text.Text = tab.Name
            text.TextColor3 = RainLib.CurrentTheme.Text
            text.Font = Enum.Font.SourceSansBold
            text.TextSize = 16
            text.TextXAlignment = Enum.TextXAlignment.Left
            text.Parent = tab.Button
        end

        tab.Button.MouseButton1Click:Connect(function()
            for _, t in pairs(window.Tabs) do
                t.Button.BackgroundColor3 = RainLib.CurrentTheme.Secondary
                t.Content.Visible = false
            end
            tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            tab.Content.Visible = true
        end)

        table.insert(window.Tabs, tab)
        if #window.Tabs == 1 then
            tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            tab.Content.Visible = true
        end

        local function getNextPosition(elementSize)
            local padding = 10
            local row = tab.ElementCount
            local containerHeight = elementSize.Y.Offset + 20
            local yOffset = padding + row * (containerHeight + padding)
            tab.ElementCount = tab.ElementCount + 1
            tab.Content.CanvasSize = UDim2.new(0, 0, 0, yOffset + containerHeight + padding)
            return UDim2.new(0, padding, 0, yOffset)
        end

        local function createContainer(element, size)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(0, size.X.Offset + 20, 0, size.Y.Offset + 20)
            container.Position = getNextPosition(size)
            container.BackgroundTransparency = 1
            container.Parent = tab.Content
            element.Parent = container
            element.Position = UDim2.new(0, 10, 0, 10)
            table.insert(tab.Elements, {container = container, element = element})
            return container
        end

        function tab:AddSection(name)
            local sectionSize = UDim2.new(0, 380, 0, 30)
            local sectionContainer = Instance.new("Frame")
            sectionContainer.Size = sectionSize
            sectionContainer.BackgroundTransparency = 1

            local section = Instance.new("TextLabel")
            section.Size = UDim2.new(0, 380, 0, 30)
            section.BackgroundTransparency = 1
            section.Text = name or "Section"
            section.TextColor3 = RainLib.CurrentTheme.Text
            section.Font = Enum.Font.GothamBold
            section.TextSize = 18
            section.TextXAlignment = Enum.TextXAlignment.Left
            section.Parent = sectionContainer

            createContainer(sectionContainer, sectionSize)
            return section
        end

        function tab:AddParagraph(options)
            local paragraphSize = UDim2.new(0, 380, 0, 40)
            local frame = Instance.new("Frame")
            frame.Size = paragraphSize
            frame.BackgroundTransparency = 1

            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(0, 380, 0, 20)
            title.Text = options.Title or "Paragraph"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 12
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = frame

            local content = Instance.new("TextLabel")
            content.Size = UDim2.new(0, 380, 0, 20)
            content.Position = UDim2.new(0, 0, 0, 20)
            content.Text = options.Content or "Content"
            content.BackgroundTransparency = 1
            content.TextColor3 = RainLib.CurrentTheme.Text
            content.Font = Enum.Font.SourceSans
            content.TextSize = 10
            content.TextWrapped = true
            content.TextXAlignment = Enum.TextXAlignment.Left
            content.Parent = frame

            createContainer(frame, paragraphSize)
            return frame
        end

        function tab:AddButton(options)
            local buttonSize = UDim2.new(0, 380, 0, 40)
            local button = Instance.new("TextButton")
            button.Size = buttonSize
            button.Text = options.Title or "Button"
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 18

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = button

            button.MouseButton1Click:Connect(options.Callback or function() end)
            createContainer(button, buttonSize)
            return button
        end

        function tab:AddToggle(key, options)
            local toggleSize = UDim2.new(0, 380, 0, 40)
            local toggle = { Value = options.Default or false }
            local frame = Instance.new("TextButton")
            frame.Size = toggleSize
            frame.Text = (options.Title or "Toggle") .. ": " .. (toggle.Value and "ON" or "OFF")
            frame.BackgroundColor3 = RainLib.CurrentTheme.Accent
            frame.TextColor3 = RainLib.CurrentTheme.Text
            frame.Font = Enum.Font.SourceSansBold
            frame.TextSize = 18

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            frame.MouseButton1Click:Connect(function()
                toggle.Value = not toggle.Value
                frame.Text = (options.Title or "Toggle") .. ": " .. (toggle.Value and "ON" or "OFF")
                if options.Callback then
                    options.Callback(toggle.Value)
                end
            end)
            createContainer(frame, toggleSize)
            function toggle:OnChanged(callback)
                frame.MouseButton1Click:Connect(function()
                    callback(toggle.Value)
                end)
            end
            return toggle
        end

        function tab:AddSlider(key, options)
            local sliderSize = UDim2.new(0, 380, 0, 40)
            local slider = { Value = options.Default or options.Min or 0 }
            local frame = Instance.new("Frame")
            frame.Size = sliderSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 280, 0, 20)
            label.Text = options.Title or "Slider"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 12
            label.Parent = frame

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 80, 0, 20)
            valueLabel.Position = UDim2.new(1, -90, 0, 0)
            valueLabel.Text = tostring(slider.Value)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = RainLib.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SourceSans
            valueLabel.TextSize = 12
            valueLabel.Parent = frame

            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -10, 0, 8)
            bar.Position = UDim2.new(0, 5, 0, 25)
            bar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            bar.Parent = frame

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)
            fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
            fill.Parent = bar

            local cornerBar = Instance.new("UICorner")
            cornerBar.CornerRadius = UDim.new(0, 4)
            cornerBar.Parent = bar

            local cornerFill = Instance.new("UICorner")
            cornerFill.CornerRadius = UDim.new(0, 4)
            cornerFill.Parent = fill

            createContainer(frame, sliderSize)
            local dragging
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
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
                    tween(fill, TweenInfo.new(0.1), {Size = UDim2.new(relativeX, 0, 1, 0)})
                    valueLabel.Text = tostring(slider.Value)
                    if options.Callback then
                        options.Callback(slider.Value)
                    end
                end
            end)
            function slider:OnChanged(callback)
                RunService.RenderStepped:Connect(function()
                    if dragging then
                        callback(slider.Value)
                    end
                end)
            end
            function slider:SetValue(value)
                slider.Value = math.clamp(value, options.Min or 0, options.Max or 100)
                if options.Rounding then
                    slider.Value = math.floor(slider.Value / options.Rounding) * options.Rounding
                end
                tween(fill, TweenInfo.new(0.2), {Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)})
                valueLabel.Text = tostring(slider.Value)
            end
            return slider
        end

        function tab:AddDropdown(key, options)
            local dropdownSize = UDim2.new(0, 380, 0, 40)
            local dropdown = { Value = options.Default or (options.Multi and {} or options.Values[1]) }
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -30, 1, 0)
            label.Text = options.Multi and table.concat(next(dropdown.Value) and dropdown.Value or {}, ", ") or dropdown.Value
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.Parent = frame

            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 20, 1, 0)
            arrow.Position = UDim2.new(1, -25, 0, 0)
            arrow.Text = "▼"
            arrow.BackgroundTransparency = 1
            arrow.TextColor3 = RainLib.CurrentTheme.Text
            arrow.Font = Enum.Font.SourceSans
            arrow.TextSize = 14
            arrow.Parent = frame

            local list = Instance.new("Frame")
            list.Size = UDim2.new(1, 0, 0, #options.Values * 30)
            list.Position = UDim2.new(0, 0, 1, 5)
            list.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            list.BackgroundTransparency = 1
            list.Visible = false
            list.Parent = frame

            local listCorner = Instance.new("UICorner")
            listCorner.CornerRadius = UDim.new(0, 8)
            listCorner.Parent = list

            for i, opt in ipairs(options.Values) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 30)
                btn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
                btn.Text = opt
                btn.BackgroundTransparency = 0.2
                btn.BackgroundColor3 = RainLib.CurrentTheme.Secondary
                btn.TextColor3 = RainLib.CurrentTheme.Text
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 14
                btn.Parent = list

                btn.MouseButton1Click:Connect(function()
                    if options.Multi then
                        dropdown.Value[opt] = not dropdown.Value[opt]
                        local values = {}
                        for k, v in pairs(dropdown.Value) do
                            if v then table.insert(values, k) end
                        end
                        label.Text = table.concat(values, ", ")
                    else
                        dropdown.Value = opt
                        label.Text = opt
                        tween(list, TweenInfo.new(0.3), {BackgroundTransparency = 1}).Completed:Connect(function() list.Visible = false end)
                    end
                    if options.Callback then
                        options.Callback(dropdown.Value)
                    end
                end)
            end

            createContainer(frame, dropdownSize)
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    list.Visible = true
                    tween(list, TweenInfo.new(0.3), {BackgroundTransparency = 0})
                    tween(arrow, TweenInfo.new(0.2), {Rotation = list.Visible and 180 or 0})
                end
            end)
            function dropdown:OnChanged(callback)
                frame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        callback(dropdown.Value)
                    end
                end)
            end
            function dropdown:SetValue(value)
                if options.Multi then
                    dropdown.Value = {}
                    for k, v in pairs(value) do
                        if table.find(options.Values, k) then
                            dropdown.Value[k] = v
                        end
                    end
                    local values = {}
                    for k, v in pairs(dropdown.Value) do
                        if v then table.insert(values, k) end
                    end
                    label.Text = table.concat(values, ", ")
                else
                    if table.find(options.Values, value) then
                        dropdown.Value = value
                        label.Text = value
                    end
                end
            end
            return dropdown
        end

        function tab:AddColorpicker(key, options)
            local colorpickerSize = UDim2.new(0, 380, 0, 120)
            local colorpicker = { Value = options.Default or Color3.fromRGB(255, 255, 255) }
            local frame = Instance.new("Frame")
            frame.Size = colorpickerSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 280, 0, 20)
            label.Text = options.Title or "Colorpicker"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.Parent = frame

            local preview = Instance.new("Frame")
            preview.Size = UDim2.new(0, 30, 0, 30)
            preview.Position = UDim2.new(1, -40, 0, 5)
            preview.BackgroundColor3 = colorpicker.Value
            preview.Parent = frame

            local rSlider = tab:AddSlider("R", {Min = 0, Max = 255, Default = math.floor(colorpicker.Value.R * 255), Rounding = 1})
            rSlider.Element.Position = UDim2.new(0, 10, 0, 40)
            rSlider:OnChanged(function(value)
                colorpicker.Value = Color3.fromRGB(value, math.floor(colorpicker.Value.G * 255), math.floor(colorpicker.Value.B * 255))
                preview.BackgroundColor3 = colorpicker.Value
                if options.Callback then options.Callback(colorpicker.Value) end
            end)

            local gSlider = tab:AddSlider("G", {Min = 0, Max = 255, Default = math.floor(colorpicker.Value.G * 255), Rounding = 1})
            gSlider.Element.Position = UDim2.new(0, 10, 0, 70)
            gSlider:OnChanged(function(value)
                colorpicker.Value = Color3.fromRGB(math.floor(colorpicker.Value.R * 255), value, math.floor(colorpicker.Value.B * 255))
                preview.BackgroundColor3 = colorpicker.Value
                if options.Callback then options.Callback(colorpicker.Value) end
            end)

            local bSlider = tab:AddSlider("B", {Min = 0, Max = 255, Default = math.floor(colorpicker.Value.B * 255), Rounding = 1})
            bSlider.Element.Position = UDim2.new(0, 10, 0, 100)
            bSlider:OnChanged(function(value)
                colorpicker.Value = Color3.fromRGB(math.floor(colorpicker.Value.R * 255), math.floor(colorpicker.Value.G * 255), value)
                preview.BackgroundColor3 = colorpicker.Value
                if options.Callback then options.Callback(colorpicker.Value) end
            end)

            createContainer(frame, colorpickerSize)
            function colorpicker:OnChanged(callback)
                rSlider:OnChanged(callback)
                gSlider:OnChanged(callback)
                bSlider:OnChanged(callback)
            end
            function colorpicker:SetValueRGB(color)
                colorpicker.Value = color
                rSlider:SetValue(math.floor(color.R * 255))
                gSlider:SetValue(math.floor(color.G * 255))
                bSlider:SetValue(math.floor(color.B * 255))
                preview.BackgroundColor3 = color
                if options.Callback then options.Callback(color) end
            end
            return colorpicker
        end

        function tab:AddKeybind(key, options)
            local keybindSize = UDim2.new(0, 380, 0, 40)
            local keybind = { Value = options.Default or "None", Mode = options.Mode or "Toggle" }
            local frame = Instance.new("Frame")
            frame.Size = keybindSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 280, 1, 0)
            label.Text = options.Title or "Keybind"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.Parent = frame

            local keyLabel = Instance.new("TextLabel")
            keyLabel.Size = UDim2.new(0, 80, 1, 0)
            keyLabel.Position = UDim2.new(1, -90, 0, 0)
            keyLabel.Text = keybind.Value
            keyLabel.BackgroundTransparency = 1
            keyLabel.TextColor3 = RainLib.CurrentTheme.Text
            keyLabel.Font = Enum.Font.SourceSans
            keyLabel.TextSize = 14
            keyLabel.Parent = frame

            createContainer(frame, keybindSize)
            local waitingForInput = false
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    waitingForInput = true
                    tween(keyLabel, TweenInfo.new(0.2), {TextTransparency = 0.5})
                    keyLabel.Text = "..."
                end
            end)
            UserInputService.InputBegan:Connect(function(input)
                if waitingForInput and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    keybind.Value = input.KeyCode.Name or input.UserInputType.Name
                    keyLabel.Text = keybind.Value
                    tween(keyLabel, TweenInfo.new(0.2), {TextTransparency = 0})
                    waitingForInput = false
                    if options.ChangedCallback then
                        options.ChangedCallback(input.KeyCode or input.UserInputType)
                    end
                    if options.Callback then
                        options.Callback(true)
                    end
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if not waitingForInput and (input.KeyCode.Name == keybind.Value or input.UserInputType.Name == keybind.Value) then
                    if keybind.Mode == "Hold" and options.Callback then
                        options.Callback(false)
                    end
                end
            end)
            function keybind:GetState()
                return UserInputService:IsKeyDown(Enum.KeyCode[keybind.Value]) or UserInputService:GetMouseButtonPressed(Enum.UserInputType[keybind.Value])
            end
            function keybind:OnClick(callback)
                UserInputService.InputBegan:Connect(function(input)
                    if not waitingForInput and keybind.Mode == "Toggle" and (input.KeyCode.Name == keybind.Value or input.UserInputType.Name == keybind.Value) then
                        callback()
                    end
                end)
            end
            function keybind:OnChanged(callback)
                frame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        callback(keybind.Value)
                    end
                end)
            end
            function keybind:SetValue(key, mode)
                keybind.Value = key
                keybind.Mode = mode or keybind.Mode
                tween(keyLabel, TweenInfo.new(0.2), {Text = keybind.Value})
            end
            return keybind
        end

        function tab:AddInput(key, options)
            local inputSize = UDim2.new(0, 100, 0, 40)
            local input = { Value = options.Default or "" }
            local textbox = Instance.new("TextBox")
            textbox.Size = inputSize
            textbox.Text = input.Value
            textbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            textbox.TextColor3 = RainLib.CurrentTheme.Text
            textbox.Font = Enum.Font.SourceSans
            textbox.TextSize = 18
            textbox.PlaceholderText = options.Placeholder or ""
            textbox.PlaceholderColor3 = RainLib.CurrentTheme.Disabled

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = textbox

            local stroke = Instance.new("UIStroke")
            stroke.Thickness = 1
            stroke.Color = RainLib.CurrentTheme.Accent
            stroke.Transparency = 0.8
            stroke.Parent = textbox

            textbox.Focused:Connect(function()
                tween(stroke, TweenInfo.new(0.2), {Transparency = 0})
            end)
            textbox.FocusLost:Connect(function()
                tween(stroke, TweenInfo.new(0.2), {Transparency = 0.8})
            end)

            createContainer(textbox, inputSize)
            textbox.FocusLost:Connect(function(enterPressed)
                input.Value = options.Numeric and tonumber(textbox.Text) or textbox.Text
                if enterPressed and options.Callback then
                    options.Callback(input.Value)
                end
            end)
            function input:OnChanged(callback)
                textbox.Changed:Connect(function()
                    input.Value = options.Numeric and tonumber(textbox.Text) or textbox.Text
                    callback(input.Value)
                end)
            end
            return input
        end

        function tab:Dialog(options)
            local dialog = Instance.new("Frame")
            dialog.Size = UDim2.new(0, 300, 0, 150)
            dialog.Position = UDim2.new(0.5, -150, 0.5, 200)
            dialog.BackgroundColor3 = RainLib.CurrentTheme.Background
            dialog.BackgroundTransparency = 1
            dialog.Parent = RainLib.ScreenGui

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 12)
            corner.Parent = dialog

            local shadow = Instance.new("UIStroke")
            shadow.Thickness = 3
            shadow.Color = Color3.fromRGB(0, 0, 0)
            shadow.Transparency = 0.5
            shadow.Parent = dialog

            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -10, 0, 20)
            title.Position = UDim2.new(0, 5, 0, 5)
            title.Text = options.Title or "Dialog"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 16
            title.Parent = dialog

            local content = Instance.new("TextLabel")
            content.Size = UDim2.new(1, -10, 0, 60)
            content.Position = UDim2.new(0, 5, 0, 30)
            content.Text = options.Content or "Content"
            content.BackgroundTransparency = 1
            content.TextColor3 = RainLib.CurrentTheme.Text
            content.Font = Enum.Font.SourceSans
            content.TextSize = 14
            content.TextWrapped = true
            content.Parent = dialog

            for i, btn in ipairs(options.Buttons or {}) do
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(0, 80, 0, 30)
                button.Position = UDim2.new(0, 10 + (i-1) * 90, 1, -40)
                button.Text = btn.Title or "Button"
                button.BackgroundColor3 = RainLib.CurrentTheme.Accent
                button.TextColor3 = RainLib.CurrentTheme.Text
                button.Font = Enum.Font.SourceSansBold
                button.TextSize = 16
                button.Parent = dialog

                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 8)
                btnCorner.Parent = button

                button.MouseButton1Click:Connect(function()
                    if btn.Callback then
                        btn.Callback()
                    end
                    tween(dialog, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0.5, 200), BackgroundTransparency = 1}).Completed:Connect(function()
                        dialog:Destroy()
                    end)
                end)
            end

            tween(dialog, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0.5, -75), BackgroundTransparency = 0})
        end

        return tab
    end

    function window:SetOption(key, value)
        if defaultOptions[key] ~= nil then
            window.Options[key] = value
            if key == "Title" then
                window.TitleLabel.Text = value
            elseif key == "Position" then
                tween(window.MainFrame, TweenInfo.new(0.5), {Position = value})
            end
        else
            warn("[RainLib] Invalid option: " .. key)
        end
    end

    table.insert(RainLib.Windows, window)
    return window
end

function RainLib:Notify(window, options)
    local notification
    local targetNotifications = window and window.Notifications or RainLib.ScreenGui:FindFirstChild("Notifications") or Instance.new("Frame")
    if not targetNotifications.Parent then
        targetNotifications.Size = UDim2.new(0, 300, 1, -25)
        targetNotifications.Position = UDim2.new(1, -310, 0, 0)
        targetNotifications.BackgroundTransparency = 1
        targetNotifications.Name = "Notifications"
        targetNotifications.Parent = RainLib.ScreenGui
    end

    local success, err = pcall(function()
        notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 280, 0, 80)
        notification.Position = UDim2.new(1, 300, 0, (#targetNotifications:GetChildren() - 1) * 90 + 10)
        notification.BackgroundColor3 = RainLib.CurrentTheme.Background
        notification.BackgroundTransparency = 1
        notification.Parent = targetNotifications

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = notification

        local shadow = Instance.new("UIStroke")
        shadow.Thickness = 3
        shadow.Color = Color3.fromRGB(0, 0, 0)
        shadow.Transparency = 0.5
        shadow.Parent = notification

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -10, 0, 20)
        title.Position = UDim2.new(0, 5, 0, 5)
        title.Text = options.Title or "Notification"
        title.BackgroundTransparency = 1
        title.TextColor3 = RainLib.CurrentTheme.Text
        title.Font = Enum.Font.GothamBold
        title.TextSize = 16
        title.Parent = notification

        local message = Instance.new("TextLabel")
        message.Size = UDim2.new(1, -10, 0, 40)
        message.Position = UDim2.new(0, 5, 0, 30)
        message.Text = options.Content or "Message"
        message.BackgroundTransparency = 1
        message.TextColor3 = RainLib.CurrentTheme.Text
        message.Font = Enum.Font.SourceSans
        message.TextSize = 14
        message.TextWrapped = true
        message.Parent = notification

        tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(1, -290, 0, (#targetNotifications:GetChildren() - 1) * 90 + 10), BackgroundTransparency = 0})
    end)
    if success then
        task.spawn(function()
            task.wait(options.Duration or 3)
            tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(1, 300, 0, notification.Position.Y.Offset), BackgroundTransparency = 1}).Completed:Connect(function()
                notification:Destroy()
            end)
        end)
    else
        warn("[RainLib] Failed to create notification: " .. err)
    end
end

function RainLib:SetTheme(theme)
    local success, err = pcall(function()
        RainLib.CurrentTheme = theme
        for _, window in pairs(RainLib.Windows) do
            tween(window.MainFrame, TweenInfo.new(0.3), {BackgroundColor3 = theme.Background})
            tween(window.TitleLabel, TweenInfo.new(0.3), {TextColor3 = theme.Text})
            tween(window.TabFrame, TweenInfo.new(0.3), {BackgroundColor3 = theme.Secondary})
            for _, tab in pairs(window.Tabs) do
                tween(tab.Button, TweenInfo.new(0.3), {TextColor3 = theme.Text, BackgroundColor3 = tab.Content.Visible and theme.Accent or theme.Secondary})
                for _, child in pairs(tab.Content:GetChildren()) do
                    if child:IsA("TextButton") or child:IsA("TextBox") then
                        tween(child, TweenInfo.new(0.3), {BackgroundColor3 = child:IsA("TextBox") and Color3.fromRGB(60, 60, 60) or theme.Accent, TextColor3 = theme.Text})
                    elseif child:IsA("Frame") then
                        for _, subchild in pairs(child:GetChildren()) do
                            if subchild:IsA("TextLabel") then
                                tween(subchild, TweenInfo.new(0.3), {TextColor3 = theme.Text})
                            elseif subchild:IsA("Frame") then
                                tween(subchild, TweenInfo.new(0.3), {BackgroundColor3 = subchild.Parent.BackgroundColor3 == theme.Accent and theme.Accent or theme.Disabled})
                            end
                        end
                    end
                end
            end
        end
    end)
    if not success then
        warn("[RainLib] Failed to set theme: " .. err)
    end
end

function RainLib:Destroy()
    for _, conn in pairs(RainLib.Connections) do
        conn:Disconnect()
    end
    tween(RainLib.ScreenGui, TweenInfo.new(0.5), {BackgroundTransparency = 1}).Completed:Connect(function()
        RainLib.ScreenGui:Destroy()
    end)
end

print("[RainLib] Library loaded!")
return RainLib
