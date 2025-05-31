-- MoonLib UI Library para Roblox
local MoonLib = {}
MoonLib.__index = MoonLib

-- Serviços do Roblox
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
        Visible = true
    }

    -- Validar tema
    local validThemes = {["Dark"] = true, ["Light"] = true}
    if not validThemes[window.Theme] then
        warn("Tema inválido: " .. tostring(window.Theme) .. ". Usando tema padrão 'Dark'.")
        window.Theme = "Dark"
    end

    -- Definir cores com base no tema
    local colors = {
        Dark = {
            FrameBg = Color3.fromRGB(30, 30, 30),
            DragBarBg = Color3.fromRGB(40, 40, 40),
            TitleText = Color3.fromRGB(255, 255, 255),
            SubtitleText = Color3.fromRGB(200, 200, 200),
            ConfirmFrameBg = Color3.fromRGB(50, 50, 50)
        },
        Light = {
            FrameBg = Color3.fromRGB(200, 200, 200),
            DragBarBg = Color3.fromRGB(220, 220, 220),
            TitleText = Color3.fromRGB(0, 0, 0),
            SubtitleText = Color3.fromRGB(50, 50, 50),
            ConfirmFrameBg = Color3.fromRGB(180, 180, 180)
        }
    }
    local themeColors = colors[window.Theme]

    -- Criar ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MoonLib_" .. window.Title
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false

    -- Criar Frame principal da janela
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    frame.BackgroundColor3 = themeColors.FrameBg
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    -- Cantos arredondados
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    -- DragBar
    local dragBar = Instance.new("Frame")
    dragBar.Size = UDim2.new(1, 0, 0, 50)
    dragBar.Position = UDim2.new(0, 0, 0, 0)
    dragBar.BackgroundColor3 = themeColors.DragBarBg
    dragBar.BorderSizePixel = 0
    dragBar.Parent = frame

    -- Título na DragBar (esquerda)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.7, -10, 0, 20)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = window.Title
    titleLabel.TextColor3 = themeColors.TitleText
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = dragBar

    -- Subtítulo na DragBar (abaixo do título)
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(0.7, -10, 0, 15)
    subtitleLabel.Position = UDim2.new(0, 5, 0, 25)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = window.SubTitle
    subtitleLabel.TextColor3 = themeColors.SubtitleText
    subtitleLabel.TextSize = 14
    subtitleLabel.Font = Enum.Font.SourceSans
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.Parent = dragBar

    -- Botão X na DragBar (direita)
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0, 10)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.Parent = dragBar

    local cornerButton = Instance.new("UICorner")
    cornerButton.CornerRadius = UDim.new(0, 5)
    cornerButton.Parent = closeButton

    -- Frame de confirmação (30px x 20px)
    local confirmFrame = Instance.new("Frame")
    confirmFrame.Size = UDim2.new(0, 30, 0, 20)
    confirmFrame.Position = UDim2.new(0.5, -15, 0.5, -10)
    confirmFrame.BackgroundColor3 = themeColors.ConfirmFrameBg
    confirmFrame.Visible = false
    confirmFrame.Parent = frame

    local cornerConfirm = Instance.new("UICorner")
    cornerConfirm.CornerRadius = UDim.new(0, 4)
    cornerConfirm.Parent = confirmFrame

    -- Botão Sim
    local yesButton = Instance.new("TextButton")
    yesButton.Size = UDim2.new(0, 13, 0, 8)
    yesButton.Position = UDim2.new(0, 2, 1, -8)
    yesButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    yesButton.Text = "Sim"
    yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    yesButton.TextSize = 8
    yesButton.Font = Enum.Font.SourceSans
    yesButton.Parent = confirmFrame

    local cornerYes = Instance.new("UICorner")
    cornerYes.CornerRadius = UDim.new(0, 2)
    cornerYes.Parent = yesButton

    -- Botão Não
    local noButton = Instance.new("TextButton")
    noButton.Size = UDim2.new(0, 13, 0, 8)
    noButton.Position = UDim2.new(1, -15, 1, -8)
    noButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    noButton.Text = "Não"
    noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    noButton.TextSize = 8
    noButton.Font = Enum.Font.SourceSans
    noButton.Parent = confirmFrame

    local cornerNo = Instance.new("UICorner")
    cornerNo.CornerRadius = UDim.new(0, 2)
    cornerNo.Parent = noButton

    -- Lógica do botão X (suporte para PC e mobile)
    closeButton.Activated:Connect(function()
        confirmFrame.Visible = true
    end)

    -- Lógica do botão Sim
    yesButton.Activated:Connect(function()
        screenGui:Destroy()
        print(string.format("Window '%s' closed", window.Title))
    end)

    -- Lógica do botão Não
    noButton.Activated:Connect(function()
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

    -- Métodos da janela
    function window:GetInfo()
        return {
            Title = self.Title,
            SubTitle = self.SubTitle,
            Theme = self.Theme,
            Visible = self.Visible
        }
    end

    print(string.format("Created window: %s (Sub: %s, Theme: %s)", window.Title, window.SubTitle, window.Theme))

    return window
end
