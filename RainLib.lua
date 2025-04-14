-- RainLib: Biblioteca de UI avançada para Roblox com flags explícitas e suporte mobile
local RainLib = {}
RainLib.__index = RainLib

-- Serviços do Roblox
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer

-- Estado global
RainLib.ScreenGui = nil
RainLib.CreatedFolders = {}
RainLib.GUIState = { Windows = {} }
RainLib.flags = {
    isMobile = UserInputService.TouchEnabled,
    isDragging = false,
    isMinimized = false
}

-- Temas padrão
RainLib.Themes = {
    Dark = {
        Primary = Color3.fromRGB(30, 30, 30),
        Secondary = Color3.fromRGB(45, 45, 45),
        Accent = Color3.fromRGB(0, 122, 255),
        Text = Color3.fromRGB(255, 255, 255),
        Disabled = Color3.fromRGB(100, 100, 100),
        Border = Color3.fromRGB(60, 60, 60)
    },
    Light = {
        Primary = Color3.fromRGB(240, 240, 240),
        Secondary = Color3.fromRGB(200, 200, 200),
        Accent = Color3.fromRGB(0, 122, 255),
        Text = Color3.fromRGB(0, 0, 0),
        Disabled = Color3.fromRGB(150, 150, 150),
        Border = Color3.fromRGB(180, 180, 180)
    }
}
RainLib.CurrentTheme = RainLib.Themes.Dark

-- Função auxiliar para criar containers
local function createContainer(instance, size, parent)
    instance.Size = size
    instance.Parent = parent or RainLib.ScreenGui
    instance.BackgroundTransparency = 1
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, RainLib.flags.isMobile and 10 or 5)
    layout.Parent = instance
end

-- Função auxiliar para animações
local function tween(instance, tweenInfo, properties)
    TweenService:Create(instance, tweenInfo, properties):Play()
end

-- Função para validar entrada
local function validateOptions(options, defaults)
    options = options or {}
    for key, value in pairs(defaults) do
        if options[key] == nil then
            options[key] = value
        end
    end
    return options
end

-- Inicialização da biblioteca
print("[RainLib] Inicializando...")
local success, err = pcall(function()
    if game.CoreGui:FindFirstChild("RainLib") or (LocalPlayer:WaitForChild("PlayerGui", 5) and LocalPlayer.PlayerGui:FindFirstChild("RainLib")) then
        RainLib:RecreateGUI()
    else
        RainLib.ScreenGui = Instance.new("ScreenGui")
        RainLib.ScreenGui.Name = "RainLib"
        RainLib.ScreenGui.Parent = game.CoreGui or LocalPlayer:WaitForChild("PlayerGui", 5)
        RainLib.ScreenGui.ResetOnSpawn = false
        RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        RainLib.ScreenGui.IgnoreGuiInset = true
    end
end)
if not success then
    warn("[RainLib] Falha na inicialização: " .. err)
    return nil
end
print("[RainLib] Inicializado com sucesso!")

-- Função para criar pastas de configuração
function RainLib:CreateFolder(folderName)
    if not folderName or folderName == "" then
        warn("[RainLib] Nome da pasta não especificado!")
        return false
    end
    
    if self.CreatedFolders[folderName] then
        print("[RainLib] Pasta já registrada: " .. folderName)
        return false
    end
    
    if makefolder and writefile then
        if not isfolder(folderName) then
            makefolder(folderName)
            self.CreatedFolders[folderName] = true
            print("[RainLib] Pasta criada: " .. folderName)
            self:Notify(nil, {Title = "Sucesso", Content = "Pasta '" .. folderName .. "' criada!", Duration = 3})
            
            local settingsPath = folderName .. "/Settings.json"
            local defaultSettings = {
                Theme = "Dark",
                WindowPosition = {X = 0.5, Y = 0.5, XOffset = -300, YOffset = -200},
                MinimizeKey = "LeftControl",
                SaveSettings = false,
                Flags = {}
            }
            local jsonSettings = HttpService:JSONEncode(defaultSettings)
            writefile(settingsPath, jsonSettings)
            print("[RainLib] Arquivo 'Settings.json' criado em: " .. settingsPath)
            self:Notify(nil, {Title = "Sucesso", Content = "Arquivo 'Settings.json' criado!", Duration = 3})
            return true
        else
            self.CreatedFolders[folderName] = true
            print("[RainLib] Pasta já existe: " .. folderName)
            self:Notify(nil, {Title = "Aviso", Content = "A pasta '" .. folderName .. "' já existe!", Duration = 3})
            
            local settingsPath = folderName .. "/Settings.json"
            if not isfile(settingsPath) then
                local defaultSettings = {
                    Theme = "Dark",
                    WindowPosition = {X = 0.5, Y = 0.5, XOffset = -300, YOffset = -200},
                    MinimizeKey = "LeftControl",
                    SaveSettings = false,
                    Flags = {}
                }
                local jsonSettings = HttpService:JSONEncode(defaultSettings)
                writefile(settingsPath, jsonSettings)
                print("[RainLib] Arquivo 'Settings.json' criado em: " .. settingsPath)
                self:Notify(nil, {Title = "Sucesso", Content = "Arquivo 'Settings.json' criado!", Duration = 3})
            end
            return false
        end
    else
        warn("[RainLib] Executor não suporta makefolder ou writefile!")
        self:Notify(nil, {Title = "Erro", Content = "Executor não suporta criação de pastas ou arquivos!", Duration = 3})
        return false
    end
end

