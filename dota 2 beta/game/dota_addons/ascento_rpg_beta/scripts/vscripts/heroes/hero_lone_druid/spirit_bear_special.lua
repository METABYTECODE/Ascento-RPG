function SpiritBearSpawn( event )
	FirstOwner = event.caster:GetUnitName()
	StartCaster = event.caster
	local player = StartCaster:GetPlayerID()
	local ability = event.ability
	local level = ability:GetLevel()
	local origin = StartCaster:GetAbsOrigin() + RandomVector(100)

	local AllUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, Vector(0,0,0), nil, 25000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	CheckBear = nil

	for _, LiveBear in pairs(AllUnits) do
		if LiveBear:GetUnitName() == "npc_dota_lone_druid_bear_special" then 
			bear = CreateUnitByName("npc_dota_lone_druid_bear_special", origin, true, StartCaster, StartCaster, StartCaster:GetTeamNumber())
			bear:SetControllableByPlayer(player, true)
			CheckBear = "Summoned"
			for i = 0, 9 do 
			    pos = StartCaster:GetOrigin() + RandomVector(150)
			    local CurrentItem = LiveBear:GetItemInSlot(i) 
			    LiveBear:DropItemAtPositionImmediate(CurrentItem, pos)
			end 
			Timers:CreateTimer(function() 
				for i = 0, 9 do 
					local CurrentItem = bear:GetItemInSlot(i) 
					if bear:IsAlive() == false then 
						bear:DropItemAtPositionImmediate(CurrentItem, pos)
						CheckBear = nil
					end 
				end
			return 0.03 end)
			UTIL_Remove(LiveBear)
		end
	end
	if CheckBear == nil then 
		bear = CreateUnitByName("npc_dota_lone_druid_bear_special", origin, true, StartCaster, StartCaster, StartCaster:GetTeamNumber())
		bear:SetControllableByPlayer(player, true)
		CheckBear = "Summoned"
	end

end
