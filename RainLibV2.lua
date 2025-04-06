local Library = {}
Library.__index = Library

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

function Library:CreateWindow(options)
    local self = setmetatable({}, Library)
    self.Tabs = {}

    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "NovaLibrary"

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Name = "Main"

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = options.Title or "Nova UI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20

    self.Main = Main
    return self
end

function Library:CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 100, 0, 30)
    TabButton.Text = name
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextSize = 14
    TabButton.Parent = self.Main

    local TabFrame = Instance.new("Frame", self.Main)
    TabFrame.Size = UDim2.new(1, -20, 1, -50)
    TabFrame.Position = UDim2.new(0, 10, 0, 50)
    TabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabFrame.Visible = false

    TabButton.MouseButton1Click:Connect(function()
        for _, v in pairs(self.Tabs) do
            v.Frame.Visible = false
        end
        TabFrame.Visible = true
    end)

    local Tab = {
        Name = name,
        Frame = TabFrame
    }

    table.insert(self.Tabs, Tab)
    return Tab
end

function Library:AddButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 150, 0, 30)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.Position = UDim2.new(0, 10, 0, 10 + (#tab.Frame:GetChildren() * 35))
    Button.Parent = tab.Frame

    Button.MouseButton1Click:Connect(callback)
end

return Library
