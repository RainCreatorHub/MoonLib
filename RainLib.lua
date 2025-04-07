-- RainLibV2 | By RainCreatorHub
local RainLib = {}
RainLib.__index = RainLib

local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local RainGui = Instance.new("ScreenGui", CoreGui)
RainGui.Name = "RainLibV2"
RainGui.ResetOnSpawn = false

-- UI Base
local MainFrame = Instance.new("Frame", RainGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Name = "MainFrame"

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(80, 80, 80)
UIStroke.Thickness = 1

local TabHolder = Instance.new("Frame", MainFrame)
TabHolder.Size = UDim2.new(0, 130, 1, 0)
TabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabHolder.BorderSizePixel = 0

local ContentHolder = Instance.new("Frame", MainFrame)
ContentHolder.Position = UDim2.new(0, 130, 0, 0)
ContentHolder.Size = UDim2.new(1, -130, 1, 0)
ContentHolder.BackgroundTransparency = 1

-- UIList for Tabs
local TabLayout = Instance.new("UIListLayout", TabHolder)
TabLayout.Padding = UDim.new(0, 4)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

function RainLib:CreateTab(tabName)
    local Tab = {}
    local Page = Instance.new("Frame", ContentHolder)
    Page.Name = tabName
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false

    local TabButton = Instance.new("TextButton", TabHolder)
    TabButton.Text = tabName
    TabButton.Size = UDim2.new(1, 0, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.BorderSizePixel = 0

    TabButton.MouseButton1Click:Connect(function()
        for _, v in pairs(ContentHolder:GetChildren()) do
            if v:IsA("Frame") then v.Visible = false end
        end
        Page.Visible = true
    end)

    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0, 6)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    function Tab:AddButton(txt, callback)
        local Button = Instance.new("TextButton", Page)
        Button.Size = UDim2.new(1, -10, 0, 30)
        Button.Text = txt
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BorderSizePixel = 0
        Button.MouseButton1Click:Connect(callback)
    end

    function Tab:AddToggle(txt, default, callback)
        local Toggle = Instance.new("TextButton", Page)
        Toggle.Size = UDim2.new(1, -10, 0, 30)
        Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.BorderSizePixel = 0

        local state = default
        Toggle.Text = txt .. " [" .. (state and "ON" or "OFF") .. "]"

        Toggle.MouseButton1Click:Connect(function()
            state = not state
            Toggle.Text = txt .. " [" .. (state and "ON" or "OFF") .. "]"
            callback(state)
        end)
    end

    function Tab:AddSlider(txt, min, max, default, callback)
        local SliderLabel = Instance.new("TextLabel", Page)
        SliderLabel.Size = UDim2.new(1, -10, 0, 30)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Text = txt .. ": " .. tostring(default)
        SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

        local SliderBar = Instance.new("Frame", Page)
        SliderBar.Size = UDim2.new(1, -10, 0, 5)
        SliderBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        SliderBar.BorderSizePixel = 0

        local Fill = Instance.new("Frame", SliderBar)
        Fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        Fill.BorderSizePixel = 0

        local dragging = false
        local function update(input)
            local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            local val = math.floor((min + ((max - min) * pos)) + 0.5)
            Fill.Size = UDim2.new(pos, 0, 1, 0)
            SliderLabel.Text = txt .. ": " .. tostring(val)
            callback(val)
        end

        SliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                update(input)
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                update(input)
            end
        end)
    end

    Page.Visible = #ContentHolder:GetChildren() == 1
    return Tab
end

return RainLib
