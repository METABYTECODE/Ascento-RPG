
if Spawn == nil then
	_G.Spawn = class({})
end

Spawn.current_units = {}
Spawn.line_interval = {}
Spawn.wave_number = 0
Spawn.drop_chance = 10
Spawn.wave_kills = 0
Spawn.need_kills = 0

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
        for k, hero in pairs(get_team_heroes(DOTA_TEAM_GOODGUYS)) do
            if PlayerResource:GetConnectionState(hero:GetPlayerID()) == DOTA_CONNECTION_STATE_CONNECTED then
                GameMode:FastWin(hero:GetPlayerID())
            end
        end

        GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
        return
    end

    Timers:CreateTimer(5, function()
                              
        Spawn:SpawnLineUnits(self.wave_number) 

    end)

end

function Spawn:SpawnLineUnits(index)
    local current_wave = index
    if current_wave == nil then
        return
    end

    CustomGameEventManager:Send_ServerToAllClients( "monster_round", {str=tostring(current_wave)} )

    

    CustomGameEventManager:Send_ServerToAllClients( "item_has_spawned", {wave = current_wave} )
    EmitGlobalSound( "Overthrow.Item.Spawn" )

    local theAbilitiesTable1 = {}
    local theAbilitiesTable2 = {}
        
    for k, v in pairs(GameRules.theAbilities) do
        if v == 1 then
            table.insert(theAbilitiesTable1, k)
        elseif v == 2 then
            table.insert(theAbilitiesTable2, k)
        end
    end

    local creep_ability_1 = GetRandomTableElement(theAbilitiesTable1)
    local creep_ability_2 = GetRandomTableElement(theAbilitiesTable1)
    local creep_ability_3 = GetRandomTableElement(theAbilitiesTable1)

    while creep_ability_1 == creep_ability_2 or 
        creep_ability_2 == creep_ability_3 or 
        creep_ability_1 == creep_ability_3 or 
        (creep_ability_1 == "physical_resistance" and creep_ability_2 == "neutral_spell_immunity") or 
        (creep_ability_1 == "physical_resistance" and creep_ability_3 == "neutral_spell_immunity") or 
        (creep_ability_2 == "physical_resistance" and creep_ability_3 == "neutral_spell_immunity") 
    do
        creep_ability_1 = GetRandomTableElement(theAbilitiesTable1)
        creep_ability_2 = GetRandomTableElement(theAbilitiesTable1)
        creep_ability_3 = GetRandomTableElement(theAbilitiesTable1)
    end

    local creep_ability_2_1 = GetRandomTableElement(theAbilitiesTable2)
    local creep_ability_2_2 = GetRandomTableElement(theAbilitiesTable2)
    local creep_ability_2_3 = GetRandomTableElement(theAbilitiesTable2)

    while creep_ability_2_1 == creep_ability_2_2 or 
        creep_ability_2_2 == creep_ability_2_3 or 
        creep_ability_2_1 == creep_ability_2_3 or 
        (creep_ability_2_1 == "physical_resistance" and creep_ability_2_2 == "neutral_spell_immunity") or 
        (creep_ability_2_1 == "physical_resistance" and creep_ability_2_3 == "neutral_spell_immunity") or 
        (creep_ability_2_2 == "physical_resistance" and creep_ability_2_3 == "neutral_spell_immunity") 
    do
        creep_ability_2_1 = GetRandomTableElement(theAbilitiesTable2)
        creep_ability_2_2 = GetRandomTableElement(theAbilitiesTable2)
        creep_ability_2_3 = GetRandomTableElement(theAbilitiesTable2)
    end

    local point1 = Entities:FindByName( nil, "line_1_spawn"):GetAbsOrigin()
    --local waypoint1 = Entities:FindByName( nil, "path_corner_1_1")
--
    local point2 = Entities:FindByName( nil, "line_2_spawn"):GetAbsOrigin() 
    --local waypoint2 = Entities:FindByName( nil, "path_corner_2_1") 
