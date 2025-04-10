"-- RainLib v1.2.2: Sections tratadas como elementos, 1 elemento por linha, largura dinâmica
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local RainLib = {
    Version = "1.2.2",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(25, 25, 25),
            Accent = Color3.fromRGB(60, 160, 255),
            Text = Color3.fromRGB(240, 240, 240),
            Secondary = Color3.fromRGB(45, 45, 45),
            Disabled = Color3.fromRGB(90, 90, 90)
        }
    },
    Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/RainLib/main/Icons.lua"))(),
    Windows = {},
    CurrentTheme = nil,
    CreatedFolders = {} -- Tabela pra rastrear pastas já criadas
}

local function tween(obj, info, properties)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.3, Enum.EasingStyle.Quint), properties)
    tween:Play()
    return tween
end

print("[RainLib] Inicializando...")
local success, err = pcall(function()
    RainLib.ScreenGui = Instance.new("ScreenGui")
    RainLib.ScreenGui.Name = "RainLib"
    RainLib.ScreenGui.Parent = game.CoreGui or LocalPlayer:WaitForChild("PlayerGui", 5)
    RainLib.ScreenGui.ResetOnSpawn = false
    RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    RainLib.CurrentTheme = RainLib.Themes.Dark
    
    -- Área para notificações
    RainLib.Notifications = Instance.new("Frame")
    RainLib.Notifications.Size = UDim2.new(0, 300, 1, -25)
    RainLib.Notifications.Position = UDim2.new(1, -310, 0, 10)
    RainLib.Notifications.BackgroundTransparency = 1
    RainLib.Notifications.Parent = RainLib.ScreenGui
end)
if not success then
    warn("[RainLib] Falha na inicialização: " .. err)
    return nil
end
print("[RainLib] Inicializado com sucesso!")

-- Função CreateFolder
function RainLib:CreateFolder(folderName)
    if not folderName or folderName == "" then
        warn("[RainLib] Nome da pasta não especificado!")
        return false
    end
    
    if self.CreatedFolders[folderName] then
        print("[RainLib] Pasta já registrada nesta sessão: " .. folderName)
        return false
    end
    
    if makefolder then
        if not isfolder(folderName) then
            makefolder(folderName)
            self.CreatedFolders[folderName] = true
            print("[RainLib] Pasta criada: " .. folderName)
            return true
        else
            self.CreatedFolders[folderName] = true
            print("[RainLib] Pasta já existe: " .. folderName)
            return false
        end
    else
        warn("[RainLib] Este executor não suporta a função makefolder!")
        return false
    end
end

-- Função Notify
function RainLib:Notify(options)
    local notificationHeight = options.SubContent and 100 or 80
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 280, 0, notificationHeight)
    notification.Position = UDim2.new(1, 300, 0, (#RainLib.Notifications:GetChildren() * (notificationHeight + 10)))
    notification.BackgroundColor3 = RainLib.CurrentTheme.Background
    notification.BackgroundTransparency = 1
    notification.Parent = RainLib.Notifications
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 20)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.Text = options.Title or "Notification"
    title.BackgroundTransparency = 1
    title.TextColor3 = RainLib.CurrentTheme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = notification
    
    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1, -10, 0, 20)
    content.Position = UDim2.new(0, 5, 0, 30)
    content.Text = options.Content or "Content"
    content.BackgroundTransparency = 1
    content.TextColor3 = RainLib.CurrentTheme.Text
    content.Font = Enum.Font.SourceSans
    content.TextSize = 14
    content.TextWrapped = true
    content.TextXAlignment = Enum.TextXAlignment.Left
    content.Parent = notification
    
    if options.SubContent then
        local subContent = Instance.new("TextLabel")
        subContent.Size = UDim2.new(1, -10, 0, 20)
        subContent.Position = UDim2.new(0, 5, 0, 55)
        subContent.Text = options.SubContent
        subContent.BackgroundTransparency = 1
        subContent.TextColor3 = RainLib.CurrentTheme.Text
        subContent.Font = Enum.Font.SourceSans
        subContent.TextSize = 12
        subContent.TextWrapped = true
        subContent.TextXAlignment = Enum.TextXAlignment.Left
        subContent.Parent = notification
    end
    
    tween(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
        Position = UDim2.new(1, -290, 0, (#RainLib.Notifications:GetChildren() - 1) * (notificationHeight + 10)),
        BackgroundTransparency = 0
    })
    
    if options.Duration then
        task.spawn(function()
            task.wait(options.Duration)
            tween(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                Position = UDim2.new(1, 300, 0, notification.Position.Y.Offset),
                BackgroundTransparency = 1
            }).Completed:Connect(function()
                notification:Destroy()
            end)
        end)
    end
