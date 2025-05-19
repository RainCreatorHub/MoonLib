local TabFunctions = {}

function TabFunctions:addSection(tab, sectionInfo)
    local Section = Instance.new("Frame")
    Section.Name = sectionInfo.Name or "Section"
    Section.Size = UDim2.new(1, 0, 0, 150)
    Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Section.BorderSizePixel = 0
    Section.Parent = tab

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Section

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 28)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(230, 230, 230)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Text = sectionInfo.Name or "Section"
    Title.Parent = Section

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Section
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)

    return Section
end

return TabFunctions
