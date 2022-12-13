function magic_damage (keys)

    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    
    local magic_damage_pct = ability:GetSpecialValueFor("magic_damage")
    

    if target:IsAlive() and not target:IsMagicImmune() then
        
        EmitSoundOn("Hero_Spectre.Desolate", caster)

        local particle_name = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
        local particle = ParticleManager:CreateParticle(particle_name, PATTACH_POINT, target)
        local pelel = caster:GetForwardVector()
        ParticleManager:SetParticleControl(particle, 0, Vector(     target:GetAbsOrigin().x,
                                                                    target:GetAbsOrigin().y, 
                                                                    GetGroundPosition(target:GetAbsOrigin(), target).z + 140))
                                                                    
        ParticleManager:SetParticleControlForward(particle, 0, caster:GetForwardVector())
        local minusPenetrate = 0
        local magicdamage = caster:GetAverageTrueAttackDamage(caster) * (magic_damage_pct / 100)
        if caster:HasModifier("modifier_magic_warrior_2_magic_penetration") then
            local penetrate = caster:FindAbilityByName("magic_warrior_2_magic_penetration"):GetSpecialValueFor( "penetrate" )
            local damageTable = {
                victim = target,
                attacker = caster,
                damage = (magicdamage * (penetrate / 100)),
                damage_type = DAMAGE_TYPE_PURE,
            }
            ApplyDamage(damageTable)
        end


        local damageTable = {
            victim = target,
            attacker = caster,
            damage = magicdamage - minusPenetrate,
            damage_type = ability:GetAbilityDamageType(),
        }
        ApplyDamage(damageTable)
 
    end

end