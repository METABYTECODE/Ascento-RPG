
SAVE_HEALTH = false

if Spawn == nil then
	_G.Spawn = class({})
end

function Spawn:InitGameMode()
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(Spawn, 'OnGameRulesStateChange'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(Spawn, 'OnEntityKilled'), self)

end


	
function Spawn:OnGameRulesStateChange( keys )
	local newState = GameRules:State_Get()
	--print("event OnGameRulesStateChange has called")

	if newState == DOTA_GAMERULES_STATE_PRE_GAME then
		Spawn:FirstSpawnBoss()
	end
end

function Spawn:OnEntityKilled( keys )
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	local killerUnit = EntIndexToHScript( keys.entindex_attacker )
	local name = killedUnit:GetUnitName()

	--Timers:CreateTimer(0.1, function() 
    --    Quests:OnEntityKilled(keys)
    --end)

    local killerAbility = nil

    if keys.entindex_inflictor ~= nil then
        killerAbility = EntIndexToHScript(keys.entindex_inflictor)
    end

    local killerEntity = nil

    if keys.entindex_attacker ~= nil then
      killerEntity = EntIndexToHScript( keys.entindex_attacker )
    end

    if not killerEntity.creep_kills then
        killerEntity.creep_kills = 0
    end

    if not killerEntity.boss_kills then
        killerEntity.boss_kills = 0
    end

    if not killerEntity.deaths then
        killerEntity.deaths = 0
    end
      
    if not killerEntity.canreinc then
        killerEntity.canreinc = 0
    end
      
    if not killerEntity.uvedomlenie then
        killerEntity.uvedomlenie = 0
    end

    if killedUnit:IsRealHero() then
        killedUnit.deaths = killedUnit.deaths + 1
    end
    
    if killerEntity:IsRealHero() then 

        local playerID = killerEntity:GetPlayerID()
        local player = PlayerResource:GetPlayer(playerID)

        local newSpawnPointForHero = GameRules.SpawnsTable[killedUnit:GetUnitName()]

        if newSpawnPointForHero ~= nil then
            if tonumber(newSpawnPointForHero) > 0 then
                if killerEntity.RespawnPos ~= nil then
                    if tonumber(killerEntity.RespawnPos) < tonumber(newSpawnPointForHero) then
                        killerEntity.RespawnPos = newSpawnPointForHero
                        CustomGameEventManager:Send_ServerToPlayer(killerEntity:GetPlayerOwner(), "create_error_message", {message = "Respawn point successfully set"})
                    end
                else
                    killerEntity.RespawnPos = newSpawnPointForHero
                    CustomGameEventManager:Send_ServerToPlayer(killerEntity:GetPlayerOwner(), "create_error_message", {message = "Respawn point successfully set"})
                end
            end
        end

        if killerEntity.all_creep_kills == nil then
            killerEntity.all_creep_kills = 0
        end
        
        if killerEntity.all_boss_kills == nil then
            killerEntity.all_boss_kills = 0
        end

        if IsCreepASCENTO(killedUnit) then
            killerEntity.creep_kills = killerEntity.creep_kills + 1
            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_creeps", {playerKilledCreeps = tonumber(killerEntity.creep_kills), need_kill_creeps = tonumber(CREEP_KILLS_DEFAULT)})
            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(killerEntity.all_creep_kills + killerEntity.creep_kills)})
            --print(killerEntity:GetUnitName())

            if killerEntity.boss_kills >= BOSS_KILLS_DEFAULT and killerEntity.creep_kills >= CREEP_KILLS_DEFAULT and killerEntity.uvedomlenie ~= 1 then
                killerEntity.uvedomlenie = 1

                GameRules:SendCustomMessage("<font color='#00EA43'>".. killerEntity:GetUnitName() ..": </font><font color='green'>Now you need kill the Skeleton Boss.</font>", 0, 0)
            end

        end
        if IsBossASCENTO(killedUnit) then
            killerEntity.boss_kills = killerEntity.boss_kills + 1
            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_boss", {playerKilledBoss = tonumber(killerEntity.boss_kills), need_kill_boss = tonumber(BOSS_KILLS_DEFAULT)})
            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_boss", {playerKilledBoss = tonumber(killerEntity.all_boss_kills + killerEntity.boss_kills)})
            --print(killerEntity:GetUnitName())

            if killerEntity.boss_kills >= BOSS_KILLS_DEFAULT and killerEntity.creep_kills >= CREEP_KILLS_DEFAULT and killerEntity.uvedomlenie ~= 1 then
                killerEntity.uvedomlenie = 1

                GameRules:SendCustomMessage("<font color='#00EA43'>".. killerEntity:GetUnitName() ..": </font><font color='green'>Now you need kill the Skeleton Boss.</font>", 0, 0)
            end
        end
        

        


        
    end





  if killedUnit:IsNeutralUnitType() or killedUnit:IsCreature() or killedUnit:IsCreep() or killedUnit:IsSummoned() then

    if IsCreepASCENTO(killedUnit) or IsBossASCENTO(killedUnit) then

        GameMode:RollDrops(killedUnit, killerEntity)

        

        local point = "spawner_" .. name
        local caster_respoint = killedUnit:GetAbsOrigin()
    
        if Entities:FindByNameNearest(point, killedUnit:GetAbsOrigin(), 25000) then 
            caster_respoint = Entities:FindByNameNearest(point, killedUnit:GetAbsOrigin(), 25000):GetAbsOrigin()
        end
    
        if killedUnit.respoint ~= nil then
            caster_respoint = killedUnit.respoint
        elseif killedUnit.vInitialSpawnPos ~= nil then
            caster_respoint = killedUnit.vInitialSpawnPos
        end

        Timers:CreateTimer({
            endTime = 10, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
        	callback = function()

                local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS)
                unit.respoint = caster_respoint
                
                local red = unit:GetLevel() * 2
                if red > 255 then red = 255 end
                local green = 255-red
                if green < 0 then green = 0 end
                unit:SetCustomHealthLabel(unit:GetLevel() .. " lvl", red, green, 0)
                GameMode:GiveDropItems(unit)
    
        	end
  	     })


        if killedUnit:GetUnitName() == "npc_dota_creature_final_tron" then
            if killerEntity ~= nil then
                if killerEntity:GetPlayerID() ~= nil and killerEntity:IsRealHero() then
                    for k, hero in pairs(get_team_heroes(DOTA_TEAM_GOODGUYS)) do 

                        if hero.boss_kills >= BOSS_KILLS_DEFAULT and hero.creep_kills >= CREEP_KILLS_DEFAULT then
                            hero.canreinc = 1

                            GameRules:SendCustomMessage("<font color='#00EA43'>".. hero:GetUnitName() ..": </font><font color='green'>You have complete the conditions for reincarnation.</font>", 0, 0)

                            local playerIDreinc = hero:GetPlayerID()
                            local playerreinc = PlayerResource:GetPlayer(playerIDreinc)

                            CustomGameEventManager:Send_ServerToPlayer(playerreinc, 'on_player_reinc_can_reinc', {})


                        else
                            GameRules:SendCustomMessage("<font color='#00EA43'>".. hero:GetUnitName() ..": </font><font color='red'>For end game you need to kill ".. BOSS_KILLS_DEFAULT .." bosses and ".. CREEP_KILLS_DEFAULT .." creeps.</font>", 0, 0)
                        end
                    end
                    --local spawnPoint = Entities:FindByName(nil, "spawner_npc_dota_boss_aghanim"):GetAbsOrigin()
                    --local unit = CreateUnitByName("npc_dota_boss_aghanim", spawnPoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS)
                    --unit:SetCustomHealthLabel("??? lvl", 255, 0, 0)
                end
            end
        end

        if killedUnit:GetUnitName() == "npc_dota_creature_weekly_boss_tri" then
            if killerEntity ~= nil and killerEntity:IsRealHero() then
                if killerEntity.boss_kills ~= nil and killerEntity.creep_kills ~= nil then
                    if killerEntity.boss_kills >= BOSS_KILLS_DEFAULT and killerEntity.creep_kills >= CREEP_KILLS_DEFAULT then

                        local AllUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, killerEntity:GetAbsOrigin(), nil, 25000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
                        for _, unit in pairs(AllUnits) do
                            if unit:GetUnitName() == "npc_dota_creature_final_tron" then
                                if unit:HasModifier("modifier_custom_invulnerable") then
                                    unit:RemoveModifierByName("modifier_custom_invulnerable")
                                end
                            end
                        end

                        GameRules:SendCustomMessage("<font color='#00EA43'>".. killerEntity:GetUnitName() ..": </font><font color='green'>Now you need to kill Citadel for your hero can Reincarnate.</font>", 0, 0)

                    else
                        GameRules:SendCustomMessage("<font color='#00EA43'>".. killerEntity:GetUnitName() ..": </font><font color='red'>For end game you need to kill ".. BOSS_KILLS_DEFAULT .." bosses and ".. CREEP_KILLS_DEFAULT .." creeps.</font>", 0, 0)

                    end
                end
            end
        end

        if killerEntity ~= nil and killerEntity:IsRealHero() then
            if killerEntity.boss_kills ~= nil and killerEntity.creep_kills ~= nil then
                if killerEntity.boss_kills >= BOSS_KILLS_DEFAULT and killerEntity.creep_kills >= CREEP_KILLS_DEFAULT and killerEntity.canreinc == 1 then
                    local playerIDreinc1 = killerEntity:GetPlayerID()
                    local playerreinc1 = PlayerResource:GetPlayer(playerIDreinc1)

                    CustomGameEventManager:Send_ServerToPlayer(playerreinc1, 'on_player_reinc_can_reinc', {})
                end
            end
        end

    end
  end

