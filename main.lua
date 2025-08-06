local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
        Enabled = false,  -- maybe I will enable it sometime
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

local Scripts = MainWindow:CreateTab("Scripts", "scroll")

local InfiniteYieldButton = Scripts:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        Rayfield:Notify({
            Title = "Executed Successfully",
            Content = "Infinite Yield has been loaded.",
            Duration = 3.9,
            Image = "check",
        })
    end,
})
local NamelessAdmin = Scripts:CreateButton({
    Name = "Nameless Admin",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source'))()
        Rayfield:Notify({
            Title = "Executed Successfully",
            Content = "Nameless Admin has been loaded.",
            Duration = 3.9,
            Image = "check",
        })
    end,
})

local LocalPlayer = MainWindow:CreateTab("LocalPlayer", "user")


local SuperSpeedToggle = LocalPlayer:CreateToggle({
    Name = "SuperSpeed",
    CurrentValue = false,
    Flag = "SuperSpeedToggle",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        if Value == true then
            humanoid.WalkSpeed = 1000
        else
            humanoid.WalkSpeed = 16
        end
    end,
})
