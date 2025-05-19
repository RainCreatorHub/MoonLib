function TabFunctions:addLabel(section, labelInfo)
    -- Container principal da label (Frame)
    local Container = Instance.new("Frame")
    Container.Name = labelInfo.Name or "LabelContainer"
    Container.BackgroundTransparency = 1
    Container.Size = UDim2.new(1, 0, 0, 24)
    Container.LayoutOrder = labelInfo.LayoutOrder or 0
    Container.Parent = section

    -- Padding opcional (exemplo)
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 6)
    UIPadding.PaddingRight = UDim.new(0, 6)
    UIPadding.PaddingTop = UDim.new(0, 4)
    UIPadding.PaddingBottom = UDim.new(0, 4)
    UIPadding.Parent = Container

    -- Label de texto
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 16
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.Text = labelInfo.Text or "Label Text"
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Center
    Label.Parent = Container

    -- Animação simples de fade in no texto
    Label.TextTransparency = 1
    spawn(function()
        for i = 1, 10 do
            Label.TextTransparency = Label.TextTransparency - 0.1
            wait(0.03)
        end
        Label.TextTransparency = 0
    end)

    return Container
end
