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

require('libraries/link_lua')
require('settings')

require('events')

--require('npcs')
--require('quests')

require("fastload_server")

require('libraries/player_load_data')




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

      


    
    Timers:CreateTimer(function()
        GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>Please save your progress sometimes.</font>", 0, 0)
        GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>Available commands:</font>", 0, 0)
        GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>-uncheck: Reset your checkpoint</font>", 0, 0)
        GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>-spawn: Teleport to Spawn</font>", 0, 0)
        GameRules:SendCustomMessage("<font color='#00EA43'>ASCENTO RPG: </font><font color='#ff0000'>00: Suicide</font>", 0, 0)
            return 600
          end
        )


    if tablelength(KILL_VOTE_RESULT) <= 0 then
        KILL_VOTE_RESULT = {tostring(KILL_VOTE_DEFAULT)} 
    end

    local killCountToEnd = maxFreq(KILL_VOTE_RESULT, tablelength(KILL_VOTE_RESULT), KILL_VOTE_DEFAULT)
    KILL_VOTE_RESULT = killCountToEnd

  --

  local mode = KILL_VOTE_RESULT:upper()

  if mode == "EASY" then
        BOSS_KILLS_DEFAULT = math.floor(BOSS_KILLS_DEFAULT * 1.1)
        CREEP_KILLS_DEFAULT = math.floor(CREEP_KILLS_DEFAULT * 1.1)
    end

    if mode == "NORMAL" then
        BOSS_KILLS_DEFAULT = math.floor(BOSS_KILLS_DEFAULT * 1.2)
        CREEP_KILLS_DEFAULT = math.floor(CREEP_KILLS_DEFAULT * 1.2)
    end

    if mode == "HARD" then
        BOSS_KILLS_DEFAULT = math.floor(BOSS_KILLS_DEFAULT * 1.3)
        CREEP_KILLS_DEFAULT = math.floor(CREEP_KILLS_DEFAULT * 1.3)
    end

    if mode == "UNFAIR" then
        BOSS_KILLS_DEFAULT = math.floor(BOSS_KILLS_DEFAULT * 1.4)
        CREEP_KILLS_DEFAULT = math.floor(CREEP_KILLS_DEFAULT * 1.4)
    end

    if mode == "IMPOSSIBLE" then
        BOSS_KILLS_DEFAULT = math.floor(BOSS_KILLS_DEFAULT * 1.5)
        CREEP_KILLS_DEFAULT = math.floor(CREEP_KILLS_DEFAULT * 1.5)
    end

    if mode == "HELL" then
        BOSS_KILLS_DEFAULT = math.floor(BOSS_KILLS_DEFAULT * 1.6)
        CREEP_KILLS_DEFAULT = math.floor(CREEP_KILLS_DEFAULT * 1.6)
    end

    if mode == "HARDCORE" then
        BOSS_KILLS_DEFAULT = math.floor(BOSS_KILLS_DEFAULT * 1.7)
        CREEP_KILLS_DEFAULT = math.floor(CREEP_KILLS_DEFAULT * 1.7)
    end

  Timers:CreateTimer(1.0, function()
    if mode == "EASY" or mode == "NORMAL" then
      GameRules:SendCustomMessage("<font color='yellow'>=== СЛОЖНОСТЬ [<b color='lightgreen'>"..mode.."</b>] ===</font>", 0, 0)
      GameRules:SendCustomMessage("<font color='yellow'>=== БОССОВ ДЛЯ РЕИНКАРНАЦИИ [<b color='lightgreen'>"..BOSS_KILLS_DEFAULT.."</b>] ===</font>", 0, 0)
      GameRules:SendCustomMessage("<font color='yellow'>=== КРИПОВ ДЛЯ РЕИНКАРНАЦИИ [<b color='lightgreen'>"..CREEP_KILLS_DEFAULT.."</b>] ===</font>", 0, 0)
    else
      GameRules:SendCustomMessage("<font color='yellow'>=== СЛОЖНОСТЬ [<b color='red'>"..mode.."</b>] ===</font>", 0, 0)
      GameRules:SendCustomMessage("<font color='yellow'>=== БОССОВ ДЛЯ РЕИНКАРНАЦИИ [<b color='red'>"..BOSS_KILLS_DEFAULT.."</b>] ===</font>", 0, 0)
      GameRules:SendCustomMessage("<font color='yellow'>=== КРИПОВ ДЛЯ РЕИНКАРНАЦИИ [<b color='red'>"..CREEP_KILLS_DEFAULT.."</b>] ===</font>", 0, 0)
    end
  end)

    



  --ОБРАЩЕНИЕ КО ВСЕМ ЮНИТАМ |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        
        --local StartPoint = Vector (-23, -738, 133)
        --local AllUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, StartPoint, nil, 25000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        --for _, enemy in pairs(AllUnits) do 
        --    if enemy:HasModifier("modifier_invulnerable") then
        --       enemy:RemoveModifierByName("modifier_invulnerable")
        --       print("Снял modifier_invulnerable")
        --    end
        --end
