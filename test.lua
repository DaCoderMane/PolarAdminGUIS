local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Version = loadstring("return 'V1.1'")()
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local Noclip = false

local Options = Fluent.Options

local Window = Fluent:CreateWindow({
    Title = "Polar Admin " .. Version, -- Use the retrieved version information
    SubTitle = "by Polar Studios",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.RightShift -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Utilities = Window:AddTab({ Title = "Utilities", Icon = "settings" }),
    PolarStudios = Window:AddTab({ Title = "Other Polar Scripts", Icon = "" }),
    UniversalScripts = Window:AddTab({ Title = "Universal Scripts", Icon = "" }),
    BladeBall = Window:AddTab({ Title = "Blade Ball", Icon = "" }),
    Arsenal = Window:AddTab({ Title = "Arsenal", Icon = "" }),
    BloxFruits = Window:AddTab({ Title = "BloxFruits", Icon = "" }),
    Dahood = Window:AddTab({ Title = "DaHood", Icon = "" }),
    Info = Window:AddTab({ Title = "Info", Icon = "info" })
}

do
    Tabs.Player:AddParagraph({
        Title = "Player Tab",
        Content = "This is a simple Tab letting you edit: \n Walkspeed, \n Jumppower/Jumpheight, \n Hipheight, \n and toggle noclip."
    })

    local WalkSpeedSlider = Tabs.Player:AddSlider("Slider", {
        Title = "Walkspeed",
        Description = "This will set your walkspeed.",
        Default = 16,
        Min = 0,
        Max = 500,
        Rounding = 1,
        Callback = function(WalkSpeed)
            local walkspeedValue = tonumber(WalkSpeed)
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkspeedValue or 16
            end
        end
    })

    local WalkSpeedInput = Tabs.Player:AddInput("Input", {
        Title = "Walkspeed",
        Default = "",
        Placeholder = "16",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(WalkSpeedTXT)
            local walkspeedNUM = tonumber(WalkSpeedTXT)
            WalkSpeedSlider:SetValue(walkspeedNUM or 16)
        end
    })

    local JumpPowerSlider = Tabs.Player:AddSlider("Slider", {
        Title = "Jumppower",
        Description = "This will set your jumppower.",
        Default = 50,
        Min = 0,
        Max = 500,
        Rounding = 1,
        Callback = function(JumpPower)
            local jumppowerValue = tonumber(JumpPower)
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").JumpPower = jumppowerValue or 50
            end
        end
    })

    local JumpPowerInput = Tabs.Player:AddInput("Input", {
        Title = "Jumppower",
        Default = "",
        Placeholder = "50",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(JumpPowerTXT)
            local jumppowerNUM = tonumber(JumpPowerTXT)
            JumpPowerSlider:SetValue(jumppowerNUM or 50)
        end
    })

    local HipHeightSlider = Tabs.Player:AddSlider("Slider", {
        Title = "Hipheight",
        Description = "This will set your hipheight.",
        Default = 0,
        Min = 0,
        Max = 500,
        Rounding = 1,
        Callback = function(HipHeightTXT)
            local HipHeightNUM = tonumber(HipHeightTXT)
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").HipHeight = HipHeightNUM or 0
            end
        end
    })

    local HipHeightInput = Tabs.Player:AddInput("Input", {
        Title = "Hipheight",
        Default = "",
        Placeholder = "0",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(HipHeightTXT)
            local HipHeightNUM = tonumber(HipHeightTXT)
            HipHeightSlider:SetValue(HipHeightNUM or 0)
        end
    })

    local NoclipToggle = Tabs.Player:AddToggle("Noclip", {
        Title = "Noclip",
        Default = false,
        Callback = function(enabled)
            if enabled then
                Noclip = true
                if player.Character then
                    player.Character.Torso.CanCollide = false;
                    player.Character.Head.CanCollide = false
                end
            else
                Noclip = false
                if player.Character then
                    player.Character.Torso.CanCollide = true;
                    player.Character.Head.CanCollide = true
                end
            end
        end
    })

local RejoinButton = Tabs.Utilities:AddButton({
        Title = "Rejoin",
        Description = "Rejoins the game",
        Callback = function()
            Window:Dialog({
                Title = "Polar Admin",
                Content = "Are you sure you want to rejoin?",
                Buttons = {
                    {
                        Title = "Yes",
                        Callback = function()
                            Fluent:Notify({
                            Title = "Polar Admin",
                            Content = "Rejoining...",
                            Duration = 8
                        })
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
                        end
                    },
                    {
                        Title = "No",
                        Callback = function()
                            Fluent:Notify({
                            Title = "Polar Admin",
                            Content = "Rejoin Canceled",
                            Duration = 8
                        })
                        end
                    }
                }
            })
        end
    })

local RejoinButton = Tabs.Info:AddButton({
        Title = "Discord",
        Description = "Copys the discord invite to your clipboard",
        Callback = function()
            setclipboard("https://discord.gg/63pT8eeVkJ")
            local Request = syn and syn.request or request
            Request({
                Url = "http://127.0.0.1:6463/rpc?v=1",
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["Origin"] = "https://discord.com"
                },
                Body = game.HttpService:JSONEncode({
                    cmd = "INVITE_BROWSER",
                    args = {
                        code = "63pT8eeVkJ"
                    },
                    nonce = game.HttpService:GenerateGUID(false)
                }),
            })
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Automatically joined discord, if it didn't work the link has been copied to your clipboard.",
            Duration = 8
        })
        end
    })

