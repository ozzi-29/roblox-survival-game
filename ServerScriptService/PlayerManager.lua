-- PlayerManager.lua
-- Gère les joueurs et leurs interactions

local PlayerManager = {}
local RewardSystem = require(game.ServerScriptService:WaitForChild("RewardSystem"))
local GameManager = require(game.ServerScriptService:WaitForChild("GameManager"))

local gameId = nil

function PlayerManager.initializePlayer(player)
    print("Initialisation du joueur:", player.Name)
    
    -- Charger les données
    local credits = RewardSystem.getCredits(player)
    local cosmetics = RewardSystem.getPlayerCosmetics(player)
    local abilities = RewardSystem.getPlayerAbilities(player)
    
    -- Créer une RemoteEvent pour la communication
    local playerData = Instance.new("Folder")
    playerData.Name = "PlayerData"
    playerData.Parent = player
    
    -- Sauvegarder les crédits
    local creditsValue = Instance.new("IntValue")
    creditsValue.Name = "Credits"
    creditsValue.Value = credits
    creditsValue.Parent = playerData
    
    return playerData
end

function PlayerManager.joinLobby(player)
    print(player.Name .. " a rejoint le lobby")
    
    -- Téléporter au lobby
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local lobbySpawn = workspace:FindFirstChild("LobbySpawn")
        if lobbySpawn then
            player.Character.HumanoidRootPart.CFrame = lobbySpawn.CFrame + Vector3.new(0, 3, 0)
        end
    end
end

function PlayerManager.joinGame(player)
    print(player.Name .. " a rejoint une partie")
    
    if gameId then
        GameManager.addPlayer(player)
        
        -- Téléporter à la map de jeu
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local gameSpawn = workspace:FindFirstChild("GameMap")
            if gameSpawn then
                player.Character.HumanoidRootPart.CFrame = gameSpawn:FindFirstChild("SpawnLocation") and gameSpawn.SpawnLocation.CFrame + Vector3.new(0, 3, 0) or gameSpawn.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
end

function PlayerManager.onPlayerDied(player)
    print(player.Name .. " est mort")
    GameManager.removePlayer(player)
end

function PlayerManager.onPlayerLeft(player)
    print(player.Name .. " a quitté le jeu")
    GameManager.removePlayer(player)
end

return PlayerManager