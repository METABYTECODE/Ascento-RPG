function Desolate (keys)

	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	
	local skillDamage = ability:GetSpecialValueFor("bonus_damage")
	
	EmitSoundOn("Hero_Spectre.Desolate", caster)

	local particle_name = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	local particle = ParticleManager:CreateParticle(particle_name, PATTACH_POINT, target)
    local pelel = caster:GetForwardVector()
    ParticleManager:SetParticleControl(particle, 0, Vector(     target:GetAbsOrigin().x,
                                                                target:GetAbsOrigin().y, 
                                                                GetGroundPosition(target:GetAbsOrigin(), target).z + 140))
                                                                
    ParticleManager:SetParticleControlForward(particle, 0, caster:GetForwardVector())

	local damageTable = {
		victim = target,
		attacker = caster,
		damage = skillDamage,
		damage_type = ability:GetAbilityDamageType(),
	}
	ApplyDamage(damageTable)


end