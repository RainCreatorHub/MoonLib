-- MoonLib UI Library para Roblox (moderno com animações)
local MoonLib = {}
MoonLib.__index = MoonLib

-- Serviços do Roblox
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- Função para criar uma janela
function MoonLib:MakeWindow(config)
    if not config or type(config) ~= "table" then
        error("Configuração inválida: é necessário passar uma tabela de configuração")
    end

    -- Configurações padrão
    local window = {
        Title = config.Title or "MoonLib Window",
        SubTitle = config.SubTitle or "",
        Theme = config.Theme or "Dark",
        Visible = true,
        Tabs = {},
        Containers = {},
        SelectedTab = 0,
        TabCount = 0
    }

    -- Validar tema
    local validThemes = {["Dark"] = true, ["Light"] = true}
    if not validThemes[window.Theme] then
        warn("Tema inválido: " .. tostring(window.Theme) .. ". Usando tema padrão 'Dark'.")
        window.Theme = "Dark"
    end

    -- Definir cores e estilos modernos
    local colors = {
        Dark = {
            FrameBg = Color3.fromRGB(25, 25, 25), -- Fundo mais escuro e elegante
            DragBarBg = Color3.fromRGB(35, 35, 40), -- Gradiente base
            TitleText = Color3.fromRGB(255, 215, 0), -- Ouro suave
            SubtitleText = Color3.fromRGB(150, 150, 160),
            ConfirmFrameBg = Color3.fromRGB(40, 40, 45),
            TabBg = Color3.fromRGB(30, 30, 35),
            TabSelectedBg = Color3.fromRGB(50, 50, 60),
            TabText = Color3.fromRGB(200, 200, 210),
            Accent = Color3.fromRGB(0, 120, 255), -- Azul vibrante como destaque
            Shadow = Color3.fromRGB(0, 0, 0)
        },
        Light = {
            FrameBg = Color3.fromRGB(240, 240, 245),
            DragBarBg = Color3.fromRGB(220, 220, 230),
            TitleText = Color3.fromRGB(0, 100, 200),
            SubtitleText = Color3.fromRGB(70, 70, 80),
            ConfirmFrameBg = Color3.fromRGB(200, 200, 210),
            TabBg = Color3.fromRGB(230, 230, 235),
            TabSelectedBg = Color3.fromRGB(200, 200, 210),
            TabText = Color3.fromRGB(50, 50, 60),
            Accent = Color3.fromRGB(0, 120, 255),
            Shadow = Color3.fromRGB(150, 150, 150)
        }
    }
    local themeColors = colors[window.Theme]

    -- Criar ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MoonLib_" .. window.Title
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false

    -- Criar Frame principal da janela (500x370 pixels)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 500, 0, 370)
    frame.Position = UDim2.new(0.5, -250, 0.5, -185)
    frame.BackgroundColor3 = themeColors.FrameBg
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    -- Adicionar sombra moderna
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6014261993" -- Sombra padrão do Roblox
    shadow.ImageColor3 = themeColors.Shadow
    shadow.ImageTransparency = 0.7
    shadow.Parent = frame

    -- Cantos arredondados
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    -- Animação de entrada
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(frame, tweenInfo, {Size = UDim2.new(0, 500, 0, 370), Position = UDim2.new(0.5, -250, 0.5, -185)})
    tween:Play()

    -- DragBar
    local dragBar = Instance.new("Frame")
    dragBar.Size = UDim2.new(1, 0, 0, 60)
    dragBar.Position = UDim2.new(0, 0, 0, 0)
    dragBar.BackgroundColor3 = themeColors.DragBarBg
    dragBar.BorderSizePixel = 0
    dragBar.Parent = frame

    -- Gradiente na DragBar
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, themeColors.DragBarBg),
        ColorSequenceKeypoint.new(1, themeColors.Accent:Lerp(themeColors.DragBarBg, 0.3))
    }
    gradient.Parent = dragBar

    -- Título na DragBar (esquerda)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.7, -10, 0, 25)
    titleLabel.Position = UDim2.new(0, 15, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = window.Title
    titleLabel.TextColor3 = themeColors.TitleText
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = dragBar

    -- Subtítulo na DragBar (abaixo do título)
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(0.7, -10, 0, 20)
    subtitleLabel.Position = UDim2.new(0, 15, 0, 35)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = window.SubTitle
    subtitleLabel.TextColor3 = themeColors.SubtitleText
    subtitleLabel.TextSize = 16
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.Parent = dragBar

    -- Botão X na DragBar (direita)
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 40, 0, 40)
    closeButton.Position = UDim2.new(1, -45, 0, 10)
    closeButton.BackgroundColor3 = themeColors.Accent
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = dragBar

    local cornerButton = Instance.new("UICorner")
    cornerButton.CornerRadius = UDim.new(0, 8)
    cornerButton.Parent = closeButton

    -- Animação do botão X ao passar o mouse
    closeButton.MouseEnter:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
    end)
    closeButton.MouseLeave:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = themeColors.Accent}):Play()
    end)

    -- Frame de confirmação (100x70 pixels)
    local confirmFrame = Instance.new("Frame")
    confirmFrame.Size = UDim2.new(0, 100, 0, 70)
    confirmFrame.Position = UDim2.new(0.5, -50, 0.5, -35)
    confirmFrame.BackgroundColor3 = themeColors.ConfirmFrameBg
    confirmFrame.Visible = false
    confirmFrame.Parent = frame

    local cornerConfirm = Instance.new("UICorner")
    cornerConfirm.CornerRadius = UDim.new(0, 10)
    cornerConfirm.Parent = confirmFrame

    -- Animação de entrada do confirmFrame
    confirmFrame.MouseEnter:Connect(function()
        TweenService:Create(confirmFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 110, 0, 80)}):Play()
    end)
    confirmFrame.MouseLeave:Connect(function()
        TweenService:Create(confirmFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 100, 0, 70)}):Play()
    end)

    -- Botão Sim
    local yesButton = Instance.new("TextButton")
    yesButton.Size = UDim2.new(0, 40, 0, 25)
    yesButton.Position = UDim2.new(0, 10, 1, -30)
    yesButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    yesButton.Text = "Sim"
    yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    yesButton.TextSize = 14
    yesButton.Font = Enum.Font.Gotham
    yesButton.Parent = confirmFrame

    local cornerYes = Instance.new("UICorner")
    cornerYes.CornerRadius = UDim.new(0, 6)
    cornerYes.Parent = yesButton

    -- Animação do botão Sim
    yesButton.MouseEnter:Connect(function()
        TweenService:Create(yesButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(0, 255, 0)}):Play()
    end)
    yesButton.MouseLeave:Connect(function()
        TweenService:Create(yesButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(0, 200, 0)}):Play()
    end)

    -- Botão Não
    local noButton = Instance.new("TextButton")
    noButton.Size = UDim2.new(0, 40, 0, 25)
    noButton.Position = UDim2.new(1, -50, 1, -30)
    noButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    noButton.Text = "Não"
    noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    noButton.TextSize = 14
    noButton.Font = Enum.Font.Gotham
    noButton.Parent = confirmFrame

    local cornerNo = Instance.new("UICorner")
    cornerNo.CornerRadius = UDim.new(0, 6)
    cornerNo.Parent = noButton

    -- Animação do botão Não
    noButton.MouseEnter:Connect(function()
        TweenService:Create(noButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
    end)
    noButton.MouseLeave:Connect(function()
        TweenService:Create(noButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}):Play()
    end)

    -- Área para abas (vertical, à esquerda)
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(0, 120, 1, -60) -- Aumentei a largura para 120
    tabBar.Position = UDim2.new(0, 0, 0, 60)
    tabBar.BackgroundTransparency = 1
    tabBar.Parent = frame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Vertical
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = tabBar

    -- Área para conteúdo das abas
    local containerHolder = Instance.new("Frame")
    containerHolder.Size = UDim2.new(1, -120, 1, -60) -- Ajustado para a nova largura da tabBar
    containerHolder.Position = UDim2.new(0, 120, 0, 60)
    containerHolder.BackgroundTransparency = 1
    containerHolder.Parent = frame

    -- Lógica do botão X (suporte para PC e mobile)
    closeButton.Activated:Connect(function()
        TweenService:Create(confirmFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 100, 0, 70), Position = UDim2.new(0.5, -50, 0.5, -35), BackgroundTransparency = 0}):Play()
        confirmFrame.Visible = true
    end)

    -- Lógica do botão Sim
    yesButton.Activated:Connect(function()
        TweenService:Create(confirmFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
        wait(0.3)
        screenGui:Destroy()
        print(string.format("Window '%s' closed", window.Title))
    end)

    -- Lógica do botão Não
    noButton.Activated:Connect(function()
        TweenService:Create(confirmFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
        wait(0.3)
        confirmFrame.Visible = false
    end)

    -- Dragging (arrastar pela DragBar)
    local dragging, dragInput, dragStart, startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)

    -- Método para criar abas
    function window:MakeTab(config)
        if not config or type(config) ~= "table" or not config.Name then
            error("Configuração de aba inválida: é necessário passar uma tabela com 'Name'")
        end

        window.TabCount = window.TabCount + 1
        local tabIndex = window.TabCount

        local tab = {
            Name = config.Name,
            Selected = false
        }

        -- Criar botão da aba com animação
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.BackgroundColor3 = themeColors.TabBg
        tabButton.Text = tab.Name
        tabButton.TextColor3 = themeColors.TabText
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.Gotham
        tabButton.Parent = tabBar

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 8)
        tabCorner.Parent = tabButton

        -- Animação da aba ao passar o mouse
        tabButton.MouseEnter:Connect(function()
            TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = themeColors.TabSelectedBg}):Play()
        end)
        tabButton.MouseLeave:Connect(function()
            if not tab.Selected then
                TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = themeColors.TabBg}):Play()
            end
        end)

        -- Criar container da aba
        local containerFrame = Instance.new("ScrollingFrame")
        containerFrame.Size = UDim2.new(1, 0, 1, 0)
        containerFrame.BackgroundTransparency = 1
        containerFrame.Visible = false
        containerFrame.ScrollBarThickness = 4
        containerFrame.ScrollBarImageColor3 = themeColors.Accent
        containerFrame.ScrollBarImageTransparency = 0.8
        containerFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        containerFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        containerFrame.Parent = containerHolder

        local containerLayout = Instance.new("UIListLayout")
        containerLayout.Padding = UDim.new(0, 10)
        containerLayout.SortOrder = Enum.SortOrder.LayoutOrder
        containerLayout.Parent = containerFrame

        local containerPadding = Instance.new("UIPadding")
        containerPadding.PaddingRight = UDim.new(0, 15)
        containerPadding.PaddingLeft = UDim.new(0, 15)
        containerPadding.PaddingTop = UDim.new(0, 10)
        containerPadding.PaddingBottom = UDim.new(0, 10)
        containerPadding.Parent = containerFrame

        -- Atualizar CanvasSize automaticamente
        containerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            containerFrame.CanvasSize = UDim2.new(0, 0, 0, containerLayout.AbsoluteContentSize.Y + 20)
        end)

        -- Lógica de seleção da aba com animação
        tabButton.Activated:Connect(function()
            window:SelectTab(tabIndex)
            TweenService:Create(tabButton, TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 45)}):Play()
            wait(0.3)
            TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 40)}):Play()
        end)

        window.Tabs[tabIndex] = tab
        window.Containers[tabIndex] = containerFrame
        tab.Frame = tabButton
        tab.Container = containerFrame

        print(string.format("Created tab: %s", tab.Name))

        -- Selecionar a primeira aba automaticamente
        if window.TabCount == 1 then
            window:SelectTab(1)
        end

        return tab
    end

    -- Método para selecionar aba
    function window:SelectTab(tabIndex)
        if window.Tabs[tabIndex] then
            window.SelectedTab = tabIndex
            for i, tab in pairs(window.Tabs) do
                tab.Selected = (i == tabIndex)
                TweenService:Create(tab.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = tab.Selected and themeColors.TabSelectedBg or themeColors.TabBg
                }):Play()
                TweenService:Create(window.Containers[i], TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundTransparency = tab.Selected and 0.3 or 1
                }):Play()
                window.Containers[i].Visible = tab.Selected
            end
            print(string.format("Selected tab: %s", window.Tabs[tabIndex].Name))
        end
    end

    -- Método da janela
    function window:GetInfo()
        return {
            Title = self.Title,
            SubTitle = self.SubTitle,
            Theme = self.Theme,
            Visible = self.Visible,
            Tabs = self.TabCount
        }
    end

    print(string.format("Created window: %s (Sub: %s, Theme: %s)", window.Title, window.SubTitle, window.Theme))

    return window
end

-- Retornar a biblioteca MoonLib e salvar no ambiente global
getgenv().MoonLib = MoonLib
return MoonLib
