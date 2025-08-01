local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ToggleSpawnSwitchGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 120, 0, 50)
frame.Position = UDim2.new(0.5, -60, 0.5, -25)
frame.BackgroundTransparency = 1

local background = Instance.new("Frame", frame)
background.Size = UDim2.new(0, 120, 0, 30)
background.Position = UDim2.new(0, 0, 0.5, -15)
background.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
background.BorderSizePixel = 0
background.BackgroundTransparency = 0.4
background.Name = "SwitchBackground"

local dot = Instance.new("Frame", background)
dot.Size = UDim2.new(0, 28, 0, 28)
dot.Position = UDim2.new(0, 1, 0, 1)
dot.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
dot.BorderSizePixel = 0
dot.Name = "ToggleDot"

local toggled = false

-- Атрибут для активации кастомного спавна
player:SetAttribute("UseCustomSpawn", false)

background.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggled = not toggled

        -- Анимация точки
        local goal = {}
        goal.Position = toggled and UDim2.new(0, 91, 0, 1) or UDim2.new(0, 1, 0, 1)

        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local tween = game:GetService("TweenService"):Create(dot, tweenInfo, goal)
        tween:Play()

        player:SetAttribute("UseCustomSpawn", toggled)
        print("Кастомный спавн:", toggled and "Включён" or "Выключен")
    end
end)

-- Логика спавна при респавне
player.CharacterAdded:Connect(function(char)
    local spawnPos = player:GetAttribute("CustomSpawn")
    local useCustom = player:GetAttribute("UseCustomSpawn")
    if spawnPos and useCustom then
        char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(spawnPos + Vector3.new(0, 3, 0))
    end
end)
