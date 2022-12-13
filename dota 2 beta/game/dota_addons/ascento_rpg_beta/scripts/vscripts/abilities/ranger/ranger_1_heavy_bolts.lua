LinkLuaModifier("modifier_ranger_1_heavy_bolts", "abilities/ranger/ranger_1_heavy_bolts.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,

}

ranger_1_heavy_bolts = class(ItemBaseClass)
modifier_ranger_1_heavy_bolts = class(ItemBaseClass)
-------------
function ranger_1_heavy_bolts:GetIntrinsicModifierName()
    return "modifier_ranger_1_heavy_bolts"
end


function modifier_ranger_1_heavy_bolts:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_ranger_1_heavy_bolts:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    }

    return funcs
end


function modifier_ranger_1_heavy_bolts:GetModifierDamageOutgoing_Percentage()
    return 0--self:GetAbility():GetSpecialValueFor("bonus_damage_pct")
end