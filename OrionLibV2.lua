local OrionLibV2 = {}

function OrionLibV2:MakeWindow(Info)
    local TweenService = game:GetService("TweenService")

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
    Title.TextWrapped = true
    Title.TextTruncate = Enum.TextTruncate.AtEnd

    local SubTitle = Instance.new("TextLabel", window)
    SubTitle.Text = Info.SubTitle or "Orion Subtitle"
    SubTitle.Size = UDim2.new(0, 300, 0, 20)
    SubTitle.Position = UDim2.new(0, 10, 0, 35)
    SubTitle.BackgroundTransparency = 1
    SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextSize = 14
    SubTitle.TextWrapped = true
    SubTitle.TextTruncate = Enum.TextTruncate.AtEnd

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

    local tabLayout = Instance.new("UIListLayout", TabScrollFrame)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 5)

    local Tabs = {}
    local TabList = {}

    function Tabs:MakeTab(TabInfo)
        local Button = Instance.new("TextButton", TabScrollFrame)
        Button.Size = UDim2.new(0, 120, 0, 30)
        Button.Text = TabInfo.Name or "Tab"
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14
        Button.AutoButtonColor = false
        Button.TextWrapped = true
        Button.TextTruncate = Enum.TextTruncate.AtEnd
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

        -- Ajustar altura do botão da aba se o texto for longo
        task.spawn(function()
            task.wait() -- Esperar renderização
            local textBounds = Button.TextBounds
            if textBounds.Y > 30 then
                Button.Size = UDim2.new(0, 120, 0, textBounds.Y + 10)
            end
        end)

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

        local contentLayout = Instance.new("UIListLayout", TabContent)
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 10)

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

        local TabFunctions = {}

        function TabFunctions:AddSection(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 25)
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
            sectionLabel.TextWrapped = true
            sectionLabel.TextTruncate = Enum.TextTruncate.AtEnd

            -- Ajustar altura do container da seção
            task.spawn(function()
                task.wait()
                local textBounds = sectionLabel.TextBounds
                if textBounds.Y > 25 then
                    container.Size = UDim2.new(1, -20, 0, textBounds.Y + 10)
                end
            end)

            TweenService:Create(sectionLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            return container
        end

        function TabFunctions:AddLabel(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
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
            title.TextWrapped = true
            title.TextTruncate = Enum.TextTruncate.AtEnd

            local description = Instance.new("TextLabel", container)
            description.Text = info.Description or "Texto"
            description.Size = UDim2.new(1, -10, 0, 18)
            description.Position = UDim2.new(0, 5, 0, 25)
            description.BackgroundTransparency = 1
            description.TextColor3 = Color3.fromRGB(180, 180, 180)
            description.Font = Enum.Font.Gotham
            description.TextSize = 13
            description.TextXAlignment = Enum.TextXAlignment.Left
            description.TextTransparency = 1
            description.TextWrapped = true

            -- Ajustar altura do container e posições com base no texto
            task.spawn(function()
                task.wait()
                local titleBounds = title.TextBounds
                local descBounds = description.TextBounds
                local titleHeight = math.max(18, titleBounds.Y)
                local descHeight = math.max(18, descBounds.Y)
                title.Size = UDim2.new(1, -10, 0, titleHeight)
                description.Size = UDim2.new(1, -10, 0, descHeight)
                description.Position = UDim2.new(0, 5, 0, 5 + titleHeight + 5)
                container.Size = UDim2.new(1, -20, 0, titleHeight + descHeight + 15)
            end)

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(title, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(description, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            return container
        end

        function TabFunctions:AddButton(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
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
            button.TextWrapped = true
            button.TextTruncate = Enum.TextTruncate.AtEnd

            local buttonCorner = Instance.new("UICorner", button)
            buttonCorner.CornerRadius = UDim.new(0, 6)

            -- Ajustar altura do botão e container
            task.spawn(function()
                task.wait()
                local textBounds = button.TextBounds
                if textBounds.Y > 30 then
                    button.Size = UDim2.new(1, -10, 0, textBounds.Y + 10)
                    container.Size = UDim2.new(1, -20, 0, textBounds.Y + 20)
                end
            end)

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

            local canClick = true
            button.MouseButton1Click:Connect(function()
                if canClick then
                    canClick = false
                    if info.Callback and typeof(info.Callback) == "function" then
                        local success, err = pcall(info.Callback)
                        if not success then warn("Button callback error: " .. err) end
                    end
                    task.wait(0.2)
                    canClick = true
                end
            end)

            return container
        end

        function TabFunctions:AddToggle(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
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
            toggleText.Position = UDim2.new(0, 10, 0, 5)
            toggleText.BackgroundTransparency = 1
            toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleText.Font = Enum.Font.GothamBold
            toggleText.TextSize = 14
            toggleText.TextXAlignment = Enum.TextXAlignment.Left
            toggleText.TextTransparency = 1
            toggleText.TextWrapped = true
            toggleText.TextTruncate = Enum.TextTruncate.AtEnd

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

            -- Ajustar altura do container e posições com base no texto
            task.spawn(function()
                task.wait()
                local textBounds = toggleText.TextBounds
                local descBounds = toggleDescription.TextBounds
                local textHeight = math.max(20, textBounds.Y)
                local descHeight = descBounds.Y > 0 and math.max(15, descBounds.Y) or 0
                toggleText.Size = UDim2.new(1, -60, 0, textHeight)
                toggleDescription.Size = UDim2.new(1, -60, 0, descHeight)
                toggleDescription.Position = UDim2.new(0, 10, 0, 5 + textHeight + 5)
                local totalHeight = math.max(50, textHeight + descHeight + 24 + 15)
                container.Size = UDim2.new(1, -20, 0, totalHeight)
                toggleButton.Position = UDim2.new(1, -60, 0, totalHeight - 24 - 5)
            end)

            local isOn = info.Default or false
            local canClick = true

            local function updateToggle()
                local toggleBackgroundColor = isOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
                local targetPosition = isOn and UDim2.new(0, 28, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = toggleBackgroundColor
                }):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Position = targetPosition
                }):Play()
                if info.Callback and typeof(info.Callback) == "function" then
                    local success, err = pcall(info.Callback, isOn)
                    if not success then warn("Toggle callback error: " .. err) end
                end
            end

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(toggleText, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            if toggleDescription.Text ~= "" then
                TweenService:Create(toggleDescription, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    TextTransparency = 0
                }):Play()
            end
            TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(toggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()

            toggleButton.MouseButton1Click:Connect(function()
                if canClick then
                    canClick = false
                    isOn = not isOn
                    updateToggle()
                    task.wait(0.2)
                    canClick = true
                end
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

            return container
        end

        return TabFunctions
    end

    return Tabs
end

return OrionLibV2
