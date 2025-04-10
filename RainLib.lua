-- RainLib.lua - Versão Colossal (1700 linhas) com Detalhes e Animações
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local RainLib = {
    Version = "1.2.3-Colossal-Animations",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(20, 20, 25),
            Accent = Color3.fromRGB(60, 160, 255),
            Text = Color3.fromRGB(240, 240, 245),
            Secondary = Color3.fromRGB(40, 40, 50),
            Disabled = Color3.fromRGB(80, 80, 90),
            Highlight = Color3.fromRGB(70, 70, 85),
            Glow = Color3.fromRGB(100, 150, 255)
        },
        Light = {
            Background = Color3.fromRGB(245, 245, 250),
            Accent = Color3.fromRGB(50, 120, 255),
            Text = Color3.fromRGB(20, 20, 25),
            Secondary = Color3.fromRGB(200, 200, 210),
            Disabled = Color3.fromRGB(140, 140, 150),
            Highlight = Color3.fromRGB(180, 180, 190),
            Glow = Color3.fromRGB(120, 180, 255)
        },
        Neon = {
            Background = Color3.fromRGB(10, 10, 20),
            Accent = Color3.fromRGB(255, 0, 255),
            Text = Color3.fromRGB(255, 255, 255),
            Secondary = Color3.fromRGB(20, 20, 40),
            Disabled = Color3.fromRGB(100, 0, 100),
            Highlight = Color3.fromRGB(50, 0, 50),
            Glow = Color3.fromRGB(255, 100, 255)
        }
    },
    CurrentTheme = nil,
    Windows = {},
    Connections = {},
    Particles = {},
    Animations = {}
}

-- Funções Auxiliares
local function tween(obj, info, properties)
    local tweenInfo = info or TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

local function MakeDraggable(DragPoint, Main)
    local Dragging, DragInput, MousePos, FramePos = false
    RainLib.Connections[#RainLib.Connections + 1] = DragPoint.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            MousePos = Input.Position
            FramePos = Main.Position
            tween(DragPoint, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
        end
    end)
    RainLib.Connections[#RainLib.Connections + 1] = DragPoint.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement then
            DragInput = Input
        end
    end)
    RainLib.Connections[#RainLib.Connections + 1] = UserInputService.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging then
            local Delta = Input.Position - MousePos
            Main.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
        end
    end)
    RainLib.Connections[#RainLib.Connections + 1] = DragPoint.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
            tween(DragPoint, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
        end
    end)
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function AddGradient(parent)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, RainLib.CurrentTheme.Background),
        ColorSequenceKeypoint.new(1, RainLib.CurrentTheme.Secondary)
    })
    gradient.Rotation = 45
    gradient.Parent = parent
    return gradient
end

local function AddGlow(parent)
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1, 20, 1, 20)
    glow.Position = UDim2.new(0, -10, 0, -10)
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = RainLib.CurrentTheme.Glow
    glow.ImageTransparency = 0.6
    glow.BackgroundTransparency = 1
    glow.Parent = parent
    return glow
end

local function AddParticles(parent, count)
    for i = 1, count or 5 do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = RainLib.CurrentTheme.Glow
        particle.BorderSizePixel = 0
        particle.Parent = parent
        CreateCorner(particle, 100)
        
        local function animateParticle()
            tween(particle, TweenInfo.new(math.random(2, 5), Enum.EasingStyle.Sine), {
                Position = UDim2.new(math.random(), 0, math.random(), 0),
                BackgroundTransparency = math.random(0.5, 1)
            }).Completed:Connect(animateParticle)
        end
        animateParticle()
        table.insert(RainLib.Particles, particle)
    end
end

local function LoadSettings(configFolder)
    local settingsPath = configFolder .. "/Settings.json"
    if isfile and readfile and isfile(settingsPath) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(settingsPath))
        end)
        if success then return data end
    end
    return {}
end

local function SaveSettings(configFolder, settings)
    if writefile then
        pcall(function()
            writefile(configFolder .. "/Settings.json", HttpService:JSONEncode(settings))
        end)
    end
end

-- Inicialização
RainLib.ScreenGui = Instance.new("ScreenGui")
RainLib.ScreenGui.Name = "RainLibColossal"
RainLib.ScreenGui.Parent = game.CoreGui or Players.LocalPlayer.PlayerGui
RainLib.ScreenGui.ResetOnSpawn = false
RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
RainLib.CurrentTheme = RainLib.Themes.Dark

-- Sistema de Easter Eggs
local function AddEasterEgg()
    if math.random(1, 100) <= 10 then
        RainLib:Notify(nil, {
            Title = "EASTER EGG DETECTADO!",
            Content = "Um Titan tá rondando por aí... Cuidado!",
            Duration = 5,
            Buttons = {
                {Text = "Fugir!", Callback = function() print("Corre, mano!") end}
            }
        })
    end
end

