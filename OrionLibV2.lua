local OrionLibV2 = {}

function OrionLibV2:MakeWindow(Info)
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local Camera = game:GetService("Workspace").CurrentCamera
    local Mouse = game.Players.LocalPlayer:GetMouse()

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
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)  
        Button.Font = Enum.Font.Gotham  
        Button.TextSize = 14  
        Button.AutoButtonColor = false  
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)  

        -- Soft wrap para o texto do botão da aba
        local tempLabel = Instance.new("TextLabel")
        tempLabel.Text = TabInfo.Name or "Tab"
        tempLabel.Font = Enum.Font.Gotham
        tempLabel.TextSize = 14
        tempLabel.TextWrapped = true
        tempLabel.Size = UDim2.new(0, 110, 0, 0)
        tempLabel.Parent = Button
        local textBounds = tempLabel.TextBounds
        tempLabel:Destroy()
        Button.Text = TabInfo.Name or "Tab"
        if textBounds.Y > 30 then
            Button.Size = UDim2.new(0, 120, 0, math.ceil(textBounds.Y) + 10)
        end

        ButtonY = ButtonY + Button.Size.Y.Offset + 5  
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
            sectionLabel.BackgroundTransparency = 1  
            sectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)  
            sectionLabel.Font = Enum.Font.GothamBold  
            sectionLabel.TextSize = 16  
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left  
            sectionLabel.TextTransparency = 1  
            sectionLabel.TextWrapped = true  
            sectionLabel.Size = UDim2.new(1, 0, 0, 0)  

            -- Soft wrap para o texto da seção
            local textBounds = sectionLabel.TextBounds
            sectionLabel.Size = UDim2.new(1, 0, 0, math.ceil(textBounds.Y) or 25)
            container.Size = UDim2.new(1, -20, 0, sectionLabel.Size.Y.Offset + 5)

            TweenService:Create(sectionLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {  
                TextTransparency = 0  
            }):Play()  

            elementY = elementY + container.Size.Y.Offset + 5  
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
            title.BackgroundTransparency = 1  
            title.TextColor3 = Color3.fromRGB(255, 255, 255)  
            title.Font = Enum.Font.GothamBold  
            title.TextSize = 14  
            title.TextXAlignment = Enum.TextXAlignment.Left  
            title.TextTransparency = 1  
            title.TextWrapped = true  
            title.Size = UDim2.new(1, -10, 0, 0)  
            title.Position = UDim2.new(0, 5, 0, 5)  

            local content = Instance.new("TextLabel", container)  
            content.Text = info.Content or "Texto"  
            content.BackgroundTransparency = 1  
            content.TextColor3 = Color3.fromRGB(180, 180, 180)  
            content.Font = Enum.Font.Gotham  
            content.TextSize = 13  
            content.TextXAlignment = Enum.TextXAlignment.Left  
            content.TextTransparency = 1  
            content.TextWrapped = true  
            content.Size = UDim2.new(1, -10, 0, 0)  

            -- Soft wrap para os textos do label
            local titleBounds = title.TextBounds
            title.Size = UDim2.new(1, -10, 0, math.ceil(titleBounds.Y) or 18)
            content.Position = UDim2.new(0, 5, 0, title.Size.Y.Offset + 5)
            local contentBounds = content.TextBounds
            content.Size = UDim2.new(1, -10, 0, math.ceil(contentBounds.Y) or 18)
            container.Size = UDim2.new(1, -20, 0, title.Size.Y.Offset + content.Size.Y.Offset + 15)

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {  
                BackgroundTransparency = 0  
            }):Play()  
            TweenService:Create(title, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {  
                TextTransparency = 0  
            }):Play()  
            TweenService:Create(content, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {  
                TextTransparency = 0  
            }):Play()  

            elementY = elementY + container.Size.Y.Offset + 10  
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
            button.TextXAlignment = Enum.TextXAlignment.Left  
            button.AutoButtonColor = false  
            button.BorderSizePixel = 0  
            button.TextTransparency = 1  
            button.BackgroundTransparency = 0.3  
            button.ClipsDescendants = true  
            button.TextWrapped = true  

            -- Soft wrap para o texto do botão
            local tempLabel = Instance.new("TextLabel")
            tempLabel.Text = info.Name or "Button"
            tempLabel.Font = Enum.Font.GothamBold
            tempLabel.TextSize = 14
            tempLabel.TextWrapped = true
            tempLabel.Size = UDim2.new(1, -20, 0, 0)
            tempLabel.Parent = button
            local textBounds = tempLabel.TextBounds
            tempLabel:Destroy()
            button.Text = info.Name or "Button"
            local buttonHeight = math.ceil(textBounds.Y) or 30
            button.Size = UDim2.new(1, -10, 0, buttonHeight)
            container.Size = UDim2.new(1, -20, 0, buttonHeight + 10)

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

            elementY = elementY + container.Size.Y.Offset + 10  
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
            toggleText.BackgroundTransparency = 1  
            toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)  
            toggleText.Font = Enum.Font.GothamBold  
            toggleText.TextSize = 14  
            toggleText.TextXAlignment = Enum.TextXAlignment.Left  
            toggleText.TextTransparency = 1  
            toggleText.TextWrapped = true  
            toggleText.Size = UDim2.new(1, -60, 0, 0)  
            toggleText.Position = UDim2.new(0, 10, 0, 5)  

            local toggleDescription = Instance.new("TextLabel", container)  
            toggleDescription.Text = info.Description or ""  
            toggleDescription.BackgroundTransparency = 1  
            toggleDescription.TextColor3 = Color3.fromRGB(180, 180, 180)  
            toggleDescription.Font = Enum.Font.Gotham  
            toggleDescription.TextSize = 11  
            toggleDescription.TextXAlignment = Enum.TextXAlignment.Left  
            toggleDescription.TextTransparency = 1  
            toggleDescription.TextWrapped = true  
            toggleDescription.Size = UDim2.new(1, -60, 0, 0)  

            -- Soft wrap para os textos do toggle
            local toggleTextBounds = toggleText.TextBounds
            toggleText.Size = UDim2.new(1, -60, 0, math.ceil(toggleTextBounds.Y) or 20)
            toggleDescription.Position = UDim2.new(0, 10, 0, toggleText.Size.Y.Offset + 5)
            local toggleDescBounds = toggleDescription.TextBounds
            toggleDescription.Size = UDim2.new(1, -60, 0, math.ceil(toggleDescBounds.Y) or 15)
            container.Size = UDim2.new(1, -20, 0, toggleText.Size.Y.Offset + toggleDescription.Size.Y.Offset + 15)

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

            elementY = elementY + container.Size.Y.Offset + 10  
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)  

            return container  
        end  

        function TabFunctions:AddDropdown(info)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -20, 0, 50)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0
            container.ZIndex = 1
            container.Parent = TabContent

            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Thickness = 1.5
            stroke.Parent = container

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = container

            local nameLabels = {}
            local descriptionLabels = {}

            local function createTextLabel(text, font, textSize, color, position, parent)
                local label = Instance.new("TextLabel")
                label.Text = text
                label.Size = UDim2.new(1, -170, 0, 0)
                label.Position = position
                label.BackgroundTransparency = 1
                label.TextColor3 = color
                label.Font = font
                label.TextSize = textSize
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTransparency = 1
                label.TextWrapped = true
                label.ZIndex = 1
                label.Parent = parent
                return label
            end

            local function splitText(text, label, maxWidth)
                if not text or text == "" then
                    return {""}
                end
                local chars = {}
                for char in text:gmatch("[\128-\191]*.") do
                    table.insert(chars, char)
                end
                local lines = {""}
                local currentLine = 1
                for _, char in ipairs(chars) do
                    local testText = lines[currentLine] .. char
                    label.Text = testText
                    task.wait()
                    if label.TextBounds.X <= maxWidth then
                        lines[currentLine] = testText
                    else
                        currentLine = currentLine + 1
                        lines[currentLine] = char
                    end
                end
                label.Text = text
                return lines
            end

            local function adjustTextLabels()
                for _, label in ipairs(nameLabels) do
                    label:Destroy()
                end
                for _, label in ipairs(descriptionLabels) do
                    label:Destroy()
                end
                nameLabels = {}
                descriptionLabels = {}

                local nameText = info.Name or "Dropdown"
                local tempNameLabel = createTextLabel(nameText, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 10, 0, 5), container)
                local maxWidth = container.AbsoluteSize.X - 180
                local nameLines = splitText(nameText, tempNameLabel, maxWidth)
                tempNameLabel:Destroy()

                local yOffset = 5
                for i, line in ipairs(nameLines) do
                    local nameLabel = createTextLabel(line, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 10, 0, yOffset), container)
                    nameLabel.Size = UDim2.new(1, -170, 0, nameLabel.TextBounds.Y or 14)
                    table.insert(nameLabels, nameLabel)
                    yOffset = yOffset + (nameLabel.TextBounds.Y or 14) + 2
                    TweenService:Create(nameLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                end

                local descText = info.Description or ""
                local tempDescLabel = createTextLabel(descText, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 10, 0, yOffset), container)
                local descLines = splitText(descText, tempDescLabel, maxWidth)
                tempDescLabel:Destroy()

                for i, line in ipairs(descLines) do
                    local descLabel = createTextLabel(line, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 10, 0, yOffset), container)
                    descLabel.Size = UDim2.new(1, -170, 0, descLabel.TextBounds.Y or 11)
                    table.insert(descriptionLabels, descLabel)
                    yOffset = yOffset + (descLabel.TextBounds.Y or 11) + 2
                    TweenService:Create(descLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                end

                container.Size = UDim2.new(1, -20, 0, math.max(50, yOffset + 5))
            end

            adjustTextLabels()

            local Dropdown = {
                Values = info.Values or {},
                Value = info.Default or (info.Multi and {} or nil),
                Multi = info.Multi or false,
                Buttons = {},
                Opened = false,
                Callback = info.Callback or function() end,
            }

            local DropdownDisplay = Instance.new("TextButton")
            DropdownDisplay.Size = UDim2.new(0, 160, 0, 24)
            DropdownDisplay.Position = UDim2.new(1, -170, 0.5, -12)
            DropdownDisplay.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            DropdownDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownDisplay.Font = Enum.Font.Gotham
            DropdownDisplay.TextSize = 13
            DropdownDisplay.TextXAlignment = Enum.TextXAlignment.Left
            DropdownDisplay.Text = "--"
            DropdownDisplay.TextTransparency = 1
            DropdownDisplay.BackgroundTransparency = 0.3
            DropdownDisplay.AutoButtonColor = false
            DropdownDisplay.ClipsDescendants = true
            DropdownDisplay.ZIndex = 2
            DropdownDisplay.Parent = container

            local displayCorner = Instance.new("UICorner")
            displayCorner.CornerRadius = UDim.new(0, 6)
            displayCorner.Parent = DropdownDisplay

            local displayStroke = Instance.new("UIStroke")
            displayStroke.Color = Color3.fromRGB(80, 80, 80)
            displayStroke.Thickness = 1
            displayStroke.Transparency = 0.5
            displayStroke.Parent = DropdownDisplay

            local DropdownIco = Instance.new("ImageLabel")
            DropdownIco.Image = "rbxassetid://10709790948"
            DropdownIco.Size = UDim2.new(0, 16, 0, 16)
            DropdownIco.Position = UDim2.new(1, -20, 0.5, -8)
            DropdownIco.BackgroundTransparency = 1
            DropdownIco.ImageColor3 = Color3.fromRGB(180, 180, 180)
            DropdownIco.ImageTransparency = 1
            DropdownIco.ZIndex = 2
            DropdownIco.Parent = DropdownDisplay

            local DropdownListLayout = Instance.new("UIListLayout")
            DropdownListLayout.Padding = UDim.new(0, 3)

            local DropdownScrollFrame = Instance.new("ScrollingFrame")
            DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -10)
            DropdownScrollFrame.Position = UDim2.fromOffset(5, 5)
            DropdownScrollFrame.BackgroundTransparency = 1
            DropdownScrollFrame.ScrollBarThickness = 6
            DropdownScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
            DropdownScrollFrame.ScrollBarImageTransparency = 0.3
            DropdownScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropdownScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
            DropdownScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
            DropdownListLayout.Parent = DropdownScrollFrame

            DropdownScrollFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseWheel then
                    local scrollAmount = 20
                    local currentPosition = DropdownScrollFrame.CanvasPosition.Y
                    local newPosition = currentPosition - (input.Position.Z * scrollAmount)
                    newPosition = math.clamp(newPosition, 0, DropdownScrollFrame.CanvasSize.Y.Offset - DropdownScrollFrame.AbsoluteWindowSize.Y)
                    DropdownScrollFrame.CanvasPosition = Vector2.new(0, newPosition)
                end
            end)

            local DropdownHolderFrame = Instance.new("Frame")
            DropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
            DropdownHolderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            DropdownHolderFrame.ClipsDescendants = true
            DropdownHolderFrame.ZIndex = 3

            local holderCorner = Instance.new("UICorner")
            holderCorner.CornerRadius = UDim.new(0, 6)
            holderCorner.Parent = DropdownHolderFrame

            local holderStroke = Instance.new("UIStroke")
            holderStroke.Color = Color3.fromRGB(80, 80, 80)
            holderStroke.Thickness = 1.5
            holderStroke.Parent = DropdownHolderFrame

            local shadow = Instance.new("ImageLabel")
            shadow.BackgroundTransparency = 1
            shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
            shadow.ScaleType = Enum.ScaleType.Slice
            shadow.SliceCenter = Rect.new(23, 23, 277, 277)
            shadow.Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30)
            shadow.Position = UDim2.fromOffset(-15, -15)
            shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
            shadow.ImageTransparency = 0.1
            shadow.ZIndex = 2
            shadow.Parent = DropdownHolderFrame

            DropdownScrollFrame.Parent = DropdownHolderFrame

            local DropdownHolderCanvas = Instance.new("Frame")
            DropdownHolderCanvas.BackgroundTransparency = 1
            DropdownHolderCanvas.Size = UDim2.fromOffset(170, 300)
            DropdownHolderCanvas.Visible = false
            DropdownHolderCanvas.ZIndex = 3
            DropdownHolderCanvas.Parent = ScreenGui
            DropdownHolderFrame.Parent = DropdownHolderCanvas

            local sizeConstraint = Instance.new("UISizeConstraint")
            sizeConstraint.MinSize = Vector2.new(170, 0)
            sizeConstraint.Parent = DropdownHolderCanvas

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()

            TweenService:Create(DropdownDisplay, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0,
                BackgroundTransparency = 0
            }):Play()

            TweenService:Create(DropdownIco, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                ImageTransparency = 0
            }):Play()

            local function RecalculateListPosition()
                local absPos = DropdownDisplay.AbsolutePosition
                local absSize = DropdownHolderCanvas.AbsoluteSize
                local Add = 0
                if Camera.ViewportSize.Y - absPos.Y < absSize.Y + 5 then
                    Add = absSize.Y + 5 - (Camera.ViewportSize.Y - absPos.Y) + 40
                end
                DropdownHolderCanvas.Position = UDim2.fromOffset(absPos.X - 5, absPos.Y - 5 - Add)
            end

            local ListSizeX = 0
            local function RecalculateListSize()
                if #Dropdown.Values > 10 then
                    DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, 392)
                else
                    DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, DropdownListLayout.AbsoluteContentSize.Y + 10)
                end
            end

            local function RecalculateCanvasSize()
                DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, DropdownListLayout.AbsoluteContentSize.Y)
            end

            RecalculateListPosition()
            RecalculateListSize()

            DropdownDisplay:GetPropertyChangedSignal("AbsolutePosition"):Connect(RecalculateListPosition)

            DropdownDisplay.MouseButton1Click:Connect(function()
                if Dropdown.Opened then
                    Dropdown:Close()
                else
                    Dropdown:Open()
                end
            end)

            UserInputService.InputBegan:Connect(function(Input)
                if Dropdown.Opened and (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
                    local AbsPos = DropdownHolderFrame.AbsolutePosition
                    local AbsSize = DropdownHolderFrame.AbsoluteSize
                    if
                        Mouse.X < AbsPos.X or
                        Mouse.X > AbsPos.X + AbsSize.X or
                        Mouse.Y < (AbsPos.Y - 20) or
                        Mouse.Y > AbsPos.Y + AbsSize.Y
                    then
                        Dropdown:Close()
                    end
                end
            end)

            function Dropdown:Open()
                Dropdown.Opened = true
                TabContent.ScrollingEnabled = false
                DropdownHolderCanvas.Visible = true
                TweenService:Create(
                    DropdownHolderFrame,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    { Size = UDim2.fromScale(1, 1) }
                ):Play()
            end

            function Dropdown:Close()
                Dropdown.Opened = false
                TabContent.ScrollingEnabled = true
                DropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
                DropdownHolderCanvas.Visible = false
            end

            function Dropdown:Display()
                local Str = ""
                if Dropdown.Multi then
                    for Value, Bool in pairs(Dropdown.Value) do
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
                    for Value, Bool in pairs(Dropdown.Value) do
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
                for _, Element in pairs(DropdownScrollFrame:GetChildren()) do
                    if not Element:IsA("UIListLayout") then
                        Element:Destroy()
                    end
                end

                local Count = 0
                local Buttons = {}

                for _, Value in ipairs(Dropdown.Values) do
                    Count = Count + 1

                    local Button = Instance.new("TextButton")
                    Button.Size = UDim2.new(1, -5, 0, 32)
                    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Button.BackgroundTransparency = 1
                    Button.Text = ""
                    Button.ZIndex = 3
                    Button.ClipsDescendants = true
                    Button.Parent = DropdownScrollFrame

                    local buttonCorner = Instance.new("UICorner")
                    buttonCorner.CornerRadius = UDim.new(0, 6)
                    buttonCorner.Parent = Button

                    local ButtonSelector = Instance.new("Frame")
                    ButtonSelector.Size = UDim2.fromOffset(4, 14)
                    ButtonSelector.Position = UDim2.fromOffset(-1, 16)
                    ButtonSelector.AnchorPoint = Vector2.new(0, 0.5)
                    ButtonSelector.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
                    ButtonSelector.BackgroundTransparency = 1
                    ButtonSelector.ZIndex = 3
                    ButtonSelector.Parent = Button

                    local selectorCorner = Instance.new("UICorner")
                    selectorCorner.CornerRadius = UDim.new(0, 2)
                    selectorCorner.Parent = ButtonSelector

                    local ButtonLabel = Instance.new("TextLabel")
                    ButtonLabel.Text = Value
                    ButtonLabel.Size = UDim2.fromScale(1, 1)
                    ButtonLabel.Position = UDim2.fromOffset(10, 0)
                    ButtonLabel.BackgroundTransparency = 1
                    ButtonLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                    ButtonLabel.Font = Enum.Font.Gotham
                    ButtonLabel.TextSize = 13
                    ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ButtonLabel.TextTransparency = 1
                    ButtonLabel.ZIndex = 3
                    ButtonLabel.Parent = Button

                    TweenService:Create(ButtonLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                        TextTransparency = 0
                    }):Play()

                    local Selected = Dropdown.Multi and Dropdown.Value[Value] or Dropdown.Value == Value

                    local function UpdateButton()
                        Selected = Dropdown.Multi and Dropdown.Value[Value] or Dropdown.Value == Value
                        local targetTransparency = Selected and 0 or 1
                        local targetSize = Selected and 14 or 6
                        TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                            BackgroundTransparency = Selected and 0.85 or 1
                        }):Play()
                        TweenService:Create(ButtonSelector, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                            BackgroundTransparency = targetTransparency
                        }):Play()
                        TweenService:Create(ButtonSelector, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                            Size = UDim2.fromOffset(4, targetSize)
                        }):Play()
                    end

                    Button.MouseEnter:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(0.2), {
                            BackgroundTransparency = Selected and 0.85 or 0.89
                        }):Play()
                    end)

                    Button.MouseLeave:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(0.2), {
                            BackgroundTransparency = Selected and 0.89 or 1
                        }):Play()
                    end)

                    Button.MouseButton1Down:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(0.2), {
                            BackgroundTransparency = 0.92
                        }):Play()
                    end)

                    Button.MouseButton1Up:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(0.2), {
                            BackgroundTransparency = Selected and 0.85 or 0.89
                        }):Play()
                    end)

                    Button.MouseButton1Click:Connect(function()
                        local Try = not Selected
                        if Dropdown:GetActiveValues() == 1 and not Try and not (info.AllowNull or false) then
                            return
                        end
                        if Dropdown.Multi then
                            Selected = Try
                            Dropdown.Value[Value] = Selected and true or nil
                        else
                            Selected = Try
                            Dropdown.Value = Selected and Value or nil
                            for _, OtherButton in pairs(Buttons) do
                                OtherButton:UpdateButton()
                            end
                        end
                        UpdateButton()
                        Dropdown:Display()
                        if info.Callback and typeof(info.Callback) == "function" then
                            info.Callback(Dropdown.Value)
                        end
                    end)

                    Buttons[Button] = { UpdateButton = UpdateButton }
                    UpdateButton()
                end

                ListSizeX = 0
                for Button, _ in pairs(Buttons) do
                    local textBounds = Button.TextLabel.TextBounds
                    if textBounds.X > ListSizeX then
                        ListSizeX = textBounds.X + 30
                    end
                end

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
                    for _, Value in pairs(Val or {}) do
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
                if info.Callback and typeof(info.Callback) == "function" then
                    info.Callback(Dropdown.Value)
                end
            end

            Dropdown:BuildDropdownList()
            Dropdown:Display()

            if info.Default then
                if Dropdown.Multi then
                    local Defaults = type(info.Default) == "table" and info.Default or {info.Default}
                    for _, Value in pairs(Defaults) do
                        if table.find(Dropdown.Values, Value) then
                            Dropdown.Value[Value] = true
                        end
                    end
                else
                    if table.find(Dropdown.Values, info.Default) then
                        Dropdown.Value = info.Default
                    end
                end
                Dropdown:BuildDropdownList()
                Dropdown:Display()
                if info.Callback and typeof(info.Callback) == "function" then
                    info.Callback(Dropdown.Value)
                end
            end

            local function onSizeChanged()
                adjustTextLabels()
                RecalculateCanvasSize()
            end

            container:GetPropertyChangedSignal("AbsoluteSize"):Connect(onSizeChanged)

            elementY = elementY + container.Size.Y.Offset + 10
            RecalculateCanvasSize()
            return container
        end

        return TabFunctions  
    end  

    return Tabs
end

return OrionLibV2
