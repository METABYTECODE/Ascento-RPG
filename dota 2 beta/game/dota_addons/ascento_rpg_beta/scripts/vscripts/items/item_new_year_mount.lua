function AddAbility( keys )
	local caster = keys.caster 
	local ability = keys.ability 
	if caster:GetUnitName() ~= "npc_dota_lone_druid_bear_creep_1" then
		if caster:FindAbilityByName("new_year_mount_datadriven") == nil and caster:FindAbilityByName("new_year_mount_cancel_datadriven") == nil then 
			caster:AddAbility("new_year_mount_datadriven"):UpgradeAbility(true)
		end
		UTIL_Remove(ability)
	end
end