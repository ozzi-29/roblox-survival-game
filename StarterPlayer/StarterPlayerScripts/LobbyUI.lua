-- LobbyUI.lua
-- Interface du lobby

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LobbyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Titre
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0.15, 0)
titleLabel.Position = UDim2.new(0, 0, 0.05, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
titleLabel.TextSize = 48
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "🎮 SURVIVAL GAME"
titleLabel.Parent = screenGui

-- Afficher les crédits
local creditsLabel = Instance.new("TextLabel")
creditsLabel.Name = "Credits"
creditsLabel.Size = UDim2.new(0.3, 0, 0.08, 0)
creditsLabel.Position = UDim2.new(0.65, 0, 0.05, 0)
creditsLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
creditsLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
creditsLabel.TextSize = 20
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.Text = "Crédits: 0"
creditsLabel.Parent = screenGui

-- Bouton Jouer
local playButton = Instance.new("TextButton")
playButton.Name = "PlayButton"
playButton.Size = UDim2.new(0.3, 0, 0.1, 0)
playButton.Position = UDim2.new(0.35, 0, 0.3, 0)
playButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.TextSize = 24
playButton.Font = Enum.Font.GothamBold
playButton.Text = "▶ JOUER"
playButton.Parent = screenGui

-- Bouton Shop
local shopButton = Instance.new("TextButton")
shopButton.Name = "ShopButton"
shopButton.Size = UDim2.new(0.3, 0, 0.1, 0)
shopButton.Position = UDim2.new(0.35, 0, 0.45, 0)
shopButton.BackgroundColor3 = Color3.fromRGB(200, 100, 200)
shopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
shopButton.TextSize = 24
shopButton.Font = Enum.Font.GothamBold
shopButton.Text = "🛍 SHOP"
shopButton.Parent = screenGui

-- Bouton Stats
local statsButton = Instance.new("TextButton")
statsButton.Name = "StatsButton"
statsButton.Size = UDim2.new(0.3, 0, 0.1, 0)
statsButton.Position = UDim2.new(0.35, 0, 0.6, 0)
statsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
statsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
statsButton.TextSize = 24
statsButton.Font = Enum.Font.GothamBold
statsButton.Text = "📊 STATS"
statsButton.Parent = screenGui

print("LobbyUI créée")