local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Создание Login UI
local loginGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
loginGui.Name = "LoginUI"
loginGui.ResetOnSpawn = false

local frame = Instance.new("Frame", loginGui)
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0

-- Плавное появление
frame.BackgroundTransparency = 1
for i = 1, 10 do
    frame.BackgroundTransparency = 1 - i * 0.07
    wait(0.02)
end

local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(0.8, 0, 0.3, 0)
textbox.Position = UDim2.new(0.1, 0, 0.35, 0)
textbox.PlaceholderText = "Введите код: BRADIKItop"
textbox.TextScaled = true

-- Авторизация
textbox.FocusLost:Connect(function(enterPressed)
    if enterPressed and textbox.Text == "BRADIKItop" then
        loginGui:Destroy()

        -- Основной UI
        local mainGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        mainGui.Name = "MainUI"

        local mainFrame = Instance.new("Frame", mainGui)
        mainFrame.Size = UDim2.new(0, 350, 0, 250)
        mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
        mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        mainFrame.BackgroundTransparency = 0.2
        mainFrame.BorderSizePixel = 0

        local button = Instance.new("TextButton", mainFrame)
        button.Size = UDim2.new(0.6, 0, 0.2, 0)
        button.Position = UDim2.new(0.2, 0, 0.4, 0)
        button.Text = "SetSpawnLocation"
        button.TextScaled = true

        local spawnPart

        button.MouseButton1Click:Connect(function()
            -- Создание полупрозрачного парт
            if spawnPart then spawnPart:Destroy() end

            spawnPart = Instance.new("Part", workspace)
            spawnPart.Anchored = true
            spawnPart.CanCollide = false
            spawnPart.Size = Vector3.new(6, 1, 6)
            spawnPart.Position = character.PrimaryPart.Position + Vector3.new(0, -3, 0)
            spawnPart.Transparency = 0.5
            spawnPart.BrickColor = BrickColor.new("Really black")
            spawnPart.Name = "CustomSpawn"

            player:SetAttribute("CustomSpawn", spawnPart.Position)
        end)

        -- Механизм спавна на парт
        player.CharacterAdded:Connect(function(char)
            local spawnPos = player:GetAttribute("CustomSpawn")
            if spawnPos then
                char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(spawnPos + Vector3.new(0, 3, 0))
            end
        end)
    end
end)
