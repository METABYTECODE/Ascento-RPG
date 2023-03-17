LinkLuaModifier("modifier_slark_essence_shift_lua_damage", "heroes/hero_slark/essence_shift_damage/slark_essence_shift_lua_damage.lua", LUA_MODIFIER_MOTION_NONE)

slark_essence_shift_lua_damage = class({})
modifier_slark_essence_shift_lua_damage = class({})

--------------------------------------------------------------------------------
-- Passive Modifier
function slark_essence_shift_lua_damage:GetIntrinsicModifierName()
	return "modifier_slark_essence_shift_lua_damage"
end

function modifier_slark_essence_shift_lua_damage:IsHidden()
	return false
end

function modifier_slark_essence_shift_lua_damage:IsDebuff()
	return false
end

function modifier_slark_essence_shift_lua_damage:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slark_essence_shift_lua_damage:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}

	return funcs
end
function modifier_slark_essence_shift_lua_damage:OnAttackLanded( params )
	local target = params.target
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		-- filter enemy
		if target:IsHero() or target:IsIllusion() or target == self:GetParent() or target:GetTeam() == self:GetParent():GetTeam() or not target:IsAlive() then
			return
		else
			self:IncrementStackCount()
		end

	end
end

function modifier_slark_essence_shift_lua_damage:GetModifierBaseAttack_BonusDamage()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor( "dmg_gain" )
end