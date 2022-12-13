LinkLuaModifier("modifier_donate_bruiser", "abilities/donate/donate_bruiser.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

donate_bruiser = class(ItemBaseClass)
modifier_donate_bruiser = class(ItemBaseClass)
-------------
function donate_bruiser:GetIntrinsicModifierName()
    return "modifier_donate_bruiser"
end

function modifier_donate_bruiser:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_donate_bruiser:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
    }
    return funcs
end

function modifier_donate_bruiser:GetModifierBaseAttackTimeConstant()
    return self:GetAbility():GetSpecialValueFor("base_attack_time") 
end
