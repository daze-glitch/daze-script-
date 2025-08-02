-- 📦 Загрузка интерфейса Rayfield
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()
local LocalPlayer = game:GetService("Players").LocalPlayer

-- 🔧 Создание основного окна
local Window = Rayfield:CreateWindow({
    Name = "Мой скрипт",
    LoadingTitle = "Загрузка...",
    LoadingSubtitle = "Подожди немного 🎮",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyScriptConfig"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- 🗂️ Создание вкладок
local MainTab = Window:CreateTab("Главная", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- ⚙️ Переменные
local InfiniteJumpEnabled = false
local NoClipEnabled = false
local velocityEnabled = false
local spawnBlock

-- 🚀 Функции на вкладке "Главная"
MainTab:CreateToggle({
    Name = "Бесконечный прыжок",
    CurrentValue = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end
})

MainTab:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Callback = function(Value)
        NoClipEnabled = Value
    end
})

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

-- 🧱 Кнопка спавна блока
MiscTab:CreateButton({
    Name = "Спавн блока",
    Callback = function()
        spawnBlock = Instance.new("Part", workspace)
        spawnBlock.Size = Vector3.new(5, 1, 5)
        spawnBlock.Anchored = true
        spawnBlock.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        spawnBlock.BrickColor = BrickColor.new("Bright blue")
        print("Блок заспавнен")
    end
})

-- 💣 Кнопка удаления всего
MiscTab:CreateButton({
    Name = "Удалить скрипт",
    Callback = function()
        -- Удаление блока
        if spawnBlock then
            spawnBlock:Destroy()
            spawnBlock = nil
        end

        -- Отключение флагов
        InfiniteJumpEnabled = false
        NoClipEnabled = false
        velocityEnabled = false

        -- Удаление интерфейса
        if Window and typeof(Window) == "Instance" then
            Window:Destroy()
        end

        -- Возврат скорости персонажа
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end

        print("Скрипт и интерфейс удалены успешно 👌")
    end
})
