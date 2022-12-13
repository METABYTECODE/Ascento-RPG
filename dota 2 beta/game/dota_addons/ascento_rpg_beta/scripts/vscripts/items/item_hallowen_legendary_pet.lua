function CreatePet ( keys )
	local caster = keys.caster
	local item = keys.ability

	if caster:GetUnitName() ~= "npc_dota_lone_druid_bear_creep_1" and caster:IsRealHero() and caster:GetUnitName() ~= "npc_special_event_halloween"  then

		if caster:HasModifier("modifier_hallowen_legendary_pet") then
			UTIL_Remove(item)
			return
		end

		local ability = caster:AddAbility("pet_helloween_buff")
        ability:UpgradeAbility(true)

		local unit = CreateUnitByName( "npc_dota_pet_halloween_drop", caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
    	unit:SetOwner(caster)
    	ParticleManager:CreateParticle( "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
    	ParticleManager:CreateParticle( "particles/ui/ui_halloween_bats_diretide_ability_draft.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )

		UTIL_Remove(item)
	end
end