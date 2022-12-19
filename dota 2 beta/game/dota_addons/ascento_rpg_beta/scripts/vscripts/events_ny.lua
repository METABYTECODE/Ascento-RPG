--local SaveLoad = require("libraries/autoload/saveload")



function GameMode:DamageFilter(filterDamage)
    local attacker = filterDamage.entindex_attacker_const and EntIndexToHScript(filterDamage.entindex_attacker_const) 
    if not attacker then
        return true 
    end 
    local ability,abilityName
    local victim = EntIndexToHScript(filterDamage.entindex_victim_const)
    local typeDamage = filterDamage.damagetype_const
    if filterDamage.entindex_inflictor_const then
        ability = EntIndexToHScript(filterDamage.entindex_inflictor_const )
        if ability and ability.GetAbilityName and ability:GetAbilityName() then
            abilityName = ability:GetAbilityName()
        end
    end

   

    local damageIncoming = filterDamage.damage


    if damageIncoming > 0 then

        local buff_ring = 0
        local buff_reinc = 0

        local buff_1 = 0
        local buff_2 = 0
        local buff_3 = 0
        local buff_4 = 0
        local buff_5 = 0
        local buff_6 = 0
        local buff_7 = 0
        local buff_8 = 0
        local buff_9 = 0

        local tank_3_armored_soul = 0

        local debuff_1 = 0
        local debuff_2 = 0
        local debuff_3 = 0
        local debuff_4 = 0
        local debuff_5 = 0
        local debuff_6 = 0

        local dazzleDebuff = 0


        if attacker:HasModifier("modifier_assasin_1_weak_spot") then
            if IsServer() then
                local ability = attacker:FindAbilityByName("assasin_1_weak_spot")
                local chance = ability:GetSpecialValueFor("critical_chance")
                if attacker:HasModifier("modifier_assasin_2_darkness") then
                    chance = chance * 2
                end
                if RollPercentage(chance) then
                    damageIncoming = damageIncoming * (ability:GetSpecialValueFor("critical_damage") / 100)
                    EmitSoundOn( "Hero_Juggernaut.BladeDance", attacker )

            
                end
            end
        end

        if attacker:HasModifier("modifier_ranger_1_heavy_bolts") then
            if IsServer() then
                local ability = attacker:FindAbilityByName("ranger_1_heavy_bolts")
                if ability ~= nil then
                    if ability:GetSpecialValueFor("bonus_damage_pct") > 0 then
                        damageIncoming = damageIncoming * (ability:GetSpecialValueFor("bonus_damage_pct") / 100)
                    end
                end
            end
        end


        if attacker:HasModifier("modifier_cultist_1_decay_curse") then
            local ability = attacker:FindModifierByName("modifier_cultist_1_decay_curse"):GetAbility()

            if ability:GetSpecialValueFor("damage_less") ~= nil then
                dazzleDebuff = ability:GetSpecialValueFor("damage_less")
            end
        end


        
        if victim:HasModifier("modifier_tank_1_shielded") then
            local ability = victim:FindAbilityByName("tank_1_shielded")
            if ability ~= nil then
                buff_2 = ability:GetLevelSpecialValueFor("damage_reduction_pct", (ability:GetLevel() - 1))
                if buff_2 > 0 then
                    buff_2 = buff_2 * -1
                else
                    buff_2 = 0
                end
            end
        end

        if victim:HasModifier("modifier_tank_3_armored_soul") then
            local ability = victim:FindAbilityByName("tank_3_armored_soul")
            if ability ~= nil then
                tank_3_armored_soul = ability:GetLevelSpecialValueFor("damage_prevents", (ability:GetLevel() - 1))
                if tank_3_armored_soul > 0 then
                    tank_3_armored_soul = tank_3_armored_soul * -1
                else
                    tank_3_armored_soul = 0
                end
            end
        end


        if victim:HasModifier("modifier_damage_reduction_30") then
            buff_4 = -30
        end

        if victim:HasModifier("modifier_damage_reduction_50") then
            buff_5 = -40
        end

        if victim:HasModifier("modifier_damage_reduction_60") then
            buff_6 = -50
        end

        if victim:HasModifier("modifier_damage_reduction_70") then
            buff_7 = -60
        end

        if victim:HasModifier("modifier_damage_reduction_80") then
            buff_8 = -70
        end

        if victim:HasModifier("modifier_boss_power_reduct") then
            local ability = victim:FindModifierByName("modifier_boss_power_reduct"):GetAbility()

            if ability:GetSpecialValueFor("damage_reduction") ~= nil then
                buff_9 = ability:GetSpecialValueFor("damage_reduction")
            end
        end

        if victim:HasModifier("modifier_damage_increase_30") then
            debuff_1 = 30
        end

        if victim:HasModifier("modifier_damage_increase_50") then
            debuff_2 = 40
        end

        if victim:HasModifier("modifier_damage_increase_60") then
            debuff_3 = 50
        end

        if victim:HasModifier("modifier_damage_increase_70") then
            debuff_4 = 60
        end

        if victim:HasModifier("modifier_damage_increase_80") then
            debuff_5 = 70
        end

        if victim:HasModifier("modifier_fighter_2_adrenaline_rush") then
            debuff_6 = 20
        end

        local damage_reduction_pct = (1 - (1+dazzleDebuff/100) * (1+buff_ring/100) * (1+buff_1/100) * (1+buff_2/100) * (1+buff_3/100) * (1+buff_4/100) * (1+buff_5/100) * (1+buff_6/100) * (1+buff_7/100) * (1+buff_8/100) * (1+buff_9/100) * (1+tank_3_armored_soul/100) * (1+debuff_1/100) * (1+debuff_2/100) * (1+debuff_3/100) * (1+debuff_4/100) * (1+debuff_5/100) * (1+debuff_6/100) )*100

        local damageChanging = damageIncoming - damageIncoming * (damage_reduction_pct / 100)

        if victim:HasModifier("modifier_fighter_1_bruiser") then
            local modifier = victim:FindModifierByName("modifier_fighter_1_bruiser")
            local ability = modifier:GetAbility()
            local block_chance = ability:GetSpecialValueFor("block_chance")
            if RollPercentage(block_chance) then
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, victim, damageChanging, nil) --БЛОК
                damageChanging = 0
            end
        end
    
        local data = {
            victim = victim,
            attacker = attacker,
            typeDamage = typeDamage,
            ability = ability,
            abilityName = abilityName,
            damage = damageChanging,
        }

        
        local applyFilter = GameMode:OnApplyDamage(data)
        if applyFilter then 
            filterDamage.damage = GameMode:OnTakeDamageFilter(applyFilter)
            if applyFilter.typeDamage == DAMAGE_TYPE_MAGICAL or applyFilter.typeDamage == DAMAGE_TYPE_PURE then


                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, victim, filterDamage.damage, nil) --МАГИЧЕСКИЙ УРОН
            else
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, victim, filterDamage.damage, nil) --ФИЗ УРОН
            end

            return not not filterDamage.damage
        end 

    else
        local data = {
            victim = victim,
            attacker = attacker,
            typeDamage = typeDamage,
            ability = ability,
            abilityName = abilityName,
            damage = damageIncoming,
        }

        local applyFilter = GameMode:OnApplyDamage(data)
        if applyFilter then 
            filterDamage.damage = GameMode:OnTakeDamageFilter(applyFilter)
            return not not filterDamage.damage
        end 

    end

    
    return false  

