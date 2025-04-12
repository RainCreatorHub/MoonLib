-- UIKit.lua
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local UIKit = {}

-- Configurações padrão
UIKit.Themes = {
    Dark = {
        Background = Color3.fromRGB(25, 25, 25),
        Accent = Color3.fromRGB(60, 160, 255),
        Text = Color3.fromRGB(240, 240, 240),
        Secondary = Color3.fromRGB(45, 45, 45),
        Disabled = Color3.fromRGB(90, 90, 90)
    }
}

-- Função auxiliar para tween
local function tween(obj, info, properties)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.3, Enum.EasingStyle.Quint), properties)
    tween:Play()
    return tween
end

-- Função para carregar configurações
function UIKit:LoadConfigs(folderName)
    local uiSettingsPath = folderName .. "/uiSettings.json"
    if isfile and isfile(uiSettingsPath) then
        local success, result = pcall(function()
            local json = readfile(uiSettingsPath)
            return HttpService:JSONDecode(json)
        end)
        if success then
            return result.Configs or {}
        else
            warn("[UIKit] Falha ao carregar uiSettings.json: " .. result)
        end
    end
    return {}
end

-- Função para adicionar configuração
function UIKit:AddConfig(folderName, configName)
    if not folderName or not configName or configName == "" then
        warn("[UIKit] Nome da pasta ou configuração não especificado!")
        return false
    end

    if not isfolder(folderName) then
        warn("[UIKit] Pasta não existe: " .. folderName)
        return false
    end

    local uiSettingsPath = folderName .. "/uiSettings.json"
    local uiSettings = {}

    if isfile and isfile(uiSettingsPath) then
        local success, result = pcall(function()
            local json = readfile(uiSettingsPath)
            return HttpService:JSONDecode(json)
        end)
        if success then
            uiSettings = result
        else
            warn("[UIKit] Falha ao ler uiSettings.json: " .. result)
            return false
        end
    else
        uiSettings = { Configs = {} }
    end

    if not uiSettings.Configs then
        uiSettings.Configs = {}
    end

    if table.find(uiSettings.Configs, configName) then
        print("[UIKit] Configuração já existe: " .. configName)
        return false
    end

    table.insert(uiSettings.Configs, configName)
    local success, err = pcall(function()
        writefile(uiSettingsPath, HttpService:JSONEncode(uiSettings))
    end)
    if success then
        print("[UIKit] Configuração adicionada: " .. configName)
        return true
    else
        warn("[UIKit] Falha ao salvar configuração: " .. err)
        return false
    end
end

-- Função principal do UIKit
function UIKit:Create(tab, folderName)
    -- Seção Interface
    tab:AddSection("Interface")

    -- Dropdown Select Theme
    local themeOptions = {}
    for themeName, _ in pairs(UIKit.Themes) do
        table.insert(themeOptions, themeName)
    end
    tab:AddDropdown("theme_select", {
        Title = "Select Theme",
        Values = themeOptions,
        Default = "Dark",
        Callback = function(value)
            local themeKey
            for key, _ in pairs(UIKit.Themes) do
                if string.lower(key) == string.lower(value) then
                    themeKey = key
                    break
                end
            end
            if themeKey then
                -- Aplicar tema (exemplo, depende da UI)
                print("[UIKit] Tema alterado para: " .. themeKey)
                -- Aqui você pode chamar uma função para mudar o tema na UI
                -- Ex.: RainLib:SetTheme(UIKit.Themes[themeKey])
            else
                warn("[UIKit] Tema não encontrado: " .. value)
            end
        end
    })

    -- Seção Ui Config
    tab:AddSection("Ui Config")

    -- Inputbox Name Config
    tab:AddInput("config_name", {
        Title = "Name Config",
        Placeholder = "Name Config",
        Callback = function(value)
            if value and value ~= "" then
                UIKit:AddConfig(folderName, value)
            end
        end
    })

    -- Dropdown Config
    local configDropdown
    local function refreshConfigDropdown()
        local configs = UIKit:LoadConfigs(folderName)
        if #configs == 0 then
            configs = {"Nenhuma configuração"}
        end
        configDropdown:SetValue(configs[1])
        configDropdown.element:FindFirstChild("TextLabel").Text = configs[1]
        local list = configDropdown.element:FindFirstChild("Frame")
        list:ClearAllChildren()
        for i, opt in ipairs(configs) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
            btn.Text = opt
            btn.BackgroundTransparency = 0.2
            btn.BackgroundColor3 = UIKit.Themes.Dark.Secondary
            btn.TextColor3 = UIKit.Themes.Dark.Text
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 14
            btn.Parent = list

            btn.MouseEnter:Connect(function()
                tween(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0, BackgroundColor3 = UIKit.Themes.Dark.Accent})
            end)
            btn.MouseLeave:Connect(function()
                tween(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, BackgroundColor3 = UIKit.Themes.Dark.Secondary})
            end)

            btn.MouseButton1Click:Connect(function()
                configDropdown.Value = opt
                configDropdown.element:FindFirstChild("TextLabel").Text = opt
                tween(list, TweenInfo.new(0.3), {BackgroundTransparency = 1}).Completed:Connect(function()
                    list.Visible = false
                end)
            end)
        end
        list.Size = UDim2.new(1, 0, 0, #configs * 30)
    end

    configDropdown = tab:AddDropdown("config_select", {
        Title = "Config",
        Values = {"Nenhuma configuração"},
        Default = "Nenhuma configuração"
    })

    -- Botão Refresh
    tab:AddButton({
        Title = "Refresh",
        Callback = function()
            refreshConfigDropdown()
            print("[UIKit] Dropdown Config atualizado")
        end
    })

    -- Inicializar Dropdown
    refreshConfigDropdown()
end

return UIKit
