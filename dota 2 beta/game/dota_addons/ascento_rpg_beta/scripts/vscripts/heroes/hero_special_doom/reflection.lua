--[[Author: Noya
	Date: 11.01.2015.
	Creates an unselectable, uncontrollable and invulnerable illusion at the back of the target
]]
function Reflection( event )
	print("Reflection Start")

	----- Conjure Image  of the target -----
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local unit_name = target:GetUnitName()
	local origin = target:GetAbsOrigin() + RandomVector(100)
	local duration = ability:GetLevelSpecialValueFor( "illusion_duration", ability:GetLevel() - 1 )
	local outgoingDamage = ability:GetLevelSpecialValueFor( "illusion_outgoing_damage", ability:GetLevel() - 1 )

	-- handle_UnitOwner needs to be nil, else it will crash the game.
	local illusion = CreateUnitByName(unit_name, origin, true, caster, nil, caster:GetTeamNumber())
	local IlluAbility = illusion:AddAbility("doom_special_spell_first")
	IlluAbility:UpgradeAbility(true)
	IlluAbility:ApplyDataDrivenModifier(illusion, illusion, "modifier_reflection_invulnerability", {})
	IlluAbility:Destroy()
	illusion:SetUnitName("Doom Illusion")

	illusion:AddAbility("doom_special_spell_first_crit"):UpgradeAbility(true)

	illusion:AddAbility("absorb_doom_illusion_datadriven"):UpgradeAbility(true)

	illusion:AddAbility("special_pure_damage_spell_datadriven"):UpgradeAbility(true)
	
	Timers:CreateTimer(function()
      ExecuteOrderFromTable({
				UnitIndex = illusion:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				TargetIndex = target:entindex(),
				AbilityIndex = nil
			})
      return 1.0
    end
  )

	Timers:CreateTimer({
	    endTime = 10, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
	    callback = function()
	      UTIL_Remove(illusion)
	    end
	  })


end

--[[Author: Noya
	Date: 11.01.2015.
	Shows the Cast Particle, which for TB is originated between each weapon, in here both bodies are linked because not every hero has 2 weapon attach points
]]
function ReflectionCast( event )

	local caster = event.caster
	local target = event.target
	local particleName = "particles/econ/items/doom/doom_ti8_immortal_arms/doom_ti8_immortal_devour.vpcf"

	local particle = ParticleManager:CreateParticle( particleName, PATTACH_POINT_FOLLOW, caster )
	ParticleManager:SetParticleControl(particle, 3, Vector(1,0,0))
	
	ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
end