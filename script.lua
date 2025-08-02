local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "✦ rizx TSB panel ✦",
   Icon = 0,
   LoadingTitle = "Loading rizx TSB panel",
   LoadingSubtitle = "by rizx",
   ShowText = "rizx panel",
   Theme = "Ocean",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "rizx hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
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

local MainTab = Window:CreateTab("Home", 170940874)
local Section = MainTab:CreateSection("Halooo")

local Players = game:GetService("Players")
local spawnBlock = nil

local Button = MainTab:CreateButton({
    Name = "Button Example",
    Callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            hookCharacterRespawn(player)
        end

        Players.PlayerAdded:Connect(function(player)
            hookCharacterRespawn(player)
        end)
    end,
})

function hookCharacterRespawn(player)
    player.CharacterAdded:Connect(function(character)
        local hrp = character:WaitForChild("HumanoidRootPart")

        spawnBlock = Instance.new("Part")
        spawnBlock.Size = Vector3.new(6, 1, 6)
        spawnBlock.Position = hrp.Position -- блок в позиции игрока
        spawnBlock.Anchored = true
        spawnBlock.CanCollide = false
        spawnBlock.Transparency = 0.5
        spawnBlock.Name = "RespawnBlock"
        spawnBlock.Parent = workspace

        -- Переместим игрока немного выше, чтобы он точно оказался в блоке
        hrp.CFrame = spawnBlock.CFrame + Vector3.new(0, 2, 0)
    end)
end

local MiscTab = Window:CreateTab("Misc", 170940874)
local MiscSection = MiscTab:CreateSection("Movement")

-- Кнопка бесконечного прыжка
local InfiniteJumpEnabled = false

local InfiniteJumpButton = MiscTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        InfiniteJumpEnabled = not InfiniteJumpEnabled
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local UserInputService = game:GetService("UserInputService")

        UserInputService.JumpRequest:Connect(function()
            if InfiniteJumpEnabled and LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end,
})

-- Слайдер скорости ходьбы
local WalkSpeedSlider = MiscTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 100}, -- стандартная скорость = 16
   Increment = 1,
   Suffix = "speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      local player = game:GetService("Players").LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

