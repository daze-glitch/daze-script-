local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "✦ rizx TSB panel ✦",
    Icon = 0,
    LoadingTitle = "Loading rizx TSB panel",
    LoadingSubtitle = "by rizx",
    ShowText = "rizx panel",
    Theme = "Ocean",
    ToggleUIKeybind = "K",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "rizx hub"
    },
    KeySystem = true,
    KeySettings = {
        Title = "✦ rizx TSB panel ✦ | Key ",
        Subtitle = "Key System",
        Note = "get key from our discord server.",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/MJA6t1DB"}
    }
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local spawnBlock = nil
local CurrentWalkSpeed = 16

local InfiniteJumpEnabled = false
local NoClipEnabled = false
local NoClipConnection = nil
local JumpConnection = nil

-- 🏠 HOME TAB
local MainTab = Window:CreateTab("Home", 170940874)
MainTab:CreateSection("Spawn & Utility")

MainTab:CreateButton({
    Name = "Spawn Respawn Block",
    Callback = function()
        if not LocalPlayer.Character then return end
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if spawnBlock then spawnBlock:Destroy() end

        spawnBlock = Instance.new("Part")
        spawnBlock.Size = Vector3.new(6, 1, 6)
        spawnBlock.Position = hrp.Position - Vector3.new(0, hrp.Size.Y / 2 + 0.5, 0)
        spawnBlock.Anchored = true
        spawnBlock.CanCollide = false
        spawnBlock.Transparency = 0.6
        spawnBlock.Color = Color3.new(0, 0, 0)
        spawnBlock.Name = "RespawnBlock"
        spawnBlock.Parent = workspace

        hookRespawn(LocalPlayer)
    end,
})

MainTab:CreateButton({
    Name = "Delete Respawn Block",
    Callback = function()
        if spawnBlock then
            spawnBlock:Destroy()
            spawnBlock = nil
        end
    end,
})

function hookRespawn(player)
    player.CharacterAdded:Connect(function(character)
        local hrp = character:WaitForChild("HumanoidRootPart")
        if spawnBlock then
            hrp.CFrame = spawnBlock.CFrame + Vector3.new(0, 2, 0)
        end

        local hum = character:WaitForChild("Humanoid")
        hum.WalkSpeed = CurrentWalkSpeed
    end)
end

-- 🛠️ MISC TAB
local MiscTab = Window:CreateTab("Misc", 170940874)
MiscTab:CreateSection("Movement & System")

MiscTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJumpToggle",
    Callback = function(Value)
        InfiniteJumpEnabled = Value

        if JumpConnection then
            JumpConnection:Disconnect()
            JumpConnection = nil
        end

        if Value then
            JumpConnection = UserInputService.JumpRequest:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end,
})

MiscTab:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Flag = "NoClipToggle",
    Callback = function(Value)
        NoClipEnabled = Value

        if NoClipConnection then
            NoClipConnection:Disconnect()
            NoClipConnection = nil
        end

        if Value then
            NoClipConnection = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    end,
})

MiscTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "speed",
    CurrentValue = CurrentWalkSpeed,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        CurrentWalkSpeed = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end,
})

MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end,
})
