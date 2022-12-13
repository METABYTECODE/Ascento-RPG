LinkLuaModifier("modifier_donate_bruiser_tb", "abilities/donate/donate_bruiser_tb.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

donate_bruiser_tb = class(ItemBaseClass)
modifier_donate_bruiser_tb = class(ItemBaseClass)
-------------
function donate_bruiser_tb:GetIntrinsicModifierName()
    return "modifier_donate_bruiser_tb"
end

function modifier_donate_bruiser_tb:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_donate_bruiser_tb:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
    }
    return funcs
end

function modifier_donate_bruiser_tb:GetModifierBaseAttackTimeConstant()
    return self:GetAbility():GetSpecialValueFor("base_attack_time") 
end