local RainAdminV1 = Tabs.PolarStudios:AddButton({
        Title = "Polar Admin (PRISON LIFE)",
        Description = "Executes Polar Admin (PRISON LIFE)",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DaCoderMane/MyRobloxScripts/main/PolarAdminPRISONLIFE.lua"))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed Polar Admin (PRISON LIFE).",
            Duration = 8
        })
        end
    })

local RainAdminV1 = Tabs.PolarStudios:AddButton({
        Title = "Polar Admin (PRISON LIFE V3)",
        Description = "Executes Polar Admin (PRISON LIFE V3)",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DaCoderMane/MyRobloxScripts/main/PolarAdminPLV3.lua"))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed Polar Admin (PRISON LIFE V3)",
            Duration = 8
        })
        end
    })

local InfiniteYeild = Tabs.UniversalScripts:AddButton({
        Title = "Infinite Yeild",
        Description = "Executes Infinite Yeild",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed Infinite Yeild.",
            Duration = 8
        })
        end
    })

local AutoParryFFJ = Tabs.BladeBall:AddButton({
        Title = "AutoParry by FFJ",
        Description = "Executes AutoParry",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FFJ1/Roblox-Exploits/main/scripts/Loader.lua"))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed Auto Parry by FFJ.",
            Duration = 8
        })
        end
    })

local AirHub = Tabs.Arsenal:AddButton({
        Title = "Air Hub",
        Description = "Executes Air Hub",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed Air Hub.",
            Duration = 8
        })
        end
    })

local LegHub = Tabs.Arsenal:AddButton({
        Title = "LegHub",
        Description = "Executes LegHub",
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/cris123452/my/main/cas'))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed LegHub.",
            Duration = 8
        })
        end
    })

local WinterHub = Tabs.BloxFruits:AddButton({
        Title = "Winter Hub",
        Description = "Executes Winter Hub",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Yatsuraa/Yuri/main/Winterhub_V2.lua"))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed Winter Hub.",
            Duration = 8
        })
        end
    })

local Dimagx = Tabs.Dahood:AddButton({
        Title = "Dimagx",
        Description = "Executes Dimagx",
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Dimag16/DimagX_NEW/main/dimagx', true))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed Dimagx.",
            Duration = 8
        })
        end
    })

local CapsLock = Tabs.Dahood:AddButton({
        Title = "CapsLock",
        Description = "Executes CapsLock",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/whoiscapslock/capslock/main/main", true))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed CapsLock.",
            Duration = 8
        })
        end
    })

local Polakya = Tabs.Dahood:AddButton({
        Title = "Polakya",
        Description = "Executes Polakya",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/pixelheadx/Polakya/main/Bestscript.md"))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed Polakya.",
            Duration = 8
        })
        end
    })
    
local CapsLockCamlock = Tabs.Dahood:AddButton({
        Title = "CapsLock Camlock",
        Description = "Executes CapsLock Camlock",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DaCoderMane/MyRobloxScripts/main/dahoodaimlock.lua"))()
            Fluent:Notify({
            Title = "Polar Admin",
            Content = "Executed CapsLock Camlock.",
            Duration = 8
        })
        end
    })
end

Fluent:Notify({
    Title = "Polar Admin",
    Content = "Key System Loaded",
    SubContent = "Join the discord",
    Duration = 8
})

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        if Noclip and player.Character then 
            player.Character.Torso.CanCollide = false;
            player.Character.Head.CanCollide = false
        end
    end)
end)

SaveManager:LoadAutoloadConfig()