-- Funções para salvar e carregar configurações
function RainLib:SaveSettings(folderName, settings)
    if not isfolder(folderName) or not writefile then
        warn("[RainLib] Não foi possível salvar configurações!")
        return
    end
    local settingsPath = folderName .. "/Settings.json"
    local jsonSettings = HttpService:JSONEncode(settings)
    writefile(settingsPath, jsonSettings)
    print("[RainLib] Configurações salvas em: " .. settingsPath)
end

function RainLib:LoadSettings(folderName)
    if not isfolder(folderName) or not isfile(folderName .. "/Settings.json") then
        warn("[RainLib] Arquivo de configurações não encontrado em: " .. folderName)
        return nil
    end
    local settingsPath = folderName .. "/Settings.json"
    local jsonSettings = readfile(settingsPath)
    local success, settings = pcall(function()
        return HttpService:JSONDecode(jsonSettings)
    end)
    if success then
        print("[RainLib] Configurações carregadas de: " .. settingsPath)
        return settings
    else
        warn("[RainLib] Falha ao carregar configurações: " .. settings)
        return nil
    end
end

-- Função para destruir o GUI
function RainLib:Destroy()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
        self.ScreenGui = nil
        RainLib.flags.isMinimized = false
        print("[RainLib] GUI destruído")
    end
end

-- Função para criar notificações
function RainLib:Notify(key, options)
    options = validateOptions(options, {
        Title = "Notificação",
        Content = "",
        Duration = 3,
        Icon = nil
    })
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, RainLib.flags.isMobile and 300 or 250, 0, RainLib.flags.isMobile and 100 or 80)
    notification.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    notification.Position = UDim2.new(1, -310, 1, -110)
    notification.Parent = self.ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification

    local border = Instance.new("UIStroke")
    border.Color = RainLib.CurrentTheme.Border
    border.Thickness = 1
    border.Parent = notification

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, RainLib.flags.isMobile and 30 or 24)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.Text = options.Title
    title.BackgroundTransparency = 1
    title.TextColor3 = RainLib.CurrentTheme.Text
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = RainLib.flags.isMobile and 18 or 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = notification

    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1, -10, 0, RainLib.flags.isMobile and 50 or 40)
    content.Position = UDim2.new(0, 5, 0, RainLib.flags.isMobile and 35 or 30)
    content.Text = options.Content
    content.BackgroundTransparency = 1
    content.TextColor3 = RainLib.CurrentTheme.Text
    content.Font = Enum.Font.SourceSans
    content.TextSize = RainLib.flags.isMobile and 16 or 14
    content.TextXAlignment = Enum.TextXAlignment.Left
    content.TextWrapped = true
    content.Parent = notification

    spawn(function()
        wait(options.Duration)
        tween(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(1, -310, 1, -50)})
        wait(0.5)
        notification:Destroy()
    end)
end

