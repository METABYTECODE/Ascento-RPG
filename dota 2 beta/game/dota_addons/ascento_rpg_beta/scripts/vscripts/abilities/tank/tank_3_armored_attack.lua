function armored_attack (keys)

    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    
    local damage_per_armor = ability:GetSpecialValueFor("damage_per_armor")
    

    if target:IsAlive() then

        local damage = caster:GetPhysicalArmorValue(false) * damage_per_armor


        local damageTable = {
            victim = target,
            attacker = caster,
            damage = damage,
            damage_type = ability:GetAbilityDamageType(),
            ability = ability,
        }
        ApplyDamage(damageTable)
 
    end

end