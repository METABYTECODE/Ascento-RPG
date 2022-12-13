function UpgradeJobTo2(keys)
	local heroProfsList = LoadKeyValues('scripts/vscripts/data/heroes.kv')
    local caster = keys.caster
	--local player = caster:GetPlayerOwner()
	hero = caster:GetUnitName()
	if caster:HasModifier("modifier_profession") then
		local CurrentProf = caster:FindModifierByName("modifier_profession")
		local CurrentProfId = CurrentProf:GetStackCount()
		if CurrentProfId == 1 then
			for k, v in pairs(heroProfsList) do
				--print("KEY: " .. k)
				if k == "Profession_2" then
					for k1, v1 in pairs(v) do
						--print("KEY1: " .. k1)
						if hero == k1 then
							for k2, v2 in pairs(v1) do
								local findSkill = caster:FindAbilityByName(k2)
								if findSkill ~= nil then
									caster:RemoveAbility(findSkill:GetName())
									caster:AddAbility(v2)
									CurrentProf:SetStackCount(2)
								end
							end
						end
					end
				end
			end
		end
	end

Timers:CreateTimer(0.1, function() 
        local item_to_remove = caster:FindItemInInventory("item_grade_profession")

	caster:RemoveItem(item_to_remove)
    end)

	
end


function UpgradeJobTo3(keys)
	local heroProfsList = LoadKeyValues('scripts/vscripts/data/heroes.kv')
    local caster = keys.caster
	--local player = caster:GetPlayerOwner()
	hero = caster:GetUnitName()
	if caster:HasModifier("modifier_profession") then
		local CurrentProf = caster:FindModifierByName("modifier_profession")
		local CurrentProfId = CurrentProf:GetStackCount()
		if CurrentProfId == 2 then
			for k, v in pairs(heroProfsList) do
				--print("KEY: " .. k)
				if k == "Profession_3" then
					for k1, v1 in pairs(v) do
						--print("KEY1: " .. k1)
						if hero == k1 then
							for k2, v2 in pairs(v1) do
								local findSkill = caster:FindAbilityByName(k2)
								if findSkill ~= nil then
									caster:RemoveAbility(findSkill:GetName())
									caster:AddAbility(v2)
									CurrentProf:SetStackCount(3)
								end
							end
						end
					end
				end
			end
		end
	end

Timers:CreateTimer(0.1, function() 
        local item_to_remove = caster:FindItemInInventory("item_grade_profession")

	caster:RemoveItem(item_to_remove)
	
    end)

	
end