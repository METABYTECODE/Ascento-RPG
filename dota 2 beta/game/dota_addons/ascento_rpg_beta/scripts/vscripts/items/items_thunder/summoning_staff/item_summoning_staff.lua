LinkLuaModifier("modifier_item_summoning_staff", "items/items_thunder/summoning_staff/item_summoning_staff.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

item_summoning_staff = class(ItemBaseClass)
item_summoning_staff_2 = item_summoning_staff
item_summoning_staff_3 = item_summoning_staff
item_summoning_staff_4 = item_summoning_staff
item_summoning_staff_5 = item_summoning_staff
item_summoning_staff_6 = item_summoning_staff
item_summoning_staff_7 = item_summoning_staff
modifier_item_summoning_staff = class(ItemBaseClass)
-------------
function item_summoning_staff:GetIntrinsicModifierName()
    return "modifier_item_summoning_staff"
end
---

function modifier_item_summoning_staff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, --GetModifierBonusStats_Intellect
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS, --GetModifierBonusStats_Agility
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    }

    return funcs
end

function modifier_item_summoning_staff:GetModifierBonusStats_Intellect()
    if not self then return end
    if not self:GetAbility() or self:GetAbility():IsNull() then return end
    return self:GetAbility():GetSpecialValueFor("bonus_int")
end

function modifier_item_summoning_staff:GetModifierBonusStats_Agility()
    if not self then return end
    if not self:GetAbility() or self:GetAbility():IsNull() then return end
    return self:GetAbility():GetSpecialValueFor("bonus_agi")
end

function modifier_item_summoning_staff:GetModifierBonusStats_Strength()
    if not self then return end
    if not self:GetAbility() or self:GetAbility():IsNull() then return end
    return self:GetAbility():GetSpecialValueFor("bonus_str")
end