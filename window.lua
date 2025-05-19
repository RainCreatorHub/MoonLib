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
end
