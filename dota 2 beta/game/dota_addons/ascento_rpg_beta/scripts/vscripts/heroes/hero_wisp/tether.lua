--[[
	Author: Ractidous, with help from Noya
	Date: 03.02.2015.
	Initialize the slowed units list, and let the caster latch.
	We also need to track the health/mana, in order to grab amount gained of health/mana in the future.
]]
function CastTether( event )
	-- Variables
	local caster	= event.caster
	local target	= event.target
	local ability	= event.ability
	if caster == target then
		Timers:CreateTimer(1,function()
            ability:EndCooldown()
            return nil
        end) 
		return nil
	end

	if not target:IsRealHero() then 
		Timers:CreateTimer(1,function()
            ability:EndCooldown()
            return nil
        end) 
		return nil
	end

	-- Store the ally unit
	ability.tether_ally = target

    ability.tether_caster = caster
    local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_wisp/wisp_tether.vpcf", PATTACH_ABSORIGIN, ability.tether_ally )
	ParticleManager:SetParticleControlEnt( nFXIndex, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", ability.tether_ally:GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( nFXIndex, 1, ability.tether_caster, PATTACH_POINT_FOLLOW, "attach_hitloc", ability.tether_caster:GetOrigin(), true )
	--ParticleManager:ReleaseParticleIndex( nFXIndex )
    ability.fx = nFXIndex
    
	ability:ApplyDataDrivenModifier( caster, ability.tether_caster, "modifier_hojyk_tether", {} )
	ability:ApplyDataDrivenModifier( caster, ability.tether_ally, "modifier_hojyk_tether_ally", {} )

	caster:SwapAbilities("hojyk_tether", "hojyk_tether_break", false, true) 
end


function EndTether( event )
	local caster = event.caster
	local ability = caster:FindAbilityByName("hojyk_tether")

    ParticleManager:DestroyParticle(ability.fx, false)
	ability.tether_caster:RemoveModifierByName("modifier_hojyk_tether")
	if ability.tether_ally then
		ability.tether_ally:RemoveModifierByName("modifier_hojyk_tether_ally")
	end

	ability.tether_caster = nil
	ability.tether_ally = nil

	caster:SwapAbilities("hojyk_tether_break", "hojyk_tether", false, true) 
end


function Think_killed( event )
	local caster = event.caster
	local ability = caster:FindAbilityByName("hojyk_tether")

	if not ability.tether_ally:IsAlive() or not ability.tether_caster:IsAlive() then

		ParticleManager:DestroyParticle(ability.fx, false)
		ability.tether_caster:RemoveModifierByName("modifier_hojyk_tether")
		if ability.tether_ally then
			ability.tether_ally:RemoveModifierByName("modifier_hojyk_tether_ally")
		end

		ability.tether_caster = nil
		ability.tether_ally = nil

		caster:SwapAbilities("hojyk_tether_break", "hojyk_tether", false, true) 
	end
end

function EndTether2( event )
	local ability = event.ability
	ability.tether_ally:RemoveModifierByName("modifier_hojyk_tether_ally")
end

function StopSound( event )
	StopSoundEvent( event.sound_name, event.caster )
end