end

function GameMode:OnApplyDamage(data)
    return data
end

function GameMode:OnTakeDamageFilter(data)
    return data.damage
end



function GameMode:OnHeroPick(event)                           
--  event.player
--  event.heroindex
--  event.hero

    local hero      = EntIndexToHScript(event.heroindex)
    local player    = EntIndexToHScript(event.player)
    if not player then return end
    local playerId  = player:GetPlayerID()
    local steamId   = PlayerResource:GetSteamAccountID(playerId)

    CustomGameEventManager:Send_ServerToPlayer(player, 'on_connect_full', {})

    CustomGameEventManager:Send_ServerToAllClients('hide_hero_stats_panel', {})


    CustomGameEventManager:Send_ServerToAllClients( "GameBegin", nil )

end




-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)

    local new_state = GameRules:State_Get()
    if new_state == DOTA_GAMERULES_STATE_INIT then



    elseif new_state == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
        
        GameMode.bSeenWaitForPlayers = true

    elseif new_state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
        GameRules:SetCustomGameSetupAutoLaunchDelay(CUSTOM_GAME_SETUP_TIME)
        GameMode:OnFirstPlayerLoaded()



    elseif new_state == DOTA_GAMERULES_STATE_HERO_SELECTION then
        if USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS then
          for i=0,9 do
            if PlayerResource:IsValidPlayer(i) then
              local color = TEAM_COLORS[PlayerResource:GetTeam(i)]
              PlayerResource:SetCustomPlayerColor(i, color[1], color[2], color[3])
            end
          end
        end
        _G.DelayedModifiersTable = _G.DelayedModifiersTable or {}
        for caster, modifier in pairs(_G.DelayedModifiersTable) do
            caster:AddNewModifier(caster, nil, modifier, {})
        end
        --GameMode:PostLoadPrecache()
        GameMode:OnAllPlayersLoaded()


        
    elseif new_state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
    elseif new_state == DOTA_GAMERULES_STATE_TEAM_SHOWCASE then
    elseif new_state == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD then
    elseif new_state == DOTA_GAMERULES_STATE_PRE_GAME then
        GameRules:GetGameModeEntity():SetCustomDireScore(0) -- Thanks for Diretide
    elseif new_state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    elseif new_state == DOTA_GAMERULES_STATE_POST_GAME then
    elseif new_state == DOTA_GAMERULES_STATE_DISCONNECT then
    end