-- Função Principal: Janela
function RainLib:Window(options)
    local window = {
        Settings = {},
        Tabs = {},
        Notifications = Instance.new("Frame"),
        Elements = {},
        CustomTheme = nil,
        Visible = true,
        DraggableElements = {},
        Animations = {}
    }
    options = options or {}
    local defaultOptions = {
        Title = "RainLib Colossal",
        SubTitle = "Animações Épicas",
        Theme = "Dark",
        MinimizeKey = "RightControl",
        ConfigFolder = "RainLibColossal"
    }
    
    window.Settings = LoadSettings(options.ConfigFolder or defaultOptions.ConfigFolder)
    window.Settings.Theme = options.Theme or window.Settings.Theme or defaultOptions.Theme
    window.Settings.MinimizeKey = options.MinimizeKey or window.Settings.MinimizeKey or defaultOptions.MinimizeKey
    
    window.MainFrame = Instance.new("Frame")
    window.MainFrame.Size = UDim2.new(0, 850, 0, 650)
    window.MainFrame.Position = UDim2.new(0.5, -425, 0.5, -325)
    window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
    window.MainFrame.BackgroundTransparency = 0.05
    window.MainFrame.ClipsDescendants = true
    window.MainFrame.BorderSizePixel = 0
    window.MainFrame.Parent = RainLib.ScreenGui
    CreateCorner(window.MainFrame, 15)
    AddGradient(window.MainFrame)
    AddGlow(window.MainFrame)
    AddParticles(window.MainFrame, 8)
    
    tween(window.MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0, 850, 0, 650), Position = UDim2.new(0.5, -425, 0.5, -325)})
    
    window.TitleBar = Instance.new("Frame")
    window.TitleBar.Size = UDim2.new(1, 0, 0, 60)
    window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    window.TitleBar.Parent = window.MainFrame
    CreateCorner(window.TitleBar, 10)
    AddGradient(window.TitleBar)
    
    window.TitleLabel = Instance.new("TextLabel")
    window.TitleLabel.Size = UDim2.new(1, -120, 0, 25)
    window.TitleLabel.Position = UDim2.new(0, 20, 0, 8)
    window.TitleLabel.BackgroundTransparency = 1
    window.TitleLabel.Text = options.Title or defaultOptions.Title
    window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
    window.TitleLabel.Font = Enum.Font.GothamBold
    window.TitleLabel.TextSize = 18
    window.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    window.TitleLabel.Parent = window.TitleBar
    
    window.SubTitleLabel = Instance.new("TextLabel")
    window.SubTitleLabel.Size = UDim2.new(1, -120, 0, 20)
    window.SubTitleLabel.Position = UDim2.new(0, 20, 0, 35)
    window.SubTitleLabel.BackgroundTransparency = 1
    window.SubTitleLabel.Text = options.SubTitle or defaultOptions.SubTitle
    window.SubTitleLabel.TextColor3 = RainLib.CurrentTheme.Text
    window.SubTitleLabel.Font = Enum.Font.Gotham
    window.SubTitleLabel.TextSize = 14
    window.SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    window.SubTitleLabel.Parent = window.TitleBar
    
    window.CloseButton = Instance.new("TextButton")
    window.CloseButton.Size = UDim2.new(0, 40, 0, 40)
    window.CloseButton.Position = UDim2.new(1, -50, 0, 10)
    window.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    window.CloseButton.Text = "X"
    window.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.CloseButton.Font = Enum.Font.SourceSansBold
    window.CloseButton.TextSize = 18
    window.CloseButton.Parent = window.TitleBar
    CreateCorner(window.CloseButton, 20)
    AddGlow(window.CloseButton)
    
    window.MinimizeBtn = Instance.new("TextButton")
    window.MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
    window.MinimizeBtn.Position = UDim2.new(1, -95, 0, 10)
    window.MinimizeBtn.BackgroundColor3 = RainLib.CurrentTheme.Accent
    window.MinimizeBtn.Text = "-"
    window.MinimizeBtn.TextColor3 = RainLib.CurrentTheme.Text
    window.MinimizeBtn.Font = Enum.Font.SourceSansBold
    window.MinimizeBtn.TextSize = 18
    window.MinimizeBtn.Parent = window.TitleBar
    CreateCorner(window.MinimizeBtn, 20)
    AddGlow(window.MinimizeBtn)
    
    window.TabContainer = Instance.new("ScrollingFrame")
    window.TabContainer.Size = UDim2.new(0, 160, 1, -70)
    window.TabContainer.Position = UDim2.new(0, 5, 0, 65)
    window.TabContainer.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    window.TabContainer.ScrollBarThickness = 0
    window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    window.TabContainer.Parent = window.MainFrame
    CreateCorner(window.TabContainer, 10)
    AddGradient(window.TabContainer)
    
    window.TabIndicator = Instance.new("Frame")
    window.TabIndicator.Size = UDim2.new(0, 5, 0, 50)
    window.TabIndicator.BackgroundColor3 = RainLib.CurrentTheme.Glow
    window.TabIndicator.Position = UDim2.new(0, 0, 0, 5)
    window.TabIndicator.Parent = window.TabContainer
    CreateCorner(window.TabIndicator, 5)
    AddGlow(window.TabIndicator)
    
    window.Notifications.Size = UDim2.new(0, 320, 1, -30)
    window.Notifications.Position = UDim2.new(1, -330, 0, 0)
    window.Notifications.BackgroundTransparency = 1
    window.Notifications.Parent = RainLib.ScreenGui
    
    MakeDraggable(window.TitleBar, window.MainFrame)
    
    window.CloseButton.MouseButton1Click:Connect(function()
        tween(window.CloseButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 45, 0, 45)})
        tween(window.MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1}).Completed:Connect(function()
            if window.MinimizeButton then window.MinimizeButton:Destroy() end
            window.MainFrame:Destroy()
            window.Notifications:Destroy()
        end)
    end)
    
    window.CloseButton.MouseEnter:Connect(function()
        tween(window.CloseButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 120, 120)})
    end)
    window.CloseButton.MouseLeave:Connect(function()
        tween(window.CloseButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)})
    end)
    
    window.MinimizeBtn.MouseButton1Click:Connect(function()
        if window.Minimized then
            tween(window.MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 850, 0, 650)})
            window.MinimizeBtn.Text = "-"
            window.MainFrame.ClipsDescendants = false
            window.TabContainer.Visible = true
        else
            window.MainFrame.ClipsDescendants = true
            tween(window.MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 850, 0, 60)})
            window.MinimizeBtn.Text = "+"
            task.wait(0.1)
            window.TabContainer.Visible = false
        end
        window.Minimized = not window.Minimized
    end)
    
    window.MinimizeBtn.MouseEnter:Connect(function()
        tween(window.MinimizeBtn, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
    end)
    window.MinimizeBtn.MouseLeave:Connect(function()
        tween(window.MinimizeBtn, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
    end)
    
    if window.Settings.MinimizeKey then
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode.Name == window.Settings.MinimizeKey then
                window.MainFrame.Visible = not window.MainFrame.Visible
                if window.MinimizeButton then
                    window.MinimizeButton.Text = window.MainFrame.Visible and "Fechar" or "Abrir"
                end
                tween(window.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = window.MainFrame.Visible and 0.05 or 1})
            end
        end)
    end
    
    function window:Minimize(options)
        options = options or {}
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, options.Width or 160, 0, options.Height or 40)
        button.Position = UDim2.new(0, 15, 0, 15)
        button.Text = options.Text1 or "Fechar"
        button.BackgroundColor3 = RainLib.CurrentTheme.Accent
        button.TextColor3 = RainLib.CurrentTheme.Text
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 18
        button.Parent = RainLib.ScreenGui
        CreateCorner(button, 12)
        AddGlow(button)
        
        button.MouseButton1Click:Connect(function()
            window.MainFrame.Visible = not window.MainFrame.Visible
            button.Text = window.MainFrame.Visible and (options.Text1 or "Fechar") or (options.Text2 or "Abrir")
            tween(button, TweenInfo.new(0.3), {Size = window.MainFrame.Visible and UDim2.new(0, 160, 0, 40) or UDim2.new(0, 140, 0, 35)})
        end)
        
        button.MouseEnter:Connect(function()
            tween(button, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
        end)
        button.MouseLeave:Connect(function()
            tween(button, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
        end)
        
        if options.Draggable then
            MakeDraggable(button, button)
        end
        
        window.MinimizeButton = button
        return button
    end
    
    function window:Tab(options)
        local tab = {
            Name = options.Title or "Tab",
            ElementCount = 0,
            Elements = {},
            Visible = false,
            Animations = {}
        }
        tab.Content = Instance.new("ScrollingFrame")
        tab.Content.Size = UDim2.new(1, -170, 1, -75)
        tab.Content.Position = UDim2.new(0, 165, 0, 70)
        tab.Content.BackgroundTransparency = 0.1
        tab.Content.ScrollBarThickness = 5
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        tab.Content.Parent = window.MainFrame
        CreateCorner(tab.Content, 10)
        AddGradient(tab.Content)
        
        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(1, -15, 0, 50)
        tab.Button.Position = UDim2.new(0, 8, 0, #window.Tabs * 55 + 5)
        tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        tab.Button.Text = tab.Name
        tab.Button.TextColor3 = RainLib.CurrentTheme.Text
        tab.Button.Font = Enum.Font.SourceSansBold
        tab.Button.TextSize = 16
        tab.Button.TextXAlignment = Enum.TextXAlignment.Left
        tab.Button.Parent = window.TabContainer
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, #window.Tabs * 55 + 60)
        CreateCorner(tab.Button, 8)
        AddGlow(tab.Button)
        
        table.insert(window.Tabs, tab)
        
        local function selectTab(index)
            for i, t in pairs(window.Tabs) do
                if i == index then
                    t.Content.Visible = true
                    t.Visible = true
                    tween(t.Content, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.1, Position = UDim2.new(0, 165, 0, 70)})
                    tween(window.TabIndicator, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 0, 0, (i-1) * 55 + 5)})
                    tween(t.Button, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Accent, Size = UDim2.new(1, -10, 0, 55)})
                else
                    tween(t.Content, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 220, 0, 70)}).Completed:Connect(function()
                        t.Content.Visible = false
                        t.Visible = false
                    end)
                    tween(t.Button, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary, Size = UDim2.new(1, -15, 0, 50)})
                end
            end
        end
        
        tab.Button.MouseButton1Click:Connect(function()
            local index = table.find(window.Tabs, tab)
            selectTab(index)
            AddEasterEgg()
        end)
        
        tab.Button.MouseEnter:Connect(function()
            if not tab.Visible then
                tween(tab.Button, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end
        end)
        tab.Button.MouseLeave:Connect(function()
            if not tab.Visible then
                tween(tab.Button, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end
        end)
        
        if #window.Tabs == 1 then
            selectTab(1)
        end
        
        local function getNextPosition(elementSize)
            local padding = 15
            local row = tab.ElementCount
            local yOffset = padding + row * (elementSize.Y.Offset + padding)
            tab.ElementCount = tab.ElementCount + 1
            tab.Content.CanvasSize = UDim2.new(0, 0, 0, yOffset + elementSize.Y.Offset + padding)
            return UDim2.new(0, padding, 0, yOffset)
        end
        
        local function saveElement(flag, value)
            window.Settings[flag] = value
            SaveSettings(options.ConfigFolder or defaultOptions.ConfigFolder, window.Settings)
        end
        
        function tab:AddToggle(key, options)
            local toggleSize = UDim2.new(0, options.Width or 140, 0, options.Height or 50)
            local flag = options.Flag or key
            local toggle = {Value = window.Settings[flag] or options.Default or false}
            local frame = Instance.new("Frame")
            frame.Size = toggleSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Position = getNextPosition(toggleSize)
            CreateCorner(frame, 10)
            AddGradient(frame)
            AddGlow(frame)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 90, 1, 0)
            label.Text = options.Title or "Toggle"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = options.Font or Enum.Font.SourceSansBold
            label.TextSize = options.TextSize or 16
            label.Parent = frame
            
            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, 25, 0, 25)
            indicator.Position = UDim2.new(1, -35, 0.5, -12.5)
            indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
            indicator.Parent = frame
            CreateCorner(indicator, 12)
            AddGlow(indicator)
            
            frame.Parent = tab.Content
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggle.Value = not toggle.Value
                    tween(indicator, TweenInfo.new(0.3, Enum.EasingStyle.Bounce), {
                        BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled,
                        Size = UDim2.new(0, toggle.Value and 30 or 25, 0, toggle.Value and 30 or 25),
                        Position = UDim2.new(1, toggle.Value and -40 or -35, 0.5, toggle.Value and -15 or -12.5)
                    })
                    saveElement(flag, toggle.Value)
                    if options.Callback then options.Callback(toggle.Value) end
                end
            end)
            
            frame.MouseEnter:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end)
            frame.MouseLeave:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end)
            
            if options.Draggable then
                MakeDraggable(frame, frame)
                table.insert(window.DraggableElements, frame)
            end
            
            table.insert(tab.Elements, frame)
            return toggle
        end
        
        function tab:AddSlider(key, options)
            local sliderSize = UDim2.new(0, options.Width or 220, 0, options.Height or 50)
            local flag = options.Flag or key
            local slider = {Value = window.Settings[flag] or options.Default or options.Min or 0}
            local frame = Instance.new("Frame")
            frame.Size = sliderSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Position = getNextPosition(sliderSize)
            CreateCorner(frame, 10)
            AddGradient(frame)
            AddGlow(frame)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 90, 1, 0)
            label.Text = options.Title or "Slider"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = options.Font or Enum.Font.SourceSansBold
            label.TextSize = options.TextSize or 16
            label.Parent = frame
            
            local sliderBar = Instance.new("Frame")
            sliderBar.Size = UDim2.new(0, 110, 0, 12)
            sliderBar.Position = UDim2.new(0, 100, 0.5, -6)
            sliderBar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            sliderBar.Parent = frame
            CreateCorner(sliderBar, 6)
            AddGradient(sliderBar)
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)
            fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
            fill.Parent = sliderBar
            CreateCorner(fill, 6)
            AddGlow(fill)
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 40, 0, 20)
            valueLabel.Position = UDim2.new(1, -50, 0, -30)
            valueLabel.Text = tostring(slider.Value)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = RainLib.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SourceSans
            valueLabel.TextSize = 14
            valueLabel.Parent = frame
            
            local dragging
            sliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    tween(sliderBar, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
                end
            end)
            sliderBar.InputEnded:Connect(function()
                dragging = false
                tween(sliderBar, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Disabled})
            end)
            
            RunService.RenderStepped:Connect(function()
                if dragging then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = math.clamp((mousePos.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                    slider.Value = math.floor((options.Min or 0) + relativeX * ((options.Max or 100) - (options.Min or 0)))
                    tween(fill, TweenInfo.new(0.2), {Size = UDim2.new(relativeX, 0, 1, 0)})
                    valueLabel.Text = tostring(slider.Value)
                    saveElement(flag, slider.Value)
                    if options.Callback then options.Callback(slider.Value) end
                end
            end)
            
            frame.Parent = tab.Content
            if options.Draggable then
                MakeDraggable(frame, frame)
                table.insert(window.DraggableElements, frame)
            end
            
            frame.MouseEnter:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end)
            frame.MouseLeave:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end)
            
            table.insert(tab.Elements, frame)
            return slider
        end
        
        function tab:AddDropdown(key, options)
            local dropdownSize = UDim2.new(0, options.Width or 140, 0, options.Height or 50)
            local flag = options.Flag or key
            local dropdown = {Value = window.Settings[flag] or options.Default or options.Values[1]}
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Position = getNextPosition(dropdownSize)
            CreateCorner(frame, 10)
            AddGradient(frame)
            AddGlow(frame)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 90, 1, 0)
            label.Text = options.Title or "Dropdown"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = options.Font or Enum.Font.SourceSansBold
            label.TextSize = options.TextSize or 16
            label.Parent = frame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 40, 1, 0)
            valueLabel.Position = UDim2.new(1, -50, 0, 0)
            valueLabel.Text = dropdown.Value
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = RainLib.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SourceSans
            valueLabel.TextSize = 14
            valueLabel.Parent = frame
            
            local expanded = false
            local dropdownMenu = Instance.new("Frame")
            dropdownMenu.Size = UDim2.new(0, 140, 0, #options.Values * 35)
            dropdownMenu.Position = UDim2.new(0, 0, 1, 5)
            dropdownMenu.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            dropdownMenu.Visible = false
            dropdownMenu.Parent = frame
            CreateCorner(dropdownMenu, 8)
            AddGradient(dropdownMenu)
            AddGlow(dropdownMenu)
            
            for i, value in ipairs(options.Values) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 35)
                btn.Position = UDim2.new(0, 0, 0, (i-1) * 35)
                btn.Text = value
                btn.BackgroundColor3 = RainLib.CurrentTheme.Secondary
                btn.TextColor3 = RainLib.CurrentTheme.Text
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 14
                btn.Parent = dropdownMenu
                CreateCorner(btn, 5)
                
                btn.MouseButton1Click:Connect(function()
                    dropdown.Value = value
                    valueLabel.Text = value
                    saveElement(flag, dropdown.Value)
                    tween(dropdownMenu, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 140, 0, 0)})
                    task.wait(0.3)
                    dropdownMenu.Visible = false
                    expanded = false
                    if options.Callback then options.Callback(dropdown.Value) end
                end)
                
                btn.MouseEnter:Connect(function()
                    tween(btn, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
                end)
                btn.MouseLeave:Connect(function()
                    tween(btn, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
                end)
            end
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    expanded = not expanded
                    dropdownMenu.Visible = true
                    tween(dropdownMenu, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 140, 0, expanded and #options.Values * 35 or 0)})
                end
            end)
            
            frame.MouseEnter:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end)
            frame.MouseLeave:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end)
            
            frame.Parent = tab.Content
            if options.Draggable then
                MakeDraggable(frame, frame)
                table.insert(window.DraggableElements, frame)
            end
            
            table.insert(tab.Elements, frame)
            return dropdown
        end
        
        function tab:AddButton(options)
            local buttonSize = UDim2.new(0, options.Width or 140, 0, options.Height or 50)
            local button = Instance.new("TextButton")
            button.Size = buttonSize
            button.Text = options.Title or "Button"
            button.BackgroundColor3 = options.Color or RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = options.Font or Enum.Font.SourceSansBold
            button.TextSize = options.TextSize or 16
            button.Position = getNextPosition(buttonSize)
            CreateCorner(button, 10)
            AddGradient(button)
            AddGlow(button)
            
            button.MouseButton1Click:Connect(function()
                tween(button, TweenInfo.new(0.2), {Size = UDim2.new(0, buttonSize.X.Offset - 10, 0, buttonSize.Y.Offset - 5)})
                task.wait(0.1)
                tween(button, TweenInfo.new(0.2), {Size = buttonSize})
                if options.Callback then options.Callback() end
            end)
            button.MouseEnter:Connect(function()
                tween(button, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end)
            button.MouseLeave:Connect(function()
                tween(button, TweenInfo.new(0.3), {BackgroundColor3 = options.Color or RainLib.CurrentTheme.Accent})
            end)
            
            button.Parent = tab.Content
            if options.Draggable then
                MakeDraggable(button, button)
                table.insert(window.DraggableElements, button)
            end
            
            table.insert(tab.Elements, button)
            return button
        end
        
        function tab:AddTextbox(key, options)
            local textboxSize = UDim2.new(0, options.Width or 160, 0, options.Height or 50)
            local flag = options.Flag or key
            local textbox = {Value = window.Settings[flag] or options.Default or ""}
            local frame = Instance.new("Frame")
            frame.Size = textboxSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Position = getNextPosition(textboxSize)
            CreateCorner(frame, 10)
            AddGradient(frame)
            AddGlow(frame)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 90, 1, 0)
            label.Text = options.Title or "Textbox"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = options.Font or Enum.Font.SourceSansBold
            label.TextSize = options.TextSize or 16
            label.Parent = frame
            
            local input = Instance.new("TextBox")
            input.Size = UDim2.new(0, 60, 0, 25)
            input.Position = UDim2.new(1, -70, 0.5, -12.5)
            input.BackgroundColor3 = RainLib.CurrentTheme.Background
            input.TextColor3 = RainLib.CurrentTheme.Text
            input.Text = textbox.Value
            input.Font = Enum.Font.SourceSans
            input.TextSize = 14
            input.Parent = frame
            CreateCorner(input, 8)
            AddGlow(input)
            
            input.Focused:Connect(function()
                tween(input, TweenInfo.new(0.3), {Size = UDim2.new(0, 65, 0, 30)})
            end)
            input.FocusLost:Connect(function(enterPressed)
                tween(input, TweenInfo.new(0.3), {Size = UDim2.new(0, 60, 0, 25)})
                if enterPressed then
                    textbox.Value = input.Text
                    saveElement(flag, textbox.Value)
                    if options.Callback then options.Callback(textbox.Value) end
                end
            end)
            
            frame.MouseEnter:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end)
            frame.MouseLeave:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end)
            
            frame.Parent = tab.Content
            if options.Draggable then
                MakeDraggable(frame, frame)
                table.insert(window.DraggableElements, frame)
            end
            
            table.insert(tab.Elements, frame)
            return textbox
        end
        
        function tab:AddCheckbox(key, options)
            local checkboxSize = UDim2.new(0, options.Width or 140, 0, options.Height or 50)
            local flag = options.Flag or key
            local checkbox = {Value = window.Settings[flag] or options.Default or false}
            local frame = Instance.new("Frame")
            frame.Size = checkboxSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Position = getNextPosition(checkboxSize)
            CreateCorner(frame, 10)
            AddGradient(frame)
            AddGlow(frame)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 90, 1, 0)
            label.Text = options.Title or "Checkbox"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = options.Font or Enum.Font.SourceSansBold
            label.TextSize = options.TextSize or 16
            label.Parent = frame
            
            local check = Instance.new("ImageLabel")
            check.Size = UDim2.new(0, 25, 0, 25)
            check.Position = UDim2.new(1, -35, 0.5, -12.5)
            check.BackgroundTransparency = 1
            check.Image = checkbox.Value and "rbxassetid://6031068421" or "rbxassetid://6031068420"
            check.ImageColor3 = RainLib.CurrentTheme.Accent
            check.Parent = frame
            AddGlow(check)
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    checkbox.Value = not checkbox.Value
                    tween(check, TweenInfo.new(0.3, Enum.EasingStyle.Bounce), {Size = UDim2.new(0, 30, 0, 30)})
                    task.wait(0.1)
                    check.Image = checkbox.Value and "rbxassetid://6031068421" or "rbxassetid://6031068420"
                    tween(check, TweenInfo.new(0.3, Enum.EasingStyle.Bounce), {Size = UDim2.new(0, 25, 0, 25)})
                    saveElement(flag, checkbox.Value)
                    if options.Callback then options.Callback(checkbox.Value) end
                end
            end)
            
            frame.MouseEnter:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end)
            frame.MouseLeave:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end)
            
            frame.Parent = tab.Content
            if options.Draggable then
                MakeDraggable(frame, frame)
                table.insert(window.DraggableElements, frame)
            end
            
            table.insert(tab.Elements, frame)
            return checkbox
        end
        
        function tab:AddColorPicker(key, options)
            local pickerSize = UDim2.new(0, options.Width or 160, 0, options.Height or 50)
            local flag = options.Flag or key
            local defaultColor = options.Default or Color3.fromRGB(255, 255, 255)
            local picker = {Value = window.Settings[flag] and Color3.fromRGB(unpack(window.Settings[flag])) or defaultColor}
            local frame = Instance.new("Frame")
            frame.Size = pickerSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Position = getNextPosition(pickerSize)
            CreateCorner(frame, 10)
            AddGradient(frame)
            AddGlow(frame)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 90, 1, 0)
            label.Text = options.Title or "Color Picker"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = options.Font or Enum.Font.SourceSansBold
            label.TextSize = options.TextSize or 16
            label.Parent = frame
            
            local colorDisplay = Instance.new("Frame")
            colorDisplay.Size = UDim2.new(0, 25, 0, 25)
            colorDisplay.Position = UDim2.new(1, -35, 0.5, -12.5)
            colorDisplay.BackgroundColor3 = picker.Value
            colorDisplay.Parent = frame
            CreateCorner(colorDisplay, 12)
            AddGlow(colorDisplay)
            
            local pickerMenu = Instance.new("Frame")
            pickerMenu.Size = UDim2.new(0, 160, 0, 160)
            pickerMenu.Position = UDim2.new(0, 0, 1, 5)
            pickerMenu.BackgroundColor3 = RainLib.CurrentTheme.Background
            pickerMenu.Visible = false
            pickerMenu.Parent = frame
            CreateCorner(pickerMenu, 8)
            AddGradient(pickerMenu)
            AddGlow(pickerMenu)
            
            local hueBar = Instance.new("Frame")
            hueBar.Size = UDim2.new(0, 25, 1, -10)
            hueBar.Position = UDim2.new(0, 5, 0, 5)
            hueBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            hueBar.Parent = pickerMenu
            CreateCorner(hueBar, 5)
            local hueGradient = Instance.new("UIGradient")
            hueGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
            })
            hueGradient.Parent = hueBar
            
            local saturationValue = Instance.new("Frame")
            saturationValue.Size = UDim2.new(0, 110, 1, -10)
            saturationValue.Position = UDim2.new(0, 35, 0, 5)
            saturationValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            saturationValue.Parent = pickerMenu
            CreateCorner(saturationValue, 5)
            AddGradient(saturationValue)
            
            local draggingHue, draggingSV
            hueBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingHue = true end
            end)
            hueBar.InputEnded:Connect(function() draggingHue = false end)
            
            saturationValue.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSV = true end
            end)
            saturationValue.InputEnded:Connect(function() draggingSV = false end)
            
            RunService.RenderStepped:Connect(function()
                if draggingHue then
                    local mousePos = UserInputService:GetMouseLocation()
                    local hue = math.clamp((mousePos.Y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
                    picker.Value = Color3.fromHSV(hue, 1, 1)
                    colorDisplay.BackgroundColor3 = picker.Value
                    saveElement(flag, {picker.Value.R * 255, picker.Value.G * 255, picker.Value.B * 255})
                    if options.Callback then options.Callback(picker.Value) end
                elseif draggingSV then
                    local mousePos = UserInputService:GetMouseLocation()
                    local sat = math.clamp((mousePos.X - saturationValue.AbsolutePosition.X) / saturationValue.AbsoluteSize.X, 0, 1)
                    local val = math.clamp((mousePos.Y - saturationValue.AbsolutePosition.Y) / saturationValue.AbsoluteSize.Y, 0, 1)
                    picker.Value = Color3.fromHSV(picker.Value:ToHSV(), sat, 1 - val)
                    colorDisplay.BackgroundColor3 = picker.Value
                    saveElement(flag, {picker.Value.R * 255, picker.Value.G * 255, picker.Value.B * 255})
                    if options.Callback then options.Callback(picker.Value) end
                end
            end)
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    pickerMenu.Visible = not pickerMenu.Visible
                    tween(pickerMenu, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {Size = pickerMenu.Visible and UDim2.new(0, 160, 0, 160) or UDim2.new(0, 160, 0, 0)})
                end
            end)
            
            frame.MouseEnter:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end)
            frame.MouseLeave:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end)
            
            frame.Parent = tab.Content
            if options.Draggable then
                MakeDraggable(frame, frame)
                table.insert(window.DraggableElements, frame)
            end
            
            table.insert(tab.Elements, frame)
            return picker
        end
        
        function tab:AddKeybind(key, options)
            local keybindSize = UDim2.new(0, options.Width or 140, 0, options.Height or 50)
            local flag = options.Flag or key
            local keybind = {Value = window.Settings[flag] or options.Default or "None"}
            local frame = Instance.new("Frame")
            frame.Size = keybindSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Position = getNextPosition(keybindSize)
            CreateCorner(frame, 10)
            AddGradient(frame)
            AddGlow(frame)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 90, 1, 0)
            label.Text = options.Title or "Keybind"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = options.Font or Enum.Font.SourceSansBold
            label.TextSize = options.TextSize or 16
            label.Parent = frame
            
            local keyLabel = Instance.new("TextLabel")
            keyLabel.Size = UDim2.new(0, 40, 1, 0)
            keyLabel.Position = UDim2.new(1, -50, 0, 0)
            keyLabel.Text = keybind.Value
            keyLabel.BackgroundTransparency = 1
            keyLabel.TextColor3 = RainLib.CurrentTheme.Text
            keyLabel.Font = Enum.Font.SourceSans
            keyLabel.TextSize = 14
            keyLabel.Parent = frame
            
            local binding = false
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    binding = true
                    keyLabel.Text = "Pressione..."
                    tween(keyLabel, TweenInfo.new(0.3), {TextColor3 = RainLib.CurrentTheme.Accent})
                end
            end)
            
            UserInputService.InputBegan:Connect(function(input)
                if binding and input.KeyCode ~= Enum.KeyCode.Unknown then
                    keybind.Value = input.KeyCode.Name
                    keyLabel.Text = keybind.Value
                    tween(keyLabel, TweenInfo.new(0.3), {TextColor3 = RainLib.CurrentTheme.Text})
                    binding = false
                    saveElement(flag, keybind.Value)
                    if options.Callback then options.Callback(keybind.Value) end
                end
            end)
            
            frame.MouseEnter:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end)
            frame.MouseLeave:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end)
            
            frame.Parent = tab.Content
            if options.Draggable then
                MakeDraggable(frame, frame)
                table.insert(window.DraggableElements, frame)
            end
            
            table.insert(tab.Elements, frame)
            return keybind
        end
        
        function tab:AddSection(options)
            local sectionSize = UDim2.new(0, options.Width or 450, 0, options.Height or 180)
            local section = {Elements = {}}
            local frame = Instance.new("Frame")
            frame.Size = sectionSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Position = getNextPosition(sectionSize)
            CreateCorner(frame, 12)
            AddGradient(frame)
            AddGlow(frame)
            AddParticles(frame, 3)
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, 0, 0, 25)
            title.Text = options.Title or "Section"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = options.Font or Enum.Font.GothamBold
            title.TextSize = options.TextSize or 18
            title.Parent = frame
            
            local content = Instance.new("ScrollingFrame")
            content.Size = UDim2.new(1, -15, 1, -35)
            content.Position = UDim2.new(0, 7.5, 0, 30)
            content.BackgroundTransparency = 0.1
            content.ScrollBarThickness = 4
            content.CanvasSize = UDim2.new(0, 0, 0, 0)
            content.Parent = frame
            CreateCorner(content, 8)
            AddGradient(content)
            
            local elementCount = 0
            local function getSectionPosition(elementSize)
                local padding = 10
                local yOffset = padding + elementCount * (elementSize.Y.Offset + padding)
                elementCount = elementCount + 1
                content.CanvasSize = UDim2.new(0, 0, 0, yOffset + elementSize.Y.Offset + padding)
                return UDim2.new(0, padding, 0, yOffset)
            end
            
            function section:AddToggle(sKey, sOptions)
                local toggleSize = UDim2.new(0, sOptions.Width or 140, 0, sOptions.Height or 50)
                local flag = sOptions.Flag or sKey
                local toggle = {Value = window.Settings[flag] or sOptions.Default or false}
                local sFrame = Instance.new("Frame")
                sFrame.Size = toggleSize
                sFrame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
                sFrame.Position = getSectionPosition(toggleSize)
                CreateCorner(sFrame, 10)
                AddGradient(sFrame)
                AddGlow(sFrame)
                
                local sLabel = Instance.new("TextLabel")
                sLabel.Size = UDim2.new(0, 90, 1, 0)
                sLabel.Text = sOptions.Title or "Toggle"
                sLabel.BackgroundTransparency = 1
                sLabel.TextColor3 = RainLib.CurrentTheme.Text
                sLabel.Font = sOptions.Font or Enum.Font.SourceSansBold
                sLabel.TextSize = sOptions.TextSize or 16
                sLabel.Parent = sFrame
                
                local sIndicator = Instance.new("Frame")
                sIndicator.Size = UDim2.new(0, 25, 0, 25)
                sIndicator.Position = UDim2.new(1, -35, 0.5, -12.5)
                sIndicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
                sIndicator.Parent = sFrame
                CreateCorner(sIndicator, 12)
                AddGlow(sIndicator)
                
                sFrame.Parent = content
                sFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        toggle.Value = not toggle.Value
                        tween(sIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Bounce), {
                            BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled,
                            Size = UDim2.new(0, toggle.Value and 30 or 25, 0, toggle.Value and 30 or 25),
                            Position = UDim2.new(1, toggle.Value and -40 or -35, 0.5, toggle.Value and -15 or -12.5)
                        })
                        saveElement(flag, toggle.Value)
                        if sOptions.Callback then sOptions.Callback(toggle.Value) end
                    end
                end)
                
                sFrame.MouseEnter:Connect(function()
                    tween(sFrame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
                end)
                sFrame.MouseLeave:Connect(function()
                    tween(sFrame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
                end)
                
                table.insert(section.Elements, sFrame)
                return toggle
            end
            
            frame.MouseEnter:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
            end)
            frame.MouseLeave:Connect(function()
                tween(frame, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end)
            
            frame.Parent = tab.Content
            if options.Draggable then
                MakeDraggable(frame, frame)
                table.insert(window.DraggableElements, frame)
            end
            
            table.insert(tab.Elements, frame)
            return section
        end
        
        return tab
    end
    
    function RainLib:Notify(window, options)
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, options.Width or 300, 0, options.Height or 90)
        notification.Position = UDim2.new(1, 320, 0, (#window.Notifications:GetChildren() - 1) * 100 + 15)
        notification.BackgroundColor3 = RainLib.CurrentTheme.Background
        notification.Parent = window.Notifications
        CreateCorner(notification, 12)
        AddGradient(notification)
        AddGlow(notification)
        AddParticles(notification, 4)
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -15, 0, 25)
        title.Position = UDim2.new(0, 7.5, 0, 5)
        title.Text = options.Title or "Notification"
        title.BackgroundTransparency = 1
        title.TextColor3 = RainLib.CurrentTheme.Text
        title.Font = options.Font or Enum.Font.GothamBold
        title.TextSize = options.TextSize or 18
        title.Parent = notification
        
        local message = Instance.new("TextLabel")
        message.Size = UDim2.new(1, -15, 0, 45)
        message.Position = UDim2.new(0, 7.5, 0, 35)
        message.Text = options.Content or "Message"
        message.BackgroundTransparency = 1
        message.TextColor3 = RainLib.CurrentTheme.Text
        message.Font = options.MessageFont or Enum.Font.SourceSans
        message.TextSize = options.MessageSize or 14
        message.TextWrapped = true
        message.Parent = notification
        
        if options.Buttons then
            for i, btn in ipairs(options.Buttons) do
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(0, 70, 0, 25)
                button.Position = UDim2.new(0, 7.5 + (i-1) * 80, 1, -30)
                button.Text = btn.Text or "Button"
                button.BackgroundColor3 = RainLib.CurrentTheme.Accent
                button.TextColor3 = RainLib.CurrentTheme.Text
                button.Font = Enum.Font.SourceSansBold
                button.TextSize = 14
                button.Parent = notification
                CreateCorner(button, 8)
                AddGlow(button)
                
                button.MouseButton1Click:Connect(function()
                    tween(button, TweenInfo.new(0.2), {Size = UDim2.new(0, 65, 0, 20)})
                    task.wait(0.1)
                    tween(button, TweenInfo.new(0.2), {Size = UDim2.new(0, 70, 0, 25)})
                    if btn.Callback then btn.Callback() end
                end)
                
                button.MouseEnter:Connect(function()
                    tween(button, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Highlight})
                end)
                button.MouseLeave:Connect(function()
                    tween(button, TweenInfo.new(0.3), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
                end)
            end
        end
        
        tween(notification, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -310, 0, (#window.Notifications:GetChildren() - 1) * 100 + 15)})
        task.spawn(function()
            task.wait(options.Duration or 4)
            tween(notification, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(1, 320, 0, notification.Position.Y.Offset), BackgroundTransparency = 1}).Completed:Connect(function()
                notification:Destroy()
            end)
        end)
    end
    
    function window:SetTheme(theme)
        if type(theme) == "string" then
            RainLib.CurrentTheme = RainLib.Themes[theme] or RainLib.Themes.Dark
            window.Settings.Theme = theme
        else
            RainLib.CurrentTheme = theme
            window.CustomTheme = theme
            window.Settings.Theme = "Custom"
        end
        SaveSettings(options.ConfigFolder or defaultOptions.ConfigFolder, window.Settings)
        tween(window.MainFrame, TweenInfo.new(0.5), {BackgroundColor3 = RainLib.CurrentTheme.Background})
        tween(window.TitleBar, TweenInfo.new(0.5), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
        tween(window.TitleLabel, TweenInfo.new(0.5), {TextColor3 = RainLib.CurrentTheme.Text})
        tween(window.SubTitleLabel, TweenInfo.new(0.5), {TextColor3 = RainLib.CurrentTheme.Text})
        tween(window.TabContainer, TweenInfo.new(0.5), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
        tween(window.TabIndicator, TweenInfo.new(0.5), {BackgroundColor3 = RainLib.CurrentTheme.Glow})
        tween(window.MinimizeBtn, TweenInfo.new(0.5), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
        
        for _, tab in pairs(window.Tabs) do
            tween(tab.Button, TweenInfo.new(0.4), {BackgroundColor3 = tab.Visible and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Secondary})
            for _, element in pairs(tab.Elements) do
                if element:IsA("Frame") or element:IsA("TextButton") then
                    tween(element, TweenInfo.new(0.4), {BackgroundColor3 = element:IsA("TextButton") and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Secondary})
                    for _, child in pairs(element:GetChildren()) do
                        if child:IsA("TextLabel") then
                            tween(child, TweenInfo.new(0.4), {TextColor3 = RainLib.CurrentTheme.Text})
                        elseif child:IsA("Frame") and child.Name ~= "Fill" then
                            tween(child, TweenInfo.new(0.4), {BackgroundColor3 = RainLib.CurrentTheme.Disabled})
                        end
                    end
                end
            end
        end
    end
    
    function window:SetSize(width, height)
        tween(window.MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, width, 0, height)})
    end
    
    function window:SetTransparency(transparency)
        tween(window.MainFrame, TweenInfo.new(0.4), {BackgroundTransparency = transparency})
    end
    
    function window:ToggleShadow(enabled)
        if enabled and not window.MainFrame:FindFirstChild("Glow") then
            AddGlow(window.MainFrame)
        elseif not enabled and window.MainFrame:FindFirstChild("Glow") then
            window.MainFrame.Glow:Destroy()
        end
    end
    
    table.insert(RainLib.Windows, window)
    return window
end

-- Funções Globais Adicionais
function RainLib:CreateCustomTheme(options)
    local theme = {
        Background = options.Background or RainLib.CurrentTheme.Background,
        Accent = options.Accent or RainLib.CurrentTheme.Accent,
        Text = options.Text or RainLib.CurrentTheme.Text,
        Secondary = options.Secondary or RainLib.CurrentTheme.Secondary,
        Disabled = options.Disabled or RainLib.CurrentTheme.Disabled,
        Highlight = options.Highlight or RainLib.CurrentTheme.Highlight,
        Glow = options.Glow or RainLib.CurrentTheme.Glow
    }
    return theme
end

function RainLib:ApplyGlobalTheme(theme)
    for _, window in pairs(RainLib.Windows) do
        window:SetTheme(theme)
    end
end

function RainLib:Destroy()
    for _, conn in pairs(RainLib.Connections) do
        conn:Disconnect()
    end
    RainLib.ScreenGui:Destroy()
    RainLib.Windows = {}
    RainLib.Connections = {}
    RainLib.Particles = {}
end

-- Easter Egg Colossal
RainLib.EasterEggs.colossal = function()
    local colossal = Instance.new("Frame")
    colossal.Size = UDim2.new(0, 250, 0, 350)
    colossal.Position = UDim2.new(0.5, -125, 1, 0)
    colossal.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
    colossal.Parent = RainLib.ScreenGui
    CreateCorner(colossal, 25)
    AddGradient(colossal)
    AddGlow(colossal)
    AddParticles(colossal, 10)
    
    local head = Instance.new("Frame")
    head.Size = UDim2.new(0, 120, 0, 120)
    head.Position = UDim2.new(0.5, -60, 0, 0)
    head.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
    head.Parent = colossal
    CreateCorner(head, 60)
    AddGlow(head)
    
    tween(colossal, TweenInfo.new(1.2, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -125, 0.5, -175)}).Completed:Connect(function()
        task.wait(3)
        tween(colossal, TweenInfo.new(1.2, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -125, 1, 0), BackgroundTransparency = 1}).Completed:Connect(function()
            colossal:Destroy()
        end)
    end)
end

return RainLib
