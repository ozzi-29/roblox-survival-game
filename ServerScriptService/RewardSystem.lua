-- RewardSystem.lua
-- Système de récompenses et de crédits

local RewardSystem = {}
local DataStoreService = game:GetService("DataStoreService")
local creditsStore = DataStoreService:GetDataStore("PlayerCredits")
local cosmetics = DataStoreService:GetDataStore("PlayerCosmetics")
local abilities = DataStoreService:GetDataStore("PlayerAbilities")

local COSMETICS = {
    {id = "skin_skeleton", name = "Squelette", price = 100, type = "skin"},
    {id = "skin_zombie", name = "Zombie", price = 150, type = "skin"},
    {id = "skin_ghost", name = "Fantôme", price = 200, type = "skin"},
    {id = "hat_crown", name = "Couronne", price = 80, type = "accessory"},
    {id = "hat_halo", name = "Auréole", price = 120, type = "accessory"},
    {id = "emote_dance", name = "Danse", price = 50, type = "emote"},
    {id = "emote_laugh", name = "Rire", price = 50, type = "emote"},
    {id = "trail_fire", name = "Traînée de Feu", price = 200, type = "trail"}
}

local ABILITIES = {
    {id = "shield", name = "Bouclier", price = 500, description = "Réduit les dégâts de 50%"},
    {id = "speed_boost", name = "Vitesse", price = 400, description = "Augmente la vitesse de 30%"},
    {id = "health_plus", name = "Santé +", price = 600, description = "Augmente la vie de 50%"},
    {id = "dash", name = "Dash", price = 700, description = "Permet de te téléporter"},
    {id = "double_jump", name = "Double Saut", price = 300, description = "Saute deux fois"}
}

function RewardSystem.addCredits(player, amount)
    local success, currentCredits = pcall(function()
        return creditsStore:GetAsync(player.UserId)
    end)
    
    currentCredits = currentCredits or 0
    local newCredits = currentCredits + amount
    
    pcall(function()
        creditsStore:SetAsync(player.UserId, newCredits)
    end)
    
    return newCredits
end

function RewardSystem.getCredits(player)
    local success, credits = pcall(function()
        return creditsStore:GetAsync(player.UserId)
    end)
    
    return credits or 0
end

function RewardSystem.spendCredits(player, amount)
    local currentCredits = RewardSystem.getCredits(player)
    
    if currentCredits < amount then
        return false, "Pas assez de crédits"
    end
    
    local newCredits = currentCredits - amount
    pcall(function()
        creditsStore:SetAsync(player.UserId, newCredits)
    end)
    
    return true, newCredits
end

function RewardSystem.buyCosmetic(player, cosmeticId)
    local cosmetic = nil
    for _, c in ipairs(COSMETICS) do
        if c.id == cosmeticId then
            cosmetic = c
            break
        end
    end
    
    if not cosmetic then
        return false, "Cosmétique introuvable"
    end
    
    local spent, newBalance = RewardSystem.spendCredits(player, cosmetic.price)
    if not spent then
        return false, newBalance
    end
    
    -- Sauvegarder le cosmétique
    local success, playerCosmetics = pcall(function()
        return game:GetService("HttpService"):JSONDecode(cosmetics:GetAsync(player.UserId) or "{}")
    end)
    
    if not playerCosmetics then playerCosmetics = {} end
    table.insert(playerCosmetics, cosmeticId)
    
    pcall(function()
        cosmetics:SetAsync(player.UserId, game:GetService("HttpService"):JSONEncode(playerCosmetics))
    end)
    
    return true, "Cosmétique acheté! Nouveaux crédits: " .. newBalance
end

function RewardSystem.buyAbility(player, abilityId)
    local ability = nil
    for _, a in ipairs(ABILITIES) do
        if a.id == abilityId then
            ability = a
            break
        end
    end
    
    if not ability then
        return false, "Capacité introuvable"
    end
    
    local spent, newBalance = RewardSystem.spendCredits(player, ability.price)
    if not spent then
        return false, newBalance
    end
    
    -- Sauvegarder la capacité
    local success, playerAbilities = pcall(function()
        return game:GetService("HttpService"):JSONDecode(abilities:GetAsync(player.UserId) or "{}")
    end)
    
    if not playerAbilities then playerAbilities = {} end
    table.insert(playerAbilities, abilityId)
    
    pcall(function()
        abilities:SetAsync(player.UserId, game:GetService("HttpService"):JSONEncode(playerAbilities))
    end)
    
    return true, "Capacité débloquée! Nouveaux crédits: " .. newBalance
end

function RewardSystem.getCosmetics()
    return COSMETICS
end

function RewardSystem.getAbilities()
    return ABILITIES
end

function RewardSystem.getPlayerCosmetics(player)
    local success, playerCosmetics = pcall(function()
        return game:GetService("HttpService"):JSONDecode(cosmetics:GetAsync(player.UserId) or "{}")
    end)
    
    return playerCosmetics or {}
end

function RewardSystem.getPlayerAbilities(player)
    local success, playerAbilities = pcall(function()
        return game:GetService("HttpService"):JSONDecode(abilities:GetAsync(player.UserId) or "{}")
    end)
    
    return playerAbilities or {}
end

return RewardSystem