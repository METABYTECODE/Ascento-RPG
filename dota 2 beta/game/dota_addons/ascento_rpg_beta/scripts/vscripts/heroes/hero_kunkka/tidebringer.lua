--[[
	Author: kritth
	Date: 09.01.2015
	Reset cooldown after attack is landed
]]
function tidebringer_set_cooldown( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local cooldown = ability:GetCooldown( ability:GetLevel() )
	local modifierName = "modifier_tidebringer_splash_datadriven"
	if not caster then return end
	if not ability then return end
	if not cooldown then return end
	
	-- Remove cooldown
	caster:RemoveModifierByName( modifierName )
	ability:StartCooldown( cooldown )

	Timers:CreateTimer( cooldown, function()
			ability:ApplyDataDrivenModifier( caster, caster, modifierName, {} )
			return nil
		end
	)
end