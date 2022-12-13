LinkLuaModifier("modifier_item_holy_damage", "items/item_holy_damage.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

item_holy_damage = class(ItemBaseClass)
modifier_item_holy_damage = class(ItemBaseClass)

-------------
function item_holy_damage:GetIntrinsicModifierName()
    return "modifier_item_holy_damage"
end

function modifier_item_holy_damage:OnCreated()
    if not IsServer() then return end
    if not self:GetCaster() then return end
    if not self:GetCaster():IsRealHero() then return end

    --self.bonus_damage = self:GetCaster():GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT):GetCurrentCharges()
    self.bonus_damage = self:GetAbility():GetCurrentCharges()

    
    --print(self.bonus_damage)
end

function modifier_item_holy_damage:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster() then return end
    if not self:GetCaster():IsRealHero() then return end

    --self.bonus_damage = self:GetCaster():GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT):GetCurrentCharges()
    self.bonus_damage = self:GetAbility():GetCurrentCharges()

    
    --print(self.bonus_damage)
    print(self.bonus_damage)
end

function modifier_item_holy_damage:OnRefresh()
    if not IsServer() then return end
    if not self:GetCaster() then return end
    if not self:GetCaster():IsRealHero() then return end

    --self.bonus_damage = self:GetCaster():GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT):GetCurrentCharges()
    self.bonus_damage = self:GetAbility():GetCurrentCharges()

    
    --print(self.bonus_damage)
    print(self.bonus_damage)
end





function modifier_item_holy_damage:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_item_holy_damage:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
    }

    return funcs
end


function modifier_item_holy_damage:GetModifierBaseDamageOutgoing_Percentage()
    return self.bonus_damage
end
