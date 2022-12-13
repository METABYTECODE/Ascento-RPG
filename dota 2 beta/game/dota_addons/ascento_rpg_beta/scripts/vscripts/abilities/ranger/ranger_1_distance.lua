LinkLuaModifier("modifier_ranger_1_distance", "abilities/ranger/ranger_1_distance.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

ranger_1_distance = class(ItemBaseClass)
modifier_ranger_1_distance = class(ItemBaseClass)
-------------
function ranger_1_distance:GetIntrinsicModifierName()
    return "modifier_ranger_1_distance"
end

function modifier_ranger_1_distance:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_ranger_1_distance:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_BONUS_DAY_VISION,
        MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
    }

    return funcs
end


function modifier_ranger_1_distance:GetModifierAttackRangeBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_range")
end

function modifier_ranger_1_distance:GetBonusDayVision()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_range")
end

function modifier_ranger_1_distance:GetBonusNightVision()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_range")
end

