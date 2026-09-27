-- EventNotificationUI.lua
-- Affiche les notifications d'événements

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local eventEmojis = {
    Zombies = "🧟",
    Tornado = "🌪️",
    Meteors = "☄️",
    Lava = "🌋",
    FogMonsters = "👹",
    Earthquake = "📍",
    BlizzardStorm = "❄️",
    Lightning = "⚡"
}

local function showEventNotification(eventName, eventNumber)
    -- Créer une notification temporaire
    local notifGui = Instance.new("ScreenGui")
    notifGui.Name = "EventNotif"
    notifGui.ResetOnSpawn = false
    notifGui.Parent = playerGui
    
    local notifLabel = Instance.new("TextLabel")
    notifLabel.Size = UDim2.new(1, 0, 0.15, 0)
    notifLabel.Position = UDim2.new(0, 0, 0.3, 0)
    notifLabel.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    notifLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifLabel.TextSize = 32
    notifLabel.Font = Enum.Font.GothamBold
    notifLabel.Text = eventEmojis[eventName] .. " " .. eventName .. " (#" .. eventNumber .. ")"
    notifLabel.Parent = notifGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = notifLabel
    
    -- Animation
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(
        0.3,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    
    local goal = {Size = UDim2.new(1, 0, 0.12, 0)}
    local tween = tweenService:Create(notifLabel, tweenInfo, goal)
    tween:Play()
    
    -- Supprimer après 3 secondes
    wait(3)
    notifGui:Destroy()
end

-- Écouter les notifications d'événements
local eventNotifRemote = ReplicatedStorage:WaitForChild("EventNotification")
if eventNotifRemote then
    eventNotifRemote.OnClientEvent:Connect(function(eventName, eventNumber)
        showEventNotification(eventName, eventNumber)
    end)
end

print("EventNotificationUI chargée")