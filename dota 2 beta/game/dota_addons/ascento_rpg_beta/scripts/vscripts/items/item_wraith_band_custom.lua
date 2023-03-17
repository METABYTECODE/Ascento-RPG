item_wraith_band_custom = class({
    GetIntrinsicModifierName = function()
        return "modifier_item_wraith_custom"
    end
})

item_assassins_mask = class(item_wraith_band_custom)
item_ghost_mask = class(item_wraith_band_custom)

modifier_item_wraith_custom = class({
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
            MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
        }
    end,
    GetModifierBonusStats_Intellect = function(self)
        return self.bonusInt
    end,
    GetModifierBonusStats_Agility = function(self)
        return self.bonusAgi
    end,
    GetModifierPhysicalArmorBonus = function(self)
        return self.bonusArmor
    end,
    GetModifierBonusStats_Strength = function(self)
        return self.bonusStr
    end,
    GetModifierAttackSpeedBonus_Constant = function(self)
        return self.bonusAttack
    end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_MULTIPLE
    end
})

function modifier_item_wraith_custom:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:OnRefresh()
    if(not IsServer()) then
        return
    end
end

function modifier_item_wraith_custom:OnRefresh()
    self.ability = self:GetAbility() or self.ability
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.bonusInt = self.ability:GetSpecialValueFor("bonus_int")
    self.bonusAgi = self.ability:GetSpecialValueFor("bonus_agi")
    self.bonusStr = self.ability:GetSpecialValueFor("bonus_str")
    self.bonusAttack = self.ability:GetSpecialValueFor("bonus_attack")
    self.bonusArmor = self.ability:GetSpecialValueFor("bonus_armor")
    
end

LinkLuaModifier("modifier_item_wraith_custom", "items/item_wraith_band_custom", LUA_MODIFIER_MOTION_NONE)