LinkLuaModifier("modifier_slark_essence_shift_lua", "heroes/hero_slark/essence_shift/slark_essence_shift_lua.lua", LUA_MODIFIER_MOTION_NONE)

slark_essence_shift_lua = class({})
modifier_slark_essence_shift_lua = class({})

--------------------------------------------------------------------------------
-- Passive Modifier
function slark_essence_shift_lua:GetIntrinsicModifierName()
	return "modifier_slark_essence_shift_lua"
end

function modifier_slark_essence_shift_lua:IsHidden()
	return false
end

function modifier_slark_essence_shift_lua:IsDebuff()
	return false
end

function modifier_slark_essence_shift_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slark_essence_shift_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}

	return funcs
end
function modifier_slark_essence_shift_lua:GetModifierProcAttack_Feedback( params )
	local target = params.target
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		-- filter enemy
		if target:IsHero() or target:IsIllusion() or target == self:GetParent() then
			return
		end

		if self:GetStackCount() < 20000 then
			self:IncrementStackCount()
		end

	end
end

function modifier_slark_essence_shift_lua:GetModifierBonusStats_Agility()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor( "agi_gain" )
end

function modifier_slark_essence_shift_lua:GetModifierBonusStats_Strength()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor( "agi_gain" )
end

function modifier_slark_essence_shift_lua:GetModifierBonusStats_Intellect()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor( "agi_gain" )
end