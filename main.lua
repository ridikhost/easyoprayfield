-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Main UI Window
local MainWindow = Rayfield:CreateWindow({
    Name = "EasyOP - Play games, your way.",
    Icon = "gamepad",
    LoadingTitle = "EasyOP - Play games, your way.",
    LoadingSubtitle = "by ShellX",
    ShowText = "EasyOP",
    Theme = "Default",

    ToggleUIKeybind = "K",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "EasyOP"
    },

    Discord = {
        Enabled = true,
        Invite = "https://discord.gg/C4RaS4ZdCE",
        RememberJoins = true
    },

    KeySystem = true,
    KeySettings = {
        Title = "Spread the word of EasyOP",
        Subtitle = "no subtitle for you bozo",
        Note = "Enter the key 'easyopisthebest'",
        FileName = "EasyOPKey",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {"easyopisthebest"}
    }
})

-- Scripts Tab
local Scripts = MainWindow:CreateTab("Scripts", "scroll")

Scripts:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        Rayfield:Notify({
            Title = "Executed Successfully",
            Content = "Infinite Yield has been loaded.",
            Duration = 3.9,
            Image = "check",
        })
    end,
})

Scripts:CreateButton({
    Name = "Nameless Admin",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()
        Rayfield:Notify({
            Title = "Executed Successfully",
            Content = "Nameless Admin has been loaded.",
            Duration = 3.9,
            Image = "check",
        })
    end,
})

-- LocalPlayer Tab
local LocalPlayer = MainWindow:CreateTab("LocalPlayer", "user")

-- SuperSpeed Toggle
LocalPlayer:CreateToggle({
    Name = "SuperSpeed",
    CurrentValue = false,
    Flag = "SuperSpeedToggle",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local function applySpeed()
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.WalkSpeed = Value and 1000 or 16
        end

        applySpeed()
        player.CharacterAdded:Connect(function()
            if Value then
                wait(0.1)
                applySpeed()
            end
        end)
    end,
})

-- SuperJump Toggle
LocalPlayer:CreateToggle({
    Name = "SuperJump",
    CurrentValue = false,
    Flag = "SuperJumpToggle",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local function applyJump()
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.JumpPower = Value and 250 or 50
        end

        applyJump()
        player.CharacterAdded:Connect(function()
            if Value then
                wait(0.1)
                applyJump()
            end
        end)
    end,
})

-- NoClip Toggle
LocalPlayer:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Flag = "NoClipToggle",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local noclip = Value
        local character = player.Character or player.CharacterAdded:Wait()

        local function noclipLoop()
            while noclip and character and character:FindFirstChild("HumanoidRootPart") and task.wait() do
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
            if character then
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end

        spawn(noclipLoop)

        player.CharacterAdded:Connect(function()
            if noclip then
                wait(0.1)
                noclipLoop()
            end
        end)
    end,
})

-- Fly Toggle
LocalPlayer:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local flying = Value

        local bodyVelocity
        local bodyGyro

        if flying then
            bodyVelocity = Instance.new("BodyVelocity", character.HumanoidRootPart)
            bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)

            bodyGyro = Instance.new("BodyGyro", character.HumanoidRootPart)
            bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            bodyGyro.CFrame = character.HumanoidRootPart.CFrame

            task.spawn(function()
                while flying do
                    task.wait()
                    local direction = (mouse.Hit.p - character.HumanoidRootPart.Position).unit
                    bodyVelocity.Velocity = direction * 50
                    bodyGyro.CFrame = CFrame.new(character.HumanoidRootPart.Position, mouse.Hit.p)
                end
            end)
        else
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end
    end,
})

-- Teleport Button (teleport to mouse position)
LocalPlayer:CreateButton({
    Name = "Teleport To Mouse",
    Callback = function()
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()
        local character = player.Character or player.CharacterAdded:Wait()

        if mouse.Hit then
            character:SetPrimaryPartCFrame(CFrame.new(mouse.Hit.p + Vector3.new(0, 5, 0)))
            Rayfield:Notify({
                Title = "Teleported!",
                Content = "Teleported to your mouse position.",
                Duration = 3,
                Image = "check"
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Could not get mouse position.",
                Duration = 3,
                Image = "error"
            })
        end
    end,
})

-- Misc Tab (Example utilities)
local Misc = MainWindow:CreateTab("Misc", "info")

-- WalkSpeed Slider
Misc:CreateSlider({
    Name = "Set WalkSpeed",
    Min = 16,
    Max = 500,
    Default = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = Value
    end,
})

-- JumpPower Slider
Misc:CreateSlider({
    Name = "Set JumpPower",
    Min = 50,
    Max = 300,
    Default = 50,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.JumpPower = Value
    end,
})

-- Reset Character Button
Misc:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local player = game.Players.LocalPlayer
        player.Character:BreakJoints()
        Rayfield:Notify({
            Title = "Character Reset",
            Content = "Your character has been reset.",
            Duration = 3,
            Image = "check"
        })
    end,
})

