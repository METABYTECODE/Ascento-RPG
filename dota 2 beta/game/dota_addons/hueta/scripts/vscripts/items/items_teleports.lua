item_teleport_boss1 = class({})
item_teleport_boss2 = class({})
item_teleport_boss3 = class({})
item_teleport_boss4 = class({})
item_teleport_boss5 = class({})
item_teleport_boss6 = class({})
item_teleport_boss7 = class({})
item_teleport_boss8 = class({})
item_teleport_boss9 = class({})

teleport_boss1 = class({})
teleport_boss2 = class({})
teleport_boss3 = class({})
teleport_boss4 = class({})
teleport_boss5 = class({})
teleport_boss6 = class({})
teleport_boss7 = class({})
teleport_boss8 = class({})
teleport_boss9 = class({})



--[[ ============================================================================================================
	Author: Rook
	Date: January 25, 2015
	Called when Cheese is cast.  Restores health and mana to the caster.
	Additional parameters: keys.HealthRestore and keys.ManaRestore
================================================================================================================= ]]

function item_tpfarm ( keys )
    local caster = keys.caster

    local tploc = ("tp_spawn_" .. CUSTOMS_PLAYER_ID[caster:GetPlayerID()])
    print(tploc)    
    local destination = Entities:FindByName(nil, tploc)
    local point=destination:GetAbsOrigin()

	local heroes = FindUnitsInRadius(caster:GetTeamNumber(), 
									point,
									nil,
									1200,
									DOTA_UNIT_TARGET_TEAM_BOTH,
									DOTA_UNIT_TARGET_HERO, 
									DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
									FIND_CLOSEST, 
									false)

if #heroes > 0 then

	local teamnumber = caster:GetTeamNumber()-5
	local tploc = ("spawn_" .. teamnumber)
    print(tploc)    
    local destination = Entities:FindByName(nil, tploc)
    local point=destination:GetAbsOrigin()
   --caster:RemoveItem("item_tpfarm")
    FindClearSpaceForUnit(caster,point, false)
    PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), caster)
    caster:Stop()

       							require('timers')
   							Timers:CreateTimer(0.2, function()
      							PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), nil)
      							return nil
  							end)
   						

else


    --caster:RemoveItem("item_tpfarm")
    FindClearSpaceForUnit(caster,point, false)
    PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), caster)
    caster:Stop()

       							require('timers')
   							Timers:CreateTimer(0.2, function()
      							PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), nil)
      							return nil
  							end)
   						end
end

