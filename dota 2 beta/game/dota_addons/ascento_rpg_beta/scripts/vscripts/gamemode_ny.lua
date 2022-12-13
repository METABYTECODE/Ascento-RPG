--// Decompiled Code. 
-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode
BAREBONES_VERSION = "1.00"

-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false

if GameMode == nil then
    DebugPrint('[BAREBONES] creating barebones game mode')
    _G.GameMode = class({})
    _G.GameDifficulty = nil
end

require('libraries/link_lua_ny')
require('settings_ny')

require('events_ny')

require("fastload_server_ny")

require('libraries/player_load_data_ny')




function GameMode:OnFirstPlayerLoaded()
    CustomGameEventManager:RegisterListener("killvote", function(userId, event)
        table.insert(KILL_VOTE_RESULT, tostring(event.option):upper())
      end)
end

function GameMode:OnAllPlayersLoaded()
    DebugPrint("[BAREBONES] All Players have loaded into the game")

    local delay = HERO_SELECTION_TIME + HERO_SELECTION_PENALTY_TIME + STRATEGY_TIME - 0.1
      if ENABLE_BANNING_PHASE then
        delay = delay + BANNING_PHASE_TIME
      end
      Timers:CreateTimer(delay, function()
        for playerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
          if PlayerResource:IsValidPlayerID(playerID) then
            -- If this player still hasn't picked a hero, random one
            -- PlayerResource:IsConnected(index) is custom-made! Can be found in 'player_resource.lua' library
            if not PlayerResource:HasSelectedHero(playerID) and not PlayerResource:IsBroadcaster(playerID) then
              PlayerResource:GetPlayer(playerID):MakeRandomHeroSelection() -- this will cause an error if player is disconnected, that's why we check if player is connected
              PlayerResource:SetHasRandomed(playerID)
              PlayerResource:SetCanRepick(playerID, false)
              --DebugPrint("[BAREBONES] Randomed a hero for a player number "..playerID)
            end
          end
        end
      end)

      
GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)

    
    Timers:CreateTimer(function()
        GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>New Year's event will be launched soon, follow the events in our Discord channel</font>", 0, 0)
        GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>Available commands:</font>", 0, 0)
        GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>-spawn: Teleport to Spawn</font>", 0, 0)
        GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>00: Suicide</font>", 0, 0)
            return 600
          end
        )

    Timers:CreateTimer(function()
        local count_items_on_ground = Entities:FindAllByClassname("dota_item_drop")
        GameRules:SendCustomMessage("<font color='blue'>Items on ground: </font><font color='#ff0000'>" .. #count_items_on_ground .. "</font>", 0, 0)
            return 60
          end
        )

    


    if tablelength(KILL_VOTE_RESULT) <= 0 then
        KILL_VOTE_RESULT = {tostring(KILL_VOTE_DEFAULT)} 
    end

    local killCountToEnd = maxFreq(KILL_VOTE_RESULT, tablelength(KILL_VOTE_RESULT), KILL_VOTE_DEFAULT)
    KILL_VOTE_RESULT = killCountToEnd

  --

  local mode = KILL_VOTE_RESULT:upper()



  Timers:CreateTimer(1.0, function()
    if mode == "EASY" or mode == "NORMAL" then
      GameRules:SendCustomMessage("<font color='yellow'>=== СЛОЖНОСТЬ [<b color='lightgreen'>"..mode.."</b>] ===</font>", 0, 0)
    else
      GameRules:SendCustomMessage("<font color='yellow'>=== СЛОЖНОСТЬ [<b color='red'>"..mode.."</b>] ===</font>", 0, 0)
    end

  end)

    

end 




function GameMode:OnHeroInGame(hero)
    DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())

    if hero:IsRealHero() then

        local playerID = hero:GetPlayerID()
        local steamID = PlayerResource:GetSteamAccountID(playerID)
        local current_hero = hero:GetUnitName()
        local abil = hero:GetAbilityByIndex(1)

        
        EmitAnnouncerSound("soundboard.ti10_truesight.snail_walks_into_a_bar")

        local item_to_remove = hero:FindItemInInventory("item_tpscroll")
        local item_to_remove2 = hero:FindItemInInventory("item_tpscroll_fake")
        if item_to_remove ~= nil then
            hero:RemoveItem(item_to_remove)
        end
        if item_to_remove2 ~= nil then
            hero:RemoveItem(item_to_remove2)
        end

        if not hero:HasModifier("modifier_movespeed_cap") then
            hero:AddNewModifier (hero, nil, "modifier_movespeed_cap", {duration = -1})
        end


        
         --ПРОВЕРКА НА ТУЛЗЫ И ЧИТЫ
         print(steamID)
        if steamID ~= 330607354 and steamID ~= 123578080 and steamID ~= 244367585 and steamID ~= 0 then 
            if IsInToolsMode() or GameRules:IsCheatMode() then
                GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
                GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>You can`t play with cheats in this custom game.</font>", 0, 0)
            end
        end
        
        if steamID ~= 330607354 and steamID ~= 123578080 and steamID ~= 244367585 and steamID ~= 0 then
            if IsDedicatedServer() then else
                GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
                GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>You can play only on Valve Dedicated Server.</font>", 0, 0)
            end
        end

    end
end

