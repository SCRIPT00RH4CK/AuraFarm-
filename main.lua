print("🔥 ЗАГРУЖАЮ RAYFIELD...")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 AURA FARM + ТЕЛЕПОРТ",
    Icon = 0,
    LoadingTitle = "Загрузка...",
    LoadingSubtitle = "Подождите секунду",
    Theme = "Dark",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AuraFarmTeleport",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false
})

local TeleportTab = Window:CreateTab("🚀 ТЕЛЕПОРТ")

TeleportTab:CreateSection("🔥 17 ЭТАП")

TeleportTab:CreateButton({
    Name = "🚀 ТЕЛЕПОРТ НА 17 ЭТАП",
    Callback = function()
        local LP = game:GetService("Players").LocalPlayer
        local char = LP.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if not hrp then
            Rayfield:Notify({
                Title = "❌ ОШИБКА",
                Content = "Персонаж не найден!",
                Duration = 3,
                Image = 0,
            })
            return
        end

        local targetPos = Vector3.new(-1980, 54, -20)

        pcall(function()
            hrp.CFrame = CFrame.new(targetPos)
            print("✅ Телепорт на 17 этап выполнен!")
            Rayfield:Notify({
                Title = "✅ ТЕЛЕПОРТ",
                Content = "Ты на 17 этапе!",
                Duration = 2,
                Image = 0,
            })
        end)
    end
})

local FarmTab = Window:CreateTab("💰 АВТОФАРМ")

FarmTab:CreateSection("🔥 АВТОФАРМ КЛИК")

local isClicking = false

FarmTab:CreateButton({
    Name = "🚀 ЗАПУСТИТЬ КЛИК +1",
    Callback = function()
        if isClicking then
            Rayfield:Notify({
                Title = "⚠️ УЖЕ ЗАПУЩЕН",
                Content = "Клик уже работает!",
                Duration = 2,
                Image = 0,
            })
            return
        end

        print("🚀 ЗАПУСК КЛИКА...")
        isClicking = true

        local RS = game:GetService("ReplicatedStorage")
        local remote = RS:FindFirstChild("Remotes"):FindFirstChild("AuraRunnerTrainClick")

        if not remote then
            Rayfield:Notify({
                Title = "❌ ОШИБКА",
                Content = "Remote не найден!",
                Duration = 3,
                Image = 0,
            })
            isClicking = false
            return
        end

        Rayfield:Notify({
            Title = "✅ КЛИК ЗАПУЩЕН",
            Content = "Клики отправляются!",
            Duration = 2,
            Image = 0,
        })

        local count = 0

        spawn(function()
            while isClicking do
                count = count + 1
                pcall(function()
                    remote:FireServer(1)
                    remote:FireServer({1})
                    remote:FireServer(1, {})
                    remote:FireServer({}, 1)
                end)
                if count % 100 == 0 then
                    print("📤 Отправлено: " .. count .. " кликов +1")
                end
                task.wait(0.01)
            end
        end)
    end
})

FarmTab:CreateButton({
    Name = "⏹️ ОСТАНОВИТЬ КЛИК",
    Callback = function()
        if not isClicking then
            Rayfield:Notify({
                Title = "⚠️ НЕ ЗАПУЩЕН",
                Content = "Клик не запущен!",
                Duration = 2,
                Image = 0,
            })
            return
        end

        isClicking = false
        Rayfield:Notify({
            Title = "⏹️ КЛИК ОСТАНОВЛЕН",
            Content = "Клик остановлен!",
            Duration = 2,
            Image = 0,
        })
        print("⏹️ КЛИК ОСТАНОВЛЕН")
    end
})

FarmTab:CreateSection("📊 СТАТИСТИКА")

local statLabel = FarmTab:CreateLabel("⏳ Кликов отправлено: 0")

local statCount = 0
spawn(function()
    while true do
        if isClicking then
            statCount = statCount + 1
            statLabel:Set("📊 Кликов отправлено: " .. statCount)
        end
        task.wait(1)
    end
end)

FarmTab:CreateSection("✨ ИНФОРМАЦИЯ")

FarmTab:CreateLabel("💾 Статус: Работает")

local CloseTab = Window:CreateTab("❌ ЗАКРЫТЬ")

CloseTab:CreateSection("❌ ЗАКРЫТИЕ")

CloseTab:CreateButton({
    Name = "❌ ЗАКРЫТЬ GUI",
    Callback = function()
        isClicking = false
        Window:Destroy()
    end
})

print("✅ RAYFIELD GUI ЗАГРУЖЕН")
print("🔥 Вкладки: ТЕЛЕПОРТ (17) | АВТОФАРМ | ЗАКРЫТЬ")
