-- Services
local Players    = game:GetService("Players")
local TweenSvc   = game:GetService("TweenService")

-- Player
local player     = Players.LocalPlayer
local playerGui  = player:WaitForChild("PlayerGui")

-- UTILITY: Tween helper
local function tween(instance, props, duration, style, dir)
    local info = TweenInfo.new(duration or .25, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out)
    return TweenSvc:Create(instance, info, props)
end

-- LOGIN UI
local loginGui = Instance.new("ScreenGui")
loginGui.Name        = "LoginUI"
loginGui.ResetOnSpawn = false
loginGui.Parent      = playerGui

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size              = UDim2.new(0, 300, 0, 150)
loginFrame.Position          = UDim2.new(0.5, -150, 0.5, -75)
loginFrame.BackgroundColor3  = Color3.new(0, 0, 0)
loginFrame.BackgroundTransparency = 0.5

-- Rounded corners
local loginCorner = Instance.new("UICorner", loginFrame)
loginCorner.CornerRadius = UDim.new(0, 12)

-- Label "Submit Key"
local lblSubmit = Instance.new("TextLabel", loginFrame)
lblSubmit.Size              = UDim2.new(1,  0, 0, 40)
lblSubmit.Position          = UDim2.new(0,  0, 0,  0)
lblSubmit.BackgroundTransparency = 1
lblSubmit.Text              = "Submit Key"
lblSubmit.TextScaled        = true
lblSubmit.TextColor3        = Color3.new(1, 1, 1)

-- TextBox for code
local txtKey = Instance.new("TextBox", loginFrame)
txtKey.Size              = UDim2.new(0.8, 0, 0, 36)
txtKey.Position          = UDim2.new(0.1, 0, 0,  60)
txtKey.PlaceholderText   = "Enter BRADIKItop"
txtKey.Text              = ""
txtKey.TextScaled        = true
txtKey.BackgroundColor3  = Color3.fromRGB(30, 30, 30)
txtKey.BackgroundTransparency = 0.3

local keyCorner = Instance.new("UICorner", txtKey)
keyCorner.CornerRadius = UDim.new(0, 8)

-- LOGIN LOGIC
txtKey.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    if txtKey.Text == "BRADIKItop" then
        loginGui:Destroy()
        ::SHOW_MAIN_UI::
    else
        txtKey.Text = ""
        txtKey.PlaceholderText = "Wrong key"
    end
end)

-- MAIN PANEL
::SHOW_MAIN_UI::
local mainGui = Instance.new("ScreenGui")
mainGui.Name        = "MainUI"
mainGui.ResetOnSpawn = false
mainGui.Parent      = playerGui

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size              = UDim2.new(0, 400, 0, 260)
mainFrame.Position          = UDim2.new(0.5, -200, 0.5, -130)
mainFrame.BackgroundColor3  = Color3.new(0, 0, 0)
mainFrame.BackgroundTransparency = 0.5

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)

-- Title "daze panel"
local lblTitle = Instance.new("TextLabel", mainFrame)
lblTitle.Size              = UDim2.new(1,  0, 0, 40)
lblTitle.Position          = UDim2.new(0,  0, 0,  0)
lblTitle.BackgroundTransparency = 1
lblTitle.Text              = "daze panel"
lblTitle.TextScaled        = true
lblTitle.TextColor3        = Color3.new(1, 1, 1)

-- Label "SetSpawnPoint"
local lblSpawn = Instance.new("TextLabel", mainFrame)
lblSpawn.Size              = UDim2.new(0.6, 0, 0, 36)
lblSpawn.Position          = UDim2.new(0.1, 0, 0,  80)
lblSpawn.BackgroundTransparency = 1
lblSpawn.Text              = "SetSpawnPoint"
lblSpawn.TextScaled        = true
lblSpawn.TextColor3        = Color3.new(1, 1, 1)

-- Toggle Switch Container
local swFrame = Instance.new("Frame", mainFrame)
swFrame.Size              = UDim2.new(0, 120, 0, 36)
swFrame.Position          = UDim2.new(0.75, -60, 0,  76)
swFrame.BackgroundTransparency = 1

-- Switch Background
local swBg = Instance.new("Frame", swFrame)
swBg.Size              = UDim2.new(1, 0, 1, 0)
swBg.Position          = UDim2.new(0, 0, 0, 0)
swBg.BackgroundColor3  = Color3.fromRGB(50, 50, 50)
swBg.BackgroundTransparency = 0.3

local bgCorner = Instance.new("UICorner", swBg)
bgCorner.CornerRadius = UDim.new(0, 18)

-- Switch Dot
local swDot = Instance.new("Frame", swBg)
swDot.Size              = UDim2.new(0, 28, 0, 28)
swDot.Position          = UDim2.new(0, 2,  0, 2)
swDot.BackgroundColor3  = Color3.fromRGB(200, 200, 200)

local dotCorner = Instance.new("UICorner", swDot)
dotCorner.CornerRadius = UDim.new(0, 14)

-- Attributes & State
player:SetAttribute("UseCustomSpawn", false)
local spawnPart, toggled = nil, false

-- Toggle logic
swBg.InputBegan:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    toggled = not toggled
    player:SetAttribute("UseCustomSpawn", toggled)

    -- animate dot
    local targetX = toggled and (swBg.AbsoluteSize.X - swDot.AbsoluteSize.X - 2) or 2
    tween(swDot, { Position = UDim2.new(0, targetX, 0, 2) }):Play()

    -- on enable: create / update spawn part
    if toggled then
        if spawnPart then spawnPart:Destroy() end
        local char = player.Character or player.CharacterAdded:Wait()
        spawnPart = Instance.new("Part", workspace)
        spawnPart.Size        = Vector3.new(6, 1, 6)
        spawnPart.Anchored    = true
        spawnPart.CanCollide  = false
        spawnPart.BrickColor  = BrickColor.new("Really black")
        spawnPart.Transparency= 0.5
        spawnPart.Position    = char.PrimaryPart.Position + Vector3.new(0, -3, 0)
        player:SetAttribute("CustomSpawn", spawnPart.Position)
    else
        if spawnPart then
            spawnPart:Destroy()
            spawnPart = nil
        end
    end
end)

-- Respawn handler
player.CharacterAdded:Connect(function(char)
    local useCustom = player:GetAttribute("UseCustomSpawn")
    local pos       = player:GetAttribute("CustomSpawn")
    if useCustom and pos then
        char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    end
end)
