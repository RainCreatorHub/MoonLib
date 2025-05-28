local OrionLibV2 = {}
local Icons = {
	["ola"] = "hi"
}
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

function OrionLibV2:MakeWindow(Info)
    local TweenService = game:GetService("TweenService")
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "CheatGUI"

    local window = Instance.new("Frame")
    window.Name = "MainWindow"
    window.Parent = ScreenGui
    window.Size = UDim2.new(0, 500, 0, 350)
    window.Position = UDim2.new(0.5, -250, 0.5, -175)
    window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    window.Active = true
    window.Draggable = true
    Instance.new("UICorner", window).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", window)
    stroke.Thickness = 1.5
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Transparency = 0.4

    local gradient = Instance.new("UIGradient", window)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    }
    gradient.Rotation = 90

    local Title = Instance.new("TextLabel", window)
    Title.Text = Info.Title or "Orion"
    Title.Size = UDim2.new(0, 300, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20

    local SubTitle = Instance.new("TextLabel", window)
    SubTitle.Text = Info.SubTitle or "Orion Subtitle"
    SubTitle.Size = UDim2.new(0, 300, 0, 20)
    SubTitle.Position = UDim2.new(0, 10, 0, 35)
    SubTitle.BackgroundTransparency = 1
    SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextSize = 14

    local Separator = Instance.new("Frame", window)
    Separator.Size = UDim2.new(1, -20, 0, 1)
    Separator.Position = UDim2.new(0, 10, 0, 60)
    Separator.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

    local VerticalLine = Instance.new("Frame", window)
    VerticalLine.Size = UDim2.new(0, 1, 1, -80)
    VerticalLine.Position = UDim2.new(0, 135, 0, 70)
    VerticalLine.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    VerticalLine.BorderSizePixel = 0

    local TabScrollFrame = Instance.new("ScrollingFrame", window)
    TabScrollFrame.Size = UDim2.new(0, 120, 1, -80)
    TabScrollFrame.Position = UDim2.new(0, 10, 0, 70)
    TabScrollFrame.BackgroundTransparency = 1
    TabScrollFrame.ScrollBarThickness = 4
    TabScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    TabScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

    local ButtonY = 0
    local Tabs = {}
    local TabList = {}

    function Tabs:MakeTab(TabInfo)
        local Button = Instance.new("TextButton", TabScrollFrame)
        Button.Size = UDim2.new(0, 120, 0, 30)
        Button.Position = UDim2.new(0, 0, 0, ButtonY)
        Button.Text = ""
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14
        Button.AutoButtonColor = false
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

        local ContentFrame = Instance.new("Frame", Button)
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.ClipsDescendants = true

        local Icon
        if TabInfo.Icon and type(TabInfo.Icon) == "string" then
            Icon = Instance.new("ImageLabel", ContentFrame)
            Icon.Size = UDim2.new(0, 20, 0, 20)
            Icon.Position = UDim2.new(0, 5, 0.5, -10)
            Icon.BackgroundTransparency = 1
            local iconKey = string.lower(TabInfo.Icon)
            if Icons[iconKey] then
                Icon.Image = Icons[iconKey]
            elseif string.match(TabInfo.Icon, "^rbxassetid://%d+$") then
                Icon.Image = TabInfo.Icon
            else
                Icon:Destroy()
                Icon = nil
            end
        end

        local TextLabel = Instance.new("TextLabel", ContentFrame)
        TextLabel.Text = TabInfo.Name or "Tab"
        TextLabel.Size = UDim2.new(1, -30, 1, 0)
        TextLabel.Position = UDim2.new(0, 30, 0, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.TextSize = 14
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left

        ButtonY = ButtonY + 35
        TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ButtonY)

        local TabContent = Instance.new("ScrollingFrame", window)
        TabContent.Name = TabInfo.Name or "TabContent"
        TabContent.Size = UDim2.new(1, -150, 1, -80)
        TabContent.Position = UDim2.new(0, 140, 0, 70)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = (#TabList == 0)
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollingDirection = Enum.ScrollingDirection.Y
        TabContent.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        table.insert(TabList, TabContent)

        Button.MouseButton1Click:Connect(function()
            for _, f in ipairs(TabList) do
                f.Visible = false
            end
            TabContent.Visible = true
            for _, btn in ipairs(TabScrollFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                end
            end
            Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)

        local elementY = 0
        local TabFunctions = {}

        function TabFunctions:AddSection(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 25)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local sectionLabel = Instance.new("TextLabel", container)
            sectionLabel.Text = info.Name or "Section"
            sectionLabel.Size = UDim2.new(1, 0, 1, 0)
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.TextSize = 16
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.TextTransparency = 1

            TweenService:Create(sectionLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            elementY = elementY + 30
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)
            return container
        end

        function TabFunctions:AddLabel(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local stroke = Instance.new("UIStroke", container)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Thickness = 1.5

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 6)

            local title = Instance.new("TextLabel", container)
            title.Text = info.Name or "Label"
            title.Size = UDim2.new(1, -10, 0, 18)
            title.Position = UDim2.new(0, 5, 0, 5)
            title.BackgroundTransparency = 1
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.TextTransparency = 1
            title.TextScaled = true
            title.TextWrapped = false

            local content = Instance.new("TextLabel", container)
            content.Text = info.Content or "Texto"
            content.Size = UDim2.new(1, -10, 0, 18)
            content.Position = UDim2.new(0, 5, 0, 25)
            content.BackgroundTransparency = 1
            content.TextColor3 = Color3.fromRGB(180, 180, 180)
            content.Font = Enum.Font.Gotham
            content.TextSize = 13
            content.TextXAlignment = Enum.TextXAlignment.Left
            content.TextTransparency = 1
            content.TextScaled = true
            content.TextWrapped = false

            local TextService = game:GetService("TextService")
            local titleSize = TextService:GetTextSize(
                title.Text,
                title.TextSize,
                title.Font,
                Vector2.new(container.AbsoluteSize.X - 10, math.huge)
            )
            local contentSize = TextService:GetTextSize(
                content.Text,
                content.TextSize,
                content.Font,
                Vector2.new(container.AbsoluteSize.X - 10, math.huge)
            )

            title.Size = UDim2.new(1, -10, 0, titleSize.Y)
            content.Size = UDim2.new(1, -10, 0, contentSize.Y)
            content.Position = UDim2.new(0, 5, 0, 5 + titleSize.Y + 5)

            local containerHeight = titleSize.Y + contentSize.Y + 15
            container.Size = UDim2.new(1, -20, 0, containerHeight)

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(title, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(content, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            elementY = elementY + containerHeight + 20
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        function TabFunctions:AddButton(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local stroke = Instance.new("UIStroke", container)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Transparency = 0.5
            stroke.Thickness = 1.5

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 6)

            local button = Instance.new("TextButton", container)
            button.Size = UDim2.new(1, -10, 1, -10)
            button.Position = UDim2.new(0, 5, 0, 5)
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.GothamBold
            button.TextSize = 14
            button.Text = info.Name or "Button"
            button.TextXAlignment = Enum.TextXAlignment.Left
            button.AutoButtonColor = false
            button.BorderSizePixel = 0
            button.TextTransparency = 1
            button.BackgroundTransparency = 0.3
            button.ClipsDescendants = true

            local buttonCorner = Instance.new("UICorner", button)
            buttonCorner.CornerRadius = UDim.new(0, 6)

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0,
                BackgroundTransparency = 0
            }):Play()

            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            end)
            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
            end)

            if info.Callback and typeof(info.Callback) == "function" then
                button.MouseButton1Click:Connect(function()
                    info.Callback()
                end)
            end

            elementY = elementY + 60
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        function TabFunctions:AddToggle(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local stroke = Instance.new("UIStroke", container)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Transparency = 0.5
            stroke.Thickness = 1.5

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 6)

            local toggleText = Instance.new("TextLabel", container)
            toggleText.Text = info.Name or "Toggle"
            toggleText.Size = UDim2.new(1, -60, 0, 20)
            toggleText.Position = UDim2.new(0, 10, 0, 5)
            toggleText.BackgroundTransparency = 1
            toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleText.Font = Enum.Font.GothamBold
            toggleText.TextSize = 14
            toggleText.TextXAlignment = Enum.TextXAlignment.Left
            toggleText.TextTransparency = 1

            local toggleDescription = Instance.new("TextLabel", container)
            toggleDescription.Text = info.Description or ""
            toggleDescription.Size = UDim2.new(1, -60, 0, 15)
            toggleDescription.Position = UDim2.new(0, 10, 0, 25)
            toggleDescription.BackgroundTransparency = 1
            toggleDescription.TextColor3 = Color3.fromRGB(180, 180, 180)
            toggleDescription.Font = Enum.Font.Gotham
            toggleDescription.TextSize = 11
            toggleDescription.TextXAlignment = Enum.TextXAlignment.Left
            toggleDescription.TextTransparency = 1
            toggleDescription.TextWrapped = true

            local toggleButton = Instance.new("TextButton", container)
            toggleButton.Size = UDim2.new(0, 50, 0, 24)
            toggleButton.Position = UDim2.new(1, -60, 0.5, -12)
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            toggleButton.BorderSizePixel = 0
            toggleButton.AutoButtonColor = false
            toggleButton.Text = ""
            toggleButton.ClipsDescendants = true

            local toggleCorner = Instance.new("UICorner", toggleButton)
            toggleCorner.CornerRadius = UDim.new(0, 12)

            local toggleIndicator = Instance.new("Frame", toggleButton)
            toggleIndicator.Size = UDim2.new(0, 20, 0, 20)
            toggleIndicator.Position = UDim2.new(0, 2, 0.5, -10)
            toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleIndicator.BorderSizePixel = 0

            local indicatorCorner = Instance.new("UICorner", toggleIndicator)
            indicatorCorner.CornerRadius = UDim.new(0, 10)

            local isOn = info.Default or false
            local toggleBackgroundColor = isOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(toggleText, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(toggleDescription, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(toggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()

            local function updateToggle()
                isOn = (isOn == nil) and false or isOn
                toggleBackgroundColor = isOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
                local targetPosition = isOn and UDim2.new(0, 28, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = toggleBackgroundColor
                }):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Position = targetPosition
                }):Play()
                if info.Callback and typeof(info.Callback) == "function" then
                    info.Callback(isOn)
                end
            end

            toggleButton.MouseButton1Click:Connect(function()
                isOn = not isOn
                updateToggle()
            end)

            toggleButton.MouseEnter:Connect(function()
                if not isOn then
                    TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
                end
            end)
            toggleButton.MouseLeave:Connect(function()
                if not isOn then
                    TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                end
            end)

            updateToggle()

            elementY = elementY + 60
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        function TabFunctions:AddDropdown(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local stroke = Instance.new("UIStroke", container)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Transparency = 0.5
            stroke.Thickness = 1

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 10)

            local title = Instance.new("TextLabel", container)
            title.Text = info.Name or "Dropdown"
            title.Size = UDim2.new(0.6, -100, 0, 20)
            title.Position = UDim2.new(0, 10, 0, 1)
            title.BackgroundTransparency = 1
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.TextTransparency = 1

            local description = Instance.new("TextLabel", container)
            description.Text = info.Description or ""
            description.Size = UDim2.new(0.6, -100, 0, 20)
            description.Position = UDim2.new(0, 10, 0, 20)
            description.BackgroundTransparency = 1
            description.TextColor3 = Color3.fromRGB(180, 180, 180)
            description.Font = Enum.Font.Gotham
            description.TextSize = 11
            description.TextXAlignment = Enum.TextXAlignment.Left
            description.TextTransparency = 1
            description.TextWrapped = true

            local Dropdown = {
                Values = info.Values or {},
                Value = info.Default,
                Multi = info.Multi or false,
                Buttons = {},
                Opened = false,
                Callback = info.Callback or function() end,
            }

            local DropdownInner = Instance.new("TextButton", container)
            DropdownInner.Size = UDim2.new(0, 160, 0, 30)
            DropdownInner.Position = UDim2.new(1, -10, 0.5, 0)
            DropdownInner.AnchorPoint = Vector2.new(1, 0.5)
            DropdownInner.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropdownInner.BackgroundTransparency = 0
            DropdownInner.AutoButtonColor = false
            DropdownInner.Text = ""
            DropdownInner.BorderSizePixel = 0
            Instance.new("UICorner", DropdownInner).CornerRadius = UDim.new(0, 8)
            local innerStroke = Instance.new("UIStroke", DropdownInner)
            innerStroke.Transparency = 0.5
            innerStroke.Color = Color3.fromRGB(100, 100, 100)
            local innerGradient = Instance.new("UIGradient", DropdownInner)
            innerGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
            }
            innerGradient.Rotation = 90

            local DropdownDisplay = Instance.new("TextLabel", DropdownInner)
            DropdownDisplay.Text = ""
            DropdownDisplay.Size = UDim2.new(1, -40, 0, 14)
            DropdownDisplay.Position = UDim2.new(0, 12, 0.5, 0)
            DropdownDisplay.AnchorPoint = Vector2.new(0, 0.5)
            DropdownDisplay.BackgroundTransparency = 1
            DropdownDisplay.TextColor3 = Color3.fromRGB(220, 220, 220)
            DropdownDisplay.Font = Enum.Font.Gotham
            DropdownDisplay.TextSize = 13
            DropdownDisplay.TextXAlignment = Enum.TextXAlignment.Left
            DropdownDisplay.TextTruncate = Enum.TextTruncate.AtEnd

            local DropdownIco = Instance.new("ImageLabel", DropdownInner)
            DropdownIco.Image = "rbxassetid://10709790948"
            DropdownIco.Size = UDim2.fromOffset(14, 14)
            DropdownIco.Position = UDim2.new(1, -10, 0.5, 0)
            DropdownIco.AnchorPoint = Vector2.new(1, 0.5)
            DropdownIco.BackgroundTransparency = 1
            DropdownIco.ImageColor3 = Color3.fromRGB(150, 150, 150)
            DropdownIco.Rotation = 0

            local DropdownListLayout = Instance.new("UIListLayout")
            DropdownListLayout.Padding = UDim.new(0, 4)
            DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local DropdownScrollFrame = Instance.new("ScrollingFrame")
            DropdownScrollFrame.Size = UDim2.new(1, -10, 1, -10)
            DropdownScrollFrame.Position = UDim2.fromOffset(5, 5)
            DropdownScrollFrame.BackgroundTransparency = 1
            DropdownScrollFrame.ScrollBarThickness = 3
            DropdownScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
            DropdownScrollFrame.ScrollBarImageTransparency = 0.7
            DropdownScrollFrame.BorderSizePixel = 0
            DropdownScrollFrame.CanvasSize = UDim2.fromScale(0, 0)
            DropdownScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
            DropdownScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
            DropdownListLayout.Parent = DropdownScrollFrame

            local DropdownHolderFrame = Instance.new("Frame")
            DropdownHolderFrame.Size = UDim2.fromScale(1, 0)
            DropdownHolderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            DropdownHolderFrame.BackgroundTransparency = 0.1
            Instance.new("UICorner", DropdownHolderFrame).CornerRadius = UDim.new(0, 8)
            local holderStroke = Instance.new("UIStroke", DropdownHolderFrame)
            holderStroke.Color = Color3.fromRGB(100, 100, 100)
            holderStroke.Transparency = 1
            holderStroke.Thickness = 1
            DropdownScrollFrame.Parent = DropdownHolderFrame

            local shadow = Instance.new("ImageLabel", DropdownHolderFrame)
            shadow.BackgroundTransparency = 1
            shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
            shadow.ScaleType = Enum.ScaleType.Slice
            shadow.SliceCenter = Rect.new(23, 23, 277, 277)
            shadow.Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(40, 40)
            shadow.Position = UDim2.fromOffset(-20, -20)
            shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
            shadow.ImageTransparency = 0.3

            local DropdownHolderCanvas = Instance.new("Frame", window)
            DropdownHolderCanvas.BackgroundTransparency = 1
            DropdownHolderCanvas.Size = UDim2.fromOffset(170, 0)
            DropdownHolderCanvas.Visible = false
            DropdownHolderFrame.Parent = DropdownHolderCanvas
            local sizeConstraint = Instance.new("UISizeConstraint", DropdownHolderCanvas)
            sizeConstraint.MinSize = Vector2.new(170, 0)

            local function RecalculateListPosition()
                local canvasHeight = DropdownHolderCanvas.Size.Y.Offset
                local buttonY = DropdownInner.AbsolutePosition.Y
                DropdownHolderCanvas.Position = UDim2.fromOffset(
                    DropdownInner.AbsolutePosition.X - window.AbsolutePosition.X,
                    buttonY - canvasHeight + 20 -- 10 studs abaixo + mais 10 studs abaixo
                )
            end

            local ListSizeX = 0
            local function RecalculateListSize()
                local contentHeight = DropdownListLayout.AbsoluteContentSize.Y + 10
                if #Dropdown.Values > 10 then
                    contentHeight = 390
                end
                DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, contentHeight)
                RecalculateListPosition()
            end

            local function RecalculateCanvasSize()
                DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, DropdownListLayout.AbsoluteContentSize.Y)
            end

            -- Inicializar a posição da lista
            RecalculateListPosition()
            RecalculateListSize()

            -- Conexão para arrastar e atualização dinâmica
            local isDragging = false
            local connection
            local function StartPositionUpdate()
                if not connection then
                    connection = RunService.RenderStepped:Connect(function()
                        if Dropdown.Opened and isDragging then
                            RecalculateListPosition()
                        end
                    end)
                end
            end

            local function StopPositionUpdate()
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end

            window.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = true
                    StartPositionUpdate()
                end
            end)

            window.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = false
                end
            end)

            DropdownInner.MouseButton1Click:Connect(function()
                if Dropdown.Opened then
                    Dropdown:Close()
                else
                    Dropdown:Open()
                end
                TweenService:Create(DropdownInner, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = Dropdown.Opened and 0.2 or 0
                }):Play()
            end)

            DropdownInner.MouseEnter:Connect(function()
                TweenService:Create(innerStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(120, 120, 120)}):Play()
                TweenService:Create(DropdownInner, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
            end)
            DropdownInner.MouseLeave:Connect(function()
                if not Dropdown.Opened then
                    TweenService:Create(innerStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(100, 100, 100)}):Play()
                    TweenService:Create(DropdownInner, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
                end
            end)

            UserInputService.InputBegan:Connect(function(input)
                if Dropdown.Opened and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                    local absPos, absSize = DropdownHolderFrame.AbsolutePosition, DropdownHolderFrame.AbsoluteSize
                    if not (Mouse.X >= absPos.X and Mouse.X <= absPos.X + absSize.X and
                            Mouse.Y >= absPos.Y and Mouse.Y <= absPos.Y + absSize.Y) then
                        Dropdown:Close()
                    end
                end
            end)

            function Dropdown:Open()
                Dropdown.Opened = true
                TabScrollFrame.ScrollingEnabled = false
                DropdownHolderCanvas.Visible = true
                TweenService:Create(DropdownIco, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Rotation = 180}):Play()
                TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 0
                }):Play()
                TweenService:Create(holderStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Transparency = 0.5}):Play()
                TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                    Position = UDim2.new(0, 0, 0, -5)
                }):Play()
                RecalculateListPosition() -- Atualiza a posição inicial
            end

            function Dropdown:Close()
                Dropdown.Opened = false
                TabScrollFrame.ScrollingEnabled = true
                TweenService:Create(DropdownIco, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Rotation = 0}):Play()
                TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Size = UDim2.fromScale(1, 0),
                    BackgroundTransparency = 0.1
                }):Play()
                TweenService:Create(holderStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Transparency = 1}):Play()
                TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Position = UDim2.new(0, 0, 0, 10)
                }):Play()
                wait(0.3)
                DropdownHolderCanvas.Visible = false
                StopPositionUpdate()
            end

            function Dropdown:Display()
                local Str = ""
                if Dropdown.Multi then
                    for Value, Bool in pairs(Dropdown.Value) do
                        if Bool then
                            Str = Str .. Value .. ", "
                        end
                    end
                    Str = Str:sub(1, #Str - 1)
                else
                    Str = Dropdown.Value or ""
                end
                DropdownDisplay.Text = (Str == "" and "" or Str)
            end

            function Dropdown:GetActiveValues()
                if Dropdown.Multi then
                    local T = {}
                    for Value, Bool in pairs(Dropdown.Value) do
                        if Bool then
                            table.insert(T, Value)
                        end
                    end
                    return T
                else
                    return Dropdown.Value and 1 or nil
                end
            end

            function Dropdown:BuildDropdownList()
                for _, Element in next, DropdownScrollFrame:GetChildren() do
                    if not Element:IsA("UIListLayout") then
                        Element:Destroy()
                    end
                end

                local Count = 0
                local DropdownList = {}

                for _, Value in ipairs(Dropdown.Values) do
                    local Table = {}
                    Count = Count + 1

                    local button = Instance.new("TextButton", DropdownScrollFrame)
                    button.Size = UDim2.new(1, -5, 0, 34)
                    button.BackgroundTransparency = 1
                    button.ZIndex = 23
                    button.Text = ""
                    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

                    local checkmark = Instance.new("ImageLabel", button)
                    checkmark.Size = UDim2.fromOffset(14, 14)
                    checkmark.Position = UDim2.new(0, 8, 0.5, 0)
                    checkmark.BackgroundTransparency = 1
                    checkmark.Image = "rbxassetid://1070976000"
                    checkmark.ImageTransparency = 1
                    checkmark.ImageColor3 = Color3.fromRGB(76, 194, 255)

                    local buttonLabel = Instance.new("TextLabel", button)
                    buttonLabel.Text = Value
                    buttonLabel.Size = UDim2.new(1, -30, 1, 0)
                    buttonLabel.Position = UDim2.fromOffset(30, 0)
                    buttonLabel.BackgroundTransparency = 1
                    buttonLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                    buttonLabel.Font = Enum.Font.Gotham
                    buttonLabel.TextSize = 13
                    buttonLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local Selected
                    if Dropdown.Multi then
                        Selected = Dropdown.Value[Value]
                    else
                        Selected = Dropdown.Value == Value
                    end

                    local function updateButton()
                        if Dropdown.Multi then
                            Selected = Dropdown.Value[Value]
                        else
                            Selected = Dropdown.Value == Value
                        end
                        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                            BackgroundTransparency = Selected and 0.7 or 1
                        }):Play()
                        TweenService:Create(checkmark, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                            ImageTransparency = (Dropdown.Multi and Selected) and 0 or 1
                        }):Play()
                    end

                    button.MouseEnter:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.2), {
                            BackgroundTransparency = Selected and 0.6 or 0.85,
                            Size = UDim2.new(1, -5, 0, 35)
                        }):Play()
                    end)
                    button.MouseLeave:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.2), {
                            BackgroundTransparency = Selected and 0.7 or 1,
                            Size = UDim2.new(1, -5, 0, 34)
                        }):Play()
                    end)
                    button.MouseButton1Down:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.1), {
                            BackgroundTransparency = 0.5
                        }):Play()
                    end)
                    button.MouseButton1Up:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.2), {
                            BackgroundTransparency = Selected and 0.6 or 0.85
                        }):Play()
                    end)

                    button.MouseButton1Click:Connect(function()
                        local Try = not Selected
                        if Dropdown:GetActiveValues() == 1 and not Try and not info.Multi then
                            -- Do nothing if single selection and trying to deselect
                        else
                            if Dropdown.Multi then
                                Selected = Try
                                Dropdown.Value[Value] = Selected and true or nil
                            else
                                Selected = Try
                                Dropdown.Value = Selected and Value or nil
                                for _, OtherButton in next, DropdownList do
                                    OtherButton:UpdateButton()
                                end
                            end
                            Table:UpdateButton()
                            Dropdown:Display()
                            if Dropdown.Callback then
                                Dropdown.Callback(Dropdown.Value)
                            end
                        end
                    end)

                    Table.UpdateButton = updateButton
                    DropdownList[button] = Table

                    updateButton()
                    Dropdown:Display()

                    if buttonLabel.TextBounds.X > ListSizeX then
                        ListSizeX = buttonLabel.TextBounds.X + 40
                    end
                end

                ListSizeX = math.max(ListSizeX, 170)
                RecalculateListSize()
                RecalculateCanvasSize()
            end

            function Dropdown:SetValues(NewValues)
                if NewValues then
                    Dropdown.Values = NewValues
                end
                Dropdown:BuildDropdownList()
            end

            function Dropdown:SetValue(Val)
                if Dropdown.Multi then
                    local nTable = {}
                    for _, Value in next, Val do
                        if table.find(Dropdown.Values, Value) then
                            nTable[Value] = true
                        end
                    end
                    Dropdown.Value = nTable
                else
                    if not Val or table.find(Dropdown.Values, Val) then
                        Dropdown.Value = Val
                    end
                end
                Dropdown:BuildDropdownList()
                Dropdown:Display()
                if Dropdown.Callback then
                    Dropdown.Callback(Dropdown.Value)
                end
            end

            local Defaults = {}
            if type(info.Default) == "string" then
                if table.find(Dropdown.Values, info.Default) then
                    table.insert(Defaults, info.Default)
                end
            elseif type(info.Default) == "table" then
                for _, Value in next, info.Default do
                    if table.find(Dropdown.Values, Value) then
                        table.insert(Defaults, Value)
                    end
                end
            elseif type(info.Default) == "number" and Dropdown.Values[info.Default] then
                table.insert(Defaults, Dropdown.Values[info.Default])
            end

            if next(Defaults) then
                if Dropdown.Multi then
                    Dropdown.Value = {}
                    for _, Value in ipairs(Defaults) do
                        Dropdown.Value[Value] = true
                    end
                else
                    Dropdown.Value = Defaults[1]
                end
            elseif Dropdown.Multi then
                Dropdown.Value = {}
            else
                Dropdown.Value = nil
            end

            Dropdown:BuildDropdownList()
            Dropdown:Display()

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            TweenService:Create(title, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
            TweenService:Create(description, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
            TweenService:Create(DropdownInner, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            TweenService:Create(innerStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Transparency = 0.5}):Play()

            elementY = elementY + 60
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        return TabFunctions
    end

    return Tabs
end

return OrionLibV2
