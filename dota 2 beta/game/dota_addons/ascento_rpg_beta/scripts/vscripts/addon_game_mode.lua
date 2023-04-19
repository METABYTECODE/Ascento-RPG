

function Precache( context )
    PrecacheEveryThingFromKV(context)
    PrecacheEveryUnitFromKV(context)
    PrecacheEveryEndlessFromKV(context)

    --PrecacheUnitByNameSync("", context)
    --PrecacheResource( "particle",  "", context)
    --PrecacheResource( "model",  "", context)
    
end

function PrecacheEveryUnitFromKV( context )
    local kv_files = {      "scripts/npc/npc_units_custom.txt",
                            "scripts/npc/npc_heroes_custom.txt"
                          }
    for _, kv in pairs(kv_files) do
        local kvs = LoadKeyValues(kv)
        if kvs then
            --print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
            --PrecacheEverythingUnitFromTable( context, kvs)
            for key, value in pairs(kvs) do
                if key ~= "Version" then
                    PrecacheUnitByNameSync(key, context)
                end
            end
        end
    end
end

function PrecacheEveryEndlessFromKV( context )
    local kv_file = "scripts/kv/endless_models.kv"
    local kvs = LoadKeyValues(kv_file)
    if kvs then
        --print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
        --PrecacheEverythingUnitFromTable( context, kvs)
        for key, value in pairs(kvs) do
            if key ~= "Models" then
                PrecacheResource("model", key, context)
            end
        end
    end
end

function PrecacheEveryThingFromKV( context )
    local kv_files = {      "scripts/npc/npc_units_custom.txt",
                            "scripts/npc/npc_abilities_custom.txt",
                            "scripts/npc/abilities/donate_abilities.txt",
                            "scripts/npc/abilities/heroes_abilities.txt",
                            "scripts/npc/abilities/enemy_abilities.txt",
                            "scripts/npc/abilities/assasin.txt",
                            "scripts/npc/abilities/cultist.txt",
                            "scripts/npc/abilities/fighter.txt",
                            "scripts/npc/abilities/mage.txt",
                            "scripts/npc/abilities/magic_warrior.txt",
                            "scripts/npc/abilities/ranger.txt",
                            "scripts/npc/abilities/support.txt",
                            "scripts/npc/abilities/tank.txt",
                            "scripts/npc/npc_heroes_custom.txt",
                            "scripts/npc/npc_items_custom.txt"
                          }
    for _, kv in pairs(kv_files) do
        local kvs = LoadKeyValues(kv)
        if kvs then
            --print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
            PrecacheEverythingFromTable( context, kvs)
        end
    end
end

function PrecacheEverythingFromTable( context, kvtable)
    for key, value in pairs(kvtable) do
        if type(value) == "table" then
            PrecacheEverythingFromTable( context, value )
        else
            if string.find(value, "vpcf") then
                PrecacheResource( "particle",  value, context)


                --print("PRECACHE PARTICLE RESOURCE", value)
                
            end
            if string.find(value, "vmdl") then  

                PrecacheResource( "model",  value, context)
                
                --print("PRECACHE MODEL RESOURCE", value)
                
            end
            if string.find(value, "vsndevts") then
                PrecacheResource( "soundfile",  value, context)
                --print("PRECACHE SOUND RESOURCE", value)
            end
        end
    end
end

require('util')

require('spawn')
require('spawn_endless')
require('libraries/autoload')
require('gamemode')



function Activate()
    GameRules.GameMode = GameMode()
    GameRules.GameMode:InitGameMode()

    _G.lootDrop               = {}

    Timers:CreateTimer(5.0, function()
        ClearItems(true)
        return 5.0
    end)

end