

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
		Spawn:initPacks()
        Spawn:FirstSpawnBoss()
	end

end

function Spawn:OnEntityKilled( keys )
    local killedUnit = EntIndexToHScript( keys.entindex_killed )
    local killerUnit = EntIndexToHScript( keys.entindex_attacker )
    local name = killedUnit:GetUnitName()
    local killerTeam = killerUnit:GetTeam()
    --print("event OnEntityKilled has called")


    if name == "npc_boss1" then


        local caster_respoint = Entities:FindByName(nil,"boss_1"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(10, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)

        end)

    elseif name == "npc_boss2" then


        local caster_respoint = Entities:FindByName(nil,"boss_2"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(10, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)

    elseif name == "npc_boss3" then


        local caster_respoint = Entities:FindByName(nil,"boss_3"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(10, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)

    elseif name == "npc_boss4" then



        local caster_respoint = Entities:FindByName(nil,"boss_4"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(10, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)


    elseif name == "npc_b_1" then

        local caster_respoint = Entities:FindByName(nil,"spawn_b_1"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(5, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)

    elseif name == "npc_b_2" then

        local caster_respoint = Entities:FindByName(nil,"spawn_b_2"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(5, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)
        
    elseif name == "npc_b_3" then

        local caster_respoint = Entities:FindByName(nil,"spawn_b_3"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(5, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)
        
    elseif name == "npc_b_4" then

        local caster_respoint = Entities:FindByName(nil,"spawn_b_4"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(5, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)
        
    elseif name == "npc_b_5" then

        local caster_respoint = Entities:FindByName(nil,"spawn_b_5"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(5, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)
        
    elseif name == "npc_b_6" then

        local caster_respoint = Entities:FindByName(nil,"spawn_b_6"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(5, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)
        
    elseif name == "npc_b_7" then

        local caster_respoint = Entities:FindByName(nil,"spawn_b_7"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(5, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)
        
    elseif name == "npc_b_8" then

        local caster_respoint = Entities:FindByName(nil,"spawn_b_8"):GetAbsOrigin() --Пробиваем адрес дома
        Timers:CreateTimer(5, function()              --Через сколько секунд появится новый фраер(5)
            local unit = CreateUnitByName(name, caster_respoint + RandomVector( RandomFloat( 0, 50)), true, nil, nil, DOTA_TEAM_BADGUYS) --создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
            
        --GameRules:SetSafeToLeave( true )
        --GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end)
        
    elseif name == "npc_b_9" then --Финальный босс

        GameRules:SetSafeToLeave( true )
        GameRules:SetGameWinner( killerTeam )


    elseif name == "npc_ascmka_1" then --цмка первой тимы

        --GameRules:SetSafeToLeave( true )
        --GameRules:MakeTeamLose(DOTA_TEAM_CUSTOM_1)

            elseif name == "npc_ascmka_2" then --цмка первой тимы

               -- GameRules:SetSafeToLeave( true )
                --GameRules:MakeTeamLose(DOTA_TEAM_CUSTOM_2)

            elseif name == "npc_ascmka_3" then --цмка первой тимы

       -- GameRules:SetSafeToLeave( true )
       -- GameRules:MakeTeamLose(DOTA_TEAM_CUSTOM_3)

            elseif name == "npc_ascmka_4" then --цмка первой тимы

       -- GameRules:SetSafeToLeave( true )
        --GameRules:MakeTeamLose(DOTA_TEAM_CUSTOM_4)


    end
end



function Spawn:FirstSpawnBoss( keys )
    local name = "npc_boss1" 
    local spawnPosition1 = Entities:FindByName(nil, "boss_1"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_boss2" 
    local spawnPosition1 = Entities:FindByName(nil, "boss_2"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_boss3" 
    local spawnPosition1 = Entities:FindByName(nil, "boss_3"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)
    
    local name = "npc_boss4" 
    local spawnPosition1 = Entities:FindByName(nil, "boss_4"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_b_1" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_b_1"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_b_2" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_b_2"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_b_3" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_b_3"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_b_4" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_b_4"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_b_5" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_b_5"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_b_6" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_b_6"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_b_7" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_b_7"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_b_8" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_b_8"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_b_9" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_b_9"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_BADGUYS)

    local name = "npc_ascmka_1" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_cmka_1"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_CUSTOM_1)

    local name = "npc_ascmka_2" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_cmka_2"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_CUSTOM_2)

    local name = "npc_ascmka_3" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_cmka_3"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_CUSTOM_3)

    local name = "npc_ascmka_4" 
    local spawnPosition1 = Entities:FindByName(nil, "spawn_cmka_4"):GetAbsOrigin()
    local unit = CreateUnitByName(name, spawnPosition1, true, nil, nil, DOTA_TEAM_CUSTOM_4)

end


pack1 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_1", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack2 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_2", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack3 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_3", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack4 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_1 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_1_4", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}

pack5 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_2 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_2_1", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack6 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_2 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_2_2", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack7 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_2 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_2_3", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack8 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_2 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_2_4", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}

pack9 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_3 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_3_1", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack10 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_3 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_3_2", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack11 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_3 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_3_3", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack12 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_3 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_3_4", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}

pack13 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_4 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_4_1", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack14 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_4 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_4_2", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack15 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_4 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_4_3", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
    isAlive = true --флаг, что пак "живой"
}
pack16 = {    --эта таблица хранит инфу о паке
    creeps = { npc_creep_farm_4 = 3}, --тут мы храним инфу о том кого мы спавним и в каком количестве. Имя - ключ, количество - значение.
    spawnPoint = {"spawn_4_4", AbsOrigin = "" }, -- тут мы храним инфу о спавнпоинте, имя ставите такое же как указали у спавнпоинта
    level = 0, --уровень крипов
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
loc11 = { --информация о локациях, может быть избыточна для вас
    packs = { pack11  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc12 = { --информация о локациях, может быть избыточна для вас
    packs = { pack12  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc13 = { --информация о локациях, может быть избыточна для вас
    packs = { pack13  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc14 = { --информация о локациях, может быть избыточна для вас
    packs = { pack14  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc15 = { --информация о локациях, может быть избыточна для вас
    packs = { pack15  }, --информация о паках на локации
    locationLevel = 1 -- текущий уровень локации
}
loc16 = { --информация о локациях, может быть избыточна для вас
    packs = { pack16  }, --информация о паках на локации
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
        loc10,
        loc11,
        loc12,
        loc13,
        loc14,
        loc15,
        loc16
    }
}




function Spawn:initPacks()
    for i = 1, #map.locations do
        for j = 1, #map.locations[i].packs do
                map.locations[i].packs[j].spawnPoint.AbsOrigin = Entities:FindByName(nil, map.locations[i].packs[j].spawnPoint[1] ):GetAbsOrigin() --сохраняем вектор спавнпоинта, чтобы не искать каждый раз
                Spawn:SpawnPack(map.locations[i].packs[j], map.locations[i].packs[j].level)    --спавним пак
        end  
    end
    Timers:CreateTimer(0.1, --каждые 5 секунд будем чекать спавны
    function()
      Spawn:CheckPacks()
      return 0.05 -- чтобы функция запускалась циклично
    end)
end

function Spawn:SpawnPack(pack, levelpack)

cycle = levelpack


    for k,v in pairs(pack.creeps) do
                    for c = 1, v do
                        local unit = CreateUnitByName(
                        k,
                        pack.spawnPoint.AbsOrigin,
                        true,
                        nil,
                        nil,
                        DOTA_TEAM_BADGUYS)  

                        

  local multiplier = cycle * 0.15
  unit:SetDeathXP(unit:GetDeathXP() * (0.85 + cycle * 0.2))
  unit:SetMinimumGoldBounty(unit:GetMinimumGoldBounty() * (0.4 + cycle * 0.2))
  unit:SetMaximumGoldBounty(unit:GetMaximumGoldBounty() * (0.5 + cycle * 0.2))
  unit:SetMaxHealth(unit:GetMaxHealth() * multiplier)
  unit:SetBaseMaxHealth(unit:GetBaseMaxHealth() * multiplier)
  unit:SetHealth(unit:GetMaxHealth() * multiplier)
  unit:SetBaseDamageMin(unit:GetBaseDamageMin() * multiplier)
  unit:SetBaseDamageMax(unit:GetBaseDamageMax() * multiplier)
  unit:SetBaseMoveSpeed(unit:GetBaseMoveSpeed() + 1 * multiplier)
  unit:SetPhysicalArmorBaseValue(unit:GetPhysicalArmorBaseValue() * multiplier)
  unit:AddNewModifier(unit, nil, "modifier_neutral_upgrade_attackspeed", {})
  unit:Heal(unit:GetMaxHealth(), unit)
  local modifier = unit:FindModifierByNameAndCaster("modifier_neutral_upgrade_attackspeed", unit)
  if modifier then
    modifier:SetStackCount(cycle)
  end

if cycle < 100 then
  unit:SetModelScale(1 + cycle/100)
end
if cycle >= 100 then
  unit:SetModelScale(2)
end
                    end
                end  
    pack.isAlive = true --ставим флажок, что пак живой.
    pack.level = (pack.level or 0) + 1
    end

    function Spawn:CheckPacks()
    for i = 1, #map.locations do
        for j = 1, #map.locations[i].packs do
            if map.locations[i].packs[j].isAlive then --бегаем только по "живым" пакам
                local creepCount =  FindUnitsInRadius(DOTA_TEAM_BADGUYS, map.locations[i].packs[j].spawnPoint.AbsOrigin ,nil, 800, 1, 2, 0, 0, false)

                -- в этой функции нам интересно ток DOTA_TEAM_ и 800. 800 - радиус поиска крипочков. По остальным параметрам - смотрите API
               
                if  #creepCount == 0 then
                    map.locations[i].packs[j].isAlive = false
                    Timers:CreateTimer(0.01, --тут вместо 5 указываем время, через которое должен реснуться пак
                        function()
                          Spawn:SpawnPack(map.locations[i].packs[j], map.locations[i].packs[j].level)
                    end)
              
              end
            end
        end
    end      
end




Spawn:InitGameMode()


