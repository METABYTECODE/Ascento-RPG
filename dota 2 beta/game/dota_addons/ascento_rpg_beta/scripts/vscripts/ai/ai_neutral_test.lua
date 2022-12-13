function Spawn( entityKeyValues )
    if not IsServer() then
        return
    end

    if thisEntity == nil then
        return
    end
  
    thisEntity:SetContextThink( "NeutralAutoCasterThink", NeutralAutoCasterThink, 1 )
end

function NeutralAutoCasterThink()
    if ( not thisEntity:IsAlive() ) then return -1 end
    if GameRules:IsGamePaused() == true then return 1 end
    if thisEntity:IsChanneling() then return 1 end
    if thisEntity:IsControllableByAnyPlayer() then return -1 end
    local npc = thisEntity

    if not thisEntity.bInitialized then
        npc.vInitialSpawnPos = npc:GetOrigin() 
        npc.fMaxDist = 250
        npc.bInitialized = true
        npc.agro = false
        npc.ability0 = FindAbility(npc, 0)
        npc.ability1 = FindAbility(npc, 1)
        npc.ability2 = FindAbility(npc, 2)
        npc.ability3 = FindAbility(npc, 3)
        npc.ability4 = FindAbility(npc, 4)
        npc.ability5 = FindAbility(npc, 5)
        npc.ability6 = FindAbility(npc, 6)
        npc.ability7 = FindAbility(npc, 7)
        npc.ability8 = FindAbility(npc, 8)
        npc.ability9 = FindAbility(npc, 9)
        npc.ability10 = FindAbility(npc, 10)
        --npc.ability11 = FindItems(npc)
    end

    local search_radius 
    if npc.agro then search_radius = npc.fMaxDist * 4 else search_radius = npc.fMaxDist end
  
    local fDist = ( npc:GetOrigin() - npc.vInitialSpawnPos ):Length2D()
    if fDist > search_radius * 3 then
        RetreatHome() 
        return 3
    end
  
    local enemies = FindUnitsInRadius(
                        npc:GetTeamNumber(),
                        npc.vInitialSpawnPos,
                        nil,
                        search_radius + 100,
                        DOTA_UNIT_TARGET_TEAM_ENEMY,
                        DOTA_UNIT_TARGET_HERO,
                        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
                        FIND_CLOSEST,
                        false )

    if #enemies == 0 then
        if npc.agro then
            RetreatHome()
        end     
        return 0.5
    end
  
    local enemy = enemies[1]

    if npc:GetUnitName() == "npc_dota_courier" then
        if enemy then
            if npc:GetHealth() < npc:GetMaxHealth() * 0.25 then
                TryCastAbility(npc.ability3, npc, enemy)
            elseif npc:GetHealth() < npc:GetMaxHealth() * 0.5 then
                TryCastAbility(npc.ability2, npc, enemy)
            elseif npc:GetHealth() < npc:GetMaxHealth() * 0.75 then
                TryCastAbility(npc.ability1, npc, enemy)
            elseif npc:GetHealth() < npc:GetMaxHealth() * 0.99 then
                TryCastAbility(npc.ability0, npc, enemy)
            end
        end

        if npc.agro then
            if npc:GetHealth() < npc:GetMaxHealth() * 0.25 then
                TryCastAbility(npc.ability3, npc, enemy)
            elseif npc:GetHealth() < npc:GetMaxHealth() * 0.5 then
                TryCastAbility(npc.ability2, npc, enemy)
            elseif npc:GetHealth() < npc:GetMaxHealth() * 0.75 then
                TryCastAbility(npc.ability1, npc, enemy)
            elseif npc:GetHealth() < npc:GetMaxHealth() * 0.99 then
                TryCastAbility(npc.ability0, npc, enemy)
            end
        end
    else
    
        if npc.agro then
                AttackMove(npc, enemy)
                TryCastAbility(npc.ability0, npc, enemy)
                TryCastAbility(npc.ability1, npc, enemy)
                if npc:GetUnitName() == "npc_dota_creature_dazzle_creep" then
                    TryCastAbility(npc.ability0, npc, npc)
                    TryCastAbility(npc.ability1, npc, npc)
                end

                TryCastAbility(npc.ability2, npc, enemy)
                TryCastAbility(npc.ability3, npc, enemy)
                TryCastAbility(npc.ability4, npc, enemy)
                TryCastAbility(npc.ability5, npc, enemy)
                TryCastAbility(npc.ability6, npc, enemy)
                TryCastAbility(npc.ability7, npc, enemy)
                TryCastAbility(npc.ability8, npc, enemy)
                TryCastAbility(npc.ability9, npc, enemy)
                TryCastAbility(npc.ability10, npc, enemy)
            --TryCastItem(npc.ability11, npc, enemy)
        else

            local allies = FindUnitsInRadius(
                npc:GetTeamNumber(),
                npc.vInitialSpawnPos,
                nil,
                300,
                DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
                FIND_CLOSEST,
                false )
              
            for i=1,#allies do
                local ally = allies[i]
                ally.agro = true
                AttackMove(ally, enemy)

                if npc:GetUnitName() == "npc_dota_creature_dazzle_creep" then
                    TryCastAbility(npc.ability0, npc, ally)
                    TryCastAbility(npc.ability1, npc, ally)
                end
                
            end 
        end 
    end
    return 1
  
