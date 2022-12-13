
if Spawn == nil then
	_G.Spawn = class({})
end

Spawn.current_units = {}
Spawn.line_interval = {}
Spawn.wave_number = 0

function Spawn:InitGameMode()
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(Spawn, 'OnGameRulesStateChange'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(Spawn, 'OnEntityKilled'), self)

end


	
function Spawn:OnGameRulesStateChange( keys )
	local newState = GameRules:State_Get()
	--print("event OnGameRulesStateChange has called")

	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		Spawn:LineBossSpawner()

        local rosh_spawner = Entities:FindByName( nil, "spawner_ny_rosh"):GetAbsOrigin()
        local unit = CreateUnitByName( "npc_roshan_def_ny" , rosh_spawner + RandomVector( RandomFloat( 0, 100 ) ), true, nil, nil, DOTA_TEAM_GOODGUYS ) 

	end
end

function Spawn:LineBossSpawner( keys )
    self.wave_number = self.wave_number + 1
    

    if self.wave_number > 50 then
        GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
        return
    end

    Spawn:SpawnLineUnits(self.wave_number) 

end

function Spawn:SpawnLineUnits(index)
    local current_wave = index
    if current_wave == nil then
        return
    end

    local point1 = Entities:FindByName( nil, "line_1_spawn"):GetAbsOrigin()
    local waypoint1 = Entities:FindByName( nil, "path_corner_1_1")

    local point2 = Entities:FindByName( nil, "line_2_spawn"):GetAbsOrigin() 
    local waypoint2 = Entities:FindByName( nil, "path_corner_2_1") 

    local point3 = Entities:FindByName( nil, "line_3_spawn"):GetAbsOrigin() 
    local waypoint3 = Entities:FindByName( nil, "path_corner_3_1")

    local point4 = Entities:FindByName( nil, "line_4_spawn"):GetAbsOrigin() 
    local waypoint4 = Entities:FindByName( nil, "path_corner_4_1")


    local unit_name = "npc_ny_creep_"
    local boss = "npc_ny_boss_"

    if current_wave > 0 and current_wave <= 10 then
        unit_name = unit_name .. "1"
    elseif current_wave > 10 and current_wave <= 20 then
        unit_name = unit_name .. "2"
    elseif current_wave > 20 and current_wave <= 30 then
        unit_name = unit_name .. "3"
    elseif current_wave > 30 and current_wave <= 40 then
        unit_name = unit_name .. "4"
    elseif current_wave > 40 and current_wave <= 50 then
        unit_name = unit_name .. "5"
    end

    if current_wave == 10 or current_wave == 20 or current_wave == 30 or current_wave == 40 or current_wave == 50 then
        local unit = CreateUnitByName( boss .. current_wave , point3 + RandomVector( RandomFloat( 0, 100 ) ), true, nil, nil, DOTA_TEAM_BADGUYS ) 
        unit:SetInitialGoalEntity( waypoint3 )
        unit.reward = true
        local ent_index = unit:entindex()
--          table.insert(self.current_units, ent_index, unit)
        self.current_units[ent_index] = unit
    end
    timer_time = 0

--  GameRules:SendCustomMessage("#Game_notification_boss_spawn_"..boss_name,0,0)
    for point_num=1, 4 do
        for i=1, 10 do


            if point_num == 1 then
                point = point1
                waypoint = waypoint1
            end
            if point_num == 2 then
                point = point2
                waypoint = waypoint2
            end
            if point_num == 3 then
                point = point3
                waypoint = waypoint3
            end
            if point_num == 4 then
                point = point4
                waypoint = waypoint4
            end

            local unit = CreateUnitByName( unit_name , point + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_BADGUYS ) 
            unit:SetInitialGoalEntity( waypoint )
            unit.reward = true

            if not unit:HasModifier("modifier_movespeed_cap") then
                unit:AddNewModifier (unit, nil, "modifier_movespeed_cap", {duration = -1})
            end

            local item = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/creeps/roshan/roshan_hat_fx.vmdl"})
            item:FollowEntity(unit, true)
            unit.roshan_hat = item

            local ent_index = unit:entindex()
            --table.insert(self.current_units, ent_index, unit)
            self.current_units[ent_index] = unit


        end
    end
end

function Spawn:OnEntityKilled( keys )
	local unit = EntIndexToHScript( keys.entindex_killed )
	local killer = EntIndexToHScript( keys.entindex_attacker )
	local name = unit:GetUnitName()

    if unit.roshan_hat ~= nil then
        UTIL_Remove(unit.roshan_hat)
    end

    if name == "npc_roshan_def_ny" then
        GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)      
    end

    if unit.reward then
        local ent_index = unit:entindex()
        
        self.current_units[ent_index] = nil
        local units = 0
        for key,value in pairs(self.current_units) do
            units = units + 1
        end

        if units == 0 then
            local reward_gold = self.wave_number * 100
            local reward_exp = self.wave_number * 100

            GiveGoldPlayers( reward_gold )
            GiveExperiencePlayers( reward_exp )

            Spawn:LineBossSpawner()
        end
    end

    
    if killer:IsRealHero() then 
        if IsEventASCENTO(killedUnit) then
            CREEP_TEAM_KILLS = CREEP_TEAM_KILLS + 1
            CustomGameEventManager:Send_ServerToAllClients("on_player_kill_event", {KilledEvents = tonumber(CREEP_TEAM_KILLS)})
        end
    end

end

function GiveGoldPlayers( gold )
    for index=0, 8 do
        if PlayerResource:HasSelectedHero(index) then
            local player = PlayerResource:GetPlayer(index)
            local hero = PlayerResource:GetSelectedHeroEntity(index)
            hero:ModifyGold(gold, false, 0)
            SendOverheadEventMessage( player, OVERHEAD_ALERT_GOLD, hero, gold, nil )
        end
    end
end

function GiveExperiencePlayers( experience )
    for index=0, 8 do
        if PlayerResource:HasSelectedHero(index) then
            local player = PlayerResource:GetPlayer(index)
            local hero = PlayerResource:GetSelectedHeroEntity(index)
            hero:AddExperience(experience, 0, false, true )
        end
    end
end



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