--
    local point3 = Entities:FindByName( nil, "line_3_spawn"):GetAbsOrigin() 
    --local waypoint3 = Entities:FindByName( nil, "path_corner_3_1")
--
    local point4 = Entities:FindByName( nil, "line_4_spawn"):GetAbsOrigin() 
    --local waypoint4 = Entities:FindByName( nil, "path_corner_4_1")


    local unit_name = "npc_ny_creep_1"
    local boss = "npc_ny_boss_"
    local currentmodel = nil
    Spawn.wave_kills = 0
    Spawn.need_kills = 0

    for k, v in pairs(GameRules.theUnits) do
       if v == current_wave then
          currentmodel = k
       end
    end


    --print("1 " .. creep_ability_1)
    --print("2 " .. creep_ability_2)
    --print("3 " .. creep_ability_3)
    --print("4 " .. creep_ability_2_1)
    --print("5 " .. creep_ability_2_2)
    --print("6 " .. creep_ability_2_3)

    if current_wave == 10 or current_wave == 20 or current_wave == 30 or current_wave == 40 or current_wave == 50 then
        Spawn.need_kills = Spawn.need_kills + 1
        local unit = CreateUnitByName( boss .. current_wave , point3 + RandomVector( RandomFloat( 0, 100 ) ), true, nil, nil, DOTA_TEAM_BADGUYS ) 

        unit:SetModel(currentmodel)
        unit:SetOriginalModel(currentmodel)
        unit:SetModelScale(2)

        unit:CreatureLevelUp(current_wave-1)

        unit:AddAbility(creep_ability_1):SetLevel(1)
        
        unit:AddAbility(creep_ability_2_1):SetLevel(1)

        --unit:SetInitialGoalEntity( waypoint3 )
        unit.reward = true
        local ent_index = unit:entindex()
--          table.insert(self.current_units, ent_index, unit)
        self.current_units[ent_index] = unit
    else

        for point_num=1, 4 do
            for i=1, 10 do

                

                if point_num == 1 then
                    point = point1
                    --waypoint = waypoint1
                end
                if point_num == 2 then
                    point = point2
                    --waypoint = waypoint2
                end
                if point_num == 3 then
                    point = point3
                    --waypoint = waypoint3
                end
                if point_num == 4 then
                    point = point4
                    --waypoint = waypoint4
                end

                Spawn.need_kills = Spawn.need_kills + 1

                local unit = CreateUnitByName( unit_name , point + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_BADGUYS ) 
                unit.clone = false

                --unit:SetInitialGoalEntity( waypoint )
                --unit:SetInitialWaypoint("path_corner_1_12")
                unit.reward = true

                unit:SetModel(currentmodel)
                unit:SetOriginalModel(currentmodel)

                unit:CreatureLevelUp(current_wave-1)

                if i == 5 then
                    --Крип чемпион

                    unit:SetModelScale(1.8)

                    unit:SetBaseDamageMin(unit:GetBaseDamageMin() * 2)
                    unit:SetBaseDamageMax(unit:GetBaseDamageMax() * 2)

                    unit:SetBaseMaxHealth(unit:GetBaseMaxHealth() * 2)
                    unit:SetHealth(unit:GetMaxHealth())
                    unit:SetDeathXP(unit:GetDeathXP() * 2)
                    unit:SetMinimumGoldBounty(unit:GetMinimumGoldBounty() * 2)
                    unit:SetMaximumGoldBounty(unit:GetMaximumGoldBounty() * 2)

                    unit:SetPhysicalArmorBaseValue(unit:GetPhysicalArmorBaseValue() * 2)

                    unit:SetRenderColor(255, 165, 0)

                    if self.wave_number > 30 then
                        local ability1 = unit:AddAbility(creep_ability_2_1)
                        ability1:SetLevel(ability1:GetMaxLevel())

                        local ability2 = unit:AddAbility(creep_ability_2_2)
                        ability2:SetLevel(ability2:GetMaxLevel())

                        local ability3 = unit:AddAbility(creep_ability_2_3)
                        ability3:SetLevel(ability3:GetMaxLevel())
                    else
                        unit:AddAbility(creep_ability_2_1):SetLevel(1)
                        
                        unit:AddAbility(creep_ability_2_2):SetLevel(1)
                    end

                    ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)

                else

                    unit:SetModelScale(1)

                    if self.wave_number > 30 then
                        local ability1 = unit:AddAbility(creep_ability_1)
                        ability1:SetLevel(ability1:GetMaxLevel())
                        
                        local ability2 = unit:AddAbility(creep_ability_2)
                        ability2:SetLevel(ability2:GetMaxLevel())

                        local ability3 = unit:AddAbility(creep_ability_3)
                        ability3:SetLevel(ability3:GetMaxLevel())
                    else
                        unit:AddAbility(creep_ability_1):SetLevel(1)
                        
                        unit:AddAbility(creep_ability_2):SetLevel(1)
                    end

                end

                if not unit:HasModifier("modifier_ny_over") then
                    unit:AddNewModifier (unit, nil, "modifier_ny_over", {duration = -1})
                end

                --local item = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/creeps/roshan/roshan_hat_fx.vmdl"})
                --item:FollowEntity(unit, true)
                --unit.roshan_hat = item

                local ent_index = unit:entindex()
                --table.insert(self.current_units, ent_index, unit)
                self.current_units[ent_index] = unit

            end
        end
    end

    local data={}
    data["liveNum"]=Spawn.need_kills - Spawn.wave_kills
    data["maxNum"]=Spawn.need_kills
    CustomGameEventManager:Send_ServerToAllClients( "monster_number_changing",data)

    --CustomGameEventManager:Send_ServerToAllClients("on_player_kill_creeps", {playerKilledCreeps = tonumber(Spawn.wave_kills), need_kill_creeps = tonumber(Spawn.need_kills)})

    --CustomGameEventManager:Send_ServerToAllClients("on_player_kill_boss", {playerKilledBoss = tonumber(Spawn.need_kills), need_kill_boss = 100})

