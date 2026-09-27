-- PlayerHealth.lua
-- Gère la santé du joueur

local Players = game:GetService("Players")
local player = Players:GetPlayerFromCharacter(script.Parent)
local humanoid = script.Parent:WaitForChild("Humanoid")
local rootPart = script.Parent:WaitForChild("HumanoidRootPart")

local maxHealth = 100
local currentHealth = maxHealth
local isInvulnerable = false

-- Ajouter la santé initiale
humanoid.MaxHealth = maxHealth
humanoid.Health = maxHealth

-- Détécter les dégâts
local lastDamageTime = 0
local damageDebounce = 0.5

local function takeDamage(amount)
    if isInvulnerable then return end
    
    local currentTime = tick()
    if currentTime - lastDamageTime < damageDebounce then
        return
    end
    lastDamageTime = currentTime
    
    humanoid:TakeDamage(amount)
    print(player.Name .. " a pris " .. amount .. " de dégâts. Santé: " .. humanoid.Health)
end

-- Téléporter le joueur en l'air s'il s'approche trop près du sol
local function checkFallDamage()
    if rootPart.Position.Y < -50 then
        humanoid.Health = 0
    end
end

-- Boucle de vérification
while true do
    wait(0.5)
    checkFallDamage()
end