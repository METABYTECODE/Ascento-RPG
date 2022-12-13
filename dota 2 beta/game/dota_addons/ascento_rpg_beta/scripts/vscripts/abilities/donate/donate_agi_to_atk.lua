LinkLuaModifier("modifier_donate_agi_to_atk", "abilities/donate/donate_agi_to_atk.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

donate_agi_to_atk = class(ItemBaseClass)
modifier_donate_agi_to_atk = class(ItemBaseClass)
-------------
function donate_agi_to_atk:GetIntrinsicModifierName()
    return "modifier_donate_agi_to_atk"
end


function modifier_donate_agi_to_atk:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_donate_agi_to_atk:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE, --GetModifierHealthBonus
    }

    return funcs
end


function modifier_donate_agi_to_atk:GetModifierBaseAttack_BonusDamage()
    return self:GetParent():GetAgility() * (self:GetAbility():GetSpecialValueFor("atk_per_agi") / 100)
end