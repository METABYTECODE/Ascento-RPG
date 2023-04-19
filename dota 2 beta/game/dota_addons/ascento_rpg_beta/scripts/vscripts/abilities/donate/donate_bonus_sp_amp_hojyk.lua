LinkLuaModifier("modifier_donate_bonus_sp_amp_hojyk", "abilities/donate/donate_bonus_sp_amp_hojyk.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,

}

donate_bonus_sp_amp_hojyk = class(ItemBaseClass)
modifier_donate_bonus_sp_amp_hojyk = class(ItemBaseClass)
-------------
function donate_bonus_sp_amp_hojyk:GetIntrinsicModifierName()
    return "modifier_donate_bonus_sp_amp_hojyk"
end


function modifier_donate_bonus_sp_amp_hojyk:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_donate_bonus_sp_amp_hojyk:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }

    return funcs
end


function modifier_donate_bonus_sp_amp_hojyk:GetModifierSpellAmplify_Percentage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage_pct")
end