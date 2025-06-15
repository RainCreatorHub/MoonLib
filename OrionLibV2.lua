local OrionLibV2 = {}

function OrionLibV2:MakeWindow(Info)
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")

    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)  
    ScreenGui.Name = "CheatGUI"  
    ScreenGui.AlwaysOnTop = true -- Garante que todo o GUI fique acima

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
            local TweenService = game:GetService("TweenService")
            local UserInputService = game:GetService("UserInputService")

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
            dropdownText.TextSize = 14
            dropdownText.TextXAlignment = Enum.TextXAlignment.Left
            dropdownText.TextTransparency = 1
            dropdownText.TextWrapped = true
            dropdownText.TextTruncate = Enum.TextTruncate.None
            dropdownText.ZIndex = 1000

            local dropdownDescription = Instance.new("TextLabel", textContainer)
            dropdownDescription.Text = info.Description or ""
            dropdownDescription.Size = UDim2.new(1, 0, 0, 15)
            dropdownDescription.Position = UDim2.new(0, 5, 0, 30)
            dropdownDescription.BackgroundTransparency = 1
            dropdownDescription.TextColor3 = Color3.fromRGB(180, 180, 180)
            dropdownDescription.Font = Enum.Font.Gotham
            dropdownDescription.TextSize = 11
            dropdownDescription.TextXAlignment = Enum.TextXAlignment.Left
            dropdownDescription.TextTransparency = 1
            dropdownDescription.TextWrapped = true
            dropdownDescription.TextTruncate = Enum.TextTruncate.None
            dropdownDescription.ZIndex = 1000

            local dropdownButton = Instance.new("TextButton", container)
            dropdownButton.Size = UDim2.new(0, 100, 0, 24)
            dropdownButton.Position = UDim2.new(0.6, 0, 0, 13)
            dropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            dropdownButton.BorderSizePixel = 0
            dropdownButton.AutoButtonColor = false
            dropdownButton.Text = info.Default or (info.Values and table.concat(info.Values, ", ")) or ""
            dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            dropdownButton.Font = Enum.Font.Gotham
            dropdownButton.TextSize = 12
            dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            dropdownButton.TextTransparency = 1
            dropdownButton.BackgroundTransparency = 0.3
            dropdownButton.ClipsDescendants = true
            dropdownButton.ZIndex = 1000

            local buttonCorner = Instance.new("UICorner", dropdownButton)
            buttonCorner.CornerRadius = UDim.new(0, 6)

            local dropdownIcon = Instance.new("TextLabel", dropdownButton)
            dropdownIcon.Size = UDim2.new(0, 20, 0, 20)
            dropdownIcon.Position = UDim2.new(1, -20, 0.5, -10)
            dropdownIcon.BackgroundTransparency = 1
            dropdownIcon.Text = "▼"
            dropdownIcon.TextColor3 = Color3.fromRGB(180, 180, 180)
            dropdownIcon.Font = Enum.Font.Gotham
            dropdownIcon.TextSize = 12
            dropdownIcon.TextTransparency = 1
            dropdownIcon.ZIndex = 1000

            local dropdownList = Instance.new("ScrollingFrame")
            dropdownList.Size = UDim2.new(0, 100, 0, 0)
            dropdownList.Position = UDim2.new(0.6, 0, 0, 37)
            dropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            dropdownList.BackgroundTransparency = 1
            dropdownList.ScrollBarThickness = 4
            dropdownList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
            dropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
            dropdownList.ScrollingDirection = Enum.ScrollingDirection.Y
            dropdownList.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
            dropdownList.Visible = false
            dropdownList.ClipsDescendants = true
            dropdownList.ZIndex = 2000 -- ZIndex muito alto para garantir prioridade

            local listStroke = Instance.new("UIStroke", dropdownList)
            listStroke.Color = Color3.fromRGB(80, 80, 80)
            listStroke.Thickness = 1.5
            listStroke.ZIndex = 2000

            local listCorner = Instance.new("UICorner", dropdownList)
            listCorner.CornerRadius = UDim.new(0, 6)

            local listLayout = Instance.new("UIListLayout", dropdownList)
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder
            listLayout.Padding = UDim.new(0, 2)
            listLayout.ZIndex = 2000

            local Dropdown = {
                Values = info.Values or {},
                Value = info.Multi and (type(info.Default) == "table" and info.Default or { [info.Default or info.Values[1]] = true }) or (info.Default or (info.Values and info.Values[1])),
                Multi = info.Multi or true,
                Opened = false,
                Callback = info.Callback or function() end,
            }

            local function updateDisplay()
                if Dropdown.Multi then
                    local selected = {}
                    for value, bool in pairs(Dropdown.Value) do
                        if bool then
                            table.insert(selected, value)
                        end
                    end
                    dropdownButton.Text = #selected > 0 and table.concat(selected, ", ") or (info.Name or "Dropdown")
                else
                    dropdownButton.Text = Dropdown.Value or (info.Name or "Dropdown")
                end
            end

            local function toggleDropdown()
                Dropdown.Opened = not Dropdown.Opened
                local targetHeight = Dropdown.Opened and math.min(#Dropdown.Values * 30, 120) or 0
                dropdownList.Visible = Dropdown.Opened
                if Dropdown.Opened then
                    dropdownList.Parent = ScreenGui -- Move para o ScreenGui com AlwaysOnTop
                    dropdownList.Position = UDim2.new(0, container.AbsolutePosition.X + dropdownButton.AbsolutePosition.X, 0, container.AbsolutePosition.Y + dropdownButton.AbsolutePosition.Y + dropdownButton.Size.Y.Offset)
                end
                TweenService:Create(dropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(0, dropdownButton.Size.X.Offset, 0, targetHeight),
                    BackgroundTransparency = Dropdown.Opened and 0 or 1
                }):Play()
                TweenService:Create(dropdownIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Rotation = Dropdown.Opened and 180 or 0
                }):Play()
                if not Dropdown.Opened then
                    dropdownList.Parent = container -- Volta ao container ao fechar
                end
            end

            local function buildDropdownList()
                for _, child in ipairs(dropdownList:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end

                local maxTextWidth = 0
                for _, value in ipairs(Dropdown.Values) do
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Text = value
                    textLabel.Font = Enum.Font.Gotham
                    textLabel.TextSize = 12
                    textLabel.TextXAlignment = Enum.TextXAlignment.Left
                    textLabel.Parent = dropdownList
                    local textWidth = textLabel.TextBounds.X
                    textLabel:Destroy()
                    maxTextWidth = math.max(maxTextWidth, textWidth)
                end

                local buttonWidth = math.min(maxTextWidth + 30, 190)
                dropdownButton.Size = UDim2.new(0, buttonWidth, 0, 24)
                dropdownButton.Position = UDim2.new(0.6, 0, 0, 13)
                dropdownList.Size = UDim2.new(0, buttonWidth, 0, Dropdown.Opened and math.min(#Dropdown.Values * 30, 120) or 0)
                dropdownList.Position = UDim2.new(0.6, 0, 0, 37)

                local count = 0
                for _, value in ipairs(Dropdown.Values) do
                    local optionButton = Instance.new("TextButton", dropdownList)
                    optionButton.Size = UDim2.new(1, 0, 0, 28)
                    optionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    optionButton.Font = Enum.Font.Gotham
                    optionButton.TextSize = 12
                    optionButton.Text = value
                    optionButton.TextXAlignment = Enum.TextXAlignment.Left
                    optionButton.TextTransparency = 1
                    optionButton.BackgroundTransparency = 0.3
                    optionButton.AutoButtonColor = false
                    optionButton.ZIndex = 2000

                    local optionCorner = Instance.new("UICorner", optionButton)
                    optionCorner.CornerRadius = UDim.new(0, 4)

                    optionButton.MouseEnter:Connect(function()
                        TweenService:Create(optionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                    end)
                    optionButton.MouseLeave:Connect(function()
                        TweenService:Create(optionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                    end)

                    optionButton.MouseButton1Click:Connect(function()
                        if Dropdown.Multi then
                            Dropdown.Value[value] = not Dropdown.Value[value] or false
                        else
                            Dropdown.Value = value
                        end
                        updateDisplay()
                        Dropdown.Callback(Dropdown.Multi and Dropdown:GetActiveValues() or Dropdown.Value)
                        if not Dropdown.Multi then
                            toggleDropdown()
                        end
                    end)

                    if Dropdown.Multi and Dropdown.Value[value] then
                        optionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
                    end

                    TweenService:Create(optionButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                        TextTransparency = 0,
                        BackgroundTransparency = 0
                    }):Play()

                    count = count + 1
                end

                dropdownList.CanvasSize = UDim2.new(0, 0, 0, count * 30)
            end

            function Dropdown:GetActiveValues()
                local values = {}
                for value, bool in pairs(Dropdown.Value) do
                    if bool then
                        table.insert(values, value)
                    end
                end
                return values
            end

            function Dropdown:SetTitle(title)
                dropdownText.Text = title or dropdownText.Text
                local textBounds = dropdownText.TextBounds
                if textBounds.Y > 20 then
                    dropdownText.Size = UDim2.new(1, 0, 0, textBounds.Y)
                    dropdownDescription.Position = UDim2.new(0, 5, 0, textBounds.Y + 10)
                end
            end

            function Dropdown:SetDesc(desc)
                dropdownDescription.Text = desc or ""
                local textBounds = dropdownDescription.TextBounds
                if textBounds.Y > 15 then
                    dropdownDescription.Size = UDim2.new(1, 0, 0, textBounds.Y)
                end
            end

            UserInputService.InputBegan:Connect(function(input)
                if Dropdown.Opened and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                    local absPos = dropdownList.AbsolutePosition
                    local absSize = dropdownList.AbsoluteSize
                    local mouse = UserInputService:GetMouseLocation()
                    if mouse.X < absPos.X or mouse.X > absPos.X + absSize.X or mouse.Y < absPos.Y or mouse.Y > absPos.Y + absSize.Y then
                        toggleDropdown()
                    end
                end
            end)

            dropdownButton.MouseEnter:Connect(function()
                TweenService:Create(dropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            end)
            dropdownButton.MouseLeave:Connect(function()
                TweenService:Create(dropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            end)

            dropdownButton.MouseButton1Click:Connect(toggleDropdown)

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(dropdownText, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(dropdownDescription, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(dropdownButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0,
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(dropdownIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            buildDropdownList()
            updateDisplay()

            elementY = elementY + 60
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container, Dropdown
        end  

        return TabFunctions  
    end  

    return Tabs
end

return OrionLibV2
