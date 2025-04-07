local UILibrary = {}
UILibrary.__index = UILibrary

-- Serviços do Roblox
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Função para criar a janela principal
function UILibrary:MakeWindow(config)
    local window = {}
    setmetatable(window, UILibrary)
    
    -- Configurações padrão
    local title = config.Title or "UI Library"
    local subtitle = config.SubTitle or "by Grok"
    local saveFolder = config.SaveFolder or "ui_config.lua"
    
    -- Criação da ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UILibraryGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Tornar o frame arrastável
    local dragging, dragInput, dragStart, startPos
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleLabel.Text = title .. " | " .. subtitle
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = mainFrame
    
    -- Container para abas
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, -10, 1, -40)
    tabContainer.Position = UDim2.new(0, 5, 0, 35)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame
    
    window.MainFrame = mainFrame
    window.TabContainer = tabContainer
    window.Tabs = {}
    return window
end

-- Função para adicionar abas
function UILibrary:AddTab(name)
    local tab = {}
    
    -- Frame da aba
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Parent = self.TabContainer
    tabFrame.Visible = false
    
    tab.Frame = tabFrame
    tab.Elements = {}
    
    -- Botão da aba (simplificado, geralmente seria em uma barra lateral)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 100, 0, 30)
    tabButton.Position = UDim2.new(0, #self.Tabs * 105, 0, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Parent = self.MainFrame
    
    tabButton.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do
            t.Frame.Visible = false
        end
        tabFrame.Visible = true
    end)
    
    table.insert(self.Tabs, tab)
    if #self.Tabs == 1 then
        tabFrame.Visible = true
    end
    
    return tab
end

-- Função para adicionar botão
function UILibrary:AddButton(tab, config)
    local buttonName = config.Name or "Button"
    local callback = config.Callback or function() end
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 150, 0, 30)
    button.Position = UDim2.new(0, 5, 0, #tab.Elements * 35)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = buttonName
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = tab.Frame
    
    button.MouseButton1Click:Connect(callback)
    table.insert(tab.Elements, button)
end

-- Função para adicionar botão de minimizar
function UILibrary:AddMinimizeButton(config)
    local buttonImage = config.Button.Image or "rbxassetid://6026568198"
    local cornerRadius = config.Corner.CornerRadius or UDim.new(0, 5)
    
    local minimizeButton = Instance.new("ImageButton")
    minimizeButton.Size = UDim2.new(0, 25, 0, 25)
    minimizeButton.Position = UDim2.new(1, -30, 0, 5)
    minimizeButton.BackgroundTransparency = 1
    minimizeButton.Image = buttonImage
    minimizeButton.Parent = self.MainFrame
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = cornerRadius
    uiCorner.Parent = minimizeButton
    
    local minimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        self.TabContainer.Visible = not minimized
        TweenService:Create(
            self.MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = minimized and UDim2.new(0, 400, 0, 30) or UDim2.new(0, 400, 0, 300)}
        ):Play()
    end)
end
return UILibrary