-- Função para criar janelas
function RainLib:Window(options)
    local window = { Tabs = {}, Elements = {}, Notifications = Instance.new("Frame") }
    options = validateOptions(options, {
        Title = "Rain Lib",
        SubTitle = "",
        Size = RainLib.flags.isMobile and UDim2.new(0, 350, 0, 450) or UDim2.new(0, 600, 0, 400),
        Position = RainLib.flags.isMobile and UDim2.new(0, 10, 0, 10) or UDim2.new(0.5, -300, 0.5, -200),
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl,
        SaveSettings = false,
        ConfigFolder = "RainConfig",
        Draggable = true,
        Minimizable = true
    })
    window.Options = options

    -- Carregar configurações salvas
    if options.SaveSettings then
        RainLib:CreateFolder(options.ConfigFolder)
        local settings = RainLib:LoadSettings(options.ConfigFolder)
        if settings then
            options.Theme = settings.Theme or options.Theme
            options.Position = UDim2.new(
                settings.WindowPosition.X,
                settings.WindowPosition.XOffset,
                settings.WindowPosition.Y,
                settings.WindowPosition.YOffset
            )
            options.MinimizeKey = settings.MinimizeKey or options.MinimizeKey
        end
    end

    -- Aplicar tema
    RainLib.CurrentTheme = RainLib.Themes[options.Theme] or RainLib.Themes.Dark

    -- Salvar estado da janela
    table.insert(RainLib.GUIState.Windows, {
        Options = options,
        Tabs = {},
        Elements = {}
    })

    -- Criar frame principal
    window.MainFrame = Instance.new("Frame")
    window.MainFrame.Size = options.Size
    window.MainFrame.Position = options.Position
    window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Primary
    window.MainFrame.Parent = RainLib.ScreenGui
    window.MainFrame.ClipsDescendants = true

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = window.MainFrame

    local border = Instance.new("UIStroke")
    border.Color = RainLib.CurrentTheme.Border
    border.Thickness = 2
    border.Parent = window.MainFrame

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, RainLib.flags.isMobile and 50 or 40)
    header.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    header.Parent = window.MainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.8, -10, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = options.Title .. (options.SubTitle ~= "" and " - " .. options.SubTitle or "")
    title.BackgroundTransparency = 1
    title.TextColor3 = RainLib.CurrentTheme.Text
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = RainLib.flags.isMobile and 20 or 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, RainLib.flags.isMobile and 40 or 30, 0, RainLib.flags.isMobile and 40 or 30)
    minimizeButton.Position = UDim2.new(1, RainLib.flags.isMobile and -50 or -40, 0, 5)
    minimizeButton.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = RainLib.CurrentTheme.Text
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.TextSize = RainLib.flags.isMobile and 20 or 18
    minimizeButton.Parent = header

    local cornerMinimize = Instance.new("UICorner")
    cornerMinimize.CornerRadius = UDim.new(0, 6)
    cornerMinimize.Parent = minimizeButton

    -- Sistema de arrastar
    if options.Draggable then
        local dragStart, startPos
        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                RainLib.flags.isDragging = true
                dragStart = input.Position
                startPos = window.MainFrame.Position
            end
        end)
        header.InputChanged:Connect(function(input)
            if RainLib.flags.isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                tween(window.MainFrame, TweenInfo.new(0.1), {Position = newPos})
                if options.SaveSettings then
                    local settings = RainLib:LoadSettings(options.ConfigFolder) or {}
                    settings.WindowPosition = {
                        X = newPos.X.Scale,
                        XOffset = newPos.X.Offset,
                        Y = newPos.Y.Scale,
                        YOffset = newPos.Y.Offset
                    }
                    RainLib:SaveSettings(options.ConfigFolder, settings)
                end
            end
        end)
        header.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                RainLib.flags.isDragging = false
            end
        end)
    end

    -- Sistema de minimizar
    if options.Minimizable then
        minimizeButton.MouseButton1Click:Connect(function()
            RainLib.flags.isMinimized = not RainLib.flags.isMinimized
            local targetSize = RainLib.flags.isMinimized and UDim2.new(window.MainFrame.Size.X.Scale, window.MainFrame.Size.X.Offset, 0, RainLib.flags.isMobile and 50 or 40) or options.Size
            tween(window.MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = targetSize})
            minimizeButton.Text = RainLib.flags.isMinimized and "+" or "-"
        end)
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode.Name == options.MinimizeKey and not RainLib.flags.isDragging then
                RainLib.flags.isMinimized = not RainLib.flags.isMinimized
                local targetSize = RainLib.flags.isMinimized and UDim2.new(window.MainFrame.Size.X.Scale, window.MainFrame.Size.X.Offset, 0, RainLib.flags.isMobile and 50 or 40) or options.Size
                tween(window.MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = targetSize})
                minimizeButton.Text = RainLib.flags.isMinimized and "+" or "-"
            end
        end)
    end

    -- Container para abas
    window.TabContainer = Instance.new("Frame")
    window.TabContainer.Size = UDim2.new(1, 0, 0, RainLib.flags.isMobile and 50 or 40)
    window.TabContainer.Position = UDim2.new(0, 0, 0, RainLib.flags.isMobile and 50 or 40)
    window.TabContainer.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    window.TabContainer.Parent = window.MainFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = window.TabContainer

    window.ContentContainer = Instance.new("Frame")
    window.ContentContainer.Size = UDim2.new(1, -10, 1, RainLib.flags.isMobile and -110 or -90)
    window.ContentContainer.Position = UDim2.new(0, 5, 0, RainLib.flags.isMobile and 105 or 85)
    window.ContentContainer.BackgroundTransparency = 1
    window.ContentContainer.Parent = window.MainFrame

    -- Função para criar abas
    function window:Tab(options)
        local tab = { Elements = {}, Frame = Instance.new("Frame") }
        options = validateOptions(options, {
            Title = "Tab",
            Icon = nil
        })
        tab.Name = options.Title
        tab.Icon = options.Icon

        -- Salvar aba no estado
        local windowIndex = #RainLib.GUIState.Windows
        table.insert(RainLib.GUIState.Windows[windowIndex].Tabs, {
            Name = tab.Name,
            Icon = tab.Icon,
            Elements = {}
        })

        -- Criar botão da aba
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, RainLib.flags.isMobile and 120 or 100, 1, 0)
        tabButton.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        tabButton.Text = options.Icon and options.Icon .. " " .. options.Title or options.Title
        tabButton.TextColor3 = RainLib.CurrentTheme.Text
        tabButton.Font = Enum.Font.SourceSans
        tabButton.TextSize = RainLib.flags.isMobile and 16 or 14
        tabButton.Parent = window.TabContainer

        local cornerTab = Instance.new("UICorner")
        cornerTab.CornerRadius = UDim.new(0, 6)
        cornerTab.Parent = tabButton

        -- Criar frame da aba
        tab.Frame.Size = UDim2.new(1, 0, 1, 0)
        tab.Frame.BackgroundTransparency = 1
        tab.Frame.Visible = false
        tab.Frame.Parent = window.ContentContainer
        tab.ElementCount = 0

        createContainer(tab.Frame, UDim2.new(1, 0, 1, 0), window.ContentContainer)

        -- Sistema de seleção de aba
        local function selectTab()
            for _, otherTab in pairs(window.Tabs) do
                otherTab.Frame.Visible = false
                if otherTab.Button then
                    tween(otherTab.Button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
                end
            end
            tab.Frame.Visible = true
            tween(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
        end

        tab.Button = tabButton
        table.insert(window.Tabs, tab)
        tabButton.MouseButton1Click:Connect(selectTab)
        if #window.Tabs == 1 then
            selectTab()
        end

        -- Função para adicionar toggle
        function tab:AddToggle(key, options)
            options = validateOptions(options, {
                Title = "Toggle",
                Default = false,
                Flag = nil,
                Callback = nil
            })
            local toggleSize = UDim2.new(0, RainLib.flags.isMobile and 150 or 120, 0, RainLib.flags.isMobile and 50 or 40)
            local toggle = { Value = options.Default }
            local frame = Instance.new("Frame")
            frame.Size = toggleSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, RainLib.flags.isMobile and 100 or 80, 1, 0)
            label.Text = options.Title
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = RainLib.flags.isMobile and 18 or 16
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, RainLib.flags.isMobile and 24 or 20, 0, RainLib.flags.isMobile and 24 or 20)
            indicator.Position = UDim2.new(1, RainLib.flags.isMobile and -34 or -30, 0.5, RainLib.flags.isMobile and -12 or -10)
            indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
            indicator.Parent = frame

            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 10)
            indicatorCorner.Parent = indicator

            -- Carregar valor salvo se Flag estiver definido
            local folderName = window.Options.ConfigFolder
            if options.Flag and folderName then
                local settings = RainLib:LoadSettings(folderName)
                if settings and settings.Flags[options.Flag] ~= nil then
                    toggle.Value = settings.Flags[options.Flag]
                    indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
                    indicator.Size = UDim2.new(0, toggle.Value and (RainLib.flags.isMobile and 28 or 24) or (RainLib.flags.isMobile and 24 or 20), 0, toggle.Value and (RainLib.flags.isMobile and 28 or 24) or (RainLib.flags.isMobile and 24 or 20))
                    indicator.Position = UDim2.new(1, toggle.Value and (RainLib.flags.isMobile and -38 or -34) or (RainLib.flags.isMobile and -34 or -30), 0.5, toggle.Value and (RainLib.flags.isMobile and -14 or -12) or (RainLib.flags.isMobile and -12 or -10))
                end
            end

            frame.Parent = tab.Frame
            tab.ElementCount = tab.ElementCount + 1
            frame.LayoutOrder = tab.ElementCount

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    toggle.Value = not toggle.Value
                    tween(indicator, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled,
                        Size = UDim2.new(0, toggle.Value and (RainLib.flags.isMobile and 28 or 24) or (RainLib.flags.isMobile and 24 or 20), 0, toggle.Value and (RainLib.flags.isMobile and 28 or 24) or (RainLib.flags.isMobile and 24 or 20)),
                        Position = UDim2.new(1, toggle.Value and (RainLib.flags.isMobile and -38 or -34) or (RainLib.flags.isMobile and -34 or -30), 0.5, toggle.Value and (RainLib.flags.isMobile and -14 or -12) or (RainLib.flags.isMobile and -12 or -10))
                    })
                    if options.Callback then
                        options.Callback(toggle.Value)
                    end
                    if options.Flag and window.Options.SaveSettings and folderName then
                        local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                        settings.Flags[options.Flag] = toggle.Value
                        RainLib:SaveSettings(folderName, settings)
                    end
                end
            end)

            -- Salvar no estado
            local windowIndex = #RainLib.GUIState.Windows
            local tabIndex = #RainLib.GUIState.Windows[windowIndex].Tabs
            table.insert(RainLib.GUIState.Windows[windowIndex].Tabs[tabIndex].Elements, {
                Type = "Toggle",
                Key = key,
                Options = options
            })

            function toggle:SetValue(value)
                toggle.Value = value
                tween(indicator, TweenInfo.new(0.2), {
                    BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled,
                    Size = UDim2.new(0, toggle.Value and (RainLib.flags.isMobile and 28 or 24) or (RainLib.flags.isMobile and 24 or 20), 0, toggle.Value and (RainLib.flags.isMobile and 28 or 24) or (RainLib.flags.isMobile and 24 or 20)),
                    Position = UDim2.new(1, toggle.Value and (RainLib.flags.isMobile and -38 or -34) or (RainLib.flags.isMobile and -34 or -30), 0.5, toggle.Value and (RainLib.flags.isMobile and -14 or -12) or (RainLib.flags.isMobile and -12 or -10))
                })
                if options.Flag and window.Options.SaveSettings and folderName then
                    local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                    settings.Flags[options.Flag] = toggle.Value
                    RainLib:SaveSettings(folderName, settings)
                end
            end

            return toggle
        end

        -- Função para adicionar slider
        function tab:AddSlider(key, options)
            options = validateOptions(options, {
                Title = "Slider",
                Min = 0,
                Max = 100,
                Default = 50,
                Rounding = nil,
                Flag = nil,
                Callback = nil
            })
            local sliderSize = UDim2.new(0, RainLib.flags.isMobile and 150 or 120, 0, RainLib.flags.isMobile and 50 or 40)
            local slider = { Value = options.Default }
            local frame = Instance.new("Frame")
            frame.Size = sliderSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, RainLib.flags.isMobile and 100 or 80, 0, RainLib.flags.isMobile and 24 or 20)
            label.Text = options.Title
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = RainLib.flags.isMobile and 14 or 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, RainLib.flags.isMobile and 36 or 30, 0, RainLib.flags.isMobile and 24 or 20)
            valueLabel.Position = UDim2.new(1, RainLib.flags.isMobile and -42 or -35, 0, 0)
            valueLabel.Text = tostring(slider.Value)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = RainLib.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SourceSans
            valueLabel.TextSize = RainLib.flags.isMobile and 14 or 12
            valueLabel.Parent = frame

            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -10, 0, RainLib.flags.isMobile and 10 or 8)
            bar.Position = UDim2.new(0, 5, 0, RainLib.flags.isMobile and 30 or 25)
            bar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            bar.Parent = frame

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((slider.Value - options.Min) / (options.Max - options.Min), 0, 1, 0)
            fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
            fill.Parent = bar

            local cornerBar = Instance.new("UICorner")
            cornerBar.CornerRadius = UDim.new(0, 4)
            cornerBar.Parent = bar

            local cornerFill = Instance.new("UICorner")
            cornerFill.CornerRadius = UDim.new(0, 4)
            cornerFill.Parent = fill

            -- Carregar valor salvo se Flag estiver definido
            local folderName = window.Options.ConfigFolder
            if options.Flag and folderName then
                local settings = RainLib:LoadSettings(folderName)
                if settings and settings.Flags[options.Flag] ~= nil then
                    slider.Value = settings.Flags[options.Flag]
                    fill.Size = UDim2.new((slider.Value - options.Min) / (options.Max - options.Min), 0, 1, 0)
                    valueLabel.Text = tostring(slider.Value)
                end
            end

            frame.Parent = tab.Frame
            tab.ElementCount = tab.ElementCount + 1
            frame.LayoutOrder = tab.ElementCount

            local dragging
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    tween(bar, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Disabled:Lerp(RainLib.CurrentTheme.Accent, 0.2)})
                end
            end)

            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    tween(bar, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Disabled})
                end
            end)

            RunService.RenderStepped:Connect(function()
                if dragging then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = math.clamp((mousePos.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    slider.Value = math.floor(options.Min + relativeX * (options.Max - options.Min))
                    if options.Rounding then
                        slider.Value = math.floor(slider.Value / options.Rounding) * options.Rounding
                    end
                    tween(fill, TweenInfo.new(0.1), {Size = UDim2.new(relativeX, 0, 1, 0)})
                    valueLabel.Text = tostring(slider.Value)
                    if options.Callback then
                        options.Callback(slider.Value)
                    end
                    if options.Flag and window.Options.SaveSettings and folderName then
                        local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                        settings.Flags[options.Flag] = slider.Value
                        RainLib:SaveSettings(folderName, settings)
                    end
                end
            end)

            function slider:SetValue(value)
                slider.Value = math.clamp(value, options.Min, options.Max)
                if options.Rounding then
                    slider.Value = math.floor(slider.Value / options.Rounding) * options.Rounding
                end
                tween(fill, TweenInfo.new(0.2), {Size = UDim2.new((slider.Value - options.Min) / (options.Max - options.Min), 0, 1, 0)})
                valueLabel.Text = tostring(slider.Value)
                if options.Flag and window.Options.SaveSettings and folderName then
                    local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                    settings.Flags[options.Flag] = slider.Value
                    RainLib:SaveSettings(folderName, settings)
                end
            end

            -- Salvar no estado
            local windowIndex = #RainLib.GUIState.Windows
            local tabIndex = #RainLib.GUIState.Windows[windowIndex].Tabs
            table.insert(RainLib.GUIState.Windows[windowIndex].Tabs[tabIndex].Elements, {
                Type = "Slider",
                Key = key,
                Options = options
            })

            return slider
        end

        -- Função para adicionar dropdown
        function tab:AddDropdown(key, options)
            options = validateOptions(options, {
                Title = "Dropdown",
                Values = {},
                Default = nil,
                Multi = false,
                Flag = nil,
                Callback = nil
            })
            local dropdownSize = UDim2.new(0, RainLib.flags.isMobile and 150 or 120, 0, RainLib.flags.isMobile and 50 or 40)
            local dropdown = { Value = options.Default or (options.Multi and {} or options.Values[1]) }
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, RainLib.flags.isMobile and -36 or -30, 1, 0)
            label.Text = options.Multi and table.concat(next(dropdown.Value) and dropdown.Value or {}, ", ") or dropdown.Value
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = RainLib.flags.isMobile and 16 or 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, RainLib.flags.isMobile and 24 or 20, 1, 0)
            arrow.Position = UDim2.new(1, RainLib.flags.isMobile and -30 or -25, 0, 0)
            arrow.Text = "▼"
            arrow.BackgroundTransparency = 1
            arrow.TextColor3 = RainLib.CurrentTheme.Text
            arrow.Font = Enum.Font.SourceSans
            arrow.TextSize = RainLib.flags.isMobile and 16 or 14
            arrow.Parent = frame

            local list = Instance.new("Frame")
            list.Size = UDim2.new(1, 0, 0, #options.Values * (RainLib.flags.isMobile and 36 or 30))
            list.Position = UDim2.new(0, 0, 1, 5)
            list.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            list.BackgroundTransparency = 1
            list.Visible = false
            list.Parent = frame
            list.ClipsDescendants = true

            local listCorner = Instance.new("UICorner")
            listCorner.CornerRadius = UDim.new(0, 8)
            listCorner.Parent = list

            local listLayout = Instance.new("UIListLayout")
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder
            listLayout.Parent = list

            -- Carregar valor salvo se Flag estiver definido
            local folderName = window.Options.ConfigFolder
            if options.Flag and folderName then
                local settings = RainLib:LoadSettings(folderName)
                if settings and settings.Flags[options.Flag] ~= nil then
                    dropdown.Value = settings.Flags[options.Flag]
                    label.Text = options.Multi and table.concat(next(dropdown.Value) and dropdown.Value or {}, ", ") or dropdown.Value
                end
            end

            for i, opt in ipairs(options.Values) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, RainLib.flags.isMobile and 36 or 30)
                btn.BackgroundTransparency = 0.2
                btn.BackgroundColor3 = RainLib.CurrentTheme.Secondary
                btn.Text = opt
                btn.TextColor3 = RainLib.CurrentTheme.Text
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = RainLib.flags.isMobile and 16 or 14
                btn.Parent = list
                btn.LayoutOrder = i

                btn.MouseEnter:Connect(function()
                    tween(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0, BackgroundColor3 = RainLib.CurrentTheme.Accent})
                end)
                btn.MouseLeave:Connect(function()
                    tween(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, BackgroundColor3 = RainLib.CurrentTheme.Secondary})
                end)

                btn.MouseButton1Click:Connect(function()
                    if options.Multi then
                        dropdown.Value[opt] = not dropdown.Value[opt]
                        local values = {}
                        for k, v in pairs(dropdown.Value) do
                            if v then table.insert(values, k) end
                        end
                        label.Text = table.concat(values, ", ")
                    else
                        dropdown.Value = opt
                        label.Text = opt
                        tween(list, TweenInfo.new(0.3), {BackgroundTransparency = 1}).Completed:Connect(function() list.Visible = false end)
                        tween(arrow, TweenInfo.new(0.2), {Rotation = 0})
                    end
                    if options.Callback then
                        options.Callback(dropdown.Value)
                    end
                    if options.Flag and window.Options.SaveSettings and folderName then
                        local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                        settings.Flags[options.Flag] = dropdown.Value
                        RainLib:SaveSettings(folderName, settings)
                    end
                end)
            end

            frame.Parent = tab.Frame
            tab.ElementCount = tab.ElementCount + 1
            frame.LayoutOrder = tab.ElementCount

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    list.Visible = not list.Visible
                    tween(list, TweenInfo.new(0.3), {BackgroundTransparency = list.Visible and 0 or 1})
                    tween(arrow, TweenInfo.new(0.2), {Rotation = list.Visible and 180 or 0})
                end
            end)

            function dropdown:SetValue(value)
                if options.Multi then
                    dropdown.Value = {}
                    for k, v in pairs(value) do
                        if table.find(options.Values, k) then
                            dropdown.Value[k] = v
                        end
                    end
                    local values = {}
                    for k, v in pairs(dropdown.Value) do
                        if v then table.insert(values, k) end
                    end
                    label.Text = table.concat(values, ", ")
                else
                    if table.find(options.Values, value) then
                        dropdown.Value = value
                        label.Text = value
                    end
                end
                if options.Flag and window.Options.SaveSettings and folderName then
                    local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                    settings.Flags[options.Flag] = dropdown.Value
                    RainLib:SaveSettings(folderName, settings)
                end
            end

            -- Salvar no estado
            local windowIndex = #RainLib.GUIState.Windows
            local tabIndex = #RainLib.GUIState.Windows[windowIndex].Tabs
            table.insert(RainLib.GUIState.Windows[windowIndex].Tabs[tabIndex].Elements, {
                Type = "Dropdown",
                Key = key,
                Options = options
            })

            return dropdown
        end

        -- Função para adicionar keybind
        function tab:AddKeybind(key, options)
            options = validateOptions(options, {
                Title = "Keybind",
                Default = "None",
                Mode = "Toggle",
                Flag = nil,
                Callback = nil,
                ChangedCallback = nil
            })
            local keybindSize = UDim2.new(0, RainLib.flags.isMobile and 150 or 120, 0, RainLib.flags.isMobile and 50 or 40)
            local keybind = { Value = options.Default, Mode = options.Mode }
            local frame = Instance.new("Frame")
            frame.Size = keybindSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, RainLib.flags.isMobile and 100 or 80, 1, 0)
            label.Text = options.Title
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = RainLib.flags.isMobile and 16 or 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local keyLabel = Instance.new("TextLabel")
            keyLabel.Size = UDim2.new(0, RainLib.flags.isMobile and 36 or 30, 1, 0)
            keyLabel.Position = UDim2.new(1, RainLib.flags.isMobile and -42 or -35, 0, 0)
            keyLabel.Text = keybind.Value
            keyLabel.BackgroundTransparency = 1
            keyLabel.TextColor3 = RainLib.CurrentTheme.Text
            keyLabel.Font = Enum.Font.SourceSans
            keyLabel.TextSize = RainLib.flags.isMobile and 16 or 14
            keyLabel.Parent = frame

            -- Carregar valor salvo se Flag estiver definido
            local folderName = window.Options.ConfigFolder
            if options.Flag and folderName then
                local settings = RainLib:LoadSettings(folderName)
                if settings and settings.Flags[options.Flag] ~= nil then
                    keybind.Value = settings.Flags[options.Flag]
                    keyLabel.Text = keybind.Value
                end
            end

            frame.Parent = tab.Frame
            tab.ElementCount = tab.ElementCount + 1
            frame.LayoutOrder = tab.ElementCount

            local waitingForInput = false
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    waitingForInput = true
                    tween(keyLabel, TweenInfo.new(0.2), {TextTransparency = 0.5})
                    keyLabel.Text = "..."
                end
            end)

            UserInputService.InputBegan:Connect(function(input)
                if waitingForInput and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    keybind.Value = input.KeyCode.Name or input.UserInputType.Name
                    keyLabel.Text = keybind.Value
                    tween(keyLabel, TweenInfo.new(0.2), {TextTransparency = 0})
                    waitingForInput = false
                    if options.ChangedCallback then
                        options.ChangedCallback(input.KeyCode or input.UserInputType)
                    end
                    if options.Callback then
                        options.Callback(true)
                    end
                    if options.Flag and window.Options.SaveSettings and folderName then
                        local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                        settings.Flags[options.Flag] = keybind.Value
                        RainLib:SaveSettings(folderName, settings)
                    end
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if not waitingForInput and (input.KeyCode.Name == keybind.Value or input.UserInputType.Name == keybind.Value) then
                    if keybind.Mode == "Hold" and options.Callback then
                        options.Callback(false)
                    end
                end
            end)

            function keybind:SetValue(keyValue, mode)
                keybind.Value = keyValue
                keybind.Mode = mode or keybind.Mode
                keyLabel.Text = keybind.Value
                if options.Flag and window.Options.SaveSettings and folderName then
                    local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                    settings.Flags[options.Flag] = keybind.Value
                    RainLib:SaveSettings(folderName, settings)
                end
            end

            -- Salvar no estado
            local windowIndex = #RainLib.GUIState.Windows
            local tabIndex = #RainLib.GUIState.Windows[windowIndex].Tabs
            table.insert(RainLib.GUIState.Windows[windowIndex].Tabs[tabIndex].Elements, {
                Type = "Keybind",
                Key = key,
                Options = options
            })

            return keybind
        end

        -- Função para adicionar botão
        function tab:AddButton(key, options)
            options = validateOptions(options, {
                Title = "Button",
                Callback = nil
            })
            local buttonSize = UDim2.new(0, RainLib.flags.isMobile and 150 or 120, 0, RainLib.flags.isMobile and 50 or 40)
            local button = {}
            local frame = Instance.new("TextButton")
            frame.Size = buttonSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Text = options.Title
            frame.TextColor3 = RainLib.CurrentTheme.Text
            frame.Font = Enum.Font.SourceSans
            frame.TextSize = RainLib.flags.isMobile and 18 or 16

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            frame.Parent = tab.Frame
            tab.ElementCount = tab.ElementCount + 1
            frame.LayoutOrder = tab.ElementCount

            frame.MouseButton1Click:Connect(function()
                if options.Callback then
                    options.Callback()
                end
            end)

            frame.MouseEnter:Connect(function()
                tween(frame, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
            end)
            frame.MouseLeave:Connect(function()
                tween(frame, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end)

            -- Salvar no estado
            local windowIndex = #RainLib.GUIState.Windows
            local tabIndex = #RainLib.GUIState.Windows[windowIndex].Tabs
            table.insert(RainLib.GUIState.Windows[windowIndex].Tabs[tabIndex].Elements, {
                Type = "Button",
                Key = key,
                Options = options
            })

            return button
        end

        -- Função para adicionar input de texto
        function tab:AddTextbox(key, options)
            options = validateOptions(options, {
                Title = "Textbox",
                Default = "",
                Flag = nil,
                Callback = nil,
                Placeholder = "Digite aqui..."
            })
            local textboxSize = UDim2.new(0, RainLib.flags.isMobile and 150 or 120, 0, RainLib.flags.isMobile and 50 or 40)
            local textbox = { Value = options.Default }
            local frame = Instance.new("Frame")
            frame.Size = textboxSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, RainLib.flags.isMobile and 100 or 80, 0, RainLib.flags.isMobile and 24 or 20)
            label.Text = options.Title
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = RainLib.flags.isMobile and 14 or 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local input = Instance.new("TextBox")
            input.Size = UDim2.new(1, -10, 0, RainLib.flags.isMobile and 20 or 16)
            input.Position = UDim2.new(0, 5, 0, RainLib.flags.isMobile and 28 or 24)
            input.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            input.Text = options.Default
            input.PlaceholderText = options.Placeholder
            input.TextColor3 = RainLib.CurrentTheme.Text
            input.Font = Enum.Font.SourceSans
            input.TextSize = RainLib.flags.isMobile and 14 or 12
            input.Parent = frame

            local inputCorner = Instance.new("UICorner")
            inputCorner.CornerRadius = UDim.new(0, 4)
            inputCorner.Parent = input

            -- Carregar valor salvo se Flag estiver definido
            local folderName = window.Options.ConfigFolder
            if options.Flag and folderName then
                local settings = RainLib:LoadSettings(folderName)
                if settings and settings.Flags[options.Flag] ~= nil then
                    textbox.Value = settings.Flags[options.Flag]
                    input.Text = textbox.Value
                end
            end

            frame.Parent = tab.Frame
            tab.ElementCount = tab.ElementCount + 1
            frame.LayoutOrder = tab.ElementCount

            input.FocusLost:Connect(function()
                textbox.Value = input.Text
                if options.Callback then
                    options.Callback(textbox.Value)
                end
                if options.Flag and window.Options.SaveSettings and folderName then
                    local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                    settings.Flags[options.Flag] = textbox.Value
                    RainLib:SaveSettings(folderName, settings)
                end
            end)

            function textbox:SetValue(value)
                textbox.Value = value
                input.Text = value
                if options.Flag and window.Options.SaveSettings and folderName then
                    local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                    settings.Flags[options.Flag] = textbox.Value
                    RainLib:SaveSettings(folderName, settings)
                end
            end

            -- Salvar no estado
            local windowIndex = #RainLib.GUIState.Windows
            local tabIndex = #RainLib.GUIState.Windows[windowIndex].Tabs
            table.insert(RainLib.GUIState.Windows[windowIndex].Tabs[tabIndex].Elements, {
                Type = "Textbox",
                Key = key,
                Options = options
            })

            return textbox
        end

        -- Função para adicionar colorpicker
        function tab:AddColorpicker(key, options)
            options = validateOptions(options, {
                Title = "Colorpicker",
                Default = Color3.fromRGB(255, 255, 255),
                Flag = nil,
                Callback = nil
            })
            local colorpickerSize = UDim2.new(0, RainLib.flags.isMobile and 150 or 120, 0, RainLib.flags.isMobile and 50 or 40)
            local colorpicker = { Value = options.Default }
            local frame = Instance.new("Frame")
            frame.Size = colorpickerSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, RainLib.flags.isMobile and 100 or 80, 1, 0)
            label.Text = options.Title
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = RainLib.flags.isMobile and 16 or 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local colorBox = Instance.new("Frame")
            colorBox.Size = UDim2.new(0, RainLib.flags.isMobile and 24 or 20, 0, RainLib.flags.isMobile and 24 or 20)
            colorBox.Position = UDim2.new(1, RainLib.flags.isMobile and -34 or -30, 0.5, RainLib.flags.isMobile and -12 or -10)
            colorBox.BackgroundColor3 = colorpicker.Value
            colorBox.Parent = frame

            local colorCorner = Instance.new("UICorner")
            colorCorner.CornerRadius = UDim.new(0, 6)
            colorCorner.Parent = colorBox

            -- Carregar valor salvo se Flag estiver definido
            local folderName = window.Options.ConfigFolder
            if options.Flag and folderName then
                local settings = RainLib:LoadSettings(folderName)
                if settings and settings.Flags[options.Flag] ~= nil then
                    colorpicker.Value = Color3.new(unpack(settings.Flags[options.Flag]))
                    colorBox.BackgroundColor3 = colorpicker.Value
                end
            end

            frame.Parent = tab.Frame
            tab.ElementCount = tab.ElementCount + 1
            frame.LayoutOrder = tab.ElementCount

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    -- Simulação de colorpicker (em um sistema real, abriria um seletor de cores)
                    local newColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                    colorpicker.Value = newColor
                    colorBox.BackgroundColor3 = newColor
                    if options.Callback then
                        options.Callback(newColor)
                    end
                    if options.Flag and window.Options.SaveSettings and folderName then
                        local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                        settings.Flags[options.Flag] = {colorpicker.Value.R, colorpicker.Value.G, colorpicker.Value.B}
                        RainLib:SaveSettings(folderName, settings)
                    end
                end
            end)

            function colorpicker:SetValue(color)
                colorpicker.Value = color
                colorBox.BackgroundColor3 = color
                if options.Flag and window.Options.SaveSettings and folderName then
                    local settings = RainLib:LoadSettings(folderName) or { Flags = {} }
                    settings.Flags[options.Flag] = {colorpicker.Value.R, colorpicker.Value.G, colorpicker.Value.B}
                    RainLib:SaveSettings(folderName, settings)
                end
            end

            -- Salvar no estado
            local windowIndex = #RainLib.GUIState.Windows
            local tabIndex = #RainLib.GUIState.Windows[windowIndex].Tabs
            table.insert(RainLib.GUIState.Windows[windowIndex].Tabs[tabIndex].Elements, {
                Type = "Colorpicker",
                Key = key,
                Options = options
            })

            return colorpicker
        end

        -- Função para adicionar label
        function tab:AddLabel(key, options)
            options = validateOptions(options, {
                Text = "Label"
            })
            local labelSize = UDim2.new(0, RainLib.flags.isMobile and 150 or 120, 0, RainLib.flags.isMobile and 30 or 24)
            local label = {}
            local frame = Instance.new("TextLabel")
            frame.Size = labelSize
            frame.BackgroundTransparency = 1
            frame.Text = options.Text
            frame.TextColor3 = RainLib.CurrentTheme.Text
            frame.Font = Enum.Font.SourceSans
            frame.TextSize = RainLib.flags.isMobile and 16 or 14
            frame.TextXAlignment = Enum.TextXAlignment.Left

            frame.Parent = tab.Frame
            tab.ElementCount = tab.ElementCount + 1
            frame.LayoutOrder = tab.ElementCount

            -- Salvar no estado
            local windowIndex = #RainLib.GUIState.Windows
            local tabIndex = #RainLib.GUIState.Windows[windowIndex].Tabs
            table.insert(RainLib.GUIState.Windows[windowIndex].Tabs[tabIndex].Elements, {
                Type = "Label",
                Key = key,
                Options = options
            })

            function label:SetText(text)
                frame.Text = text
            end

            return label
        end

        return tab
    end

    return window
