modifier_slark_essence_shift_lua_damage_debuff = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_essence_shift_lua_damage_debuff:IsHidden()
	return false
end

function modifier_slark_essence_shift_lua_damage_debuff:IsDebuff()
	return true
end

function modifier_slark_essence_shift_lua_damage_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_essence_shift_lua_damage_debuff:OnCreated( kv )
	-- references
	self.dmg_loss = self:GetAbility():GetSpecialValueFor( "dmg_loss" )
	self.duration = -1

	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_slark_essence_shift_lua_damage_debuff:OnRefresh( kv )
	-- references
	self.dmg_loss = self:GetAbility():GetSpecialValueFor( "dmg_loss" )
	self.duration = -1

	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_slark_essence_shift_lua_damage_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slark_essence_shift_lua_damage_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}

	return funcs
end

function modifier_slark_essence_shift_lua_damage_debuff:GetModifierBaseAttack_BonusDamage()
	return self:GetStackCount() * -self.dmg_loss
end

--------------------------------------------------------------------------------
-- Helper
function modifier_slark_essence_shift_lua_damage_debuff:AddStack( duration )
	-- Add modifier
	local mod = self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_slark_essence_shift_lua_damage_stack",
		{
			duration = self.duration,
		}
	)
	mod.modifier = self

	-- Add stack
	self:IncrementStackCount()
end

function modifier_slark_essence_shift_lua_damage_debuff:RemoveStack()
	self:DecrementStackCount()

	if self:GetStackCount()<=0 then
		self:Destroy()
	end
end