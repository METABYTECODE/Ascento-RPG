function StartMount( keys )
	local caster = keys.caster
	local ability = keys.ability 
	local pos = caster:GetAbsOrigin()
	if caster:FindModifierByName("modifier_mount_active") == nil then 
		local mount = CreateUnitByName( "npc_dota_new_year_mount", pos, true, caster, caster, caster:GetTeamNumber())
		mount:SetOwner(caster)
		StartSoundEvent("ui.crafting_mech", caster)
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_mount_active", {})
		Timers:CreateTimer(function() 
			if mount ~= nil and mount:GetOwner() == caster then
				local caster_pos = caster:GetAbsOrigin()
				local caster_angles = caster:GetAngles()
				mount:SetAngles(caster_angles.x, caster_angles.y, caster_angles.z) 
				mount:SetAbsOrigin(caster_pos-Vector(0,0,150))
				if caster:IsAlive() == false then 
					if mount ~= nil then
						UTIL_Remove(mount)
					end
					if caster:FindAbilityByName("new_year_mount_cancel_datadriven") ~= nil then 
						caster:RemoveAbility("new_year_mount_cancel_datadriven")
						caster:AddAbility("new_year_mount_datadriven"):UpgradeAbility(true)	
					end
				end
			end
			return 0.03 
		end)
	end
	caster:RemoveAbility("new_year_mount_datadriven")
	caster:AddAbility("new_year_mount_cancel_datadriven"):UpgradeAbility(true)
end

function StopMount( keys )
	local caster = keys.caster
	local ability = keys.ability 
	local abs = caster:GetAbsOrigin()

	local FindMountUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, abs, nil, 1000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

	for _, mount in pairs(FindMountUnits) do
		if mount:GetOwner() == caster and mount:GetUnitName() == "npc_dota_new_year_mount" then
			UTIL_Remove(mount)
			caster:RemoveModifierByName("modifier_mount_active")
			caster:RemoveAbility("new_year_mount_cancel_datadriven")
			caster:AddAbility("new_year_mount_datadriven"):UpgradeAbility(true)
			StartSoundEvent("ui.contract_fail", caster)
		end
	end
end