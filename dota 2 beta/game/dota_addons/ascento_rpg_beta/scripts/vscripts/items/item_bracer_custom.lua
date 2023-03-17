item_bracer_custom = class({
    GetIntrinsicModifierName = function()
        return "modifier_item_bracer_custom"
    end
})

item_ogres_bracer = class(item_bracer_custom)
item_giants_bracer = class(item_bracer_custom)

modifier_item_bracer_custom = class({
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
            MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
            MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
            MODIFIER_PROPERTY_HEALTH_BONUS
        }
    end,
    GetModifierBonusStats_Intellect = function(self)
        return self.bonusInt
    end,
    GetModifierBonusStats_Agility = function(self)
        return self.bonusAgi
    end,
    GetModifierConstantHealthRegen = function(self)
        return self.bonusHealthRegen
    end,
    GetModifierBonusStats_Strength = function(self)
        return self.bonusStr
    end,
    GetModifierHealthBonus = function(self)
        return self.bonusHealth
    end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_MULTIPLE
    end
})

function modifier_item_bracer_custom:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:OnRefresh()
    if(not IsServer()) then
        return
    end
end

function modifier_item_bracer_custom:OnRefresh()
    self.ability = self:GetAbility() or self.ability
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.bonusInt = self.ability:GetSpecialValueFor("bonus_int")
    self.bonusAgi = self.ability:GetSpecialValueFor("bonus_agi")
    self.bonusStr = self.ability:GetSpecialValueFor("bonus_str")
    self.bonusHealthRegen = self.ability:GetSpecialValueFor("bonus_hp_regen")
    self.bonusHealth = self.ability:GetSpecialValueFor("bonus_health")
    
end

LinkLuaModifier("modifier_item_bracer_custom", "items/item_bracer_custom", LUA_MODIFIER_MOTION_NONE)