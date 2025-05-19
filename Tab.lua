function OrionLibV2:MakeTab(Window, Info)
    local TweenService = game:GetService("TweenService")

    local TabButton = Instance.new("TextButton")
    TabButton.Name = Info.Name or "Tab"
    TabButton.Size = UDim2.new(1, 0, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextSize = 16
    TabButton.Text = Info.Name or "Tab"
    TabButton.AutoButtonColor = false

    local UICorner = Instance.new("UICorner", TabButton)
    UICorner.CornerRadius = UDim.new(0, 6)

    TabButton.MouseEnter:Connect(function()
        TweenService:Create(TabButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end)

    TabButton.MouseLeave:Connect(function()
        TweenService:Create(TabButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
    end)

    -- Frame para o conteúdo da aba
    local TabContent = Instance.new("Frame")
    TabContent.Name = Info.Name .. "Content"
    TabContent.Size = UDim2.new(1, -150, 1, -80)
    TabContent.Position = UDim2.new(0, 140, 0, 70)
    TabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContent.Visible = false
    TabContent.Parent = Window

    local UICornerContent = Instance.new("UICorner", TabContent)
    UICornerContent.CornerRadius = UDim.new(0, 12)

    -- Troca de abas
    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(Window:GetChildren()) do
            if frame:IsA("Frame") and frame.Name:find("Content") then
                frame.Visible = false
            end
        end
        TabContent.Visible = true
    end)

    return TabButton, TabContent
end
