local OrionLibV2 = {}

function OrionLibV2:MakeWindow(Info)
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local Camera = game:GetService("Workspace").CurrentCamera

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RainLib"
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false

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
        Button.Text = TabInfo.Name or "Tab"  
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)  
        Button.Font = Enum.Font.Gotham  
        Button.TextSize = 14  
        Button.AutoButtonColor = false  
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)  

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

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {  
                BackgroundTransparency = 0  
            }):Play()  
            TweenService:Create(title, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {  
                TextTransparency = 0  
            }):Play()  
            TweenService:Create(content, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {  
                TextTransparency = 0  
            }):Play()  

            elementY = elementY + 60  
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
            stroke.Thickness = 1.5  

            local corner = Instance.new("UICorner", container)  
            corner.CornerRadius = UDim.new(0, 6)  

            local toggleText = Instance.new("TextLabel", container)  
            toggleText.Text = info.Name or "Toggle"  
            toggleText.Size = UDim2.new(1, -60, 0, 20)  
            toggleText.Position = UDim2.new(0, 10, 0, 1)  
            toggleText.BackgroundTransparency = 1  
            toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)  
            toggleText.Font = Enum.Font.GothamBold  
            toggleText.TextSize = 14  
            toggleText.TextXAlignment = Enum.TextXAlignment.Left  
            toggleText.TextTransparency = 1  

            local toggleDescription = Instance.new("TextLabel", container)  
            toggleDescription.Text = info.Description or ""  
            toggleDescription.Size = UDim2.new(1, -60, 0, 15)  
            toggleDescription.Position = UDim2.new(0, 10, 0, 21)  
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
            container.ZIndex = 1000

            local stroke = Instance.new("UIStroke", container)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Thickness = 1.5
            stroke.ZIndex = 1000

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 6)

            local textContainer = Instance.new("Frame", container)
            textContainer.Size = UDim2.new(0.4, 0, 1, 0)
            textContainer.Position = UDim2.new(0, 0, 0, 0)
            textContainer.BackgroundTransparency = 1
            textContainer.ClipsDescendants = false
            textContainer.ZIndex = 1000

            local dropdownText = Instance.new("TextLabel", textContainer)
            dropdownText.Text = info.Name or "Dropdown"
            dropdownText.Size = UDim2.new(1, 0, 0, 20)
            dropdownText.Position = UDim2.new(0, 5, 0, 10)
            dropdownText.BackgroundTransparency = 1
            dropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
            dropdownText.Font = Enum.Font.GothamBold
            dropdownText.TextSize = 13
            dropdownText.TextXAlignment = Enum.TextXAlignment.Left
            dropdownText.TextTransparency = 1
            dropdownText.TextTruncate = Enum.TextTruncate.AtEnd
            dropdownText.ZIndex = 1000

            local dropdownDescription = Instance.new("TextLabel", textContainer)
            dropdownDescription.Text = info.Description or ""
            dropdownDescription.Size = UDim2.new(1, -170, 0, 14)
            dropdownDescription.Position = UDim2.new(0, 5, 0, 30)
            dropdownDescription.BackgroundTransparency = 1
            dropdownDescription.TextColor3 = Color3.fromRGB(180, 180, 180)
            dropdownDescription.Font = Enum.Font.Gotham
            dropdownDescription.TextSize = 11
            dropdownDescription.TextXAlignment = Enum.TextXAlignment.Left
            dropdownDescription.TextTransparency = 1
            dropdownDescription.TextTruncate = Enum.TextTruncate.AtEnd
            dropdownDescription.ZIndex = 1000

            local dropdownInner = Instance.new("TextButton", container)
            dropdownInner.Size = UDim2.new(0, 160, 0, 30)
            dropdownInner.Position = UDim2.new(1, -10, 0.5, 0)
            dropdownInner.AnchorPoint = Vector2.new(1, 0.5)
            dropdownInner.BackgroundTransparency = 0.9
            dropdownInner.Text = ""
            dropdownInner.ZIndex = 1000
            dropdownInner.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

            local innerCorner = Instance.new("UICorner", dropdownInner)
            innerCorner.CornerRadius = UDim.new(0, 5)

            local innerStroke = Instance.new("UIStroke", dropdownInner)
            innerStroke.Transparency = 0.5
            innerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            innerStroke.Color = Color3.fromRGB(80, 80, 80)

            local dropdownDisplay = Instance.new("TextLabel", dropdownInner)
            dropdownDisplay.Font = Font.new("rbxasset://fonts/families/GothamSSm.json")
            dropdownDisplay.Text = info.Default or "--"
            dropdownDisplay.TextColor3 = Color3.fromRGB(240, 240, 240)
            dropdownDisplay.TextSize = 13
            dropdownDisplay.TextXAlignment = Enum.TextXAlignment.Left
            dropdownDisplay.Size = UDim2.new(1, -30, 0, 14)
            dropdownDisplay.Position = UDim2.new(0, 8, 0.5, 0)
            dropdownDisplay.AnchorPoint = Vector2.new(0, 0.5)
            dropdownDisplay.BackgroundTransparency = 1
            dropdownDisplay.TextTruncate = Enum.TextTruncate.AtEnd
            dropdownDisplay.ZIndex = 1000

            local dropdownIco = Instance.new("ImageLabel", dropdownInner)
            dropdownIco.Image = "rbxassetid://10709790948"
            dropdownIco.Size = UDim2.fromOffset(16, 16)
            dropdownIco.AnchorPoint = Vector2.new(1, 0.5)
            dropdownIco.Position = UDim2.new(1, -8, 0.5, 0)
            dropdownIco.BackgroundTransparency = 1
            dropdownIco.ImageColor3 = Color3.fromRGB(180, 180, 180)
            dropdownIco.ZIndex = 1000

            local Dropdown = {
                Values = info.Values or {},
                Value = info.Multi and (type(info.Default) == "table" and info.Default or { [info.Default or info.Values[1]] = true }) or (info.Default or info.Values[1]),
                Multi = info.Multi or false,
                Buttons = {},
                Opened = false,
                Type = "Dropdown",
                Callback = info.Callback or function() end,
            }

            local dropdownHolderCanvas = Instance.new("Frame", ScreenGui)
            dropdownHolderCanvas.BackgroundTransparency = 1
            dropdownHolderCanvas.Size = UDim2.fromOffset(170, 300)
            dropdownHolderCanvas.Visible = false
            dropdownHolderCanvas.ZIndex = 2000

            local dropdownHolderFrame = Instance.new("Frame", dropdownHolderCanvas)
            dropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
            dropdownHolderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            dropdownHolderFrame.ZIndex = 2000

            local holderCorner = Instance.new("UICorner", dropdownHolderFrame)
            holderCorner.CornerRadius = UDim.new(0, 7)

            local holderStroke = Instance.new("UIStroke", dropdownHolderFrame)
            holderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            holderStroke.Color = Color3.fromRGB(80, 80, 80)
            holderStroke.ZIndex = 2000

            local dropdownScrollFrame = Instance.new("ScrollingFrame", dropdownHolderFrame)
            dropdownScrollFrame.Size = UDim2.new(1, -5, 1, -10)
            dropdownScrollFrame.Position = UDim2.fromOffset(5, 5)
            dropdownScrollFrame.BackgroundTransparency = 1
            dropdownScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
            dropdownScrollFrame.ScrollBarImageTransparency = 0.95
            dropdownScrollFrame.ScrollBarThickness = 4
            dropdownScrollFrame.BorderSizePixel = 0
            dropdownScrollFrame.CanvasSize = UDim2.fromScale(0, 0)
            dropdownScrollFrame.ZIndex = 2000

            local dropdownListLayout = Instance.new("UIListLayout", dropdownScrollFrame)
            dropdownListLayout.Padding = UDim.new(0, 3)
            dropdownListLayout.ZIndex = 2000

            local function RecalculateListPosition()
                local add = 0
                if Camera.ViewportSize.Y - dropdownInner.AbsolutePosition.Y < dropdownHolderCanvas.AbsoluteSize.Y - 5 then
                    add = dropdownHolderCanvas.AbsoluteSize.Y - 5 - (Camera.ViewportSize.Y - dropdownInner.AbsolutePosition.Y) + 40
                end
                dropdownHolderCanvas.Position = UDim2.fromOffset(dropdownInner.AbsolutePosition.X - 1, dropdownInner.AbsolutePosition.Y - 5 - add)
            end

            local ListSizeX = 0
            local function RecalculateListSize()
                if #Dropdown.Values > 10 then
                    dropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, 392)
                else
                    dropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, dropdownListLayout.AbsoluteContentSize.Y + 10)
                end
            end

            local function RecalculateCanvasSize()
                dropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, dropdownListLayout.AbsoluteContentSize.Y)
            end

            RecalculateListPosition()
            RecalculateListSize()

            TweenService:GetPropertyChangedSignal(dropdownInner, "AbsolutePosition"):Connect(RecalculateListPosition)

            dropdownInner.MouseButton1Click:Connect(function()
                Dropdown:Open()
            end)

            UserInputService.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    local absPos, absSize = dropdownHolderFrame.AbsolutePosition, dropdownHolderFrame.AbsoluteSize
                    if Mouse.X < absPos.X or Mouse.X > absPos.X + absSize.X or Mouse.Y < (absPos.Y - 20 - 1) or Mouse.Y > absPos.Y + absSize.Y then
                        Dropdown:Close()
                    end
                end
            end)

            function Dropdown:Open()
                Dropdown.Opened = true
                TabContent.ScrollingEnabled = false
                dropdownHolderCanvas.Visible = true
                TweenService:Create(dropdownHolderFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 1)}):Play()
            end

            function Dropdown:Close()
                Dropdown.Opened = false
                TabContent.ScrollingEnabled = true
                dropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
                dropdownHolderCanvas.Visible = false
            end

            function Dropdown:Display()
                local str = ""
                if Dropdown.Multi then
                    for _, value in next, Dropdown.Values do
                        if Dropdown.Value[value] then
                            str = str .. value .. ", "
                        end
                    end
                    str = str:sub(1, #str - 2)
                else
                    str = Dropdown.Value or "--"
                end
                dropdownDisplay.Text = str
            end

            function Dropdown:GetActiveValues()
                if Dropdown.Multi then
                    local t = {}
                    for value, bool in next, Dropdown.Value do
                        table.insert(t, value)
                    end
                    return t
                else
                    return Dropdown.Value and 1 or 0
                end
            end

            function Dropdown:BuildDropdownList()
                for _, element in next, dropdownScrollFrame:GetChildren() do
                    if not element:IsA("UIListLayout") then
                        element:Destroy()
                    end
                end

                local count = 0
                Dropdown.Buttons = {}

                for idx, value in next, Dropdown.Values do
                    count = count + 1

                    local buttonSelector = Instance.new("Frame", dropdownScrollFrame)
                    buttonSelector.Size = UDim2.fromOffset(4, 14)
                    buttonSelector.BackgroundColor3 = Color3.fromRGB(76, 194, 255)
                    buttonSelector.Position = UDim2.fromOffset(-1, 16)
                    buttonSelector.AnchorPoint = Vector2.new(0, 0.5)
                    Instance.new("UICorner", buttonSelector).CornerRadius = UDim.new(0, 2)

                    local buttonLabel = Instance.new("TextLabel", dropdownScrollFrame)
                    buttonLabel.Font = Font.new("rbxasset://fonts/families/GothamSSm.json")
                    buttonLabel.Text = value
                    buttonLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                    buttonLabel.TextSize = 13
                    buttonLabel.TextXAlignment = Enum.TextXAlignment.Left
                    buttonLabel.BackgroundTransparency = 1
                    buttonLabel.Size = UDim2.fromScale(1, 1)
                    buttonLabel.Position = UDim2.fromOffset(10, 0)
                    buttonLabel.ZIndex = 23

                    local button = Instance.new("TextButton", dropdownScrollFrame)
                    button.Size = UDim2.new(1, -5, 0, 32)
                    button.BackgroundTransparency = 1
                    button.Text = ""
                    button.ZIndex = 23
                    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

                    local selected = Dropdown.Multi and Dropdown.Value[value] or Dropdown.Value == value
                    local backTransparency = selected and 0.89 or 1
                    button.BackgroundTransparency = backTransparency
                    buttonSelector.BackgroundTransparency = selected and 0 or 1

                    button.MouseEnter:Connect(function()
                        button.BackgroundTransparency = selected and 0.85 or 0.89
                    end)
                    button.MouseLeave:Connect(function()
                        button.BackgroundTransparency = selected and 0.89 or 1
                    end)
                    button.MouseButton1Down:Connect(function()
                        button.BackgroundTransparency = 0.92
                    end)
                    button.MouseButton1Up:Connect(function()
                        button.BackgroundTransparency = selected and 0.85 or 0.89
                    end)

                    buttonLabel.MouseButton1Click:Connect(function()
                        local try = not selected
                        if Dropdown:GetActiveValues() == 1 and not try and not info.AllowNull then
                            return
                        end
                        if Dropdown.Multi then
                            selected = try
                            Dropdown.Value[value] = selected and true or nil
                        else
                            selected = try
                            Dropdown.Value = selected and value or nil
                            for _, btn in next, Dropdown.Buttons do
                                btn:UpdateButton()
                            end
                        end
                        Dropdown.Buttons[button]:UpdateButton()
                        Dropdown:Display()
                        if info.Callback then
                            info.Callback(Dropdown.Value)
                        end
                    end)

                    function Dropdown.Buttons[button]:UpdateButton()
                        selected = Dropdown.Multi and Dropdown.Value[value] or Dropdown.Value == value
                        button.BackgroundTransparency = selected and 0.89 or 1
                        buttonSelector.BackgroundTransparency = selected and 0 or 1
                    end

                    Dropdown.Buttons[button]:UpdateButton()
                end

                ListSizeX = 0
                for btn, _ in next, Dropdown.Buttons do
                    if btn:FindFirstChild("ButtonLabel") then
                        local textBounds = btn.ButtonLabel.TextBounds
                        if textBounds.X > ListSizeX then
                            ListSizeX = textBounds.X
                        end
                    end
                end
                ListSizeX = ListSizeX + 30

                RecalculateCanvasSize()
                RecalculateListSize()
            end

            function Dropdown:SetValues(newValues)
                if newValues then
                    Dropdown.Values = newValues
                end
                Dropdown:BuildDropdownList()
            end

            function Dropdown:OnChanged(func)
                Dropdown.Changed = func
                func(Dropdown.Value)
            end

            function Dropdown:SetValue(val)
                if Dropdown.Multi then
                    local nTable = {}
                    for value, bool in next, val do
                        if table.find(Dropdown.Values, value) then
                            nTable[value] = true
                        end
                    end
                    Dropdown.Value = nTable
                else
                    if not val then
                        Dropdown.Value = nil
                    elseif table.find(Dropdown.Values, val) then
                        Dropdown.Value = val
                    end
                end
                Dropdown:BuildDropdownList()
                if info.Callback then
                    info.Callback(Dropdown.Value)
                end
            end

            function Dropdown:Destroy()
                container:Destroy()
                dropdownHolderCanvas:Destroy()
            end

            Dropdown:BuildDropdownList()
            Dropdown:Display()

            local defaults = {}
            if type(info.Default) == "string" then
                local idx = table.find(Dropdown.Values, info.Default)
                if idx then table.insert(defaults, idx) end
            elseif type(info.Default) == "table" then
                for _, value in next, info.Default do
                    local idx = table.find(Dropdown.Values, value)
                    if idx then table.insert(defaults, idx) end
                end
            elseif type(info.Default) == "number" and Dropdown.Values[info.Default] then
                table.insert(defaults, info.Default)
            end

            if next(defaults) then
                for i = 1, #defaults do
                    local idx = defaults[i]
                    if Dropdown.Multi then
                        Dropdown.Value[Dropdown.Values[idx]] = true
                    else
                        Dropdown.Value = Dropdown.Values[idx]
                        break
                    end
                end
                Dropdown:BuildDropdownList()
                Dropdown:Display()
            end

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            TweenService:Create(dropdownText, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
            TweenService:Create(dropdownDescription, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
            TweenService:Create(dropdownInner, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            TweenService:Create(dropdownDisplay, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
            TweenService:Create(dropdownIco, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {ImageTransparency = 0}):Play()

            elementY = elementY + 60
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container, Dropdown
        end  

        return TabFunctions  
    end  

    return Tabs
end

return OrionLibV2
