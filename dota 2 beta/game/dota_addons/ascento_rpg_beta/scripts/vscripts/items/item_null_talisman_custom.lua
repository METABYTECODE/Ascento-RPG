item_null_talisman_custom = class({
    GetIntrinsicModifierName = function()
        return "modifier_item_null_talisman_custom"
    end
})

item_magician_talisman = class(item_null_talisman_custom)
item_archmagician_talisman = class(item_null_talisman_custom)

modifier_item_null_talisman_custom = class({
    IsHidden = function()
        return true
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
    RemoveOnDeath = function()
        return false
    end,
    DeclareFunctions = function()
        return {
            MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
            MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
            MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
            MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
            MODIFIER_PROPERTY_MANA_BONUS
        }
    end,
    GetModifierBonusStats_Intellect = function(self)
        return self.bonusInt
    end,
    GetModifierBonusStats_Agility = function(self)
        return self.bonusAgi
    end,
    GetModifierConstantManaRegen = function(self)
        return self.bonusManaRegen
    end,
    GetModifierBonusStats_Strength = function(self)
        return self.bonusStr
    end,
    GetModifierManaBonus = function(self)
        return self.bonusMana
    end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_MULTIPLE
    end
})

function modifier_item_null_talisman_custom:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:OnRefresh()
    if(not IsServer()) then
        return
    end
end

function modifier_item_null_talisman_custom:OnRefresh()
    self.ability = self:GetAbility() or self.ability
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.bonusInt = self.ability:GetSpecialValueFor("bonus_int")
    self.bonusAgi = self.ability:GetSpecialValueFor("bonus_agi")
    self.bonusStr = self.ability:GetSpecialValueFor("bonus_str")
    self.bonusManaRegen = self.ability:GetSpecialValueFor("bonus_mana_regen")
    self.bonusMana = self.ability:GetSpecialValueFor("bonus_mana")
    
end

LinkLuaModifier("modifier_item_null_talisman_custom", "items/item_null_talisman_custom", LUA_MODIFIER_MOTION_NONE)