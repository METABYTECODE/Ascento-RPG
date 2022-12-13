LinkLuaModifier("modifier_boss_power_reduct", "abilities/enemy/boss_power_reduct.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

boss_power_reduct = class(ItemBaseClass)
modifier_boss_power_reduct = class(ItemBaseClass)
-------------
function boss_power_reduct:GetIntrinsicModifierName()
    return "modifier_boss_power_reduct"
end

function modifier_boss_power_reduct:GetTexture() return "cursed_shield" end


function modifier_boss_power_reduct:OnCreated()
	self:SetStackCount(50)
end

--------------------------------------------------------------------------------

function modifier_boss_power_reduct:DeclareFunctions()
	return {MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING}
end

--------------------------------------------------------------------------------

function modifier_boss_power_reduct:GetModifierStatusResistanceStacking()
	return self:GetStackCount()
end