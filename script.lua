local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Создание черного полупрозрачного фрейма
local loginGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
loginGui.Name = "LoginUI"

local frame = Instance.new("Frame", loginGui)
frame.Size = UDim2.new(0.4, 0, 0.3, 0)
frame.Position = UDim2.new(0.3, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5

-- Текстбокс для ввода кода
local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(0.8, 0, 0.4, 0)
textbox.Position = UDim2.new(0.1, 0, 0.3, 0)
textbox.PlaceholderText = "Enter code..."
textbox.TextScaled = true

-- Обработка кода
textbox.FocusLost:Connect(function(enterPressed)
    if enterPressed and textbox.Text == "BRADIKItop" then
        loginGui:Destroy()

        -- Основной UI
        local mainGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        mainGui.Name = "MainUI"

        local mainFrame = Instance.new("Frame", mainGui)
        mainFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
        mainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
        mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        mainFrame.BackgroundTransparency = 0.2

        -- Кнопка setSpawnLocation
        local button = Instance.new("TextButton", mainFrame)
        button.Size = UDim2.new(0.6, 0, 0.2, 0)
        button.Position = UDim2.new(0.2, 0, 0.4, 0)
        button.Text = "SetSpawnLocation"
        button.TextScaled = true

        button.MouseButton1Click:Connect(function()
            print("Spawn location set!") -- Здесь будет ваша логика
        end)
    end
end)