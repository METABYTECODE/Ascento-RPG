function AttackUnit(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local damage = (caster:GetLevel() or 1) * ability:GetLevelSpecialValueFor("bonus_damage_taken", (ability:GetLevel() -1))

	ApplyDamage({ability = ability, victim = target, attacker = caster, damage = damage, damage_type = ability:GetAbilityDamageType()})
	
end