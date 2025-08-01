local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- ⚙️ Авторизация
local loginGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
loginGui.Name = "LoginUI"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 400, 0, 180)
loginFrame.Position = UDim2.new(0.5, -200, 0.5, -90)
loginFrame.BackgroundColor3 = Color3.new(0, 0, 0)
loginFrame.BackgroundTransparency = 0.3
loginFrame.BorderSizePixel = 0

local textbox = Instance.new("TextBox", loginFrame)
textbox.Size = UDim2.new(0.8, 0, 0.3, 0)
textbox.Position = UDim2.new(0.1, 0, 0.35, 0)
textbox.PlaceholderText = "Введите код: BRADIKItop"
textbox.TextScaled = true
textbox.Text = ""

textbox.FocusLost:Connect(function(enterPressed)
    if enterPressed and textbox.Text == "BRADIKItop" then
        loginGui:Destroy()

        -- 🖤 Основной UI
        local mainGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        mainGui.Name = "MainUI"
        mainGui.ResetOnSpawn = false

        local mainFrame = Instance.new("Frame", mainGui)
        mainFrame.Size = UDim2.new(0, 350, 0, 250)
        mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
        mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        mainFrame.BackgroundTransparency = 0.2
        mainFrame.BorderSizePixel = 0

        local button = Instance.new("TextButton", mainFrame)
        button.Size = UDim2.new(0.6, 0, 0.2, 0)
        button.Position = UDim2.new(0.2, 0, 0.2, 0)
        button.Text = "SetSpawnLocation"
        button.TextScaled = true

        local spawnPart
        player:SetAttribute("UseCustomSpawn", false)

        -- 🔘 Переключатель
        local switchFrame = Instance.new("Frame", mainFrame)
        switchFrame.Size = UDim2.new(0, 120, 0, 30)
        switchFrame.Position = UDim2.new(0.2, 0, 0.6, 0)
        switchFrame.BackgroundTransparency = 1

        local background = Instance.new("Frame", switchFrame)
        background.Size = UDim2.new(0, 120, 0, 30)
        background.Position = UDim2.new(0, 0, 0, 0)
        background.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        background.BackgroundTransparency = 0.4
        background.BorderSizePixel = 0

        local dot = Instance.new("Frame", background)
        dot.Size = UDim2.new(0, 28, 0, 28)
        dot.Position = UDim2.new(0, 1, 0, 1)
        dot.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        dot.BorderSizePixel = 0

        local toggled = false

        background.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                toggled = not toggled

                local goal = {}
                goal.Position = toggled and UDim2.new(0, 91, 0, 1) or UDim2.new(0, 1, 0, 1)
                local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local tween = TweenService:Create(dot, tweenInfo, goal)
                tween:Play()

                player:SetAttribute("UseCustomSpawn", toggled)
            end
        end)

        -- 🔘 Кнопка установки спавн-точки
        button.MouseButton1Click:Connect(function()
            if spawnPart then spawnPart:Destroy() end

            local char = player.Character or player.CharacterAdded:Wait()
            spawnPart = Instance.new("Part", workspace)
            spawnPart.Anchored = true
            spawnPart.CanCollide = false
            spawnPart.Size = Vector3.new(6, 1, 6)
            spawnPart.Position = char.PrimaryPart.Position + Vector3.new(0, -3, 0)
            spawnPart.Transparency = 0.5
            spawnPart.BrickColor = BrickColor.new("Really black")
            spawnPart.Name = "CustomSpawn"

            player:SetAttribute("CustomSpawn", spawnPart.Position)
        end)

        -- ⚡️ Респавн
        player.CharacterAdded:Connect(function(char)
            local spawnPos = player:GetAttribute("CustomSpawn")
            local useCustom = player:GetAttribute("UseCustomSpawn")
            if spawnPos and useCustom then
                char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(spawnPos + Vector3.new(0, 3, 0))
            end
        end)
    end
end)
