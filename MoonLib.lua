local OrionLibV2 = {}
print("Ui library: Loading")

function OrionLibV2:MakeWindow(Info)
    local TweenService = game:WaitForChild("TweenService")
    local UserInputService = game:WaitForChild("UserInputService")
    local Players = game:WaitForChild("Players")
    local Camera = workspace:WaitForChild("Camera")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer and LocalPlayer:GetMouse()
    if not LocalPlayer then return nil end
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 5)
    if not PlayerGui then return nil end

    local function errorHandler(err)
        warn("OrionLibV2 Error: " .. tostring(err))
    end

    local success, result = pcall(function()
        local ScreenGui = Instance.new("ScreenGui", PlayerGui)
        ScreenGui.Name = "CheatGUI"
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
        Title.Text = (Info and Info.Title) or "Orion"
        Title.Size = UDim2.new(0, 300, 0, 30)
        Title.Position = UDim2.new(0, 10, 0, 5)
        Title.BackgroundTransparency = 1
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 20

        local SubTitle = Instance.new("TextLabel", window)
        SubTitle.Text = (Info and Info.SubTitle) or "Orion Subtitle"
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
        local TabList = {}

        local function createTextLabel(text, font, textSize, color, position, parent, maxWidthOffset)
            local label = Instance.new("TextLabel")
            label.Text = text
            label.Size = UDim2.new(1, maxWidthOffset, 0, 0)
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

            print("Ui Library: Window Loaded")
        local Tabs = {}

        function Tabs:MakeTab(TabInfo)
            local success, tabResult = xpcall(function()
                local Button = Instance.new("TextButton", TabScrollFrame)
                Button.Size = UDim2.new(0, 120, 0, 30)
                Button.Position = UDim2.new(0, 0, 0, ButtonY)
                Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Font = Enum.Font.Gotham
                Button.TextSize = 14
                Button.AutoButtonColor = false
                Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

                local tempLabel = Instance.new("TextLabel")
                tempLabel.Text = (TabInfo and TabInfo.Name) or "Tab"
                tempLabel.Font = Enum.Font.Gotham
                tempLabel.TextSize = 14
                tempLabel.TextWrapped = true
                tempLabel.Size = UDim2.new(0, 110, 0, 0)
                tempLabel.Parent = Button
                local textBounds = tempLabel.TextBounds
                tempLabel:Destroy()
                Button.Text = (TabInfo and TabInfo.Name) or "Tab"
                if textBounds.Y > 30 then
                    Button.Size = UDim2.new(0, 120, 0, math.ceil(textBounds.Y) + 10)
                end
                Button.TextYAlignment = Enum.TextYAlignment.Center

                ButtonY = ButtonY + Button.Size.Y.Offset + 5
                TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ButtonY)

                local TabContent = Instance.new("ScrollingFrame", window)
                TabContent.Name = (TabInfo and TabInfo.Name) or "TabContent"
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
                local extraYOffset = 2

                local function addElementToContainer(container, y, parent, maxWidthOffset, createFunc)
                    local ok, obj = xpcall(createFunc, errorHandler)
                    if ok and obj then
                        y = y + obj.Size.Y.Offset + 10
                        if parent:IsA("ScrollingFrame") then
                            parent.CanvasSize = UDim2.new(0, 0, 0, y)
                        elseif parent:IsA("Frame") then
                            parent.Size = UDim2.new(1, maxWidthOffset, 0, math.max(50, y))
                            local gp = parent.Parent
                            if gp:IsA("ScrollingFrame") then
                                gp.CanvasSize = UDim2.new(0, 0, 0, gp.CanvasSize.Y.Offset + parent.Size.Y.Offset + 10)
                            end
                        end
                    end
                    return obj, y
                end

                        print("Ui library: Tab Loaded")
                        
                function TabFunctions:AddSection(info)
                    local ok, sectionResult = xpcall(function()
                        local container = Instance.new("Frame", TabContent)
                        container.Size = UDim2.new(1, -20, 0, 20)
                        container.Position = UDim2.new(0, 10, 0, elementY + 20)
                        container.BackgroundTransparency = 1
                        container.BorderSizePixel = 0.1

                        local contentFrame = Instance.new("Frame", container)
                        contentFrame.Size = UDim2.new(1, -10, 0, 0)
                        contentFrame.Position = UDim2.new(0, 5, 0, 10)
                        contentFrame.BackgroundTransparency = 1
                        contentFrame.BorderSizePixel = 0.1

                        local nameLabels = {}
                        local nameText = (info and info.Name) or "Section"
                        local tempLabel = createTextLabel(nameText, Enum.Font.GothamBold, 16, Color3.fromRGB(200, 200, 200), UDim2.new(0, 0, 0, 0), container, -10)
                        local maxWidth = container.AbsoluteSize.X - 5
                        if maxWidth <= 0 then maxWidth = 300 end
                        local nameLines = splitText(nameText, tempLabel, maxWidth)
                        tempLabel:Destroy()

                        local yOff = -((#nameLines * 16) / 2)
                        for _, line in ipairs(nameLines) do
                            local nameLabel = createTextLabel(line, Enum.Font.GothamBold, 16, Color3.fromRGB(200, 200, 200), UDim2.new(0.5, 0, 0.5, yOff), container, -10)
                            nameLabel.Size = UDim2.new(1, -10, 0, nameLabel.TextBounds.Y or 16)
                            nameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                            nameLabel.TextXAlignment = Enum.TextXAlignment.Center
                            table.insert(nameLabels, nameLabel)
                            yOff = yOff + (nameLabel.TextBounds.Y or 16)
                            TweenService:Create(nameLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                        end

                        container.Size = UDim2.new(1, -15, 0, math.max(20, yOff + 5))
                        elementY = elementY + container.Size.Y.Offset + 5
                        TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

                        local function onSizeChanged()
                            for _, label in ipairs(nameLabels) do label:Destroy() end
                            nameLabels = {}
                            local maxWidth = container.AbsoluteSize.X - 10
                            if maxWidth <= 0 then maxWidth = 300 end
                            local tempLabel = createTextLabel(nameText, Enum.Font.GothamBold, 16, Color3.fromRGB(200, 200, 200), UDim2.new(0, 0, 0, 0), container, -10)
                            local nameLines = splitText(nameText, tempLabel, maxWidth)
                            tempLabel:Destroy()
                            local yOff = -((#nameLines * 16) / 2)
                            for _, line in ipairs(nameLines) do
                                local nameLabel = createTextLabel(line, Enum.Font.GothamBold, 16, Color3.fromRGB(200, 200, 200), UDim2.new(0.5, 0, 0.5, yOff), container, -10)
                                nameLabel.Size = UDim2.new(1, -10, 0, nameLabel.TextBounds.Y or 16)
                                nameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                                nameLabel.TextXAlignment = Enum.TextXAlignment.Center
                                table.insert(nameLabels, nameLabel)
                                yOff = yOff + (nameLabel.TextBounds.Y or 16)
                                TweenService:Create(nameLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                            end
                            container.Size = UDim2.new(1, -15, 0, math.max(25, yOff + 5))
                            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)
                        end

                        container:GetPropertyChangedSignal("AbsoluteSize"):Connect(onSizeChanged)
                        return container
                    end, errorHandler)
                    if ok then
                        return sectionResult
                    end
                end

                        print("Ui Library: Section Loaded")

function TabFunctions:AddLabel(info)
    info = info or {}
    local createLabel = function()
        local labelContainer = Instance.new("Frame", TabContent)
        labelContainer.Size = UDim2.new(1, -20, 0, 50)
        labelContainer.Position = UDim2.new(0, 10, 0, elementY + 20)
        labelContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        labelContainer.BackgroundTransparency = 1
        labelContainer.BorderSizePixel = 0

        local stroke = Instance.new("UIStroke", labelContainer)
        stroke.Color = Color3.fromRGB(80, 80, 80)
        stroke.Thickness = 1.5

        local corner = Instance.new("UICorner", labelContainer)
        corner.CornerRadius = UDim.new(0, 6)

        local nameLabels = {}
        local descriptionLabels = {}

        local nameText = info.Name or "Label"
        local tempNameLabel = createTextLabel(nameText, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 5, 0, 0), labelContainer, -20)
        local maxWidth = labelContainer.AbsoluteSize.X - 20
        if maxWidth <= 0 then maxWidth = 300 end
        local nameLines = splitText(nameText, tempNameLabel, maxWidth)
        local nameLineHeight = (tempNameLabel.TextBounds.Y ~= 0 and tempNameLabel.TextBounds.Y) or 13
        tempNameLabel:Destroy()

        local totalNameHeight = #nameLines * nameLineHeight
        local yOffset = -(totalNameHeight / 2) + 5
        for _, line in ipairs(nameLines) do
            local nameLabel = createTextLabel(line, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 5, 0.5, yOffset), labelContainer, -20)
            nameLabel.Size = UDim2.new(1, -20, 0, nameLineHeight)
            nameLabel.AnchorPoint = Vector2.new(0, 0.5)
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            table.insert(nameLabels, nameLabel)
            yOffset = yOffset + nameLineHeight
            TweenService:Create(nameLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
        end

        -- Ajustando yOffset para descrição: começa logo abaixo da última linha do nome
        yOffset = yOffset - (nameLineHeight / 2) + 30

        local descText = info.Description or ""
        local tempDescLabel = createTextLabel(descText, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 5, 0, yOffset), labelContainer, -20)
        local descLines = splitText(descText, tempDescLabel, maxWidth)
        tempDescLabel:Destroy()

        for _, line in ipairs(descLines) do
            local descLabel = createTextLabel(line, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 5, 0, yOffset), labelContainer, -20)
            descLabel.Size = UDim2.new(1, -20, 0, descLabel.TextBounds.Y or 11)
            table.insert(descriptionLabels, descLabel)
            yOffset = yOffset + (descLabel.TextBounds.Y or 11)
            TweenService:Create(descLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
        end

        labelContainer.Size = UDim2.new(1, -20, 0, math.max(50, yOffset + 10))
        TweenService:Create(labelContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()

        -- Printando cada elemento
        print("Label Container:", labelContainer)
        for _, label in ipairs(nameLabels) do
            print("Name Label:", label.Text)
        end
        for _, label in ipairs(descriptionLabels) do
            print("Description Label:", label.Text)
        end

        return labelContainer
    end
    local newLabel, newElementY = addElementToContainer(TabContent, elementY, TabContent, -20, createLabel)
    elementY = newElementY
    return newLabel
end
                function TabFunctions:AddButton(info)
                    local createButton = function()
                        local buttonContainer = Instance.new("Frame", TabContent)
                        buttonContainer.Size = UDim2.new(1, -20, 0, 50)
                        buttonContainer.Position = UDim2.new(0, 10, 0, elementY + 20)
                        buttonContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        buttonContainer.BackgroundTransparency = 1
                        buttonContainer.BorderSizePixel = 0

                        local stroke = Instance.new("UIStroke", buttonContainer)
                        stroke.Color = Color3.fromRGB(80, 80, 80)
                        stroke.Thickness = 1.5

                        local corner = Instance.new("UICorner", buttonContainer)
                        corner.CornerRadius = UDim.new(0, 6)

                        local nameLabels = {}
                        local descriptionLabels = {}

                        local button = Instance.new("TextButton", buttonContainer)
                        button.Size = UDim2.new(1, 0, 1, 0)
                        button.Position = UDim2.new(0, 0, 0, 0)
                        button.BackgroundTransparency = 1
                        button.Text = ""
                        button.AutoButtonColor = false
                        button.ZIndex = 2

                        local nameText = (info and info.Name) or "Button"
                        local tempNameLabel = createTextLabel(nameText, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 10, 0, 0), buttonContainer, -20)
                        local maxWidth = buttonContainer.AbsoluteSize.X - 20
                        if maxWidth <= 0 then maxWidth = 300 end
                        local nameLines = splitText(nameText, tempNameLabel, maxWidth)
                        tempNameLabel:Destroy()

                        local yOffset = -((#nameLines * 14) / 2) + extraYOffset
                        for _, line in ipairs(nameLines) do
                            local nameLabel = createTextLabel(line, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 10, 0.5, yOffset), buttonContainer, -20)
                            nameLabel.Size = UDim2.new(1, -20, 0, nameLabel.TextBounds.Y or 14)
                            nameLabel.AnchorPoint = Vector2.new(0, 0.5)
                            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                            table.insert(nameLabels, nameLabel)
                            yOffset = yOffset + (nameLabel.TextBounds.Y or 14)
                            TweenService:Create(nameLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                        end

                        local descText = (info and info.Description) or ""
                        local tempDescLabel = createTextLabel(descText, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 10, 0, yOffset), buttonContainer, -20)
                        local descLines = splitText(descText, tempDescLabel, maxWidth)
                        tempDescLabel:Destroy()

                        for _, line in ipairs(descLines) do
                            local descLabel = createTextLabel(line, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 10, 0, yOffset), buttonContainer, -20)
                            descLabel.Size = UDim2.new(1, -20, 0, descLabel.TextBounds.Y or 11)
                            table.insert(descriptionLabels, descLabel)
                            yOffset = yOffset + (descLabel.TextBounds.Y or 11)
                            TweenService:Create(descLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                        end

                        buttonContainer.Size = UDim2.new(1, -20, 0, math.max(50, yOffset + 10))
                        TweenService:Create(buttonContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()

                        if info and typeof(info.Callback) == "function" then
                            button.MouseButton1Click:Connect(function()
                                local ok, cbErr = xpcall(info.Callback, errorHandler)
                                if not ok then warn(cbErr) end
                            end)
                        end

                        button.MouseEnter:Connect(function()
                            TweenService:Create(buttonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                        end)
                        button.MouseLeave:Connect(function()
                            TweenService:Create(buttonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                        end)

                        return buttonContainer
                    end
                    local newButton, newElementY = addElementToContainer(TabContent, elementY, TabContent, -20, createButton)
                    elementY = newElementY
                    return newButton
                end

                        print("Ui Library: Button Loaded")
                function TabFunctions:AddToggle(info)
                    local createToggle = function()
                        local toggleContainer = Instance.new("Frame", TabContent)
                        toggleContainer.Size = UDim2.new(1, -20, 0, 50)
                        toggleContainer.Position = UDim2.new(0, 10, 0, elementY + 20)
                        toggleContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        toggleContainer.BackgroundTransparency = 1
                        toggleContainer.BorderSizePixel = 0

                        local stroke = Instance.new("UIStroke", toggleContainer)
                        stroke.Color = Color3.fromRGB(80, 80, 80)
                        stroke.Thickness = 1.5

                        local corner = Instance.new("UICorner", toggleContainer)
                        corner.CornerRadius = UDim.new(0, 6)

                        local nameLabels = {}
                        local descriptionLabels = {}

                        local nameText = (info and info.Name) or "Toggle"
                        local tempNameLabel = createTextLabel(nameText, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 10, 0, 0), toggleContainer, -70)
                        local maxWidth = toggleContainer.AbsoluteSize.X - 70
                        if maxWidth <= 0 then maxWidth = 300 end
                        local nameLines = splitText(nameText, tempNameLabel, maxWidth)
                        tempNameLabel:Destroy()

                        local yOffset = -((#nameLines * 14) / 2) + extraYOffset
                        for _, line in ipairs(nameLines) do
                            local nameLabel = createTextLabel(line, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 10, 0.5, yOffset), toggleContainer, -70)
                            nameLabel.Size = UDim2.new(1, -70, 0, nameLabel.TextBounds.Y or 14)
                            nameLabel.AnchorPoint = Vector2.new(0, 0.5)
                            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                            table.insert(nameLabels, nameLabel)
                            yOffset = yOffset + (nameLabel.TextBounds.Y or 14)
                            TweenService:Create(nameLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                        end

                        local descText = (info and info.Description) or ""
                        local tempDescLabel = createTextLabel(descText, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 10, 0, yOffset), toggleContainer, -70)
                        local descLines = splitText(descText, tempDescLabel, maxWidth)
                        tempDescLabel:Destroy()

                        for _, line in ipairs(descLines) do
                            local descLabel = createTextLabel(line, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 10, 0, yOffset), toggleContainer, -70)
                            descLabel.Size = UDim2.new(1, -70, 0, descLabel.TextBounds.Y or 11)
                            table.insert(descriptionLabels, descLabel)
                            yOffset = yOffset + (descLabel.TextBounds.Y or 11)
                            TweenService:Create(descLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                        end

                        toggleContainer.Size = UDim2.new(1, -20, 0, math.max(50, yOffset + 5))

                        local toggleButton = Instance.new("TextButton", toggleContainer)
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

                        local isOn = (info and info.Default) or false
                        local function updateToggle()
                            isOn = (isOn == nil) and false or isOn
                            local bg = isOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
                            local targetPosition = isOn and UDim2.new(0, 28, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                            TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = bg}):Play()
                            TweenService:Create(toggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetPosition}):Play()
                            if info and typeof(info.Callback) == "function" then
                                local ok, cbErr = xpcall(function() info.Callback(isOn) end, errorHandler)
                                if not ok then warn(cbErr) end
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

                        TweenService:Create(toggleContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
                        TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
                        TweenService:Create(toggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()

                        updateToggle()
                        return toggleContainer
                    end
                    local newToggle, newElementY = addElementToContainer(TabContent, elementY, TabContent, -20, createToggle)
                    elementY = newElementY
                    return newToggle
                end

                        print("Ui Library: Toggle Loaded")
                function TabFunctions:AddDropdown(info)
                    local createDropdown = function()
                        local dropdownContainer = Instance.new("Frame", TabContent)
                        dropdownContainer.Size = UDim2.new(1, -20, 0, 50)
                        dropdownContainer.Position = UDim2.new(0, 10, 0, elementY + 20)
                        dropdownContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        dropdownContainer.BackgroundTransparency = 1
                        dropdownContainer.BorderSizePixel = 0
                        dropdownContainer.ZIndex = 1

                        local stroke = Instance.new("UIStroke")
                        stroke.Color = Color3.fromRGB(80, 80, 80)
                        stroke.Thickness = 1.5
                        stroke.Parent = dropdownContainer

                        local corner = Instance.new("UICorner")
                        corner.CornerRadius = UDim.new(0, 6)
                        corner.Parent = dropdownContainer

                        local nameLabels = {}
                        local descriptionLabels = {}

                        local nameText = (info and info.Name) or "Dropdown"
                        local tempNameLabel = createTextLabel(nameText, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 10, 0, 0), dropdownContainer, -170)
                        local maxWidth = dropdownContainer.AbsoluteSize.X - 170
                        if maxWidth <= 0 then maxWidth = 300 end
                        local nameLines = splitText(nameText, tempNameLabel, maxWidth)
                        tempNameLabel:Destroy()

                        local yOffset = -((#nameLines * 14) / 2) + extraYOffset
                        for _, line in ipairs(nameLines) do
                            local nameLabel = createTextLabel(line, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 10, 0.5, yOffset), dropdownContainer, -170)
                            nameLabel.Size = UDim2.new(1, -170, 0, nameLabel.TextBounds.Y or 14)
                            nameLabel.AnchorPoint = Vector2.new(0, 0.5)
                            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                            table.insert(nameLabels, nameLabel)
                            yOffset = yOffset + (nameLabel.TextBounds.Y or 14)
                            TweenService:Create(nameLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                        end

                        local descText = (info and info.Description) or ""
                        local tempDescLabel = createTextLabel(descText, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 10, 0, yOffset), dropdownContainer, -170)
                        local descLines = splitText(descText, tempDescLabel, maxWidth)
                        tempDescLabel:Destroy()

                        for _, line in ipairs(descLines) do
                            local descLabel = createTextLabel(line, Enum.Font.Gotham, 11, Color3.fromRGB(180, 180, 180), UDim2.new(0, 10, 0, yOffset), dropdownContainer, -170)
                            descLabel.Size = UDim2.new(1, -170, 0, descLabel.TextBounds.Y or 11)
                            table.insert(descriptionLabels, descLabel)
                            yOffset = yOffset + (descLabel.TextBounds.Y or 11)
                            TweenService:Create(descLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                        end

                        dropdownContainer.Size = UDim2.new(1, -20, 0, math.max(50, yOffset + 5))

                        local Dropdown = {
                            Values = (info and info.Values) or {},
                            Value = (info and info.Default) or ((info and info.Multi) and {} or nil),
                            Multi = (info and info.Multi) or false,
                            Buttons = {},
                            Opened = false,
                            Callback = (info and info.Callback) or function() end,
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
                        DropdownDisplay.Parent = dropdownContainer

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
                        DropdownHolderCanvas.Parent = PlayerGui
                        DropdownHolderFrame.Parent = DropdownHolderCanvas

                        local sizeConstraint = Instance.new("UISizeConstraint")
                        sizeConstraint.MinSize = Vector2.new(170, 0)
                        sizeConstraint.Parent = DropdownHolderCanvas

                        TweenService:Create(dropdownContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
                        TweenService:Create(DropdownDisplay, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
                        TweenService:Create(DropdownIco, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {ImageTransparency = 0}):Play()

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
                                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X or Mouse.Y < (AbsPos.Y - 20) or Mouse.Y > AbsPos.Y + AbsSize.Y then
                                    Dropdown:Close()
                                end
                            end
                        end)

                        function Dropdown:Open()
                            Dropdown.Opened = true
                            TabContent.ScrollingEnabled = false
                            DropdownHolderCanvas.Visible = true
                            TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 1)}):Play()
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

                            local Buttons = {}

                            for _, Value in ipairs(Dropdown.Values) do
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
                                ButtonSelector.Size = UDim2.fromOffset(4, 10)
                                ButtonSelector.Position = UDim2.fromOffset(-1, 16)
                                ButtonSelector.AnchorPoint = UDim2.new(0, 0.5)
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

                                TweenService:Create(ButtonLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

                                local Selected = Dropdown.Multi and Dropdown.Value[Value] or Dropdown.Value == Value

                                local function UpdateButton()
                                    Selected = Dropdown.Multi and Dropdown.Value[Value] or Dropdown.Value == Value
                                    local targetTransparency = Selected and 0 or 1
                                    local targetSize = Selected and 14 or 10
                                    TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = Selected and 0.85 or 1}):Play()
                                    TweenService:Create(ButtonSelector, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = targetTransparency}):Play()
                                    TweenService:Create(ButtonSelector, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.fromOffset(4, targetSize)}):Play()
                                end

                                Button.MouseEnter:Connect(function()
                                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = Selected and 0.85 or 0.89}):Play()
                                end)

                                Button.MouseLeave:Connect(function()
                                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = Selected and 0.85 or 1}):Play()
                                end)

                                Button.MouseButton1Down:Connect(function()
                                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = 0.92}):Play()
                                end)

                                Button.MouseButton1Up:Connect(function()
                                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = Selected and 0.85 or 0.95}):Play()
                                end)

                                Button.MouseButton1Click:Connect(function()
                                    local Try = not Selected
                                    if Dropdown:GetActiveValues() == 1 and not Try and not ((info and info.AllowNull) or false) then
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
                                    if info and typeof(info.Callback) == "function" then
                                        local ok, cbErr = xpcall(function() info.Callback(Dropdown.Value) end, errorHandler)
                                        if not ok then warn(cbErr) end
                                    end
                                end)

                                Buttons[Button] = { UpdateButton = UpdateButton }
                                UpdateButton()
                            end

                            ListSizeX = 0
                            for Button, _ in pairs(Buttons) do
                                local lbl = Button:FindFirstChildWhichIsA("TextLabel", true)
                                if lbl then
                                    local textBounds = lbl.TextBounds
                                    if textBounds.X > ListSizeX then
                                        ListSizeX = textBounds.X + 30
                                    end
                                end
                            end

                            RecalculateCanvasSize()
                            RecalculateListSize()
                        end

                        function Dropdown:SetValues(NewValues)
                            local ok, err = xpcall(function()
                                if NewValues then
                                    Dropdown.Values = NewValues
                                end
                                Dropdown:BuildDropdownList()
                            end, errorHandler)
                            if not ok then warn(err) end
                        end

                        function Dropdown:SetValue(Val)
                            local ok, err = xpcall(function()
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
                                if info and typeof(info.Callback) == "function" then
                                    info.Callback(Dropdown.Value)
                                end
                            end, errorHandler)
                            if not ok then warn(err) end
                        end

                        Dropdown:BuildDropdownList()
                        Dropdown:Display()

                        if info and info.Default then
                            local ok, err = xpcall(function()
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
                                if info and typeof(info.Callback) == "function" then
                                    info.Callback(Dropdown.Value)
                                end
                            end, errorHandler)
                            if not ok then warn(err) end
                        end

                        return dropdownContainer
                    end
                    local newDropdown, newElementY = addElementToContainer(TabContent, elementY, TabContent, -20, createDropdown)
                    elementY = newElementY
                    return newDropdown
                end

                        print("Ui Library: Dropdown Loaded")
                return TabFunctions
            end, errorHandler)
            if success then
                return tabResult
            end
        end

        return Tabs
    end, errorHandler)

    if success then
        return result
    end
end
print("To com preguiça Ok? isso veio da Ui Library não do script.")
print("Ui library: Loaded")
return OrionLibV2
