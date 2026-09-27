-- GameManager.lua
-- Gère la logique principale du jeu et les phases de jeu

local GameManager = {}
local RewardSystem = require(game.ServerScriptService:WaitForChild("RewardSystem"))
local EventManager = require(game.ServerScriptService:WaitForChild("EventManager"))

local gameState = {} -- { gameId, players = {}, isActive, eventCount, startTime }
local eventInterval = 30 -- Événement toutes les 30 secondes
local minPlayersToStart = 1

function GameManager.createGame()
    local gameId = game:GetService("HttpService"):GenerateGUID(false)
    gameState = {
        gameId = gameId,
        players = {},
        isActive = true,
        eventCount = 0,
        startTime = tick(),
        survivedPlayers = {}
    }
    print("Partie créée avec l'ID:", gameId)
    return gameId
end

function GameManager.addPlayer(player)
    table.insert(gameState.players, player.UserId)
    print(player.Name .. " a rejoint la partie")
end

function GameManager.removePlayer(player)
    for i, userId in ipairs(gameState.players) do
        if userId == player.UserId then
            table.remove(gameState.players, i)
            print(player.Name .. " a quitté la partie")
            break
        end
    end
end

function GameManager.startGame()
    if #gameState.players < minPlayersToStart then
        print("Pas assez de joueurs pour commencer")
        return false
    end
    
    gameState.isActive = true
    gameState.startTime = tick()
    gameState.eventCount = 0
    
    -- Lancer la boucle des événements
    GameManager.eventLoop()
    return true
end

function GameManager.eventLoop()
    while gameState.isActive do
        wait(eventInterval)
        
        if gameState.isActive then
            gameState.eventCount = gameState.eventCount + 1
            
            local randomEvent = EventManager.getRandomEvent()
            local gameMap = workspace:FindFirstChild("GameMap")
            local mapCenter = gameMap and gameMap:FindFirstChild("SpawnLocation") and gameMap.SpawnLocation.Position or Vector3.new(0, 10, 0)
            
            EventManager.triggerEvent(randomEvent, mapCenter)
            
            -- Notifier tous les joueurs de l'événement
            GameManager.notifyPlayers(randomEvent, gameState.eventCount)
            
            local duration = EventManager.getEventDuration(randomEvent)
            wait(duration)
        end
    end
end

function GameManager.notifyPlayers(eventName, eventNumber)
    local notification = Instance.new("RemoteEvent")
    notification.Name = "EventNotification"
    notification.Parent = game.ReplicatedStorage
    
    notification:FireAllClients(eventName, eventNumber)
end

function GameManager.playerSurvived(player)
    if not gameState.survivedPlayers[player.UserId] then
        gameState.survivedPlayers[player.UserId] = 0
    end
    gameState.survivedPlayers[player.UserId] = gameState.survivedPlayers[player.UserId] + 1
    
    -- Donner une récompense
    local reward = 10 + (gameState.eventCount * 5)
    RewardSystem.addCredits(player, reward)
    print(player.Name .. " a survécu! +" .. reward .. " crédits")
end

function GameManager.endGame()
    gameState.isActive = false
    local duration = tick() - gameState.startTime
    local minutes = math.floor(duration / 60)
    local seconds = duration % 60
    
    print("Partie terminée! Durée: " .. minutes .. "m " .. seconds .. "s")
    print("Événements surmontés: " .. gameState.eventCount)
end

function GameManager.getGameStats()
    return {
        eventCount = gameState.eventCount,
        playerCount = #gameState.players,
        duration = tick() - gameState.startTime,
        survivedPlayers = gameState.survivedPlayers
    }
end

return GameManager