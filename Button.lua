function TabFunctions:addButton(tab, buttonInfo)
    local Button = Instance.new("TextButton")
    Button.Name = buttonInfo.Name or "Button"
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = true
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 16
    Button.TextColor3 = Color3.fromRGB(220, 220, 220)
    Button.Text = buttonInfo.Text or "Button"
    Button.LayoutOrder = buttonInfo.LayoutOrder or 0

    -- Container do botão dentro da tab
    local Container = tab:FindFirstChild("Container")
    if not Container then
        Container = Instance.new("Frame")
        Container.Name = "Container"
        Container.Size = UDim2.new(1, 0, 1, 0)
        Container.BackgroundTransparency = 1
        Container.Parent = tab
    end

    Button.Parent = Container

    -- Animação simples no mouse enter/leave
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)

    -- Callback no clique
    if buttonInfo.Callback and typeof(buttonInfo.Callback) == "function" then
        Button.MouseButton1Click:Connect(buttonInfo.Callback)
    end

    return Button
end
