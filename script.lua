local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()
local LocalPlayer = game:GetService("Players").LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "Мой скрипт",
    LoadingTitle = "Загрузка...",
    LoadingSubtitle = "Это займёт пару секунд 🧠",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyScriptConfig"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Главная", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Примерные функции
local InfiniteJumpEnabled = false
local NoClipEnabled = false
local velocityEnabled = false

-- Кнопка бесконечного прыжка
MainTab:CreateToggle({
    Name = "Бесконечный прыжок",
    CurrentValue = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end
})

-- Кнопка noclip
MainTab:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Callback = function(Value)
        NoClipEnabled = Value
    end
})

-- Кнопка бустера скорости
MainTab:CreateToggle({
    Name = "Velocity",
    CurrentValue = false,
    Callback = function(Value)
        velocityEnabled = Value
        if velocityEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = 100
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

-- Блок, который можно спаунить
local spawnBlock

MiscTab:CreateButton({
    Name = "Спавн блока",
    Callback = function()
        spawnBlock = Instance.new("Part", workspace)
        spawnBlock.Size = Vector3.new(5, 1, 5)
        spawnBlock.Anchored = true
        spawnBlock.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        spawnBlock.BrickColor = BrickColor.new("Bright blue")
        print("Блок создан")
    end
})

-- 🔴 Кнопка удаления всего скрипта
MiscTab:CreateButton({
    Name = "Удалить скрипт",
    Callback = function()
        if spawnBlock then
            spawnBlock:Destroy()
            spawnBlock = nil
        end

        InfiniteJumpEnabled = false
        NoClipEnabled = false
        velocityEnabled = false

        if Window and typeof(Window) == "Instance" then
            Window:Destroy()
        end

        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end

        print("Скрипт и интерфейс успешно удалены 👌")
    end
})
