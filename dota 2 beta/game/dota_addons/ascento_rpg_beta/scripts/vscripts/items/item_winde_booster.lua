item_winde_booster = class({
    GetIntrinsicModifierName = function()
        return "modifier_item_winde_booster"
    end
})

modifier_item_winde_booster = class({
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
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
        }
    end,
    GetModifierAttackSpeedBonus_Constant = function(self)
        return self.bonusAttackSpeed
    end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_MULTIPLE
    end
})

function modifier_item_winde_booster:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:OnRefresh()
    if(not IsServer()) then
        return
    end
end

function modifier_item_winde_booster:OnRefresh()
    self.ability = self:GetAbility() or self.ability
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("bonus_attack_speed")
    
end

LinkLuaModifier("modifier_item_winde_booster", "items/item_winde_booster", LUA_MODIFIER_MOTION_NONE)