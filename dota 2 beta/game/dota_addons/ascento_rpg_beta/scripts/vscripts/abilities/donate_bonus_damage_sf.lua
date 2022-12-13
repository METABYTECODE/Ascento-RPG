LinkLuaModifier("modifier_donate_bonus_damage_sf", "abilities/donate_bonus_damage_sf.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,

}

donate_bonus_damage_sf = class(ItemBaseClass)
modifier_donate_bonus_damage_sf = class(ItemBaseClass)
-------------
function donate_bonus_damage_sf:GetIntrinsicModifierName()
    return "modifier_donate_bonus_damage_sf"
end


function modifier_donate_bonus_damage_sf:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_donate_bonus_damage_sf:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    }

    return funcs
end


function modifier_donate_bonus_damage_sf:GetModifierDamageOutgoing_Percentage()
    return 0--self:GetAbility():GetSpecialValueFor("bonus_damage_pct")
end