--[[
	author: jacklarnes
	email: christucket@gmail.com
	reddit: /u/jacklarnes
	Date: 03.04.2015.
	Much help from Noya and BMD
]]

--[[
	Must have luna_lucent_beam_datadriven ability to deal damage
	i defaulted the damage to 300 if the ability doesn't exist
]]

time_of_day_reset = nil

function eclipse_start(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability

	ability.bounceTable = {}

	ability_lucent_beam = caster:FindAbilityByName("luna_lucent_beam_datadriven")
	if ability_lucent_beam ~= nil then
		ability.damage = ability_lucent_beam:GetAbilityDamage()
	else
		ability.damage = ability:GetSpecialValueFor("damage") -- i set it to 300 just because... this is a "default damage"
	end

	ability.radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1)
	ability.beam_interval = ability:GetLevelSpecialValueFor("beam_interval", ability:GetLevel() - 1)
	ability.night_duration = ability:GetLevelSpecialValueFor("night_duration", ability:GetLevel() - 1)

	-- if not scepter
	ability.beams = ability:GetLevelSpecialValueFor("beams", ability:GetLevel() - 1) 
	ability.max_hit_count = ability:GetLevelSpecialValueFor("hit_count", ability:GetLevel() - 1)
	-- else
	--ability.beams = ability:GetLevelSpecialValueFor("beams_scepter", ability:GetLevel() - 1) 
	--ability.max_hit_count = ability:GetLevelSpecialValueFor("hit_count_scepter", ability:GetLevel() - 1) 


	for delay = 0, (ability.beams-1) * ability.beam_interval, ability.beam_interval do
		Timers:CreateTimer(delay, function ()
				-- i'm assuming it returns these in random order, might have to fix later
				if caster:IsAlive() == false then
					return
				end

				local unitsNearTarget = FindUnitsInRadius(caster:GetTeamNumber(),
			                            caster:GetAbsOrigin(),
			                            nil,
			                            ability.radius,
			                            DOTA_UNIT_TARGET_TEAM_ENEMY,
			                            DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
			                            DOTA_UNIT_TARGET_FLAG_NONE,
			                            FIND_ANY_ORDER,
			                            false)

				-- finds the first target with < max_hit_count
				target = nil
				for k, v in pairs(unitsNearTarget) do
					if ability.bounceTable[v] == nil or ability.bounceTable[v] < ability.max_hit_count then
						target = v
						break
					end
				end

				-- if it finds a target, deals damage and then adds it to the bounceTable
				if target ~= nil then
					if caster:GetUnitName() == "npc_dota_hero_rubick" then
						beam = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_chaos_meteor.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
					end
					if caster:GetUnitName() == "npc_dota_hero_custom_antimage" then
						beam = ParticleManager:CreateParticle("particles/units/heroes/hero_leshrac/leshrac_lightning_bolt.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
					end
					EmitSoundOn("Hero_Invoker.ChaosMeteor.Impact", target)

					local damageTable = {
							victim = target,
							attacker = caster,
							damage = ability.damage,
							damage_type = DAMAGE_TYPE_PURE} 
					ApplyDamage(damageTable)

					ability.bounceTable[target] = ((ability.bounceTable[target] or 0) + 1)
				end
			end)
	end 
end