end

function Spawn:FirstSpawnBoss( keys )

local unitNames = {
	"npc_dota_neutral_kobold",
    "npc_dota_neutral_kobold_tunneler",
    "npc_dota_creature_weekly_boss_tri",
    "npc_dota_creature_final_tron",
    "npc_dota_neutral_ogre_mauler",
    "npc_dota_neutral_satyr_hellcaller",
    "npc_dota_roshan_halloween_minion",
    "npc_dota_necronomicon_warrior_1",
    "npc_dota_neutral_kobold_taskmaster",
    "npc_dota_neutral_polar_furbolg_champion",
    "npc_dota_broodmother_spiderling",
    "npc_dota_warlock_golem_1",
    "npc_dota_neutral_centaur_outrunner",
    "npc_dota_brewmaster_earth_1",
    "npc_dota_unit_undying_zombie",
    "npc_dota_badguys_tower1_bot",
    "npc_dota_creep_badguys_ranged",
    "npc_dota_creep_badguys_ranged_upgraded",
    "npc_dota_creep_badguys_ranged_upgraded_mega",
    "npc_dota_creep_goodguys_ranged",
    "npc_dota_creature_tiny_creep",
    "npc_dota_creature_slardar_creep",
    "npc_dota_creature_clock_creep",
    "npc_dota_creature_gyro_creep",
    "npc_dota_creature_enigma_creep",
    "npc_dota_creature_aa_creep" ,
    "npc_dota_creature_lich_creep",
    "npc_dota_creature_wisp_creep",
    "npc_dota_creature_grimstroke_creep",
    "npc_dota_creature_dazzle_creep",
    "npc_dota_neutral_ogre_magi",
    "npc_dota_creep_goodguys_melee_upgraded_mega",
    "npc_dota_neutral_granite_golem",
    "npc_dota_necronomicon_archer_2",
    "npc_dota_neutral_polar_furbolg_ursa_warrior",
    "npc_dota_broodmother_spiderite",
    "npc_dota_furion_treant_large",
    "npc_dota_warlock_golem_2",
    "npc_dota_neutral_mud_golem_split",
    "npc_dota_neutral_mud_golem",
    "npc_dota_neutral_mud_golem_split_doom",
    "npc_dota_neutral_centaur_khan",
    "npc_dota_brewmaster_storm_1",
    "npc_dota_brewmaster_fire_1",
    "npc_dota_unit_undying_zombie_torso",
    "npc_dota_lone_druid_bear1",
    "npc_dota_goodguys_tower4",
    "npc_dota_courier",
    "npc_dota_creep_goodguys_ranged_upgraded_mega",
    "npc_boss_volk1",
    "npc_boss_volk2",
    "npc_dota_neutral_big_thunder_lizard",
    "npc_dota_creature_last_boss" ,
    "npc_dota_creature_tiny_boss",
    "npc_dota_creature_tide_boss",
    "npc_dota_creature_timbersaw_boss",
    "npc_dota_creature_tinker_boss",
    "npc_dota_creature_arc_warden_boss",
    "npc_dota_creature_tusk_boss",
    "npc_dota_creature_wywern_boss",
    "npc_dota_creature_cm_boss",
    "npc_dota_creature_qop_boss",
    "npc_dota_creature_templar_boss",
    "npc_dota_creature_luna_boss",
    "npc_dota_creature_lina_boss",
    "npc_dota_creature_meepo_boss",
    "npc_dota_creature_weekly_boss_odin",
    "npc_dota_creature_weekly_boss_dva",
    "npc_dota_creature_weekly_boss_new_year"
  }


  	local entityfound = nil


  	for _,theUnit in ipairs(unitNames) do


  		local pointName = Entities:FindAllByName("spawner_" .. theUnit)

  		if pointName ~= nil then
  			for _,thePoint in ipairs(pointName) do

                    local spawnPosition = thePoint:GetAbsOrigin()
                    PrecacheUnitByNameAsync(theUnit, function(...) end)
                    CreateUnitByNameAsync(theUnit, spawnPosition + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS, function(unit)
                        unit.respoint = spawnPosition

                        local red = unit:GetLevel() * 2
                        if red > 255 then red = 255 end

                        local green = 255-red
                        if green < 0 then green = 0 end

                        unit:SetCustomHealthLabel(unit:GetLevel() .. " lvl", red, green, 0)

                        GameMode:GiveDropItems(unit)

                        if unit:GetUnitName() == "npc_dota_creature_final_tron" then
                            unit:AddNewModifier(unit, nil, "modifier_custom_invulnerable", {})
                        end

                    end)



                    --if unit:GetUnitName() == "npc_special_event_halloween" then
                    --    unit:SetCustomHealthLabel("??? lvl", 255, 0, 0)
                    --end
  			end
    	end

      

    end

end


				--GameRules:SendCustomMessage("#Game_notification_",0,0)
function Spawn:DropItem( unit, item_name, chance )
	local ranFloat = RandomFloat(0, 100)
	if ranFloat <= chance then		
		local spawnPoint = unit:GetAbsOrigin()	
		local newItem = CreateItem( item_name, nil, nil )
		local drop = CreateItemOnPositionForLaunch( spawnPoint, newItem )
		local initialPoint = unit:GetAbsOrigin() + RandomVector( RandomFloat( 50, 125 ) )

		newItem:LaunchLootInitialHeight( false, 0, 150, 0.75, initialPoint )
	end
end



Spawn:InitGameMode()