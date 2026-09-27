-- PlayerAbilities.lua
-- Gère les capacités spéciales du joueur

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players:GetPlayerFromCharacter(script.Parent)
local humanoid = script.Parent:WaitForChild("Humanoid")
local rootPart = script.Parent:WaitForChild("HumanoidRootPart")

local abilities = {}
local abilityCooldowns = {}

local ABILITY_CONFIGS = {
    shield = {
        cooldown = 10,
        duration = 5,
        effect = function()
            print(player.Name .. " utilise Bouclier!")
            -- Créer un bouclier visuel
            local shield = Instance.new("Part")
            shield.Shape = Enum.PartType.Ball
            shield.Size = Vector3.new(6, 6, 6)
            shield.CanCollide = false
            shield.Transparency = 0.5
            shield.Color = Color3.fromRGB(0, 100, 255)
            shield.TopSurface = Enum.SurfaceType.Smooth
            shield.BottomSurface = Enum.SurfaceType.Smooth
            shield.CFrame = rootPart.CFrame
            shield.Parent = script.Parent
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = rootPart
            weld.Part1 = shield
            weld.Parent = shield
            
            game:GetService("Debris"):AddItem(shield, ABILITY_CONFIGS.shield.duration)
        end
    },
    speed_boost = {
        cooldown = 15,
        duration = 5,
        effect = function()
            print(player.Name .. " utilise Vitesse!")
            humanoid.WalkSpeed = 32 -- Augmente la vitesse
            wait(ABILITY_CONFIGS.speed_boost.duration)
            humanoid.WalkSpeed = 16 -- Retour à la normale
        end
    },
    dash = {
        cooldown = 8,
        duration = 0.5,
        effect = function()
            print(player.Name .. " utilise Dash!")
            local dashDirection = rootPart.CFrame.LookVector * 50
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = dashDirection
            bodyVelocity.Parent = rootPart
            game:GetService("Debris"):AddItem(bodyVelocity, ABILITY_CONFIGS.dash.duration)
        end
    }
}

local function activateAbility(abilityId)
    if not abilities[abilityId] then return end
    
    local config = ABILITY_CONFIGS[abilityId]
    if not config then return end
    
    local lastUse = abilityCooldowns[abilityId] or 0
    if tick() - lastUse < config.cooldown then
        print("Capacité en cooldown: " .. abilityId)
        return
    end
    
    abilityCooldowns[abilityId] = tick()
    config.effect()
end

-- Charger les capacités du joueur
local function loadPlayerAbilities()
    -- À implémenter avec le système de récompenses
    -- Pour le test, on active toutes les capacités
    abilities = {
        shield = true,
        speed_boost = true,
        dash = true
    }
end

-- Raccourcis clavier (à adapter selon vos préférences)
if script:FindFirstChild("LocalScript") == nil then
    local localScript = Instance.new("LocalScript")
    localScript.Parent = script
    localScript.Source = [[local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.E then
        script.Parent:FireEvent("ActivateAbility", "shield")
    elseif input.KeyCode == Enum.KeyCode.R then
        script.Parent:FireEvent("ActivateAbility", "speed_boost")
    elseif input.KeyCode == Enum.KeyCode.F then
        script.Parent:FireEvent("ActivateAbility", "dash")
    end
end)
]]
end

loadPlayerAbilities()