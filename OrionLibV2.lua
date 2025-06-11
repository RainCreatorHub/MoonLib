local OrionLibV2 = {}

-- Função auxiliar para criar elementos com configurações padrão
local function ApplyCommonStyles(element, cornerRadius, strokeColor)
    local corner = Instance.new("UICorner", element)
    corner.CornerRadius = UDim.new(0, cornerRadius or 6)
    
    local stroke = Instance.new("UIStroke", element)
    stroke.Thickness = 1.5
    stroke.Color = strokeColor or Color3.fromRGB(80, 80, 80)
    stroke.Transparency = 0.5
end

function OrionLibV2:MakeWindow(Info)
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local Camera = game:GetService("Workspace").CurrentCamera

    local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
    local screenScale = isMobile and math.min(Camera.ViewportSize.X, Camera.ViewportSize.Y) / 500 or 1

    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "CheatGUI"

    local windowFrame = Instance.new("Frame")
    windowFrame.Name = "MainWindow"
    windowFrame.Parent = ScreenGui
    windowFrame.Size = UDim2.new(0, 500 * screenScale, 0, 350 * screenScale)
    windowFrame.Position = UDim2.new(0.5, -250 * screenScale, 0.5, -175 * screenScale)
    windowFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    windowFrame.Active = true
    windowFrame.Draggable = true
    ApplyCommonStyles(windowFrame, 12 * screenScale, Color3.fromRGB(0, 0, 0))

    local gradient = Instance.new("UIGradient", windowFrame)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    }
    gradient.Rotation = 90

    local Title = Instance.new("TextLabel", windowFrame)
    Title.Text = Info.Title or "Orion"
    Title.Size = UDim2.new(0, 300 * screenScale, 0, 30 * screenScale)
    Title.Position = UDim2.new(0, 10 * screenScale, 0, 5 * screenScale)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20 * screenScale

    local SubTitle = Instance.new("TextLabel", windowFrame)
    SubTitle.Text = Info.SubTitle or "Orion Subtitle"
    SubTitle.Size = UDim2.new(0, 300 * screenScale, 0, 20 * screenScale)
    SubTitle.Position = UDim2.new(0, 10 * screenScale, 0, 35 * screenScale)
    SubTitle.BackgroundTransparency = 1
    SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextSize = 14 * screenScale

    local Separator = Instance.new("Frame", windowFrame)
    Separator.Size = UDim2.new(1, -20 * screenScale, 0, 1 * screenScale)
    Separator.Position = UDim2.new(0, 10 * screenScale, 0, 60 * screenScale)
    Separator.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

    local VerticalLine = Instance.new("Frame", windowFrame)
    VerticalLine.Size = UDim2.new(0, 1 * screenScale, 1, -80 * screenScale)
    VerticalLine.Position = UDim2.new(0, 135 * screenScale, 0, 70 * screenScale)
    VerticalLine.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    VerticalLine.BorderSizePixel = 0

    local TabScrollFrame = Instance.new("ScrollingFrame", windowFrame)
    TabScrollFrame.Size = UDim2.new(0, 120 * screenScale, 1, -80 * screenScale)
    TabScrollFrame.Position = UDim2.new(0, 10 * screenScale, 0, 70 * screenScale)
    TabScrollFrame.BackgroundTransparency = 1
    TabScrollFrame.ScrollBarThickness = 4 * screenScale
    TabScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    TabScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

    local ButtonY = 0
    local TabList = {}
    local Window = {}

    function Window:MakeTab(TabInfo)
        local Button = Instance.new("TextButton", TabScrollFrame)
        Button.Size = UDim2.new(0, 120 * screenScale, 0, 30 * screenScale)
        Button.Position = UDim2.new(0, 0, 0, ButtonY)
        Button.Text = TabInfo.Name or "Tab"
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14 * screenScale
        Button.AutoButtonColor = false
        ApplyCommonStyles(Button, 6 * screenScale)

        ButtonY = ButtonY + 35 * screenScale
        TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ButtonY)

        local TabContent = Instance.new("ScrollingFrame", windowFrame)
        TabContent.Name = TabInfo.Name or "TabContent"
        TabContent.Size = UDim2.new(1, -150 * screenScale, 1, -80 * screenScale)
        TabContent.Position = UDim2.new(0, 140 * screenScale, 0, 70 * screenScale)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = (#TabList == 0)
        TabContent.ScrollBarThickness = 4 * screenScale
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollingDirection = Enum.ScrollingDirection.Y
        TabContent.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        table.insert(TabList, TabContent)

        Button.MouseButton1Click:Connect(function()
            for _, f in ipairs(TabList) do f.Visible = false end
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
            container.Size = UDim2.new(1, -20 * screenScale, 0, 25 * screenScale)
            container.Position = UDim2.new(0, 10 * screenScale, 0, elementY + 20 * screenScale)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local sectionLabel = Instance.new("TextLabel", container)
            sectionLabel.Text = info.Name or "Section"
            sectionLabel.Size = UDim2.new(1, 0, 1, 0)
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.TextSize = 16 * screenScale
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.TextTransparency = 1

            TweenService:Create(sectionLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            elementY = elementY + 30 * screenScale
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)
            return container
        end

        function TabFunctions:AddLabel(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20 * screenScale, 0, 50 * screenScale)
            container.Position = UDim2.new(0, 10 * screenScale, 0, elementY + 20 * screenScale)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0
            ApplyCommonStyles(container)

            local title = Instance.new("TextLabel", container)
            title.Text = info.Name or "Label"
            title.Size = UDim2.new(1, -10 * screenScale, 0, 18 * screenScale)
            title.Position = UDim2.new(0, 5 * screenScale, 0, 5 * screenScale)
            title.BackgroundTransparency = 1
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14 * screenScale
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.TextTransparency = 1

            local content = Instance.new("TextLabel", container)
            content.Text = info.Content or "Texto"
            content.Size = UDim2.new(1, -10 * screenScale, 0, 18 * screenScale)
            content.Position = UDim2.new(0, 5 * screenScale, 0, 25 * screenScale)
            content.BackgroundTransparency = 1
            content.TextColor3 = Color3.fromRGB(180, 180, 180)
            content.Font = Enum.Font.Gotham
            content.TextSize = 13 * screenScale
            content.TextXAlignment = Enum.TextXAlignment.Left
            content.TextTransparency = 1

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(title, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(content, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            elementY = elementY + 60 * screenScale
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        function TabFunctions:AddButton(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20 * screenScale, 0, 50 * screenScale)
            container.Position = UDim2.new(0, 10 * screenScale, 0, elementY + 20 * screenScale)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0
            ApplyCommonStyles(container)

            local button = Instance.new("TextButton", container)
            button.Size = UDim2.new(1, -10 * screenScale, 1, -10 * screenScale)
            button.Position = UDim2.new(0, 5 * screenScale, 0, 5 * screenScale)
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.GothamBold
            button.TextSize = 14 * screenScale
            button.Text = info.Name or "Button"
            button.TextXAlignment = Enum.TextXAlignment.Left
            button.AutoButtonColor = false
            button.BorderSizePixel = 0
            button.TextTransparency = 1
            button.BackgroundTransparency = 0.3
            button.ClipsDescendants = true
            ApplyCommonStyles(button)

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

            elementY = elementY + 60 * screenScale
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        function TabFunctions:AddToggle(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20 * screenScale, 0, 50 * screenScale)
            container.Position = UDim2.new(0, 10 * screenScale, 0, elementY + 20 * screenScale)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0
            ApplyCommonStyles(container)

            local toggleText = Instance.new("TextLabel", container)
            toggleText.Text = info.Name or "Toggle"
            toggleText.Size = UDim2.new(1, -60 * screenScale, 0, 20 * screenScale)
            toggleText.Position = UDim2.new(0, 10 * screenScale, 0, 5 * screenScale)
            toggleText.BackgroundTransparency = 1
            toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleText.Font = Enum.Font.GothamBold
            toggleText.TextSize = 14 * screenScale
            toggleText.TextXAlignment = Enum.TextXAlignment.Left
            toggleText.TextTransparency = 1

            local toggleDescription = Instance.new("TextLabel", container)
            toggleDescription.Text = info.Description or ""
            toggleDescription.Size = UDim2.new(1, -60 * screenScale, 0, 15 * screenScale)
            toggleDescription.Position = UDim2.new(0, 10 * screenScale, 0, 25 * screenScale)
            toggleDescription.BackgroundTransparency = 1
            toggleDescription.TextColor3 = Color3.fromRGB(180, 180, 180)
            toggleDescription.Font = Enum.Font.Gotham
            toggleDescription.TextSize = 11 * screenScale
            toggleDescription.TextXAlignment = Enum.TextXAlignment.Left
            toggleDescription.TextWrapped = true
            toggleDescription.TextTransparency = 1

            local toggleButton = Instance.new("TextButton", container)
            toggleButton.Size = UDim2.new(0, 50 * screenScale, 0, 24 * screenScale)
            toggleButton.Position = UDim2.new(1, -60 * screenScale, 0.5, -12 * screenScale)
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            toggleButton.BorderSizePixel = 0
            toggleButton.AutoButtonColor = false
            toggleButton.Text = ""
            toggleButton.ClipsDescendants = true
            ApplyCommonStyles(toggleButton, 12 * screenScale)

            local toggleIndicator = Instance.new("Frame", toggleButton)
            toggleIndicator.Size = UDim2.new(0, 20 * screenScale, 0, 20 * screenScale)
            toggleIndicator.Position = UDim2.new(0, 2 * screenScale, 0.5, -10 * screenScale)
            toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleIndicator.BorderSizePixel = 0
            ApplyCommonStyles(toggleIndicator, 10 * screenScale)

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
                local targetPosition = isOn and UDim2.new(0, 28 * screenScale, 0.5, -10 * screenScale) or UDim2.new(0, 2 * screenScale, 0.5, -10 * screenScale)
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

            elementY = elementY + 60 * screenScale
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        function TabFunctions:AddDropdown(Config)
            local Dropdown = {
                Values = Config.Values or {},
                Value = Config.Default,
                Multi = Config.Multi or false,
                Buttons = {},
                Opened = false,
                Type = "Dropdown",
                Callback = Config.Callback or function() end,
                Changed = Config.Changed or function() end,
            }

            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20 * screenScale, 0, 50 * screenScale)
            container.Position = UDim2.new(0, 10 * screenScale, 0, elementY + 20 * screenScale)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0
            ApplyCommonStyles(container)

            local DropdownDisplay = Instance.new("TextLabel", container)
            DropdownDisplay.Text = "Value"
            DropdownDisplay.TextColor3 = Color3.fromRGB(240, 240, 240)
            DropdownDisplay.TextSize = 13 * screenScale
            DropdownDisplay.TextXAlignment = Enum.TextXAlignment.Left
            DropdownDisplay.Size = UDim2.new(1, -30 * screenScale, 0, 14 * screenScale)
            DropdownDisplay.Position = UDim2.new(0, 8 * screenScale, 0.5, 0)
            DropdownDisplay.AnchorPoint = Vector2.new(0, 0.5)
            DropdownDisplay.BackgroundTransparency = 1
            DropdownDisplay.TextTruncate = Enum.TextTruncate.AtEnd

            local DropdownIco = Instance.new("ImageLabel", container)
            DropdownIco.Image = "rbxassetid://10709790948"
            DropdownIco.Size = UDim2.fromOffset(16 * screenScale, 16 * screenScale)
            DropdownIco.AnchorPoint = Vector2.new(1, 0.5)
            DropdownIco.Position = UDim2.new(1, -8 * screenScale, 0.5, 0)
            DropdownIco.BackgroundTransparency = 1
            DropdownIco.ImageColor3 = Color3.fromRGB(180, 180, 180)

            local DropdownInner = Instance.new("TextButton", container)
            DropdownInner.Size = UDim2.fromOffset(160 * screenScale, 30 * screenScale)
            DropdownInner.Position = UDim2.new(1, -10 * screenScale, 0.5, 0)
            DropdownInner.AnchorPoint = Vector2.new(1, 0.5)
            DropdownInner.BackgroundTransparency = 0.9
            DropdownInner.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ApplyCommonStyles(DropdownInner, 5 * screenScale, Color3.fromRGB(100, 100, 100))

            local DropdownListLayout = Instance.new("UIListLayout")
            DropdownListLayout.Padding = UDim.new(0, 3 * screenScale)

            local DropdownScrollFrame = Instance.new("ScrollingFrame")
            DropdownScrollFrame.Size = UDim2.new(1, -5 * screenScale, 1, -10 * screenScale)
            DropdownScrollFrame.Position = UDim2.fromOffset(5 * screenScale, 5 * screenScale)
            DropdownScrollFrame.BackgroundTransparency = 1
            DropdownScrollFrame.ScrollBarThickness = 4 * screenScale
            DropdownScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
            DropdownScrollFrame.ScrollBarImageTransparency = 0.95
            DropdownScrollFrame.CanvasSize = UDim2.fromScale(0, 0)
            DropdownScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
            DropdownScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

            local DropdownHolderFrame = Instance.new("Frame")
            DropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
            DropdownHolderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ApplyCommonStyles(DropdownHolderFrame, 7 * screenScale)
            DropdownHolderFrame.Parent = ScreenGui
            DropdownHolderFrame.Visible = false
            DropdownScrollFrame.Parent = DropdownHolderFrame
            DropdownListLayout.Parent = DropdownScrollFrame

            local DropdownHolderCanvas = Instance.new("Frame", ScreenGui)
            DropdownHolderCanvas.BackgroundTransparency = 1
            DropdownHolderCanvas.Size = UDim2.fromOffset(170 * screenScale, 300 * screenScale)
            DropdownHolderCanvas.Visible = false
            DropdownHolderFrame.Parent = DropdownHolderCanvas

            local function RecalculateListPosition()
                local Add = 0
                if Camera.ViewportSize.Y - DropdownInner.AbsolutePosition.Y < DropdownHolderCanvas.AbsoluteSize.Y then
                    Add = DropdownHolderCanvas.AbsoluteSize.Y - (Camera.ViewportSize.Y - DropdownInner.AbsolutePosition.Y) + 40 * screenScale
                end
                DropdownHolderCanvas.Position = UDim2.fromOffset(DropdownInner.AbsolutePosition.X - 1 * screenScale, DropdownInner.AbsolutePosition.Y - 5 * screenScale - Add)
            end

            local ListSizeX = 0
            local function RecalculateListSize()
                if #Dropdown.Values > 10 then
                    DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, 392 * screenScale)
                else
                    local totalHeight = DropdownListLayout.AbsoluteContentSize.Y + 10 * screenScale
                    DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, totalHeight)
                end
            end

            local function RecalculateCanvasSize()
                DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, DropdownListLayout.AbsoluteContentSize.Y)
            end

            RecalculateListPosition()
            RecalculateListSize()

            DropdownInner:GetPropertyChangedSignal("AbsolutePosition"):Connect(RecalculateListPosition)

            local function HandleInput(input)
                if isMobile then
                    if input.UserInputType == Enum.UserInputType.Touch then
                        Dropdown:Open()
                    end
                else
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dropdown:Open()
                    end
                end
            end

            DropdownInner.InputBegan:Connect(HandleInput)

            UserInputService.InputBegan:Connect(function(Input)
                if (isMobile and Input.UserInputType == Enum.UserInputType.Touch) or (not isMobile and Input.UserInputType == Enum.UserInputType.MouseButton1) then
                    local AbsPos, AbsSize = DropdownHolderFrame.AbsolutePosition, DropdownHolderFrame.AbsoluteSize
                    if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X or Mouse.Y < (AbsPos.Y - 20 * screenScale) or Mouse.Y > AbsPos.Y + AbsSize.Y then
                        Dropdown:Close()
                    end
                end
            end)

            function Dropdown:Open()
                Dropdown.Opened = true
                TabContent.ScrollingEnabled = false
                DropdownHolderCanvas.Visible = true
                TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1)
                }):Play()
                TweenService:Create(DropdownInner, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                }):Play()
            end

            function Dropdown:Close()
                Dropdown.Opened = false
                TabContent.ScrollingEnabled = true
                DropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
                DropdownHolderCanvas.Visible = false
                TweenService:Create(DropdownInner, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                }):Play()
            end

            function Dropdown:Display()
                local Str = ""
                if Dropdown.Multi then
                    for Value, Bool in next, Dropdown.Value do
                        if Bool then
                            Str = Str .. Value .. ", "
                        end
                    end
                    Str = Str:sub(1, #Str - 2)
                else
                    Str = Dropdown.Value or ""
                end
                DropdownDisplay.Text = (Str == "" and "--" or Str)
            end

            function Dropdown:GetActiveValues()
                if Dropdown.Multi then
                    local T = {}
                    for Value, Bool in next, Dropdown.Value do
                        if Bool then
                            table.insert(T, Value)
                        end
                    end
                    return T
                else
                    return Dropdown.Value and 1 or 0
                end
            end

            function Dropdown:BuildDropdownList()
                for _, Element in next, DropdownScrollFrame:GetChildren() do
                    if not Element:IsA("UIListLayout") then
                        Element:Destroy()
                    end
                end

                local Count = 0
                local textSegments = {}
                for _, Value in next, Dropdown.Values do
                    local textLength = #Value
                    local segments = {}
                    if textLength > 10 then
                        for i = 1, math.ceil(textLength / 10) do
                            local startIdx = (i - 1) * 10 + 1
                            local endIdx = math.min(i * 10, textLength)
                            table.insert(segments, Value:sub(startIdx, endIdx))
                        end
                    else
                        table.insert(segments, Value)
                    end
                    table.insert(textSegments, {text = Value, segments = segments})

                    local ButtonFrame = Instance.new("Frame", DropdownScrollFrame)
                    ButtonFrame.Size = UDim2.new(1, -5 * screenScale, 0, 32 * screenScale * #segments)
                    ButtonFrame.BackgroundTransparency = 1
                    ButtonFrame.ClipsDescendants = true
                    ApplyCommonStyles(ButtonFrame, 6 * screenScale)

                    local ButtonSelector = Instance.new("Frame", ButtonFrame)
                    ButtonSelector.Size = UDim2.fromOffset(4 * screenScale, 14 * screenScale)
                    ButtonSelector.BackgroundColor3 = Color3.fromRGB(76, 194, 255)
                    ButtonSelector.Position = UDim2.fromOffset(-1 * screenScale, 16 * screenScale)
                    ButtonSelector.AnchorPoint = Vector2.new(0, 0.5)
                    ApplyCommonStyles(ButtonSelector, 2 * screenScale)

                    for i, segment in ipairs(segments) do
                        local Button = Instance.new("TextButton", ButtonFrame)
                        Button.Size = UDim2.new(1, -5 * screenScale, 0, 32 * screenScale)
                        Button.Position = UDim2.new(0, 0, 0, (i - 1) * 32 * screenScale)
                        Button.BackgroundTransparency = 1
                        Button.Text = ""
                        Button.ZIndex = 23
                        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        ApplyCommonStyles(Button, 6 * screenScale)

                        local ButtonLabel = Instance.new("TextLabel", Button)
                        ButtonLabel.Text = segment
                        ButtonLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                        ButtonLabel.TextSize = 13 * screenScale
                        ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
                        ButtonLabel.BackgroundTransparency = 1
                        ButtonLabel.Size = UDim2.fromScale(1, 1)
                        ButtonLabel.Position = UDim2.fromOffset(10 * screenScale, 0)
                        ButtonLabel.Name = "ButtonLabel"

                        local Selected = Dropdown.Multi and Dropdown.Value[Value] or Dropdown.Value == Value
                        local BackTransparency = Selected and 0.89 or 1
                        local SelTransparency = Selected and 0 or 1

                        Button.BackgroundTransparency = BackTransparency
                        ButtonSelector.BackgroundTransparency = SelTransparency
                        ButtonSelector.Size = UDim2.new(0, 4 * screenScale, 0, Selected and 14 * screenScale or 6 * screenScale)
                        if i == 1 then
                            ButtonSelector.Parent = Button
                        end

                        Button.MouseEnter:Connect(function()
                            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = Selected and 0.85 or 0.89}):Play()
                        end)
                        Button.MouseLeave:Connect(function()
                            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = Selected and 0.89 or 1}):Play()
                        end)
                        Button.MouseButton1Click:Connect(function()
                            local Try = not Selected
                            if Dropdown:GetActiveValues() == 1 and not Try and not Config.AllowNull then
                                return
                            end
                            if Dropdown.Multi then
                                Selected = Try
                                Dropdown.Value[Value] = Selected and true or nil
                            else
                                Selected = Try
                                Dropdown.Value = Selected and Value or nil
                                for _, OtherButton in next, Dropdown.Buttons do
                                    if OtherButton ~= Button then
                                        OtherButton.BackgroundTransparency = 1
                                        OtherButton.ButtonSelector.BackgroundTransparency = 1
                                        OtherButton.ButtonSelector.Size = UDim2.new(0, 4 * screenScale, 0, 6 * screenScale)
                                    end
                                end
                            end
                            Button.BackgroundTransparency = Selected and 0.89 or 1
                            ButtonSelector.BackgroundTransparency = Selected and 0 or 1
                            ButtonSelector.Size = UDim2.new(0, 4 * screenScale, 0, Selected and 14 * screenScale or 6 * screenScale)
                            Dropdown:Display()
                            if Dropdown.Callback then
                                Dropdown.Callback(Dropdown.Value)
                            end
                            if Dropdown.Changed then
                                Dropdown.Changed(Dropdown.Value)
                            end
                        end)

                        Dropdown.Buttons[Button] = {
                            UpdateButton = function()
                                Selected = Dropdown.Multi and Dropdown.Value[Value] or Dropdown.Value == Value
                                Button.BackgroundTransparency = Selected and 0.89 or 1
                                ButtonSelector.BackgroundTransparency = Selected and 0 or 1
                                ButtonSelector.Size = UDim2.new(0, 4 * screenScale, 0, Selected and 14 * screenScale or 6 * screenScale)
                            end,
                            ButtonLabel = ButtonLabel
                        }

                        Count = Count + 1
                    end
                end

                ListSizeX = 0
                for Button, Table in next, Dropdown.Buttons do
                    if Table.ButtonLabel and Table.ButtonLabel.TextBounds.X > ListSizeX then
                        ListSizeX = Table.ButtonLabel.TextBounds.X
                    end
                end
                ListSizeX = ListSizeX + 30 * screenScale

                RecalculateCanvasSize()
                RecalculateListSize()
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
                    Dropdown.Value = table.find(Dropdown.Values, Val) and Val or nil
                end
                Dropdown:BuildDropdownList()
                Dropdown:Display()
                if Dropdown.Callback then
                    Dropdown.Callback(Dropdown.Value)
                end
                if Dropdown.Changed then
                    Dropdown.Changed(Dropdown.Value)
                end
            end

            function Dropdown:Destroy()
                container:Destroy()
            end

            -- Inicializar o Dropdown
            if Dropdown.Multi then
                Dropdown.Value = {}
                if type(Config.Default) == "table" then
                    for _, Value in next, Config.Default do
                        if table.find(Dropdown.Values, Value) then
                            Dropdown.Value[Value] = true
                        end
                    end
                end
            else
                if type(Config.Default) == "string" and table.find(Dropdown.Values, Config.Default) then
                    Dropdown.Value = Config.Default
                end
            end

            Dropdown:BuildDropdownList()
            Dropdown:Display()

            elementY = elementY + 60 * screenScale
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return Dropdown
        end

        return TabFunctions
    end

    return Window
end

return OrionLibV2
