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
        Enabled = false, -- Optional future setting
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