end

function RainLib:Window(options)
    local window = {}
    options = options or {}
    local defaultOptions = {
        Title = "Rain Lib",
        SubTitle = "",
        Position = UDim2.new(0.5, -300, 0.5, -200),
    }
    window.Options = {}
    for key, defaultValue in pairs(defaultOptions) do
        window.Options[key] = options[key] or defaultValue
    end
    
    window.Minimized = false
    window.Tabs = {}
    
    local success, err = pcall(function()
        window.MainFrame = Instance.new("Frame")
        window.MainFrame.Size = UDim2.new(0, 600, 0, 400)
        window.MainFrame.Position = window.Options.Position
        window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
        window.MainFrame.ClipsDescendants = true
        window.MainFrame.BackgroundTransparency = 1
        window.MainFrame.Parent = RainLib.ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = window.MainFrame
        
        window.TitleBar = Instance.new("Frame")
        window.TitleBar.Size = UDim2.new(1, 0, 0, 50)
        window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TitleBar.Parent = window.MainFrame
        
        window.TitleLabel = Instance.new("TextLabel")
        window.TitleLabel.Size = UDim2.new(1, -60, 0, 20)
        window.TitleLabel.Position = UDim2.new(0, 15, 0, 5)
        window.TitleLabel.BackgroundTransparency = 1
        window.TitleLabel.Text = window.Options.Title
        window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
        window.TitleLabel.Font = Enum.Font.GothamBold
        window.TitleLabel.TextSize = 16
        window.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        window.TitleLabel.Parent = window.TitleBar
        
        window.SubTitleLabel = Instance.new("TextLabel")
        window.SubTitleLabel.Size = UDim2.new(1, -60, 0, 15)
        window.SubTitleLabel.Position = UDim2.new(0, 15, 0, 25)
        window.SubTitleLabel.BackgroundTransparency = 1
        window.SubTitleLabel.Text = window.Options.SubTitle
        window.SubTitleLabel.TextColor3 = RainLib.CurrentTheme.Text
        window.SubTitleLabel.Font = Enum.Font.Gotham
        window.SubTitleLabel.TextSize = 12
        window.SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        window.SubTitleLabel.Parent = window.TitleBar
        
        window.MinimizeBtn = Instance.new("TextButton")
        window.MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
        window.MinimizeBtn.Position = UDim2.new(1, -75, 0, 10)
        window.MinimizeBtn.BackgroundColor3 = RainLib.CurrentTheme.Accent
        window.MinimizeBtn.Text = "-"
        window.MinimizeBtn.TextColor3 = RainLib.CurrentTheme.Text
        window.MinimizeBtn.Font = Enum.Font.SourceSansBold
        window.MinimizeBtn.TextSize = 16
        window.MinimizeBtn.Parent = window.TitleBar
        
        local minimizeCorner = Instance.new("UICorner")
        minimizeCorner.CornerRadius = UDim.new(0, 8)
        minimizeCorner.Parent = window.MinimizeBtn
        
        window.TabContainer = Instance.new("ScrollingFrame")
        window.TabContainer.Size = UDim2.new(0, 150, 1, -50)
        window.TabContainer.Position = UDim2.new(0, 0, 0, 50)
        window.TabContainer.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TabContainer.ScrollBarThickness = 0
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        window.TabContainer.Parent = window.MainFrame
        
        window.MainFrame.Position = UDim2.new(window.Options.Position.X.Scale, window.Options.Position.X.Offset, 0.5, 300)
        tween(window.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = window.Options.Position, BackgroundTransparency = 0})
    end)
    if not success then
        warn("[RainLib] Falha ao criar janela: " .. err)
        return nil
    end
    
    window.MinimizeBtn.MouseButton1Click:Connect(function()
        if window.Minimized then
            tween(window.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 600, 0, 400)})
            window.MinimizeBtn.Text = "-"
            window.MainFrame.ClipsDescendants = false
            window.TabContainer.Visible = true
        else
            window.MainFrame.ClipsDescendants = true
            window.MinimizeBtn.Text = "+"
            tween(window.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 600, 0, 50)})
            task.wait(0.1)
            window.TabContainer.Visible = false
        end
        window.Minimized = not window.Minimized
    end)
    
    function window:Dialog(options)
        local dialog = Instance.new("Frame")
        dialog.Size = UDim2.new(0, 300, 0, 150)
        dialog.Position = UDim2.new(0.5, -150, 0.5, 200)
        dialog.BackgroundColor3 = RainLib.CurrentTheme.Background
        dialog.BackgroundTransparency = 1
        dialog.Parent = RainLib.ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = dialog
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -10, 0, 20)
        title.Position = UDim2.new(0, 5, 0, 5)
        title.Text = options.Title or "Dialog"
        title.BackgroundTransparency = 1
        title.TextColor3 = RainLib.CurrentTheme.Text
        title.Font = Enum.Font.GothamBold
        title.TextSize = 16
        title.TextXAlignment = Enum.TextXAlignment.Center
        title.Parent = dialog
        
        local content = Instance.new("TextLabel")
        content.Size = UDim2.new(1, -10, 0, 60)
        content.Position = UDim2.new(0, 5, 0, 30)
        content.Text = options.Content or "Content"
        content.BackgroundTransparency = 1
        content.TextColor3 = RainLib.CurrentTheme.Text
        content.Font = Enum.Font.SourceSans
        content.TextSize = 14
        content.TextWrapped = true
        content.TextXAlignment = Enum.TextXAlignment.Center
        content.Parent = dialog
        
        for i, btn in ipairs(options.Buttons or {}) do
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 80, 0, 30)
            button.Position = UDim2.new(0, 10 + (i-1) * 90, 1, -40)
            button.Text = btn.Title or "Button"
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 16
            button.Parent = dialog
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 8)
            btnCorner.Parent = button
            
            button.MouseButton1Click:Connect(function()
                if btn.Callback then
                    btn.Callback()
                end
                tween(dialog, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                    Position = UDim2.new(0.5, -150, 0.5, 200),
                    BackgroundTransparency = 1
                }).Completed:Connect(function()
                    dialog:Destroy()
                end)
            end)
        end
        
        tween(dialog, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0.5, -150, 0.5, -75),
            BackgroundTransparency = 0
        })
    end
    
    function window:Tab(options)
        local tab = {}
        options = options or {}
        tab.Name = options.Title or "Tab"
        tab.Icon = options.Icon or nil
        tab.ElementCount = 0
        
        tab.Main = Instance.new("ScrollingFrame")
        tab.Main.Size = UDim2.new(1, -160, 1, -60)
        tab.Main.Position = UDim2.new(0, 155, 0, 55)
        tab.Main.BackgroundTransparency = 1
        tab.Main.ScrollBarThickness = 4
        tab.Main.CanvasSize = UDim2.new(0, 0, 0, 0)
        tab.Main.Parent = window.MainFrame
        
        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(1, -10, 0, 40)
        tab.Button.Position = UDim2.new(0, 5, 0, #window.Tabs * 45 + 5)
        tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        tab.Button.Text = tab.Icon and "" or tab.Name
        tab.Button.TextColor3 = RainLib.CurrentTheme.Text
        tab.Button.Font = Enum.Font.SourceSansBold
        tab.Button.TextSize = 16
        tab.Button.TextXAlignment = Enum.TextXAlignment.Left
        tab.Button.Parent = window.TabContainer
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, #window.Tabs * 45 + 50)
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = tab.Button
        
        if tab.Icon then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 24, 0, 24)
            icon.Position = UDim2.new(0, 10, 0.5, -12)
            icon.BackgroundTransparency = 1
            icon.Image = RainLib.Icons[tab.Icon] or tab.Icon
            icon.Parent = tab.Button
            
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, -40, 1, 0)
            text.Position = UDim2.new(0, 40, 0, 0)
            text.BackgroundTransparency = 1
            text.Text = tab.Name
            text.TextColor3 = RainLib.CurrentTheme.Text
            text.Font = Enum.Font.SourceSansBold
            text.TextSize = 16
            text.TextXAlignment = Enum.TextXAlignment.Left
            text.Parent = tab.Button
        end
        
        local function getNextPosition(elementHeight)
            local padding = 10
            local yOffset = padding + tab.ElementCount * (elementHeight + padding)
            tab.ElementCount = tab.ElementCount + 1
            tab.Main.CanvasSize = UDim2.new(0, 0, 0, yOffset + elementHeight + padding)
            return UDim2.new(0, padding, 0, yOffset)
        end
        
        function tab:AddSection(name)
            local sectionHeight = 30
            local section = Instance.new("Frame")
            section.Size = UDim2.new(1, -20, 0, sectionHeight)
            section.BackgroundTransparency = 1
            section.Position = getNextPosition(sectionHeight)
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, 0, 0, sectionHeight)
            title.Text = name or "Section"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 18
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = section
            
            local underline = Instance.new("Frame")
            underline.Size = UDim2.new(0.3, 0, 0, 2)
            underline.Position = UDim2.new(0, 0, 1, -2)
            underline.BackgroundColor3 = RainLib.CurrentTheme.Accent
            underline.Parent = section
            
            section.Parent = tab.Main
            return section
        end
        
        function tab:AddParagraph(options)
            local paragraphHeight = 40
            local paragraph = Instance.new("Frame")
            paragraph.Size = UDim2.new(1, -20, 0, paragraphHeight)
            paragraph.BackgroundTransparency = 1
            paragraph.Position = getNextPosition(paragraphHeight)
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, 0, 0, 20)
            title.Text = options.Title or "Paragraph"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 12
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = paragraph
            
            local content = Instance.new("TextLabel")
            content.Size = UDim2.new(1, 0, 0, 20)
            content.Position = UDim2.new(0, 0, 0, 20)
            content.Text = options.Content or "Content"
            content.BackgroundTransparency = 1
            content.TextColor3 = RainLib.CurrentTheme.Text
            content.Font = Enum.Font.SourceSans
            content.TextSize = 10
            content.TextWrapped = true
            content.TextXAlignment = Enum.TextXAlignment.Left
            content.Parent = paragraph
            
            paragraph.Parent = tab.Main
            return paragraph
        end
        
        function tab:AddButton(options)
            local buttonHeight = 40
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -20, 0, buttonHeight)
            button.Position = getNextPosition(buttonHeight)
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.Text = options.Title or "Button"
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 16
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = button
            
            if options.Description then
                local desc = Instance.new("TextLabel")
                desc.Size = UDim2.new(1, 0, 0, 20)
                desc.Position = UDim2.new(0, 0, 0, 20)
                desc.Text = options.Description
                desc.BackgroundTransparency = 1
                desc.TextColor3 = RainLib.CurrentTheme.Text
                desc.Font = Enum.Font.SourceSans
                desc.TextSize = 12
                desc.TextXAlignment = Enum.TextXAlignment.Left
                desc.Parent = button
            end
            
            button.Parent = tab.Main
            
            button.MouseButton1Click:Connect(options.Callback or function() end)
            return button
        end
        
        function tab:AddToggle(options)
            local toggleHeight = 30
            local toggle = Instance.new("Frame")
            toggle.Size = UDim2.new(1, -20, 0, toggleHeight)
            toggle.Position = getNextPosition(toggleHeight)
            toggle.BackgroundTransparency = 1
            toggle.Parent = tab.Main
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -50, 0, toggleHeight)
            title.Text = options.Name or "Toggle"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.SourceSansBold
            title.TextSize = 16
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = toggle
            
            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(0, 40, 0, 20)
            toggleBtn.Position = UDim2.new(1, -40, 0.5, -10)
            toggleBtn.BackgroundColor3 = options.Default and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
            toggleBtn.Text = ""
            toggleBtn.Parent = toggle
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = toggleBtn
            
            local state = options.Default or false
            
            toggleBtn.MouseButton1Click:Connect(function()
                state = not state
                tween(toggleBtn, TweenInfo.new(0.2), {
                    BackgroundColor3 = state and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
                })
                if options.Callback then
                    options.Callback(state)
                end
            end)
            
            return toggle
        end
        
        table.insert(window.Tabs, tab)
        return tab
    end
    
    table.insert(RainLib.Windows, window)
    return window
end

print("[RainLib] carregada!")
return RainLib
