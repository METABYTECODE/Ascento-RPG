function CreatePet ( keys )
	local caster = keys.caster
	local item = keys.ability
	if caster:GetUnitName() ~= "npc_dota_lone_druid_bear_creep_1" then
		local ability = caster:AddAbility("pet_new_year_legendary_buff")
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_new_year_legendary_pet", {})
		ability:Destroy()

		local unit = CreateUnitByName( "npc_dota_pet_new_year_legendary", caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
    	unit:SetOwner(caster)
    	ParticleManager:CreateParticle( "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )

		UTIL_Remove(item)
	end
end