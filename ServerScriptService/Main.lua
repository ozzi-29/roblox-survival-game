-- Main.lua
-- Script principal qui initialise le jeu

local GameManager = require(game.ServerScriptService:WaitForChild("GameManager"))
local PlayerManager = require(game.ServerScriptService:WaitForChild("PlayerManager"))
local Players = game:GetService("Players")

local currentGameId = nil

-- Événement quand un joueur arrive
Players.PlayerAdded:Connect(function(player)
    print(player.Name .. " a rejoint le serveur")
    
    -- Initialiser le joueur
    PlayerManager.initializePlayer(player)
    PlayerManager.joinLobby(player)
    
    -- Attendre le chargement du personnage
    player.CharacterAdded:Connect(function(character)
        print(player.Name .. " a spawn")
        
        -- Ajouter un listener pour la mort
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            PlayerManager.onPlayerDied(player)
        end)
    end)
end)

-- Événement quand un joueur quitte
Players.PlayerRemoving:Connect(function(player)
    print(player.Name .. " a quitté le serveur")
    PlayerManager.onPlayerLeft(player)
end)

-- Créer une partie au démarrage du serveur
wait(5)
print("\n=== DÉMARRAGE DU JEU ===")
currentGameId = GameManager.createGame()

-- Attendre 10 secondes puis lancer la partie
wait(10)
if GameManager.startGame() then
    print("Partie lancée!")
else
    print("Erreur: impossible de lancer la partie")
end