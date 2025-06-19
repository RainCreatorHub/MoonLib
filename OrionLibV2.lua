local success, OrionLibV2 = pcall(function()
    local OrionLibV2 = {}

    local successMakeWindow, MakeWindow = pcall(function()
        function OrionLibV2:MakeWindow(Info)
            local successInner, result = pcall(function()
                local successTweenService, TweenService = pcall(function() return game:GetService("TweenService") end)
                if not successTweenService then warn("Erro ao obter TweenService: " .. tostring(result)) return end

                local successUserInputService, UserInputService = pcall(function() return game:GetService("UserInputService") end)
                if not successUserInputService then warn("Erro ao obter UserInputService: " .. tostring(result)) return end

                local successPlayers, Players = pcall(function() return game:GetService("Players") end)
                if not successPlayers then warn("Erro ao obter Players: " .. tostring(result)) return end

                local successLocalPlayer, LocalPlayer = pcall(function() return Players.LocalPlayer end)
                if not successLocalPlayer then warn("Erro ao obter LocalPlayer: " .. tostring(result)) return end

                local successMouse, Mouse = pcall(function() return LocalPlayer:GetMouse() end)
                if not successMouse then warn("Erro ao obter Mouse: " .. tostring(result)) return end

                local successCamera, Camera = pcall(function() return game:GetService("Workspace").CurrentCamera end)
                if not successCamera then warn("Erro ao obter Camera: " .. tostring(result)) return end

                local successScreenGui, ScreenGui = pcall(function() return Instance.new("ScreenGui") end)
                if not successScreenGui then warn("Erro ao criar ScreenGui: " .. tostring(result)) return end
                pcall(function() ScreenGui.Name = "CheatGUI" end, function(err) warn("Erro ao definir Name de ScreenGui: " .. tostring(err)) end)
                pcall(function() ScreenGui.Parent = LocalPlayer.PlayerGui end, function(err) warn("Erro ao definir Parent de ScreenGui: " .. tostring(err)) end)
                pcall(function() ScreenGui.ResetOnSpawn = false end, function(err) warn("Erro ao definir ResetOnSpawn de ScreenGui: " .. tostring(err)) end)

                local successWindow, window = pcall(function() return Instance.new("Frame") end)
                if not successWindow then warn("Erro ao criar window: " .. tostring(result)) return end
                pcall(function() window.Name = "MainWindow" end, function(err) warn("Erro ao definir Name de window: " .. tostring(err)) end)
                pcall(function() window.Parent = ScreenGui end, function(err) warn("Erro ao definir Parent de window: " .. tostring(err)) end)
                pcall(function() window.Size = UDim2.new(0, 500, 0, 350) end, function(err) warn("Erro ao definir Size de window: " .. tostring(err)) end)
                pcall(function() window.Position = UDim2.new(0.5, -250, 0.5, -175) end, function(err) warn("Erro ao definir Position de window: " .. tostring(err)) end)
                pcall(function() window.BackgroundColor3 = Color3.fromRGB(30, 30, 30) end, function(err) warn("Erro ao definir BackgroundColor3 de window: " .. tostring(err)) end)
                pcall(function() window.Active = true end, function(err) warn("Erro ao definir Active de window: " .. tostring(err)) end)
                pcall(function() window.Draggable = true end, function(err) warn("Erro ao definir Draggable de window: " .. tostring(err)) end)

                local successCorner, corner = pcall(function() return Instance.new("UICorner") end)
                if not successCorner then warn("Erro ao criar corner: " .. tostring(result)) return end
                pcall(function() corner.CornerRadius = UDim.new(0, 12) end, function(err) warn("Erro ao definir CornerRadius de corner: " .. tostring(err)) end)
                pcall(function() corner.Parent = window end, function(err) warn("Erro ao definir Parent de corner: " .. tostring(err)) end)

                local successStroke, stroke = pcall(function() return Instance.new("UIStroke") end)
                if not successStroke then warn("Erro ao criar stroke: " .. tostring(result)) return end
                pcall(function() stroke.Thickness = 1.5 end, function(err) warn("Erro ao definir Thickness de stroke: " .. tostring(err)) end)
                pcall(function() stroke.Color = Color3.fromRGB(0, 0, 0) end, function(err) warn("Erro ao definir Color de stroke: " .. tostring(err)) end)
                pcall(function() stroke.Transparency = 0.4 end, function(err) warn("Erro ao definir Transparency de stroke: " .. tostring(err)) end)
                pcall(function() stroke.Parent = window end, function(err) warn("Erro ao definir Parent de stroke: " .. tostring(err)) end)

                local successGradient, gradient = pcall(function() return Instance.new("UIGradient") end)
                if not successGradient then warn("Erro ao criar gradient: " .. tostring(result)) return end
                local successColorSequence, colorSequence = pcall(function() return ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                } end)
                if not successColorSequence then warn("Erro ao criar colorSequence: " .. tostring(colorSequence)) end
                pcall(function() gradient.Color = colorSequence end, function(err) warn("Erro ao definir Color de gradient: " .. tostring(err)) end)
                pcall(function() gradient.Rotation = 90 end, function(err) warn("Erro ao definir Rotation de gradient: " .. tostring(err)) end)
                pcall(function() gradient.Parent = window end, function(err) warn("Erro ao definir Parent de gradient: " .. tostring(err)) end)

                local successTitle, Title = pcall(function() return Instance.new("TextLabel") end)
                if not successTitle then warn("Erro ao criar Title: " .. tostring(result)) return end
                pcall(function() Title.Text = Info.Title or "Orion" end, function(err) warn("Erro ao definir Text de Title: " .. tostring(err)) end)
                pcall(function() Title.Size = UDim2.new(0, 300, 0, 30) end, function(err) warn("Erro ao definir Size de Title: " .. tostring(err)) end)
                pcall(function() Title.Position = UDim2.new(0, 10, 0, 5) end, function(err) warn("Erro ao definir Position de Title: " .. tostring(err)) end)
                pcall(function() Title.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de Title: " .. tostring(err)) end)
                pcall(function() Title.TextColor3 = Color3.fromRGB(255, 255, 255) end, function(err) warn("Erro ao definir TextColor3 de Title: " .. tostring(err)) end)
                pcall(function() Title.TextXAlignment = Enum.TextXAlignment.Left end, function(err) warn("Erro ao definir TextXAlignment de Title: " .. tostring(err)) end)
                pcall(function() Title.Font = Enum.Font.GothamBold end, function(err) warn("Erro ao definir Font de Title: " .. tostring(err)) end)
                pcall(function() Title.TextSize = 20 end, function(err) warn("Erro ao definir TextSize de Title: " .. tostring(err)) end)
                pcall(function() Title.Parent = window end, function(err) warn("Erro ao definir Parent de Title: " .. tostring(err)) end)

                local successSubTitle, SubTitle = pcall(function() return Instance.new("TextLabel") end)
                if not successSubTitle then warn("Erro ao criar SubTitle: " .. tostring(result)) return end
                pcall(function() SubTitle.Text = Info.SubTitle or "Orion Subtitle" end, function(err) warn("Erro ao definir Text de SubTitle: " .. tostring(err)) end)
                pcall(function() SubTitle.Size = UDim2.new(0, 300, 0, 20) end, function(err) warn("Erro ao definir Size de SubTitle: " .. tostring(err)) end)
                pcall(function() SubTitle.Position = UDim2.new(0, 10, 0, 35) end, function(err) warn("Erro ao definir Position de SubTitle: " .. tostring(err)) end)
                pcall(function() SubTitle.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de SubTitle: " .. tostring(err)) end)
                pcall(function() SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180) end, function(err) warn("Erro ao definir TextColor3 de SubTitle: " .. tostring(err)) end)
                pcall(function() SubTitle.TextXAlignment = Enum.TextXAlignment.Left end, function(err) warn("Erro ao definir TextXAlignment de SubTitle: " .. tostring(err)) end)
                pcall(function() SubTitle.Font = Enum.Font.Gotham end, function(err) warn("Erro ao definir Font de SubTitle: " .. tostring(err)) end)
                pcall(function() SubTitle.TextSize = 14 end, function(err) warn("Erro ao definir TextSize de SubTitle: " .. tostring(err)) end)
                pcall(function() SubTitle.Parent = window end, function(err) warn("Erro ao definir Parent de SubTitle: " .. tostring(err)) end)

                local successSeparator, Separator = pcall(function() return Instance.new("Frame") end)
                if not successSeparator then warn("Erro ao criar Separator: " .. tostring(result)) return end
                pcall(function() Separator.Size = UDim2.new(1, -20, 0, 1) end, function(err) warn("Erro ao definir Size de Separator: " .. tostring(err)) end)
                pcall(function() Separator.Position = UDim2.new(0, 10, 0, 60) end, function(err) warn("Erro ao definir Position de Separator: " .. tostring(err)) end)
                pcall(function() Separator.BackgroundColor3 = Color3.fromRGB(80, 80, 80) end, function(err) warn("Erro ao definir BackgroundColor3 de Separator: " .. tostring(err)) end)
                pcall(function() Separator.Parent = window end, function(err) warn("Erro ao definir Parent de Separator: " .. tostring(err)) end)

                local successVerticalLine, VerticalLine = pcall(function() return Instance.new("Frame") end)
                if not successVerticalLine then warn("Erro ao criar VerticalLine: " .. tostring(result)) return end
                pcall(function() VerticalLine.Size = UDim2.new(0, 1, 1, -80) end, function(err) warn("Erro ao definir Size de VerticalLine: " .. tostring(err)) end)
                pcall(function() VerticalLine.Position = UDim2.new(0, 135, 0, 70) end, function(err) warn("Erro ao definir Position de VerticalLine: " .. tostring(err)) end)
                pcall(function() VerticalLine.BackgroundColor3 = Color3.fromRGB(80, 80, 80) end, function(err) warn("Erro ao definir BackgroundColor3 de VerticalLine: " .. tostring(err)) end)
                pcall(function() VerticalLine.BorderSizePixel = 0 end, function(err) warn("Erro ao definir BorderSizePixel de VerticalLine: " .. tostring(err)) end)
                pcall(function() VerticalLine.Parent = window end, function(err) warn("Erro ao definir Parent de VerticalLine: " .. tostring(err)) end)

                local successTabScrollFrame, TabScrollFrame = pcall(function() return Instance.new("ScrollingFrame") end)
                if not successTabScrollFrame then warn("Erro ao criar TabScrollFrame: " .. tostring(result)) return end
                pcall(function() TabScrollFrame.Size = UDim2.new(0, 120, 1, -80) end, function(err) warn("Erro ao definir Size de TabScrollFrame: " .. tostring(err)) end)
                pcall(function() TabScrollFrame.Position = UDim2.new(0, 10, 0, 70) end, function(err) warn("Erro ao definir Position de TabScrollFrame: " .. tostring(err)) end)
                pcall(function() TabScrollFrame.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de TabScrollFrame: " .. tostring(err)) end)
                pcall(function() TabScrollFrame.ScrollBarThickness = 4 end, function(err) warn("Erro ao definir ScrollBarThickness de TabScrollFrame: " .. tostring(err)) end)
                pcall(function() TabScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100) end, function(err) warn("Erro ao definir ScrollBarImageColor3 de TabScrollFrame: " .. tostring(err)) end)
                pcall(function() TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) end, function(err) warn("Erro ao definir CanvasSize de TabScrollFrame: " .. tostring(err)) end)
                pcall(function() TabScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y end, function(err) warn("Erro ao definir ScrollingDirection de TabScrollFrame: " .. tostring(err)) end)
                pcall(function() TabScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar end, function(err) warn("Erro ao definir VerticalScrollBarInset de TabScrollFrame: " .. tostring(err)) end)
                pcall(function() TabScrollFrame.Parent = window end, function(err) warn("Erro ao definir Parent de TabScrollFrame: " .. tostring(err)) end)

                local successButtonY, ButtonY = pcall(function() return 0 end)
                if not successButtonY then warn("Erro ao inicializar ButtonY: " .. tostring(result)) return end
                local successTabs, Tabs = pcall(function() return {} end)
                if not successTabs then warn("Erro ao inicializar Tabs: " .. tostring(result)) return end
                local successTabList, TabList = pcall(function() return {} end)
                if not successTabList then warn("Erro ao inicializar TabList: " .. tostring(result)) return end

                local successMakeTab, MakeTab = pcall(function()
                    function Tabs:MakeTab(TabInfo)
                        local successButton, Button = pcall(function() return Instance.new("TextButton") end)
                        if not successButton then warn("Erro ao criar Button: " .. tostring(result)) return end
                        pcall(function() Button.Size = UDim2.new(0, 120, 0, 30) end, function(err) warn("Erro ao definir Size de Button: " .. tostring(err)) end)
                        pcall(function() Button.Position = UDim2.new(0, 0, 0, ButtonY) end, function(err) warn("Erro ao definir Position de Button: " .. tostring(err)) end)
                        pcall(function() Button.Text = TabInfo.Name or "Tab" end, function(err) warn("Erro ao definir Text de Button: " .. tostring(err)) end)
                        pcall(function() Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end, function(err) warn("Erro ao definir BackgroundColor3 de Button: " .. tostring(err)) end)
                        pcall(function() Button.TextColor3 = Color3.fromRGB(255, 255, 255) end, function(err) warn("Erro ao definir TextColor3 de Button: " .. tostring(err)) end)
                        pcall(function() Button.Font = Enum.Font.Gotham end, function(err) warn("Erro ao definir Font de Button: " .. tostring(err)) end)
                        pcall(function() Button.TextSize = 14 end, function(err) warn("Erro ao definir TextSize de Button: " .. tostring(err)) end)
                        pcall(function() Button.AutoButtonColor = false end, function(err) warn("Erro ao definir AutoButtonColor de Button: " .. tostring(err)) end)
                        pcall(function() Button.Parent = TabScrollFrame end, function(err) warn("Erro ao definir Parent de Button: " .. tostring(err)) end)

                        local successButtonCorner, buttonCorner = pcall(function() return Instance.new("UICorner") end)
                        if not successButtonCorner then warn("Erro ao criar buttonCorner: " .. tostring(result)) return end
                        pcall(function() buttonCorner.CornerRadius = UDim.new(0, 6) end, function(err) warn("Erro ao definir CornerRadius de buttonCorner: " .. tostring(err)) end)
                        pcall(function() buttonCorner.Parent = Button end, function(err) warn("Erro ao definir Parent de buttonCorner: " .. tostring(err)) end)

                        local successNewButtonY, newButtonY = pcall(function() return ButtonY + 35 end)
                        if not successNewButtonY then warn("Erro ao calcular newButtonY: " .. tostring(result)) return end
                        pcall(function() ButtonY = newButtonY end, function(err) warn("Erro ao atribuir newButtonY a ButtonY: " .. tostring(err)) end)
                        pcall(function() TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ButtonY) end, function(err) warn("Erro ao definir CanvasSize de TabScrollFrame: " .. tostring(err)) end)

                        local successTabContent, TabContent = pcall(function() return Instance.new("ScrollingFrame") end)
                        if not successTabContent then warn("Erro ao criar TabContent: " .. tostring(result)) return end
                        pcall(function() TabContent.Name = TabInfo.Name or "TabContent" end, function(err) warn("Erro ao definir Name de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.Size = UDim2.new(1, -145, 1, -80) end, function(err) warn("Erro ao definir Size de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.Position = UDim2.new(0, 145, 0, 70) end, function(err) warn("Erro ao definir Position de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de TabContent: " .. tostring(err)) end)
                        local successTabListLength, tabListLength = pcall(function() return #TabList end)
                        if not successTabListLength then warn("Erro ao obter comprimento de TabList: " .. tostring(result)) return end
                        pcall(function() TabContent.Visible = (tabListLength == 0) end, function(err) warn("Erro ao definir Visible de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.ScrollBarThickness = 4 end, function(err) warn("Erro ao definir ScrollBarThickness de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100) end, function(err) warn("Erro ao definir ScrollBarImageColor3 de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.CanvasSize = UDim2.new(0, 0, 0, 0) end, function(err) warn("Erro ao definir CanvasSize de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.ScrollingDirection = Enum.ScrollingDirection.Y end, function(err) warn("Erro ao definir ScrollingDirection de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar end, function(err) warn("Erro ao definir VerticalScrollBarInset de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.ClipsDescendants = true end, function(err) warn("Erro ao definir ClipsDescendants de TabContent: " .. tostring(err)) end)
                        pcall(function() TabContent.Parent = window end, function(err) warn("Erro ao definir Parent de TabContent: " .. tostring(err)) end)
                        pcall(function() table.insert(TabList, TabContent) end, function(err) warn("Erro ao inserir TabContent em TabList: " .. tostring(err)) end)

                        local successClickConnection, clickConnection = pcall(function()
                            return Button.MouseButton1Click:Connect(function()
                                local successTabLoop, tabLoopResult = pcall(function()
                                    for _, f in ipairs(TabList) do
                                        pcall(function() f.Visible = false end, function(err) warn("Erro ao definir Visible de TabList item: " .. tostring(err)) end)
                                    end
                                end)
                                if not successTabLoop then warn("Erro no loop de TabList: " .. tostring(tabLoopResult)) end
                                pcall(function() TabContent.Visible = true end, function(err) warn("Erro ao definir Visible de TabContent: " .. tostring(err)) end)
                                local successBtnLoop, btnLoopResult = pcall(function()
                                    for _, btn in ipairs(TabScrollFrame:GetChildren()) do
                                        pcall(function()
                                            if btn:IsA("TextButton") then
                                                pcall(function() btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end, function(err) warn("Erro ao definir BackgroundColor3 de btn: " .. tostring(err)) end)
                                            end
                                        end, function(err) warn("Erro ao verificar IsA de btn: " .. tostring(err)) end)
                                    end
                                end)
                                if not successBtnLoop then warn("Erro no loop de botões: " .. tostring(btnLoopResult)) end
                                pcall(function() Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70) end, function(err) warn("Erro ao definir BackgroundColor3 de Button: " .. tostring(err)) end)
                            end)
                        end)
                        if not successClickConnection then warn("Erro ao conectar MouseButton1Click: " .. tostring(clickConnection)) end

                        local successElementY, elementY = pcall(function() return 0 end)
                        if not successElementY then warn("Erro ao inicializar elementY: " .. tostring(result)) return end
                        local successTabFunctions, TabFunctions = pcall(function() return {} end)
                        if not successTabFunctions then warn("Erro ao inicializar TabFunctions: " .. tostring(result)) return end

                        local successRecalculateCanvasSize, RecalculateCanvasSize = pcall(function()
                            local function RecalculateCanvasSize()
                                local successTotalHeight, totalHeight = pcall(function() return 0 end)
                                if not successTotalHeight then warn("Erro ao inicializar totalHeight: " .. tostring(result)) return end
                                local successChildLoop, childLoopResult = pcall(function()
                                    for _, child in ipairs(TabContent:GetChildren()) do
                                        pcall(function()
                                            if child:IsA("Frame") and child.Visible then
                                                local successChildBottom, childBottom = pcall(function() return child.Position.Y.Offset + child.Size.Y.Offset end)
                                                if not successChildBottom then warn("Erro ao calcular childBottom: " .. tostring(childBottom)) end
                                                local successMax, maxResult = pcall(function() return math.max(totalHeight, childBottom) end)
                                                if not successMax then warn("Erro ao calcular max para totalHeight: " .. tostring(maxResult)) end
                                                pcall(function() totalHeight = maxResult end, function(err) warn("Erro ao atribuir maxResult a totalHeight: " .. tostring(err)) end)
                                            end
                                        end, function(err) warn("Erro ao verificar IsA de child: " .. tostring(err)) end)
                                    end
                                end)
                                if not successChildLoop then warn("Erro no loop de filhos: " .. tostring(childLoopResult)) end
                                local successFinalMax, finalMaxResult = pcall(function() return math.max(totalHeight, elementY) + 20 end)
                                if not successFinalMax then warn("Erro ao calcular finalMax: " .. tostring(finalMaxResult)) end
                                local successCanvasSize, canvasSize = pcall(function() return UDim2.new(0, 0, 0, finalMaxResult) end)
                                if not successCanvasSize then warn("Erro ao criar UDim2 para CanvasSize: " .. tostring(canvasSize)) end
                                pcall(function() TabContent.CanvasSize = canvasSize end, function(err) warn("Erro ao definir CanvasSize de TabContent: " .. tostring(err)) end)
                            end
                            return RecalculateCanvasSize
                        end)
                        if not successRecalculateCanvasSize then warn("Erro ao definir RecalculateCanvasSize: " .. tostring(result)) return end

                        local successAddSection, AddSection = pcall(function()
                            function TabFunctions:AddSection(info)
                                local successContainer, container = pcall(function() return Instance.new("Frame", TabContent) end)
                                if not successContainer then warn("Erro ao criar container: " .. tostring(result)) return end
                                pcall(function() container.Size = UDim2.new(1, -20, 0, 25) end, function(err) warn("Erro ao definir Size de container: " .. tostring(err)) end)
                                pcall(function() container.Position = UDim2.new(0, 10, 0, elementY + 20) end, function(err) warn("Erro ao definir Position de container: " .. tostring(err)) end)
                                pcall(function() container.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de container: " .. tostring(err)) end)
                                pcall(function() container.BorderSizePixel = 0 end, function(err) warn("Erro ao definir BorderSizePixel de container: " .. tostring(err)) end)

                                local successSectionLabel, sectionLabel = pcall(function() return Instance.new("TextLabel", container) end)
                                if not successSectionLabel then warn("Erro ao criar sectionLabel: " .. tostring(result)) return end
                                pcall(function() sectionLabel.Text = info.Name or "Section" end, function(err) warn("Erro ao definir Text de sectionLabel: " .. tostring(err)) end)
                                pcall(function() sectionLabel.Size = UDim2.new(1, 0, 1, 0) end, function(err) warn("Erro ao definir Size de sectionLabel: " .. tostring(err)) end)
                                pcall(function() sectionLabel.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de sectionLabel: " .. tostring(err)) end)
                                pcall(function() sectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200) end, function(err) warn("Erro ao definir TextColor3 de sectionLabel: " .. tostring(err)) end)
                                pcall(function() sectionLabel.Font = Enum.Font.GothamBold end, function(err) warn("Erro ao definir Font de sectionLabel: " .. tostring(err)) end)
                                pcall(function() sectionLabel.TextSize = 16 end, function(err) warn("Erro ao definir TextSize de sectionLabel: " .. tostring(err)) end)
                                pcall(function() sectionLabel.TextXAlignment = Enum.TextXAlignment.Center end, function(err) warn("Erro ao definir TextXAlignment de sectionLabel: " .. tostring(err)) end)
                                pcall(function() sectionLabel.TextTransparency = 1 end, function(err) warn("Erro ao definir TextTransparency de sectionLabel: " .. tostring(err)) end)

                                local successTween, tweenResult = pcall(function()
                                    return TweenService:Create(sectionLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0})
                                end)
                                if not successTween then warn("Erro ao criar tween para sectionLabel: " .. tostring(tweenResult)) end
                                pcall(function() tweenResult:Play() end, function(err) warn("Erro ao reproduzir tween para sectionLabel: " .. tostring(err)) end)

                                local successNewElementY, newElementY = pcall(function() return elementY + 30 end)
                                if not successNewElementY then warn("Erro ao calcular newElementY: " .. tostring(result)) return end
                                pcall(function() elementY = newElementY end, function(err) warn("Erro ao atribuir newElementY a elementY: " .. tostring(err)) end)
                                pcall(function() RecalculateCanvasSize() end, function(err) warn("Erro ao chamar RecalculateCanvasSize: " .. tostring(err)) end)
                                return container
                            end
                            return AddSection
                        end)
                        if not successAddSection then warn("Erro ao definir AddSection: " .. tostring(result)) return end
                        pcall(function() TabFunctions.AddSection = AddSection end, function(err) warn("Erro ao atribuir AddSection a TabFunctions: " .. tostring(err)) end)

                        local successAddLabel, AddLabel = pcall(function()
                            function TabFunctions:AddLabel(info)
                                local successContainer, container = pcall(function() return Instance.new("Frame") end)
                                if not successContainer then warn("Erro ao criar container: " .. tostring(result)) return end
                                pcall(function() container.Size = UDim2.new(1, -20, 0, 50) end, function(err) warn("Erro ao definir Size de container: " .. tostring(err)) end)
                                pcall(function() container.Position = UDim2.new(0, 10, 0, elementY + 20) end, function(err) warn("Erro ao definir Position de container: " .. tostring(err)) end)
                                pcall(function() container.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end, function(err) warn("Erro ao definir BackgroundColor3 de container: " .. tostring(err)) end)
                                pcall(function() container.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de container: " .. tostring(err)) end)
                                pcall(function() container.BorderSizePixel = 0 end, function(err) warn("Erro ao definir BorderSizePixel de container: " .. tostring(err)) end)
                                pcall(function() container.ZIndex = 1 end, function(err) warn("Erro ao definir ZIndex de container: " .. tostring(err)) end)
                                pcall(function() container.Parent = TabContent end, function(err) warn("Erro ao definir Parent de container: " .. tostring(err)) end)

                                local successStroke, stroke = pcall(function() return Instance.new("UIStroke") end)
                                if not successStroke then warn("Erro ao criar stroke: " .. tostring(result)) return end
                                pcall(function() stroke.Color = Color3.fromRGB(80, 80, 80) end, function(err) warn("Erro ao definir Color de stroke: " .. tostring(err)) end)
                                pcall(function() stroke.Thickness = 1.5 end, function(err) warn("Erro ao definir Thickness de stroke: " .. tostring(err)) end)
                                pcall(function() stroke.Parent = container end, function(err) warn("Erro ao definir Parent de stroke: " .. tostring(err)) end)

                                local successCorner, corner = pcall(function() return Instance.new("UICorner") end)
                                if not successCorner then warn("Erro ao criar corner: " .. tostring(result)) return end
                                pcall(function() corner.CornerRadius = UDim.new(0, 6) end, function(err) warn("Erro ao definir CornerRadius de corner: " .. tostring(err)) end)
                                pcall(function() corner.Parent = container end, function(err) warn("Erro ao definir Parent de corner: " .. tostring(err)) end)

                                local successNameLabels, nameLabels = pcall(function() return {} end)
                                if not successNameLabels then warn("Erro ao inicializar nameLabels: " .. tostring(result)) return end
                                local successContentLabels, contentLabels = pcall(function() return {} end)
                                if not successContentLabels then warn("Erro ao inicializar contentLabels: " .. tostring(result)) return end

                                local successCreateTextLabel, createTextLabel = pcall(function()
                                    local function createTextLabel(text, font, textSize, color, position, parent)
                                        local successLabel, label = pcall(function() return Instance.new("TextLabel") end)
                                        if not successLabel then warn("Erro ao criar label: " .. tostring(result)) return end
                                        pcall(function() label.Text = text end, function(err) warn("Erro ao definir Text de label: " .. tostring(err)) end)
                                        pcall(function() label.Size = UDim2.new(1, -10, 0, 0) end, function(err) warn("Erro ao definir Size de label: " .. tostring(err)) end)
                                        pcall(function() label.Position = position end, function(err) warn("Erro ao definir Position de label: " .. tostring(err)) end)
                                        pcall(function() label.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de label: " .. tostring(err)) end)
                                        pcall(function() label.TextColor3 = color end, function(err) warn("Erro ao definir TextColor3 de label: " .. tostring(err)) end)
                                        pcall(function() label.Font = font end, function(err) warn("Erro ao definir Font de label: " .. tostring(err)) end)
                                        pcall(function() label.TextSize = textSize end, function(err) warn("Erro ao definir TextSize de label: " .. tostring(err)) end)
                                        pcall(function() label.TextXAlignment = Enum.TextXAlignment.Left end, function(err) warn("Erro ao definir TextXAlignment de label: " .. tostring(err)) end)
                                        pcall(function() label.TextTransparency = 1 end, function(err) warn("Erro ao definir TextTransparency de label: " .. tostring(err)) end)
                                        pcall(function() label.TextWrapped = true end, function(err) warn("Erro ao definir TextWrapped de label: " .. tostring(err)) end)
                                        pcall(function() label.ZIndex = 1 end, function(err) warn("Erro ao definir ZIndex de label: " .. tostring(err)) end)
                                        pcall(function() label.Parent = parent end, function(err) warn("Erro ao definir Parent de label: " .. tostring(err)) end)
                                        return label
                                    end
                                    return createTextLabel
                                end)
                                if not successCreateTextLabel then warn("Erro ao definir createTextLabel: " .. tostring(result)) return end

                                local successSplitText, splitText = pcall(function()
                                    local function splitText(text, label, maxWidth)
                                        local successTextCheck, textCheck = pcall(function() return not text or text == "" end)
                                        if not successTextCheck then warn("Erro ao verificar text: " .. tostring(textCheck)) return {""} end
                                        if textCheck then return {""} end
                                        local successChars, chars = pcall(function() return {} end)
                                        if not successChars then warn("Erro ao inicializar chars: " .. tostring(result)) return {""} end
                                        local successCharLoop, charLoopResult = pcall(function()
                                            for char in text:gmatch("[\128-\191]*.") do
                                                pcall(function() table.insert(chars, char) end, function(err) warn("Erro ao inserir char em chars: " .. tostring(err)) end)
                                            end
                                        end)
                                        if not successCharLoop then warn("Erro no loop de chars: " .. tostring(charLoopResult)) return {""} end
                                        local successLines, lines = pcall(function() return {""} end)
                                        if not successLines then warn("Erro ao inicializar lines: " .. tostring(result)) return {""} end
                                        local successCurrentLine, currentLine = pcall(function() return 1 end)
                                        if not successCurrentLine then warn("Erro ao inicializar currentLine: " .. tostring(result)) return {""} end
                                        local successLineLoop, lineLoopResult = pcall(function()
                                            for _, char in ipairs(chars) do
                                                local successTestText, testText = pcall(function() return lines[currentLine] .. char end)
                                                if not successTestText then warn("Erro ao concatenar testText: " .. tostring(testText)) end
                                                pcall(function() label.Text = testText end, function(err) warn("Erro ao definir Text de label: " .. tostring(err)) end)
                                                task.wait()
                                                local successBounds, bounds = pcall(function() return label.TextBounds.X <= maxWidth end)
                                                if not successBounds then warn("Erro ao verificar TextBounds: " .. tostring(bounds)) end
                                                if bounds then
                                                    pcall(function() lines[currentLine] = testText end, function(err) warn("Erro ao atribuir testText a lines: " .. tostring(err)) end)
                                                else
                                                    local successNewLine, newLine = pcall(function() return currentLine + 1 end)
                                                    if not successNewLine then warn("Erro ao calcular newLine: " .. tostring(newLine)) end
                                                    pcall(function() currentLine = newLine end, function(err) warn("Erro ao atribuir newLine a currentLine: " .. tostring(err)) end)
                                                    pcall(function() lines[currentLine] = char end, function(err) warn("Erro ao atribuir char a lines: " .. tostring(err)) end)
                                                end
                                            end
                                        end)
                                        if not successLineLoop then warn("Erro no loop de linhas: " .. tostring(lineLoopResult)) return {""} end
                                        pcall(function() label.Text = text end, function(err) warn("Erro ao restaurar Text de label: " .. tostring(err)) end)
                                        return lines
                                    end
                                    return splitText
                                end)
                                if not successSplitText then warn("Erro ao definir splitText: " .. tostring(result)) return end

                                local successAdjustTextLabels, adjustTextLabels = pcall(function()
                                    local function adjustTextLabels()
                                        local successNameLoop, nameLoopResult = pcall(function()
                                            for _, label in ipairs(nameLabels) do
                                                pcall(function() label:Destroy() end, function(err) warn("Erro ao destruir nameLabel: " .. tostring(err)) end)
                                            end
                                        end)
                                        if not successNameLoop then warn("Erro no loop de nameLabels: " .. tostring(nameLoopResult)) end
                                        local successContentLoop, contentLoopResult = pcall(function()
                                            for _, label in ipairs(contentLabels) do
                                                pcall(function() label:Destroy() end, function(err) warn("Erro ao destruir contentLabel: " .. tostring(err)) end)
                                            end
                                        end)
                                        if not successContentLoop then warn("Erro no loop de contentLabels: " .. tostring(contentLoopResult)) end
                                        pcall(function() nameLabels = {} end, function(err) warn("Erro ao reinicializar nameLabels: " .. tostring(err)) end)
                                        pcall(function() contentLabels = {} end, function(err) warn("Erro ao reinicializar contentLabels: " .. tostring(err)) end)

                                        local successNameText, nameText = pcall(function() return info.Name or "Label" end)
                                        if not successNameText then warn("Erro ao obter nameText: " .. tostring(nameText)) end
                                        local successTempNameLabel, tempNameLabel = pcall(function() return createTextLabel(nameText, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 5, 0, 5), container) end)
                                        if not successTempNameLabel then warn("Erro ao criar tempNameLabel: " .. tostring(tempNameLabel)) end
                                        local successMaxWidth, maxWidth = pcall(function() return container.AbsoluteSize.X - 10 end)
                                        if not successMaxWidth then warn("Erro ao calcular maxWidth: " .. tostring(maxWidth)) end
                                        local successNameLines, nameLines = pcall(function() return splitText(nameText, tempNameLabel, maxWidth) end)
                                        if not successNameLines then warn("Erro ao obter nameLines: " .. tostring(nameLines)) end
                                        pcall(function() tempNameLabel:Destroy() end, function(err) warn("Erro ao destruir tempNameLabel: " .. tostring(err)) end)

                                        local successYOffset, yOffset = pcall(function() return 5 end)
                                        if not successYOffset then warn("Erro ao inicializar yOffset: " .. tostring(result)) return end
                                        local successNameLineLoop, nameLineLoopResult = pcall(function()
                                            for i, line in ipairs(nameLines) do
                                                local successNameLabel, nameLabel = pcall(function() return createTextLabel(line, Enum.Font.GothamBold, 14, Color3.fromRGB(255, 255, 255), UDim2.new(0, 5, 0, yOffset), container) end)
                                                if not successNameLabel then warn("Erro ao criar nameLabel: " .. tostring(nameLabel)) end
                                                local successTextBounds, textBounds = pcall(function() return nameLabel.TextBounds.Y or 14 end)
                                                if not successTextBounds then warn("Erro ao obter TextBounds de nameLabel: " .. tostring(textBounds)) end
                                                pcall(function() nameLabel.Size = UDim2.new(1, -10, 0, textBounds) end, function(err) warn("Erro ao definir Size de nameLabel: " .. tostring(err)) end)
                                                pcall(function() table.insert(nameLabels, nameLabel) end, function(err) warn("Erro ao inserir nameLabel em nameLabels: " .. tostring(err)) end)
                                                local successNewOffset, newOffset = pcall(function() return yOffset + textBounds + 2 end)
                                                if not successNewOffset then warn("Erro ao calcular newOffset: " .. tostring(newOffset)) end
                                                pcall(function() yOffset = newOffset end, function(err) warn("Erro ao atribuir newOffset a yOffset: " .. tostring(err)) end)
                                                local successTweenCreate, tweenCreate = pcall(function() return TweenService:Create(nameLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}) end)
                                                if not successTweenCreate then warn("Erro ao criar tween para nameLabel: " .. tostring(tweenCreate)) end
                                                pcall(function() tweenCreate:Play() end, function(err) warn("Erro ao reproduzir tween para nameLabel: " .. tostring(err)) end)
                                            end
                                        end)
                                        if not successNameLineLoop then warn("Erro no loop de nameLines: " .. tostring(nameLineLoopResult)) end

                                        local successContentText, contentText = pcall(function() return info.Content or "Texto" end)
                                        if not successContentText then warn("Erro ao obter contentText: " .. tostring(contentText)) end
                                        local successTempContentLabel, tempContentLabel = pcall(function() return createTextLabel(contentText, Enum.Font.Gotham, 13, Color3.fromRGB(180, 180, 180), UDim2.new(0, 5, 0, yOffset), container) end)
                                        if not successTempContentLabel then warn("Erro ao criar tempContentLabel: " .. tostring(tempContentLabel)) end
                                        local successContentLines, contentLines = pcall(function() return splitText(contentText, tempContentLabel, maxWidth) end)
                                        if not successContentLines then warn("Erro ao obter contentLines: " .. tostring(contentLines)) end
                                        pcall(function() tempContentLabel:Destroy() end, function(err) warn("Erro ao destruir tempContentLabel: " .. tostring(err)) end)

                                        local successContentLineLoop, contentLineLoopResult = pcall(function()
                                            for i, line in ipairs(contentLines) do
                                                local successContentLabel, contentLabel = pcall(function() return createTextLabel(line, Enum.Font.Gotham, 13, Color3.fromRGB(180, 180, 180), UDim2.new(0, 5, 0, yOffset), container) end)
                                                if not successContentLabel then warn("Erro ao criar contentLabel: " .. tostring(contentLabel)) end
                                                local successContentBounds, contentBounds = pcall(function() return contentLabel.TextBounds.Y or 13 end)
                                                if not successContentBounds then warn("Erro ao obter TextBounds de contentLabel: " .. tostring(contentBounds)) end
                                                pcall(function() contentLabel.Size = UDim2.new(1, -10, 0, contentBounds) end, function(err) warn("Erro ao definir Size de contentLabel: " .. tostring(err)) end)
                                                pcall(function() table.insert(contentLabels, contentLabel) end, function(err) warn("Erro ao inserir contentLabel em contentLabels: " .. tostring(err)) end)
                                                local successNewContentOffset, newContentOffset = pcall(function() return yOffset + contentBounds + 2 end)
                                                if not successNewContentOffset then warn("Erro ao calcular newContentOffset: " .. tostring(newContentOffset)) end
                                                pcall(function() yOffset = newContentOffset end, function(err) warn("Erro ao atribuir newContentOffset a yOffset: " .. tostring(err)) end)
                                                local successContentTweenCreate, contentTweenCreate = pcall(function() return TweenService:Create(contentLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}) end)
                                                if not successContentTweenCreate then warn("Erro ao criar tween para contentLabel: " .. tostring(contentTweenCreate)) end
                                                pcall(function() contentTweenCreate:Play() end, function(err) warn("Erro ao reproduzir tween para contentLabel: " .. tostring(err)) end)
                                            end
                                        end)
                                        if not successContentLineLoop then warn("Erro no loop de contentLines: " .. tostring(contentLineLoopResult)) end

                                        local successContainerSize, containerSize = pcall(function() return math.max(50, yOffset + 5) end)
                                        if not successContainerSize then warn("Erro ao calcular containerSize: " .. tostring(containerSize)) end
                                        pcall(function() container.Size = UDim2.new(1, -20, 0, containerSize) end, function(err) warn("Erro ao definir Size de container: " .. tostring(err)) end)
                                    end
                                    return adjustTextLabels
                                end)
                                if not successAdjustTextLabels then warn("Erro ao definir adjustTextLabels: " .. tostring(result)) return end

                                pcall(function() adjustTextLabels() end, function(err) warn("Erro ao chamar adjustTextLabels: " .. tostring(err)) end)

                                local successSizeChangedConnection, sizeChangedConnection = pcall(function()
                                    return container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                                        pcall(function() adjustTextLabels() end, function(err) warn("Erro ao ajustar labels no evento SizeChanged: " .. tostring(err)) end)
                                        pcall(function() RecalculateCanvasSize() end, function(err) warn("Erro ao chamar RecalculateCanvasSize no evento SizeChanged: " .. tostring(err)) end)
                                    end)
                                end)
                                if not successSizeChangedConnection then warn("Erro ao conectar evento AbsoluteSize: " .. tostring(sizeChangedConnection)) end

                                local successContainerTween, containerTweenResult = pcall(function()
                                    return TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0})
                                end)
                                if not successContainerTween then warn("Erro ao criar tween para container: " .. tostring(containerTweenResult)) end
                                pcall(function() containerTweenResult:Play() end, function(err) warn("Erro ao reproduzir tween para container: " .. tostring(err)) end)

                                local successNewElementY, newElementY = pcall(function() return elementY + container.Size.Y.Offset + 10 end)
                                if not successNewElementY then warn("Erro ao calcular newElementY: " .. tostring(newElementY)) return end
                                pcall(function() elementY = newElementY end, function(err) warn("Erro ao atribuir newElementY a elementY: " .. tostring(err)) end)
                                pcall(function() RecalculateCanvasSize() end, function(err) warn("Erro ao chamar RecalculateCanvasSize: " .. tostring(err)) end)
                                return container
                            end
                            return AddLabel
                        end)
                        if not successAddLabel then warn("Erro ao definir AddLabel: " .. tostring(result)) return end
                        pcall(function() TabFunctions.AddLabel = AddLabel end, function(err) warn("Erro ao atribuir AddLabel a TabFunctions: " .. tostring(err)) end)

                        local successAddButton, AddButton = pcall(function()
                            function TabFunctions:AddButton(info)
                                local successContainer, container = pcall(function() return Instance.new("Frame") end)
                                if not successContainer then warn("Erro ao criar container: " .. tostring(result)) return end
                                pcall(function() container.Size = UDim2.new(1, -20, 0, 50) end, function(err) warn("Erro ao definir Size de container: " .. tostring(err)) end)
                                pcall(function() container.Position = UDim2.new(0, 10, 0, elementY + 20) end, function(err) warn("Erro ao definir Position de container: " .. tostring(err)) end)
                                pcall(function() container.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end, function(err) warn("Erro ao definir BackgroundColor3 de container: " .. tostring(err)) end)
                                pcall(function() container.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de container: " .. tostring(err)) end)
                                pcall(function() container.BorderSizePixel = 0 end, function(err) warn("Erro ao definir BorderSizePixel de container: " .. tostring(err)) end)
                                pcall(function() container.ZIndex = 1 end, function(err) warn("Erro ao definir ZIndex de container: " .. tostring(err)) end)
                                pcall(function() container.Parent = TabContent end, function(err) warn("Erro ao definir Parent de container: " .. tostring(err)) end)

                                local successStroke, stroke = pcall(function() return Instance.new("UIStroke") end)
                                if not successStroke then warn("Erro ao criar stroke: " .. tostring(result)) return end
                                pcall(function() stroke.Color = Color3.fromRGB(80, 80, 80) end, function(err) warn("Erro ao definir Color de stroke: " .. tostring(err)) end)
                                pcall(function() stroke.Thickness = 1.5 end, function(err) warn("Erro ao definir Thickness de stroke: " .. tostring(err)) end)
                                pcall(function() stroke.Parent = container end, function(err) warn("Erro ao definir Parent de stroke: " .. tostring(err)) end)

                                local successCorner, corner = pcall(function() return Instance.new("UICorner") end)
                                if not successCorner then warn("Erro ao criar corner: " .. tostring(result)) return end
                                pcall(function() corner.CornerRadius = UDim.new(0, 6) end, function(err) warn("Erro ao definir CornerRadius de corner: " .. tostring(err)) end)
                                pcall(function() corner.Parent = container end, function(err) warn("Erro ao definir Parent de corner: " .. tostring(err)) end)

                                local successButton, button = pcall(function() return Instance.new("TextButton") end)
                                if not successButton then warn("Erro ao criar button: " .. tostring(result)) return end
                                pcall(function() button.Size = UDim2.new(1, -10, 1, -10) end, function(err) warn("Erro ao definir Size de button: " .. tostring(err)) end)
                                pcall(function() button.Position = UDim2.new(0, 5, 0, 5) end, function(err) warn("Erro ao definir Position de button: " .. tostring(err)) end)
                                pcall(function() button.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end, function(err) warn("Erro ao definir BackgroundColor3 de button: " .. tostring(err)) end)
                                pcall(function() button.TextColor3 = Color3.fromRGB(255, 255, 255) end, function(err) warn("Erro ao definir TextColor3 de button: " .. tostring(err)) end)
                                pcall(function() button.Font = Enum.Font.GothamBold end, function(err) warn("Erro ao definir Font de button: " .. tostring(err)) end)
                                pcall(function() button.TextSize = 14 end, function(err) warn("Erro ao definir TextSize de button: " .. tostring(err)) end)
                                pcall(function() button.Text = info.Name or "Button" end, function(err) warn("Erro ao definir Text de button: " .. tostring(err)) end)
                                pcall(function() button.TextXAlignment = Enum.TextXAlignment.Left end, function(err) warn("Erro ao definir TextXAlignment de button: " .. tostring(err)) end)
                                pcall(function() button.AutoButtonColor = false end, function(err) warn("Erro ao definir AutoButtonColor de button: " .. tostring(err)) end)
                                pcall(function() button.BorderSizePixel = 0 end, function(err) warn("Erro ao definir BorderSizePixel de button: " .. tostring(err)) end)
                                pcall(function() button.TextTransparency = 1 end, function(err) warn("Erro ao definir TextTransparency de button: " .. tostring(err)) end)
                                pcall(function() button.BackgroundTransparency = 0.3 end, function(err) warn("Erro ao definir BackgroundTransparency de button: " .. tostring(err)) end)
                                pcall(function() button.ClipsDescendants = true end, function(err) warn("Erro ao definir ClipsDescendants de button: " .. tostring(err)) end)
                                pcall(function() button.ZIndex = 1 end, function(err) warn("Erro ao definir ZIndex de button: " .. tostring(err)) end)
                                pcall(function() button.Parent = container end, function(err) warn("Erro ao definir Parent de button: " .. tostring(err)) end)

                                local successButtonCorner, buttonCorner = pcall(function() return Instance.new("UICorner") end)
                                if not successButtonCorner then warn("Erro ao criar buttonCorner: " .. tostring(result)) return end
                                pcall(function() buttonCorner.CornerRadius = UDim.new(0, 6) end, function(err) warn("Erro ao definir CornerRadius de buttonCorner: " .. tostring(err)) end)
                                pcall(function() buttonCorner.Parent = button end, function(err) warn("Erro ao definir Parent de buttonCorner: " .. tostring(err)) end)

                                local successContainerTween, containerTweenResult = pcall(function()
                                    return TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0})
                                end)
                                if not successContainerTween then warn("Erro ao criar tween para container: " .. tostring(containerTweenResult)) end
                                pcall(function() containerTweenResult:Play() end, function(err) warn("Erro ao reproduzir tween para container: " .. tostring(err)) end)

                                local successButtonTween, buttonTweenResult = pcall(function()
                                    return TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0, BackgroundTransparency = 0})
                                end)
                                if not successButtonTween then warn("Erro ao criar tween para button: " .. tostring(buttonTweenResult)) end
                                pcall(function() buttonTweenResult:Play() end, function(err) warn("Erro ao reproduzir tween para button: " .. tostring(err)) end)

                                local successMouseEnterConnection, mouseEnterConnection = pcall(function()
                                    return button.MouseEnter:Connect(function()
                                        local successEnterTween, enterTweenResult = pcall(function()
                                            return TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)})
                                        end)
                                        if not successEnterTween then warn("Erro ao criar tween para MouseEnter: " .. tostring(enterTweenResult)) end
                                        pcall(function() enterTweenResult:Play() end, function(err) warn("Erro ao reproduzir tween para MouseEnter: " .. tostring(err)) end)
                                    end)
                                end)
                                if not successMouseEnterConnection then warn("Erro ao conectar MouseEnter: " .. tostring(mouseEnterConnection)) end

                                local successMouseLeaveConnection, mouseLeaveConnection = pcall(function()
                                    return button.MouseLeave:Connect(function()
                                        local successLeaveTween, leaveTweenResult = pcall(function()
                                            return TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
                                        end)
                                        if not successLeaveTween then warn("Erro ao criar tween para MouseLeave: " .. tostring(leaveTweenResult)) end
                                        pcall(function() leaveTweenResult:Play() end, function(err) warn("Erro ao reproduzir tween para MouseLeave: " .. tostring(err)) end)
                                    end)
                                end)
                                if not successMouseLeaveConnection then warn("Erro ao conectar MouseLeave: " .. tostring(mouseLeaveConnection)) end

                                if info.Callback and typeof(info.Callback) == "function" then
                                    local successClickConnection, clickConnection = pcall(function()
                                        return button.MouseButton1Click:Connect(function()
                                            pcall(function() info.Callback() end, function(err) warn("Erro ao executar callback do botão: " .. tostring(err)) end)
                                        end)
                                    end)
                                    if not successClickConnection then warn("Erro ao conectar MouseButton1Click: " .. tostring(clickConnection)) end
                                end

                                local successNewElementY, newElementY = pcall(function() return elementY + 60 end)
                                if not successNewElementY then warn("Erro ao calcular newElementY: " .. tostring(newElementY)) return end
                                pcall(function() elementY = newElementY end, function(err) warn("Erro ao atribuir newElementY a elementY: " .. tostring(err)) end)
                                pcall(function() RecalculateCanvasSize() end, function(err) warn("Erro ao chamar RecalculateCanvasSize: " .. tostring(err)) end)
                                return container
                            end
                            return AddButton
                        end)
                        if not successAddButton then warn("Erro ao definir AddButton: " .. tostring(result)) return end
                        pcall(function() TabFunctions.AddButton = AddButton end, function(err) warn("Erro ao atribuir AddButton a TabFunctions: " .. tostring(err)) end)

                        local successAddToggle, AddToggle = pcall(function()
                            function TabFunctions:AddToggle(info)
                                local successContainer, container = pcall(function() return Instance.new("Frame") end)
                                if not successContainer then warn("Erro ao criar container: " .. tostring(result)) return end
                                pcall(function() container.Size = UDim2.new(1, -20, 0, 50) end, function(err) warn("Erro ao definir Size de container: " .. tostring(err)) end)
                                pcall(function() container.Position = UDim2.new(0, 10, 0, elementY + 20) end, function(err) warn("Erro ao definir Position de container: " .. tostring(err)) end)
                                pcall(function() container.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end, function(err) warn("Erro ao definir BackgroundColor3 de container: " .. tostring(err)) end)
                                pcall(function() container.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de container: " .. tostring(err)) end)
                                pcall(function() container.BorderSizePixel = 0 end, function(err) warn("Erro ao definir BorderSizePixel de container: " .. tostring(err)) end)
                                pcall(function() container.ZIndex = 1 end, function(err) warn("Erro ao definir ZIndex de container: " .. tostring(err)) end)
                                pcall(function() container.Parent = TabContent end, function(err) warn("Erro ao definir Parent de container: " .. tostring(err)) end)

                                local successStroke, stroke = pcall(function() return Instance.new("UIStroke") end)
                                if not successStroke then warn("Erro ao criar stroke: " .. tostring(result)) return end
                                pcall(function() stroke.Color = Color3.fromRGB(80, 80, 80) end, function(err) warn("Erro ao definir Color de stroke: " .. tostring(err)) end)
                                pcall(function() stroke.Thickness = 1.5 end, function(err) warn("Erro ao definir Thickness de stroke: " .. tostring(err)) end)
                                pcall(function() stroke.Parent = container end, function(err) warn("Erro ao definir Parent de stroke: " .. tostring(err)) end)

                                local successCorner, corner = pcall(function() return Instance.new("UICorner") end)
                                if not successCorner then warn("Erro ao criar corner: " .. tostring(result)) return end
                                pcall(function() corner.CornerRadius = UDim.new(0, 6) end, function(err) warn("Erro ao definir CornerRadius de corner: " .. tostring(err)) end)
                                pcall(function() corner.Parent = container end, function(err) warn("Erro ao definir Parent de corner: " .. tostring(err)) end)

                                local successToggleButton, toggleButton = pcall(function() return Instance.new("TextButton") end)
                                if not successToggleButton then warn("Erro ao criar toggleButton: " .. tostring(result)) return end
                                pcall(function() toggleButton.Size = UDim2.new(0, 50, 0, 24) end, function(err) warn("Erro ao definir Size de toggleButton: " .. tostring(err)) end)
                                pcall(function() toggleButton.Position = UDim2.new(1, -60, 0.5, -12) end, function(err) warn("Erro ao definir Position de toggleButton: " .. tostring(err)) end)
                                pcall(function() toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end, function(err) warn("Erro ao definir BackgroundColor3 de toggleButton: " .. tostring(err)) end)
                                pcall(function() toggleButton.BorderSizePixel = 0 end, function(err) warn("Erro ao definir BorderSizePixel de toggleButton: " .. tostring(err)) end)
                                pcall(function() toggleButton.AutoButtonColor = false end, function(err) warn("Erro ao definir AutoButtonColor de toggleButton: " .. tostring(err)) end)
                                pcall(function() toggleButton.Text = "" end, function(err) warn("Erro ao definir Text de toggleButton: " .. tostring(err)) end)
                                pcall(function() toggleButton.ClipsDescendants = true end, function(err) warn("Erro ao definir ClipsDescendants de toggleButton: " .. tostring(err)) end)
                                pcall(function() toggleButton.ZIndex = 1 end, function(err) warn("Erro ao definir ZIndex de toggleButton: " .. tostring(err)) end)
                                pcall(function() toggleButton.Parent = container end, function(err) warn("Erro ao definir Parent de toggleButton: " .. tostring(err)) end)

                                local successToggleCorner, toggleCorner = pcall(function() return Instance.new("UICorner") end)
                                if not successToggleCorner then warn("Erro ao criar toggleCorner: " .. tostring(result)) return end
                                pcall(function() toggleCorner.CornerRadius = UDim.new(0, 12) end, function(err) warn("Erro ao definir CornerRadius de toggleCorner: " .. tostring(err)) end)
                                pcall(function() toggleCorner.Parent = toggleButton end, function(err) warn("Erro ao definir Parent de toggleCorner: " .. tostring(err)) end)

                                local successToggleIndicator, toggleIndicator = pcall(function() return Instance.new("Frame") end)
                                if not successToggleIndicator then warn("Erro ao criar toggleIndicator: " .. tostring(result)) return end
                                pcall(function() toggleIndicator.Size = UDim2.new(0, 20, 0, 20) end, function(err) warn("Erro ao definir Size de toggleIndicator: " .. tostring(err)) end)
                                pcall(function() toggleIndicator.Position = UDim2.new(0, 2, 0.5, -10) end, function(err) warn("Erro ao definir Position de toggleIndicator: " .. tostring(err)) end)
                                pcall(function() toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255) end, function(err) warn("Erro ao definir BackgroundColor3 de toggleIndicator: " .. tostring(err)) end)
                                pcall(function() toggleIndicator.BorderSizePixel = 0 end, function(err) warn("Erro ao definir BorderSizePixel de toggleIndicator: " .. tostring(err)) end)
                                pcall(function() toggleIndicator.ZIndex = 1 end, function(err) warn("Erro ao definir ZIndex de toggleIndicator: " .. tostring(err)) end)
                                pcall(function() toggleIndicator.Parent = toggleButton end, function(err) warn("Erro ao definir Parent de toggleIndicator: " .. tostring(err)) end)

                                local successIndicatorCorner, indicatorCorner = pcall(function() return Instance.new("UICorner") end)
                                if not successIndicatorCorner then warn("Erro ao criar indicatorCorner: " .. tostring(result)) return end
                                pcall(function() indicatorCorner.CornerRadius = UDim.new(0, 10) end, function(err) warn("Erro ao definir CornerRadius de indicatorCorner: " .. tostring(err)) end)
                                pcall(function() indicatorCorner.Parent = toggleIndicator end, function(err) warn("Erro ao definir Parent de indicatorCorner: " .. tostring(err)) end)

                                local successIsOn, isOn = pcall(function() return info.Default or false end)
                                if not successIsOn then warn("Erro ao inicializar isOn: " .. tostring(result)) return end
                                local successToggleBackgroundColor, toggleBackgroundColor = pcall(function() return isOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50) end)
                                if not successToggleBackgroundColor then warn("Erro ao inicializar toggleBackgroundColor: " .. tostring(result)) return end

                                local successNameLabels, nameLabels = pcall(function() return {} end)
                                if not successNameLabels then warn("Erro ao inicializar nameLabels: " .. tostring(result)) return end
                                local successDescriptionLabels, descriptionLabels = pcall(function() return {} end)
                                if not successDescriptionLabels then warn("Erro ao inicializar descriptionLabels: " .. tostring(result)) return end

                                local successCreateTextLabel, createTextLabel = pcall(function()
                                    local function createTextLabel(text, font, textSize, color, position, parent)
                                        local successLabel, label = pcall(function() return Instance.new("TextLabel") end)
                                        if not successLabel then warn("Erro ao criar label: " .. tostring(result)) return end
                                        pcall(function() label.Text = text end, function(err) warn("Erro ao definir Text de label: " .. tostring(err)) end)
                                        pcall(function() label.Size = UDim2.new(1, -60, 0, 0) end, function(err) warn("Erro ao definir Size de label: " .. tostring(err)) end)
                                        pcall(function() label.Position = position end, function(err) warn("Erro ao definir Position de label: " .. tostring(err)) end)
                                        pcall(function() label.BackgroundTransparency = 1 end, function(err) warn("Erro ao definir BackgroundTransparency de label: " .. tostring(err)) end)
                                        pcall(function() label.TextColor3 = color end, function(err) warn("Erro ao definir TextColor3 de label: " .. tostring(err)) end)
                                        pcall(function() label.Font = font end, function(err) warn("Erro ao definir Font de label: " .. tostring(err)) end)
                                        pcall(function() label.TextSize = textSize end, function(err) warn("Erro ao definir TextSize de label: " .. tostring(err)) end)
                                        pcall(function() label.TextXAlignment = Enum.TextXAlignment.Left end, function(err) warn("Erro ao definir TextXAlignment de label: " .. tostring(err)) end)
                                        pcall(function() label.TextTransparency = 1 end, function(err) warn("Erro ao definir TextTransparency de label: " .. tostring(err)) end)
                                        pcall(function() label.TextWrapped = true end, function(err) warn("Erro ao definir TextWrapped de label: " .. tostring(err)) end)
                                        pcall(function() label.ZIndex = 1 end, function(err) warn("Erro ao definir ZIndex de label: " .. tostring(err)) end)
                                        pcall(function() label.Parent = parent end, function(err) warn("Erro ao definir Parent de label: " .. tostring(err)) end)
                                        return label
                                    end
                                    return createTextLabel
                                end)
                                if not successCreateTextLabel then warn("Erro ao definir createTextLabel: " .. tostring(result)) return end

                                local successSplitText, splitText = pcall(function()
                                    local function splitText(text, label, maxWidth)
                                        local successTextCheck, textCheck = pcall(function() return not text or text == "" end)
                                        if not successTextCheck then warn("Erro ao verificar text: " .. tostring(textCheck)) return {""} end
                                        if textCheck then return {""} end
                                        local successChars, chars = pcall(function() return {} end)
                                        if not successChars then warn("Erro ao inicializar chars: " .. tostring(result)) return {""} end
                                        local successCharLoop, charLoopResult = pcall(function()
                                            for char in text:gmatch("[\128-\191]*.") do
                                                pcall(function() table.insert(chars, char) end, function(err) warn("Erro ao inserir char em chars: " .. tostring(err)) end)
                                            end
                                        end)
                                        if not successCharLoop then warn("Erro no loop de chars: " .. tostring(charLoopResult)) return {""} end
                                        local successLines, lines = pcall(function() return {""} end)
                                        if not successLines then warn("Erro ao inicializar lines: " .. tostring(result)) return {""} end
                                        local successCurrentLine, currentLine = pcall(function() return 1 end)
                                        if not successCurrentLine then warn("Erro ao inicializar currentLine: " .. tostring(result)) return {""} end
                                        local successLineLoop, lineLoopResult = pcall(function()
                                            for _, char in ipairs(chars) do
                                                local successTestText, testText = pcall(function() return lines[currentLine] .. char end)
                                                if not successTestText then warn("Erro ao concatenar testText: " .. tostring(testText)) end
                                                pcall(function() label.Text = testText end, function(err) warn("Erro ao definir Text de label: " .. tostring(err)) end)
                                                task.wait()
                                                local successBounds, bounds = pcall(function() return label.TextBounds.X <= maxWidth end)
                                                if not successBounds then warn("Erro ao verificar TextBounds: " .. tostring(bounds)) end
                                                if bounds then
                                                    pcall(function() lines[currentLine] = testText end, function(err) warn("Erro ao atribuir testText a lines: " .. tostring(err)) end)
                                                else
                                                    local successNewLine, newLine = pcall(function() return currentLine + 1 end)
                                                    if not successNewLine then warn("Erro ao calcular newLine: " .. tostring(newLine)) end
                                                    pcall(function() currentLine = newLine end, function(err) warn("Erro ao atribuir newLine a currentLine: " .. tostring(err)) end)
                                                    pcall(function() lines[currentLine] = char end, function(err) warn("Erro ao atribuir char a lines: " .. tostring(err)) end)
                                                end
                                            end
                                        end)
                                        if not successLineLoop then warn("Erro no loop de linhas: " .. tostring(lineLoopResult)) return {""} end
                                        pcall(function() label.Text = text end, function(err) warn("Erro ao restaurar Text de label: " .. tostring(err)) end)
                                        return lines
                                    end
                                    return splitText
                                end)
                                if not successSplitText then warn("Erro ao definir splitText: " .. tostring(result)) return end

                                local successAdjustTextLabels, adjustTextLabels = pcall(function()
                                    local function adjustTextLabels()
                                        local successNameLoop, nameLoopResult = pcall(function()
                                            for _, label in ipairs(nameLabels) do
                                                pcall(function() label:Destroy() end, function(err) warn("Erro ao destruir nameLabel: " .. tostring(err)) end)
                                            end
                                        end)
                                        if not successNameLoop then warn("Erro no loop de nameLabels: " .. tostring(nameLoopResult)) end
                                        local successDescLoop, descLoopResult = pcall(function()
                                            for _, label in ipairs(descriptionLabels) do
                                                pcall(function() label:Destroy() end, function(err) warn("Erro ao destruir descriptionLabel: " .. tostring(err)) end)
                                            end
                                        end)
                                        if not successDescLoop then warn("Erro no loop de descriptionLabels: " .. tostring(descLoopResult)) end
                                        pcall(function() nameLabels = {} end, function(err) warn("Erro ao reinicializar nameLabels: " .. tostring(err)) end)
                                        pcall(function() descriptionLabels = {} end, function(err) warn("Erro ao reinicializar descriptionLabels: " .. tostring(err)) end)

                                        local successNameText, nameText = pcall(function() return info.Name or "Toggle" end)
                                        if not successNameText then warn("Erro ao obter nameText: " .. tostring(nameText)) end
                                        local successTempNameLabel, tempNameLabel = pcall(function