end 




function GameMode:OnHeroInGame(hero)
    DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())

    if hero:IsRealHero() then

        local playerID = hero:GetPlayerID()
        local steamID = PlayerResource:GetSteamAccountID(playerID)
        local current_hero = hero:GetUnitName()
        local abil = hero:GetAbilityByIndex(1)
        --print("Steam Community ID: " .. tostring(steamID))
        --print("Current Hero: " .. tostring(current_hero))
        --print("OnHeroInGame | " .. current_hero .. " | " .. steamID)
        hero.order_timer = 10
        GameMode:FirstLoad(hero)
        GameMode:DonateLoad(hero)
        Timers:CreateTimer(function()
            GameMode:TopLoad(hero)
            return 30
        end)

        
        EmitAnnouncerSound("soundboard.new_year_drums")

        local item_to_remove = hero:FindItemInInventory("item_tpscroll")
        local item_to_remove2 = hero:FindItemInInventory("item_tpscroll_fake")
        if item_to_remove ~= nil then
            hero:RemoveItem(item_to_remove)
        end
        if item_to_remove2 ~= nil then
            hero:RemoveItem(item_to_remove2)
        end

        _G.lootDrop[playerID] = true

        CustomGameEventManager:RegisterListener("loot_drop", function(userId, event)
            local state = tostring(event.option)
            local enabled = true
        
            if state == "on" then
              enabled = true
            else
              enabled = false
            end
        
            _G.lootDrop[event.playerID] = enabled
        end)

--

        if hero.creep_kills == nil then
            hero.creep_kills = 0
        end

        if hero.boss_kills == nil then
            hero.boss_kills = 0
        end

        if hero.all_creep_kills == nil then
            hero.all_creep_kills = 0
        end
        if hero.all_boss_kills == nil then
            hero.all_boss_kills = 0
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






--START UPGRADES |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        --hero:FindAbilityByName("phantom_assassin_phantom_strike_datadriven"):UpgradeAbility(true)

        --local blink = hero:AddAbility("phantom_assassin_phantom_strike_datadriven")
        --blink:UpgradeAbility(true)

        if not hero:HasModifier("modifier_movespeed_cap") then
            hero:AddNewModifier (hero, nil, "modifier_movespeed_cap", {duration = -1})
        end
        if not hero:HasModifier("modifier_profession") then
            hero:AddNewModifier (hero, nil, "modifier_profession", {duration = -1})
        end
        if not hero:HasModifier("modifier_incarnation") then
            hero:AddNewModifier (hero, nil, "modifier_incarnation", {duration = -1})
        end
        if not hero:HasModifier("modifier_custom_attribute_status_resistance") then
            hero:AddNewModifier (hero, nil, "modifier_custom_attribute_status_resistance", {duration = -1})
        end

        
        local item_to_add = hero:FindItemInInventory("item_phantom_assassin_phantom_strike_datadriven")
        if item_to_add == nil then
            hero:AddItemByName("item_phantom_assassin_phantom_strike_datadriven")
        end

        local item_to_remove = hero:FindItemInInventory("item_tpscroll")
        local item_to_remove2 = hero:FindItemInInventory("item_tpscroll_fake")
        if item_to_remove ~= nil then
            hero:RemoveItem(item_to_remove)
        end
        if item_to_remove2 ~= nil then
            hero:RemoveItem(item_to_remove2)
        end


        Timers:CreateTimer(function()
            --if hero:FindAbilityByName("balanar_form_datadriven") ~= nil then 
            --    if hero:FindAbilityByName("terrorblade_metamorphosis_datadriven") ~= nil then 
            --        hero:RemoveAbility("terrorblade_metamorphosis_datadriven")
            --    end
            --end
            local highground = GetGroundHeight(hero:GetAbsOrigin(), hero)
            --print(highground)
            if highground > 250 then
                hero:ForceKill(true)
                GameRules:SendCustomMessage("<font color='red'>КУДАААА?! [<b color='red'>НА ХГ</b>] ходить запрещено!</font>", 0, 0)
            end
        return 1.0 end)

  --Timers:CreateTimer(1.0, function()
    --Npcs:CheckQuests(hero)
  --end)


        



    end
end

function GameMode:OnGameInProgress()
    --local playerID = hero:GetPlayerID()
    --local steamID = PlayerResource:GetSteamAccountID(playerID)
    --local current_hero = hero:GetUnitName()

    --DebugPrint("[BAREBONES] The game has officially begun")
    --print("OnGameInProgress")


end

