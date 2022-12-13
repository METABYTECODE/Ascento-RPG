LinkLuaModifier("modifier_ranger_2_crossbow_mastery", "abilities/ranger/ranger_2_crossbow_mastery.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,

}

ranger_2_crossbow_mastery = class(ItemBaseClass)
modifier_ranger_2_crossbow_mastery = class(ItemBaseClass)
-------------
function ranger_2_crossbow_mastery:GetIntrinsicModifierName()
    return "modifier_ranger_2_crossbow_mastery"
end


function modifier_ranger_2_crossbow_mastery:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end


---
function modifier_ranger_2_crossbow_mastery:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
    }

    return funcs
end


function modifier_ranger_2_crossbow_mastery:GetModifierDamageOutgoing_Percentage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage_pct")
end


function modifier_ranger_2_crossbow_mastery:GetModifierBaseAttackTimeConstant()
    return self:GetAbility():GetSpecialValueFor("base_attack_time")
end