end

function FindAbility(unit, index)
    local ability = unit:GetAbilityByIndex(index)
    if ability then
        local ability_behavior = ability:GetBehaviorInt()

        if bit.band( ability_behavior, DOTA_ABILITY_BEHAVIOR_PASSIVE ) == DOTA_ABILITY_BEHAVIOR_PASSIVE then
            ability.behavior = "passive"
        elseif bit.band( ability_behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
            ability.behavior = "target"
        elseif bit.band( ability_behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET ) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
            ability.behavior = "no_target"
        elseif bit.band( ability_behavior, DOTA_ABILITY_BEHAVIOR_POINT ) == DOTA_ABILITY_BEHAVIOR_POINT then
            ability.behavior = "point"
        elseif bit.band( ability_behavior, DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING ) == DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING then
            ability.behavior = "backswing"        -- способность направлена на точку
        end

        return ability
    else
        return nil
    end
end
function TryCastAbility(ability, caster, enemy)
    if ability == nil -- способность существует ?
    or  not ability:IsFullyCastable()     -- способность можно использовать?
    or ability.behavior == "passive"     -- способность пассивна ?
    or  enemy:IsMagicImmune()  then        -- цель имеет уммунитет к магии ?
        return
    end
    --print("CAST ABIITY")
    --print("ability behavior = "..ability.behavior)
    --print("enemy = "..enemy:GetUnitName())
    --print("caster = "..caster:GetUnitName())
    --print("ability = "..ability:GetName())

    local order_type = DOTA_UNIT_ORDER_CAST_TARGET
    if ability.behavior == "target" then
        order_type = DOTA_UNIT_ORDER_CAST_TARGET
    elseif ability.behavior == "no_target" then
        order_type = DOTA_UNIT_ORDER_CAST_NO_TARGET
    elseif ability.behavior == "point" then
        order_type = DOTA_UNIT_ORDER_CAST_POSITION
    elseif ability.behavior == "backswing" then
        order_type = DOTA_UNIT_ORDER_CAST_POSITION
    elseif ability.behavior == "passive" then
        return
    end
    --print(ability:GetAbilityName())
    ExecuteOrderFromTable({
        UnitIndex = caster:entindex(),        -- индекс кастера
        OrderType = order_type,                -- тип приказа
        AbilityIndex = ability:entindex(),    -- индекс способности
        TargetIndex = enemy:entindex(),     -- индекс врага
        Position = enemy:GetOrigin(),         -- положение врага
        Queue = false,                        -- ждать очереди ?
    })
    caster:SetContextThink( "NeutralAutoCasterThink", NeutralAutoCasterThink, 1 ) -- если способность использована, то поведение начинается заного
end
function TryCastItem(ability, caster, enemy)
    if ability == nil or  not ability:IsFullyCastable() or ability.behavior == "passive" then
        return
    end
    local order_type
    if ability.behavior == "target" then
        order_type = DOTA_UNIT_ORDER_CAST_TARGET
    elseif ability.behavior == "no_target" then
        order_type = DOTA_UNIT_ORDER_CAST_NO_TARGET
    elseif ability.behavior == "point" then
        order_type = DOTA_UNIT_ORDER_CAST_POSITION
    elseif ability.behavior == "passive" then
        return
    end
    ExecuteOrderFromTable({
        UnitIndex = caster:entindex(),
        OrderType = order_type,
        AbilityIndex = ability:entindex(),
        TargetIndex = enemy:entindex(),
        Position = enemy:GetOrigin(),
        Queue = false,
    })
    caster:SetContextThink( "NeutralAutoCasterThink", NeutralAutoCasterThink, 1 )
end

function AttackMove( unit, enemy )
    if enemy == nil then
        return
    end
    ExecuteOrderFromTable({
        UnitIndex = unit:entindex(),
        OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
        Position = enemy:GetOrigin(),
        Queue = false,
    })

    return 1
end

function RetreatHome()
    thisEntity.agro = false

    ExecuteOrderFromTable({
        UnitIndex = thisEntity:entindex(),
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        Position = thisEntity.vInitialSpawnPos     
    })
end

function FindItems(p)
    for i = 0, DOTA_ITEM_MAX - 1 do
        local item = p:GetItemInSlot( i )
        if item then
            local ability_behavior = item:GetBehaviorInt()

            if bit.band( ability_behavior, DOTA_ABILITY_BEHAVIOR_PASSIVE ) == DOTA_ABILITY_BEHAVIOR_PASSIVE then
                item.behavior = "passive"
            elseif bit.band( ability_behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
                item.behavior = "target"
            elseif bit.band( ability_behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET ) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
                item.behavior = "no_target"
            elseif bit.band( ability_behavior, DOTA_ABILITY_BEHAVIOR_POINT ) == DOTA_ABILITY_BEHAVIOR_POINT then
                item.behavior = "point"
            end
            return item
        end
    end
end