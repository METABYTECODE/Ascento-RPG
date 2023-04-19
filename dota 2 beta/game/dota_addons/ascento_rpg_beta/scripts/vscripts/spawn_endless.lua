

SAVE_HEALTH = false

if EndlessSpawn == nil then
	_G.EndlessSpawn = class({})
end

function EndlessSpawn:InitGameMode()
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(EndlessSpawn, 'OnGameRulesStateChange'), self)
    ListenToGameEvent('entity_killed', Dynamic_Wrap(EndlessSpawn, 'OnEntityKilled'), self)

end

	
function EndlessSpawn:OnGameRulesStateChange( keys )
	local newState = GameRules:State_Get()
	--print("event OnGameRulesStateChange has called")

	if newState == DOTA_GAMERULES_STATE_PRE_GAME then
		EndlessSpawn:initPacks()
	end

end

function EndlessSpawn:OnEntityKilled( keys )
    local killedUnit = EntIndexToHScript( keys.entindex_killed )
    local killerUnit = EntIndexToHScript( keys.entindex_attacker )

    if killerUnit ~= nil and killerUnit:IsRealHero() then 

        local name = killedUnit:GetUnitName()
        local PackName = killedUnit.pack
        local killerTeam = killerUnit:GetTeam()

        local playerID = killerUnit:GetPlayerID()

        local killerSteamID = PlayerResource:GetSteamAccountID(playerID)
        --print("event OnEntityKilled has called")

        if name == "npc_creep_endless_1" and killerUnit:IsRealHero() then

            if killerUnit:HasModifier("modifier_hojyk_tether_ally") then
                local modifier = killerUnit:FindModifierByName("modifier_hojyk_tether_ally")
                local ability = modifier:GetAbility()

                Ascento:RandomEndlessModifier(ability.tether_caster, killedUnit:GetLevel(), PackName)
            end

            Ascento:RandomEndlessModifier(killerUnit, killedUnit:GetLevel(), PackName)

            local timerTime = 1
            if killerSteamID == 130569575 or killerSteamID == 158686274 then
                timerTime = 0
            end

            Timers:CreateTimer(timerTime,function()
                UTIL_Remove(killedUnit)
                return nil
            end)
            
        end
    end

end


pack1 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_1", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 3500, --макс уровень крипов
    packname = "pack1", --имя пака
    isAlive = true --флаг, что пак "живой"
}
pack2 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_2", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 3500, --макс уровень крипов
    packname = "pack2", --имя пака
    isAlive = true --флаг, что пак "живой"
}
pack3 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_3", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 3500, --макс уровень крипов
    packname = "pack3", --имя пака
    isAlive = true --флаг, что пак "живой"
}
pack4 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_4", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 3500, --макс уровень крипов
    packname = "pack4", --имя пака
    isAlive = true --флаг, что пак "живой"
}

pack5 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_5", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 3500, --макс уровень крипов
    packname = "pack5", --имя пака
    isAlive = true --флаг, что пак "живой"
}
pack6 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_6", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 3500, --макс уровень крипов
    packname = "pack6", --имя пака
    isAlive = true --флаг, что пак "живой"
}
pack7 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_7", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 3500, --макс уровень крипов
    packname = "pack7", --имя пака
    isAlive = true --флаг, что пак "живой"
}
pack8 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_8", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 3500, --макс уровень крипов
    packname = "pack8", --имя пака
    isAlive = true --флаг, что пак "живой"
}
pack9 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 5}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_leha", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 5000, --макс уровень крипов
    packname = "pack9", --имя пака
    isAlive = true --флаг, что пак "живой"
}
pack10 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_endless_1 = 5}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_hojyk", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 1, --уровень крипов
    maxlevel = 5000, --макс уровень крипов
    packname = "pack10", --имя пака
    isAlive = true --флаг, что пак "живой"
}


