-- EventManager.lua
-- Gère tous les événements aléatoires du jeu

local EventManager = {}
local events = {
    "Zombies",
    "Tornado",
    "Meteors",
    "Lava",
    "FogMonsters",
    "Earthquake",
    "BlizzardStorm",
    "Lightning"
}

local eventDurations = {
    Zombies = 25,
    Tornado = 20,
    Meteors = 30,
    Lava = 25,
    FogMonsters = 30,
    Earthquake = 15,
    BlizzardStorm = 25,
    Lightning = 20
}

local eventRadius = 100 -- Rayon d'effet des événements

function EventManager.getRandomEvent()
    return events[math.random(1, #events)]
end

function EventManager.triggerEvent(eventName, position)
    print("Événement déclenché: " .. eventName)
    
    if eventName == "Zombies" then
        EventManager.triggerZombies(position)
    elseif eventName == "Tornado" then
        EventManager.triggerTornado(position)
    elseif eventName == "Meteors" then
        EventManager.triggerMeteors(position)
    elseif eventName == "Lava" then
        EventManager.triggerLava(position)
    elseif eventName == "FogMonsters" then
        EventManager.triggerFogMonsters(position)
    elseif eventName == "Earthquake" then
        EventManager.triggerEarthquake(position)
    elseif eventName == "BlizzardStorm" then
        EventManager.triggerBlizzardStorm(position)
    elseif eventName == "Lightning" then
        EventManager.triggerLightning(position)
    end
end

function EventManager.triggerZombies(position)
    -- Spawn des zombies autour de la position
    local zombieCount = math.random(3, 8)
    for i = 1, zombieCount do
        local offsetX = math.random(-eventRadius, eventRadius)
        local offsetZ = math.random(-eventRadius, eventRadius)
        local spawnPos = position + Vector3.new(offsetX, 3, offsetZ)
        -- Créer un zombie à cette position
        print("Zombie spawn à", spawnPos)
    end
end

function EventManager.triggerTornado(position)
    print("Tornada créée à", position)
    -- Tornade qui pousse les joueurs
    -- Peut être implémentée avec une force radiale
end

function EventManager.triggerMeteors(position)
    print("Météorites qui tombent!")
    local meteorCount = math.random(5, 15)
    for i = 1, meteorCount do
        local offsetX = math.random(-eventRadius, eventRadius)
        local offsetZ = math.random(-eventRadius, eventRadius)
        local meteorPos = position + Vector3.new(offsetX, 50, offsetZ)
        print("Météorite à", meteorPos)
    end
end

function EventManager.triggerLava(position)
    print("Lave monte du sol!")
    -- Créer une montée de lave
end

function EventManager.triggerFogMonsters(position)
    print("Brouillard épais avec des monstres!")
    -- Brouillard + monstres aléatoires
end

function EventManager.triggerEarthquake(position)
    print("Tremblement de terre!")
    -- Secouer la caméra et les objets
end

function EventManager.triggerBlizzardStorm(position)
    print("Tempête de neige!")
    -- Diminue la visibilité et ralentit les joueurs
end

function EventManager.triggerLightning(position)
    print("Éclairs dangereux!")
    -- Éclairs aléatoires qui font des dégâts
end

function EventManager.getEventDuration(eventName)
    return eventDurations[eventName] or 25
end

return EventManager