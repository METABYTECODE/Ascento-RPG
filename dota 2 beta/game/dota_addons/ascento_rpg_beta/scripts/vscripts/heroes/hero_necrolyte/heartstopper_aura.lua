--[[Author: Pizzalol
	Date: 11.07.2015.
	Deals damage based on the max HP of the target]]
function HeartstopperAura( keys )
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target
	local target_max_hp = target:GetMaxHealth() / 100
	local aura_damage = ability:GetLevelSpecialValueFor("aura_damage", (ability:GetLevel() - 1))
	local aura_damage_interval = ability:GetLevelSpecialValueFor("aura_damage_interval", (ability:GetLevel() - 1))

	local damage = target_max_hp * -aura_damage * aura_damage_interval

	

	-- Shows the debuff on the target's modifier bar only if Necrophos is visible
	local visibility_modifier = "modifier_cultist_2_decay_aura"
	if target:CanEntityBeSeenByMyTeam(caster) then
		ability:ApplyDataDrivenModifier(caster, target, visibility_modifier, {})
	else
		target:RemoveModifierByName(visibility_modifier)
	end

	local damage_table = {}

	damage_table.attacker = caster
	damage_table.victim = target
	damage_table.damage_type = DAMAGE_TYPE_PURE
	damage_table.ability = ability
	damage_table.damage = damage
	damage_table.damage_flags = DOTA_DAMAGE_FLAG_HPLOSS -- Doesnt trigger abilities and items that get disabled by damage

	ApplyDamage(damage_table)

	local hp_heal = damage * (ability:GetLevelSpecialValueFor( "hp_heal" , (ability:GetLevel() - 1)) / 100)

	caster:Heal(hp_heal, caster)
end