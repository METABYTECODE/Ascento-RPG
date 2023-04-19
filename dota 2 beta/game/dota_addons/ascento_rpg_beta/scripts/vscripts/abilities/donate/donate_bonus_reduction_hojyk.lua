LinkLuaModifier("modifier_donate_bonus_reduction_hojyk", "abilities/donate/donate_bonus_reduction_hojyk.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

donate_bonus_reduction_hojyk = class(ItemBaseClass)
modifier_donate_bonus_reduction_hojyk = class(ItemBaseClass)
-------------
function donate_bonus_reduction_hojyk:GetIntrinsicModifierName()
    return "modifier_donate_bonus_reduction_hojyk"
end


function modifier_donate_bonus_reduction_hojyk:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_donate_bonus_reduction_hojyk:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, --GetModifierPhysicalArmorBonus
    }

    return funcs
end


function modifier_donate_bonus_reduction_hojyk:GetModifierPhysicalArmorBonus()
    return 50 + ( self:GetParent():GetPhysicalArmorBaseValue() * self:GetAbility():GetLevelSpecialValueFor("armor_pct", (self:GetAbility():GetLevel() - 1)) )
end
