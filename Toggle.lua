function TabFunctions:addToggle(tab, toggleInfo)
    local Container = tab:FindFirstChild("Container")
    if not Container then
        Container = Instance.new("Frame")
        Container.Name = "Container"
        Container.Size = UDim2.new(1, 0, 1, 0)
        Container.BackgroundTransparency = 1
        Container.Parent = tab
    end

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.LayoutOrder = toggleInfo.LayoutOrder or 0
    ToggleFrame.Parent = Container

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = toggleInfo.Text or "Toggle"
    ToggleLabel.Font = Enum.Font.GothamBold
    ToggleLabel.TextSize = 16
    ToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(0.85, 0, 0.15, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame

    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 18, 0, 18)
    ToggleCircle.Position = UDim2.new(0, 2, 0, 1)
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.AnchorPoint = Vector2.new(0, 0)
    ToggleCircle.Parent = ToggleButton

    local toggled = false

    local function updateToggle()
        if toggled then
            ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            ToggleCircle:TweenPosition(UDim2.new(1, -20, 0, 1), "Out", "Quad", 0.2, true)
        else
            ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleCircle:TweenPosition(UDim2.new(0, 2, 0, 1), "Out", "Quad", 0.2, true)
        end
    end

    ToggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        updateToggle()
        if toggleInfo.Callback and typeof(toggleInfo.Callback) == "function" then
            toggleInfo.Callback(toggled)
        end
    end)

    updateToggle()

    return ToggleFrame
end
