modifier_slark_essence_shift_lua_debuff = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_essence_shift_lua_debuff:IsHidden()
	return false
end

function modifier_slark_essence_shift_lua_debuff:IsDebuff()
	return true
end

function modifier_slark_essence_shift_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_essence_shift_lua_debuff:OnCreated( kv )
	-- references
	self.stat_loss = self:GetAbility():GetSpecialValueFor( "stat_loss" )
	self.duration = -1

	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_slark_essence_shift_lua_debuff:OnRefresh( kv )
	-- references
	self.stat_loss = self:GetAbility():GetSpecialValueFor( "stat_loss" )
	self.duration = -1

	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_slark_essence_shift_lua_debuff:OnDestroy( kv )

end


--------------------------------------------------------------------------------
-- Helper
function modifier_slark_essence_shift_lua_debuff:AddStack( duration )
	-- Add modifier
	local mod = self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_slark_essence_shift_lua_stack",
		{
			duration = self.duration,
		}
	)
	mod.modifier = self

	-- Add stack
	self:IncrementStackCount()
end

function modifier_slark_essence_shift_lua_debuff:RemoveStack()
	self:DecrementStackCount()

	if self:GetStackCount()<=0 then
		self:Destroy()
	end
end