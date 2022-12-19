function OnEnterAura(kv)
    local target = kv.target
    local caster = kv.caster
    local damage = kv.blazedamage
    local interval = kv.interval

    ApplyDamage({
        attacker = caster,
        victim = target,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = kv.ability,
        damage = damage * interval
    })
end

function OnThink(kv)
    local parent = kv.caster
    local ability = kv.ability

    if ability:GetLevel() == 8 then
        if parent:GetLevel() < MAX_LEVEL then
            DisplayError(parent:GetPlayerID(), "Requires Level " .. MAX_LEVEL)
            parent:DropItemAtPositionImmediate(ability, parent:GetAbsOrigin())
        end
    end
end