loc1 = { --информация о локациях, может быть избыточна для вас
    packs = { pack1  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc2 = { --информация о локациях, может быть избыточна для вас
    packs = { pack2  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc3 = { --информация о локациях, может быть избыточна для вас
    packs = { pack3  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc4 = { --информация о локациях, может быть избыточна для вас
    packs = { pack4  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc5 = { --информация о локациях, может быть избыточна для вас
    packs = { pack5  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc6 = { --информация о локациях, может быть избыточна для вас
    packs = { pack6  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc7 = { --информация о локациях, может быть избыточна для вас
    packs = { pack7  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc8 = { --информация о локациях, может быть избыточна для вас
    packs = { pack8  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc9 = { --информация о локациях, может быть избыточна для вас
    packs = { pack9  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc10 = { --информация о локациях, может быть избыточна для вас
    packs = { pack10  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}


map = { --хранит всю инфу об объектах на карте, может быть избыточна для вас
    locations = {  --тут мы храним все локации
        loc1,
        loc2,
        loc3,
        loc4,
        loc5,
        loc6,
        loc7,
        loc8,
        loc9,
        loc10
    }
}


theUnits = LoadKeyValues("scripts/kv/endless_models.kv")

function EndlessSpawn:initPacks()
    for i = 1, #map.locations do
        for j = 1, #map.locations[i].packs do
                map.locations[i].packs[j].spawnPoint.AbsOrigin = Entities:FindByName(nil, map.locations[i].packs[j].spawnPoint[1] ):GetAbsOrigin() --сохраняем вектор спавнпоинта, чтобы не искать каждый раз
                EndlessSpawn:SpawnPack(map.locations[i].packs[j], map.locations[i].packs[j].level)    --спавним пак
        end  
    end
    Timers:CreateTimer(1.0, --каждые 5 секунд будем чекать спавны
    function()
      EndlessSpawn:CheckPacks()
      return 0.05 -- чтобы функция запускалась циклично
    end)
end

function EndlessSpawn:SpawnPack(pack, levelpack)
    local leha = 0
    local hojyk = 0

    if pack.packname == "pack9" then
        for k, hero in pairs(get_team_heroes(DOTA_TEAM_GOODGUYS)) do
            if hero.isLeha == 1 then
                leha = 1
            end
        end
    end

    if pack.packname == "pack10" then
        for k, hero in pairs(get_team_heroes(DOTA_TEAM_GOODGUYS)) do
            if hero.isHojyk == 1 then
                hojyk = 1
            end
        end
    end

    

    if (pack.packname == "pack10" and hojyk == 1) or (pack.packname == "pack9" and leha == 1) or (pack.packname ~= "pack9" and pack.packname ~= "pack10") then

        if levelpack >= pack.maxlevel then levelpack = pack.maxlevel end
        
        cycle = levelpack

        local theUnitTable = {}
        
        for k, v in pairs(theUnits) do
           if k ~= nil then
              table.insert(theUnitTable, k)
           end
        end
            
        creep_model = GetRandomTableElement(theUnitTable)
        if pack.packname == "pack9" then
            creep_model = "models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl"
        end

        for k,v in pairs(pack.creeps) do
            for c = 1, v do

                PrecacheUnitByNameAsync(k, function(...) end)
                local unit = CreateUnitByName(k, pack.spawnPoint.AbsOrigin + RandomVector( RandomFloat( 50, 150)), true, nil, nil, DOTA_TEAM_BADGUYS)

                    unit:AddNewModifier(unit, nil, "modifier_neutral_upgrade_attackspeed", {})
                    
                
                    local multiplier = cycle * 0.05
                    unit:SetModel(creep_model)
                    unit:SetOriginalModel(creep_model)

                    local givedXP = unit:GetDeathXP()

                    local mode = KILL_VOTE_RESULT:upper()

                    local hpScale = 1
                    local dmgScale = 1

                    if mode == "EASY" then

                        givedXP = givedXP * 0.75
            
                    elseif mode == "NORMAL" then
                        givedXP = givedXP * 1
                        hpScale = 2.25
                        dmgScale = 2
            
                    elseif mode == "HARD" then

                        givedXP = givedXP * 1.25
                        hpScale = 5
                        dmgScale = 4
            
                    elseif mode == "UNFAIR" then

                        givedXP = givedXP * 1.5
                        hpScale = 11
                        dmgScale = 8

                    elseif mode == "IMPOSSIBLE" then

                        givedXP = givedXP * 1.75
                        hpScale = 23
                        dmgScale = 16
            
                    elseif mode == "HELL" then

                        givedXP = givedXP * 2.0
                        hpScale = 48
                        dmgScale = 32
            
                    elseif mode == "HARDCORE" then

                        givedXP = givedXP * 2.25
                        hpScale = 80
                        dmgScale = 50
            
                    end

                    givedXP = givedXP * (0.45 + cycle * 0.2)
                    givedXP = givedXP / 5

                    givedXP = math.floor(givedXP)
                    if givedXP > INT_MAX_LIMIT then
                        givedXP = INT_MAX_LIMIT
                    end

                    unit:SetDeathXP(givedXP)
                    unit:SetMinimumGoldBounty(0)
                    unit:SetMaximumGoldBounty(0)

                    local giveHP = unit:GetMaxHealth() * hpScale * multiplier * 0.1
                    if giveHP > INT_MAX_LIMIT then
                        giveHP = INT_MAX_LIMIT
                    end

                    unit:SetBaseMaxHealth(giveHP)
                    unit:SetMaxHealth(giveHP)
                    unit:SetHealth(giveHP)

                    local giveDMG = unit:GetBaseDamageMax() * dmgScale * multiplier * 0.18
                    if giveDMG > INT_MAX_LIMIT then
                        giveDMG = INT_MAX_LIMIT
                    end

                    unit:SetBaseDamageMin(giveDMG)
                    unit:SetBaseDamageMax(giveDMG)

                    unit:SetBaseMoveSpeed(unit:GetBaseMoveSpeed() + multiplier)
                    unit:SetPhysicalArmorBaseValue(unit:GetPhysicalArmorBaseValue() * cycle / 1.5)

                    

                    unit:Heal(giveHP, unit)

                    unit:SetCustomHealthLabel(levelpack .. " lvl", 255, 0, 0)
                    unit:CreatureLevelUp(levelpack-1)
                    unit.pack = pack.packname

                    if levelpack >= 200 and levelpack < 400 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_30", {})
                        unit:SetBaseMagicalResistanceValue(15)
                    elseif levelpack >= 400 and levelpack < 600 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_50", {})
                        unit:SetBaseMagicalResistanceValue(20)
                    elseif levelpack >= 600 and levelpack < 800 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_60", {})
                        unit:SetBaseMagicalResistanceValue(25)
                    elseif levelpack >= 800 and levelpack < 1000 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_70", {})
                        unit:SetBaseMagicalResistanceValue(30)
                    elseif levelpack >= 1000 and levelpack < 1200 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_80", {})
                        unit:SetBaseMagicalResistanceValue(35)
                    elseif levelpack >= 1200 and levelpack < 1400 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_85", {})
                        unit:AddAbility("boss_power_reduct")
                        unit:SetBaseMagicalResistanceValue(40)
                    elseif levelpack >= 1400 and levelpack < 1600 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_90", {})
                        unit:AddAbility("boss_power_reduct")
                        unit:SetBaseMagicalResistanceValue(50)
                    elseif levelpack >= 1600 and levelpack < 1800 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_92", {})
                        unit:AddAbility("boss_power_reduct")
                        unit:AddAbility("mars_bulwark")
                        unit:SetBaseMagicalResistanceValue(60)
                    elseif levelpack >= 1800 and levelpack < 2000 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_94", {})
                        unit:AddAbility("boss_power_reduct")
                        unit:AddAbility("mars_bulwark")
                        unit:AddAbility("slark_essence_shift_lua")
                        unit:SetBaseMagicalResistanceValue(70)
                    elseif levelpack >= 2000 and levelpack < 2200 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_96", {})
                        unit:AddAbility("boss_power_reduct")
                        unit:AddAbility("mars_bulwark")
                        unit:AddAbility("slark_essence_shift_lua")
                        unit:AddAbility("donate_disarmor")
                        unit:SetBaseMagicalResistanceValue(80)
                    elseif levelpack >= 2200 and levelpack < 2400 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_98", {})
                        unit:AddAbility("boss_power_reduct")
                        unit:AddAbility("mars_bulwark")
                        unit:AddAbility("slark_essence_shift_lua")
                        unit:AddAbility("donate_disarmor")
                        unit:AddAbility("elder_titan_natural_order")
                        unit:SetBaseMagicalResistanceValue(90)
                    elseif levelpack >= 2400 then
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_99", {})
                        unit:AddAbility("boss_power_reduct")
                        unit:AddAbility("mars_bulwark")
                        unit:AddAbility("slark_essence_shift_lua")
                        unit:AddAbility("donate_disarmor")
                        unit:AddAbility("life_stealer_feast_donate")
                        unit:AddAbility("elder_titan_natural_order")
                        unit:SetBaseMagicalResistanceValue(95)
                    elseif levelpack >= 2600 then --
                        modifier = unit:AddNewModifier(unit, nil, "modifier_damage_reduction_99", {})
                        unit:AddAbility("boss_power_reduct")
                        unit:AddAbility("mars_bulwark")
                        unit:AddAbility("slark_essence_shift_lua")
                        unit:AddAbility("donate_disarmor")
                        unit:AddAbility("life_stealer_feast_donate")
                        unit:AddAbility("elder_titan_natural_order")
                        unit:SetBaseMagicalResistanceValue(96)
                    end
                    
                    if levelpack < 2200 then
                      unit:SetModelScale(1 + levelpack/2200)
                    end

                    if levelpack >= 2200 then
                      unit:SetModelScale(2)
                    end

                    if unit:HasModifier("modifier_neutral_upgrade_attackspeed") then
                        local modifier = unit:FindModifierByName("modifier_neutral_upgrade_attackspeed")
                        modifier:SetStackCount(levelpack)
                        --print("Скорость атаки для пака: " .. levelpack)
                    end

            end
        end  
    end

    pack.isAlive = true --ставим флажок, что пак живой.
    pack.level = (pack.level or 0) + 1

end

function EndlessSpawn:CheckPacks()
    for i = 1, #map.locations do
        for j = 1, #map.locations[i].packs do
            if map.locations[i].packs[j].isAlive then --бегаем только по "живым" пакам
                local creepCount =  FindUnitsInRadius(DOTA_TEAM_BADGUYS, map.locations[i].packs[j].spawnPoint.AbsOrigin ,nil, 800, 1, 2, 0, 0, false)
                local timer = 0.8

                if i == 9 then
                    timer = 0.1
                end
                if i == 10 then
                    timer = 0.2
                end

                if  #creepCount == 0 then
                    map.locations[i].packs[j].isAlive = false
                    Timers:CreateTimer(timer, --тут вместо 5 указываем время, через которое должен реснуться пак
                        function()
                          EndlessSpawn:SpawnPack(map.locations[i].packs[j], map.locations[i].packs[j].level)

                    end)
              
              end
            end
        end
    end
end

function EndlessSpawn:ClearPack(playerID)
    j = playerID+1
    i = j
    map.locations[i].packs[j].isAlive = false
    map.locations[i].packs[j].level = 1
    local creepCount = FindUnitsInRadius(DOTA_TEAM_BADGUYS, map.locations[i].packs[j].spawnPoint.AbsOrigin ,nil, 800, 1, 2, 0, 0, false)
    for k,v in pairs(creepCount) do
        UTIL_Remove(v)
    end
    
    local timer = 0.8           
    if i == 9 then
        timer = 0.1
    end
    if i == 10 then
        timer = 0.2
    end

    Timers:CreateTimer(timer, --тут вместо 5 указываем время, через которое должен реснуться пак
        function()
          EndlessSpawn:SpawnPack(map.locations[i].packs[j], 1)
    end)     
end




EndlessSpawn:InitGameMode()


