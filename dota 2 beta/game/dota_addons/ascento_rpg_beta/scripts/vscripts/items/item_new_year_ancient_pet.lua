function CreatePet ( keys )
	local caster = keys.caster
	local item = keys.ability
	if caster:GetUnitName() ~= "npc_dota_lone_druid_bear_creep_1" then
		local ability = caster:AddAbility("pet_new_year_ancient_buff")
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_new_year_ancient_buff", {})
		ability:Destroy()
		caster:AddAbility("elder_titan_natural_order"):UpgradeAbility(true)

		local unit = CreateUnitByName( "npc_dota_pet_new_year_ancient", caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
    	unit:SetOwner(caster)
    	ParticleManager:CreateParticle( "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_electric.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )

		UTIL_Remove(item)
	end
end