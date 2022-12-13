LinkLuaModifier("modifier_item_ring_primary", "items/item_ring_primary.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

item_ring_primary = class(ItemBaseClass)
modifier_item_ring_primary = class(ItemBaseClass)

item_ring_1 = item_ring_primary
item_ring_2 = item_ring_primary
item_ring_3 = item_ring_primary
item_ring_4 = item_ring_primary
item_ring_5 = item_ring_primary
item_ring_6 = item_ring_primary
item_ring_7 = item_ring_primary
item_ring_8 = item_ring_primary
item_ring_9 = item_ring_primary
item_ring_10 = item_ring_primary
item_ring_11 = item_ring_primary
item_ring_12 = item_ring_primary
item_ring_13 = item_ring_primary
item_ring_14 = item_ring_primary
item_ring_15 = item_ring_primary
item_ring_16 = item_ring_primary
item_ring_17 = item_ring_primary
item_ring_18 = item_ring_primary
item_ring_19 = item_ring_primary
item_ring_20 = item_ring_primary
item_ring_21 = item_ring_primary
item_ring_22 = item_ring_primary
item_ring_23 = item_ring_primary
item_ring_24 = item_ring_primary
item_ring_25 = item_ring_primary
item_ring_26 = item_ring_primary
item_ring_27 = item_ring_primary
item_ring_28 = item_ring_primary
item_ring_29 = item_ring_primary
item_ring_30 = item_ring_primary
item_ring_31 = item_ring_primary

-------------
function item_ring_primary:GetIntrinsicModifierName()
    return "modifier_item_ring_primary"
end

function modifier_item_ring_primary:OnCreated()
    if not IsServer() then return end
    if not self:GetCaster() then return end
    if not self:GetCaster():IsRealHero() then return end

    self.strength = 0
    self.agility = 0
    self.intellect = 0
    local bonus = self:GetAbility():GetSpecialValueFor("bonus_primary")
    local primaryAttr = self:GetCaster():GetPrimaryAttribute()
    if primaryAttr == 0 then
        self.strength = bonus
    elseif primaryAttr == 1 then
        self.agility = bonus
    elseif primaryAttr == 2 then
        self.intellect = bonus
    end

end

function modifier_item_ring_primary:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_item_ring_primary:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }

    return funcs
end


function modifier_item_ring_primary:GetModifierBonusStats_Strength()
    return self.strength
end

function modifier_item_ring_primary:GetModifierBonusStats_Agility()
    return self.agility
end

function modifier_item_ring_primary:GetModifierBonusStats_Intellect()
    return self.intellect
end

