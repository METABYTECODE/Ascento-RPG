LinkLuaModifier("modifier_candy_attribute_bonus", "items/item_candy.lua", LUA_MODIFIER_MOTION_NONE)

item_candy = class({})

function item_candy:OnSpellStart()
    local caster = self:GetCaster()
    local modifier = caster:AddNewModifier(caster, self, "modifier_candy_attribute_bonus", {})

    if modifier then
        modifier:SetStackCount(modifier:GetStackCount() + 1)
    end

    self:SpendCharge()
end


modifier_candy_attribute_bonus = class({})

function modifier_candy_attribute_bonus:IsHidden()
    return true
end

function modifier_candy_attribute_bonus:IsDebuff()
    return false
end

function modifier_candy_attribute_bonus:IsPurgable()
    return true
end

function modifier_candy_attribute_bonus:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }

    return funcs
end

function modifier_candy_attribute_bonus:OnCreated()
    if not IsServer() then
        return
    end

    self:SetStackCount(1)
end


function modifier_candy_attribute_bonus:GetModifierBonusStats_Strength()
    local primary_attribute = self:GetParent():GetPrimaryAttribute()
    if primary_attribute == DOTA_ATTRIBUTE_STRENGTH then
        return 1
    end
    return 0
end

function modifier_candy_attribute_bonus:GetModifierBonusStats_Agility()
    local primary_attribute = self:GetParent():GetPrimaryAttribute()
    if primary_attribute == DOTA_ATTRIBUTE_AGILITY then
        return 1
    end
    return 0
end

function modifier_candy_attribute_bonus:GetModifierBonusStats_Intellect()
    local primary_attribute = self:GetParent():GetPrimaryAttribute()
    if primary_attribute == DOTA_ATTRIBUTE_INTELLECT then
        return 1
    end
    return 0
end








modifier_candy_attribute_bonus = class({})

function modifier_candy_attribute_bonus:IsHidden()
    return false
end

function modifier_candy_attribute_bonus:IsDebuff()
    return false
end

function modifier_candy_attribute_bonus:IsPurgable()
    return true
end

function modifier_candy_attribute_bonus:GetTexture()
    return "custom/candy"
end

function modifier_candy_attribute_bonus:OnCreated()
    if not IsServer() then
        return
    end

    self:SetStackCount(1)
end

function modifier_candy_attribute_bonus:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }

    return funcs
end

function modifier_candy_attribute_bonus:GetModifierBonusStats_Strength()
    return self:GetStackCount()
end

function modifier_candy_attribute_bonus:GetModifierBonusStats_Agility()
    return self:GetStackCount()
end

function modifier_candy_attribute_bonus:GetModifierBonusStats_Intellect()
    return self:GetStackCount()
end