end

-- Função para recriar o GUI
function RainLib:RecreateGUI()
    if RainLib.ScreenGui then
        RainLib:Destroy()
        print("[RainLib] GUI antigo destruído")
    end

    if RainLib.GUIState then
        for _, windowState in ipairs(RainLib.GUIState.Windows) do
            local window = RainLib:Window(windowState.Options)
            for _, tabState in ipairs(windowState.Tabs) do
                local tab = window:Tab({ Title = tabState.Name, Icon = tabState.Icon })
                for _, elementState in ipairs(tabState.Elements) do
                    if elementState.Type == "Toggle" then
                        tab:AddToggle(elementState.Key, elementState.Options)
                    elseif elementState.Type == "Slider" then
                        tab:AddSlider(elementState.Key, elementState.Options)
                    elseif elementState.Type == "Dropdown" then
                        tab:AddDropdown(elementState.Key, elementState.Options)
                    elseif elementState.Type == "Keybind" then
                        tab:AddKeybind(elementState.Key, elementState.Options)
                    elseif elementState.Type == "Button" then
                        tab:AddButton(elementState.Key, elementState.Options)
                    elseif elementState.Type == "Textbox" then
                        tab:AddTextbox(elementState.Key, elementState.Options)
                    elseif elementState.Type == "Colorpicker" then
                        tab:AddColorpicker(elementState.Key, elementState.Options)
                    elseif elementState.Type == "Label" then
                        tab:AddLabel(elementState.Key, elementState.Options)
                    end
                end
            end
        end
        print("[RainLib] GUI recriado com base no estado salvo")
    else
        warn("[RainLib] Nenhum estado de GUI salvo para recriar")
    end
end

-- Função para mudar tema
function RainLib:SetTheme(themeName)
    RainLib.CurrentTheme = RainLib.Themes[themeName] or RainLib.Themes.Dark
    -- Atualizar todos os elementos visuais (simplificado)
    print("[RainLib] Tema alterado para: " .. themeName)
end

return RainLib
