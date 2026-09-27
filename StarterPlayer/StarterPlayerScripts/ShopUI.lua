-- ShopUI.lua
-- Interface du shop pour acheter des cosmétiques et capacités

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local shopOpen = false

local function createShopUI()
    if playerGui:FindFirstChild("ShopGui") then
        playerGui.ShopGui:Destroy()
        return
    end
    
    local shopGui = Instance.new("ScreenGui")
    shopGui.Name = "ShopGui"
    shopGui.ResetOnSpawn = false
    shopGui.Parent = playerGui
    
    -- Fond semi-transparent
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.7
    background.Parent = shopGui
    
    -- Fenêtre du shop
    local shopWindow = Instance.new("Frame")
    shopWindow.Name = "ShopWindow"
    shopWindow.Size = UDim2.new(0.8, 0, 0.9, 0)
    shopWindow.Position = UDim2.new(0.1, 0, 0.05, 0)
    shopWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    shopWindow.BorderSizePixel = 0
    shopWindow.Parent = shopGui
    
    -- Titre
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    titleLabel.TextSize = 32
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "🛍 SHOP"
    titleLabel.Parent = shopWindow
    
    -- ScrollingFrame pour les cosmétiques
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Name = "ItemsContainer"
    scrollingFrame.Size = UDim2.new(0.95, 0, 0.85, 0)
    scrollingFrame.Position = UDim2.new(0.025, 0, 0.12, 0)
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
    scrollingFrame.Parent = shopWindow
    
    -- Layout pour les items
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = UDim2.new(0.3, 0, 0.25, 0)
    gridLayout.Parent = scrollingFrame
    
    -- Créer des items de test
    local items = {
        {name = "Squelette", price = 100, emoji = "💀"},
        {name = "Zombie", price = 150, emoji = "🧟"},
        {name = "Fantôme", price = 200, emoji = "👻"},
        {name = "Couronne", price = 80, emoji = "👑"},
        {name = "Bouclier", price = 500, emoji = "🛡"},
        {name = "Vitesse", price = 400, emoji = "⚡"},
    }
    
    for _, item in ipairs(items) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Name = item.name
        itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        itemFrame.Parent = scrollingFrame
        
        local itemLabel = Instance.new("TextLabel")
        itemLabel.Size = UDim2.new(1, 0, 0.5, 0)
        itemLabel.BackgroundTransparency = 1
        itemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemLabel.TextSize = 24
        itemLabel.Font = Enum.Font.GothamBold
        itemLabel.Text = item.emoji .. " " .. item.name
        itemLabel.Parent = itemFrame
        
        local priceLabel = Instance.new("TextLabel")
        priceLabel.Size = UDim2.new(1, 0, 0.25, 0)
        priceLabel.Position = UDim2.new(0, 0, 0.5, 0)
        priceLabel.BackgroundTransparency = 1
        priceLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        priceLabel.TextSize = 16
        priceLabel.Font = Enum.Font.Gotham
        priceLabel.Text = item.price .. " 💰"
        priceLabel.Parent = itemFrame
        
        local buyButton = Instance.new("TextButton")
        buyButton.Size = UDim2.new(1, 0, 0.25, 0)
        buyButton.Position = UDim2.new(0, 0, 0.75, 0)
        buyButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        buyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        buyButton.TextSize = 14
        buyButton.Font = Enum.Font.GothamBold
        buyButton.Text = "ACHETER"
        buyButton.Parent = itemFrame
        
        buyButton.MouseButton1Click:Connect(function()
            print("Achat de", item.name, "pour", item.price, "crédits")
        end)
    end
    
    -- Bouton Fermer
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.1, 0, 0.08, 0)
    closeButton.Position = UDim2.new(0.9, 0, 0.01, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "✕"
    closeButton.Parent = shopWindow
    
    closeButton.MouseButton1Click:Connect(function()
        shopGui:Destroy()
        shopOpen = false
    end)
    
    shopOpen = true
end

-- Mettre en place un raccourci pour ouvrir le shop (sera appelé depuis LobbyUI)
local function toggleShop()
    if shopOpen then
        if playerGui:FindFirstChild("ShopGui") then
            playerGui.ShopGui:Destroy()
        end
        shopOpen = false
    else
        createShopUI()
    end
end

print("ShopUI chargée")