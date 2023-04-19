LinkLuaModifier("modifier_donate_muerta_bsa", "abilities/donate/donate_muerta_bsa.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,

}

donate_muerta_bsa = class(ItemBaseClass)
modifier_donate_muerta_bsa = class(ItemBaseClass)
-------------
function donate_muerta_bsa:GetIntrinsicModifierName()
    return "modifier_donate_muerta_bsa"
end


function modifier_donate_muerta_bsa:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_donate_muerta_bsa:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
    }

    return funcs
end


function modifier_donate_muerta_bsa:GetModifierBaseAttackTimeConstant()
    return self:GetAbility():GetSpecialValueFor("base_attack_time")
end