end

function GameMode:OnPlayerLevelUp(keys)

    --local playerId  = keys.PlayerID
    --local player = EntIndexToHScript(keys.player)
    local hero = EntIndexToHScript(keys.hero_entindex)
    --local level = keys.level


    --Timers:CreateTimer(0.5, function() 
        --Stats:OnLevelUp(hero)
        --Npcs:CheckQuests(hero)
    --end)



    hero:SetAbilityPoints(hero:GetAbilityPoints() + 1)
end


-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
    SendToConsole("dota_hud_healthbars 1")

    local npc = EntIndexToHScript(keys.entindex)

    if not npc or npc:GetClassname() == "npc_dota_thinker" or npc:IsPhantom() then
        return
    end

    if IsEventASCENTO(npc) then
 
    end

    if npc:IsRealHero() and npc.bFirstSpawned == nil then
        npc.bFirstSpawned = true

        GameMode:OnHeroInGame(npc)
    end


    if npc:IsRealHero() then 

        local item_to_remove = npc:FindItemInInventory("item_tpscroll")
        local item_to_remove2 = npc:FindItemInInventory("item_tpscroll_fake")
        if item_to_remove ~= nil then
            npc:RemoveItem(item_to_remove)
        end
        if item_to_remove2 ~= nil then
            npc:RemoveItem(item_to_remove2)
        end


        if npc:HasModifier("modifier_fountain_invulnerability") then
            modifier = npc:RemoveModifierByName("modifier_fountain_invulnerability")
        end

    end
end




-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys) 

    local new_state = GameRules:State_Get()
    if new_state > DOTA_GAMERULES_STATE_HERO_SELECTION then
        local playerID = keys.PlayerID or keys.player_id
        
        --if not playerID or not PlayerResource:IsValidPlayerID(playerID) then
        --    print("OnPlayerReconnect - Reconnected player ID isn't valid!")
        --end

        if PlayerResource:HasSelectedHero(playerID) or PlayerResource:HasRandomed(playerID) then
            -- This playerID already had a hero before disconnect
        else
            -- PlayerResource:IsConnected(playerID) is custom-made; can be found in 'player_resource.lua' library
            if PlayerResource:IsConnected(playerID) and not PlayerResource:IsBroadcaster(playerID) then
                PlayerResource:GetPlayer(playerID):MakeRandomHeroSelection()
                PlayerResource:SetHasRandomed(playerID)
                PlayerResource:SetCanRepick(playerID, false)
            end
        end
    end
end


-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:OnConnectFull(keys)
    self:CaptureGameMode()
    PlayerResource:OnPlayerConnect(keys)
end

function GameMode:OnPlayerChat(keys)
    --if not IsServer() then return end

    local teamonly = keys.teamonly
    local userID = keys.userid
    local text = keys.text
    local steamid = tostring(PlayerResource:GetSteamID(keys.playerid))
    local player = PlayerResource:GetPlayer(keys.playerid):GetAssignedHero()

    if not player then return end

    local StartPoint = Vector (-23, -738, 133)

    for str in string.gmatch(text, "%S+") do
        if str == "00" then
          player:ForceKill(true)
        end

        if str == "-spawn" then
            local ent = Entities:FindByName( nil, "respawn_0") --строка ищет как раз таки нашу точку pnt1
            local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты
            FindClearSpaceForUnit(player, point, true)
            PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), player)
            player:Stop()
            Timers:CreateTimer(0.2, function()
                PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)
                return nil
            end)
        end

    end

    if steamid == "76561198290873082" or steamid == "76561198083843808" or steamid == "76561198376130254" or steamid == "76561198204633313" then
        for str in string.gmatch(text, "%S+") do

            if str == "-dev_win" then
                GameMode:FastWin(player:GetPlayerID())
                GameRules:SetGameWinner(PlayerResource:GetPlayer(keys.playerid):GetTeamNumber())
            end
        
            if str == "-dev_lvlmax" then
              HeroMaxLevel(player)
            end
        
            if str == "-dev_god" then
                if not player:HasModifier("modifier_invulnerable") then
                    player:AddNewModifier(player, nil, "modifier_invulnerable", {})
                end
            end
        
            if str == "-dev_ungod" then
                if player:HasModifier("modifier_invulnerable") then
                    player:RemoveModifierByName("modifier_invulnerable")
                end
            end
        end
    end
  
end