end

function Spawn:RandomStatDrop( hero )
    if RollPercentage(20) then
        local bookRnd = RandomInt(1, 3)
        local givebook = nil
        if bookRnd == 1 then 
            givebook = "item_tome_str_3"
        elseif bookRnd == 2 then 
            givebook = "item_tome_agi_3"
        elseif bookRnd == 3 then 
            givebook = "item_tome_int_3"
        end

        if givebook ~= nil then 
            local item = CreateItem(givebook, nil, nil)
            local pos = hero:GetAbsOrigin()
            local drop = CreateItemOnPositionSync(pos, item)
            local pos_launch = pos + RandomVector(RandomFloat(50, 100))
            if item ~= nil then
                item:LaunchLoot(false, 200, 0.75, pos_launch)
            end
        end
    end
end


function Spawn:OnEntityKilled( keys )
	local unit = EntIndexToHScript( keys.entindex_killed )
	local killer = EntIndexToHScript( keys.entindex_attacker )
	local name = unit:GetUnitName()

    --if unit.roshan_hat ~= nil then
    --    UTIL_Remove(unit.roshan_hat)
    --end

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

    --item_tome_agi_3
    if unit.clone == nil then
        unit.clone = true
    end
    
    if IsEventASCENTO(unit) and unit.clone ~= nil then
        if unit.clone ~= true then
            Spawn.wave_kills = Spawn.wave_kills + 1
            
            local data={}
            data["liveNum"]=Spawn.need_kills - Spawn.wave_kills
            data["maxNum"]=Spawn.need_kills
            CustomGameEventManager:Send_ServerToAllClients( "monster_number_changing",data)

            --CustomGameEventManager:Send_ServerToAllClients("on_player_kill_creeps", {playerKilledCreeps = tonumber(Spawn.wave_kills), need_kill_creeps = 100})
            Spawn:RandomStatDrop(killer)
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