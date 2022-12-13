LinkLuaModifier("modifier_tank_1_tough", "abilities/tank/tank_1_tough.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

tank_1_tough = class(ItemBaseClass)
modifier_tank_1_tough = class(ItemBaseClass)
-------------
function tank_1_tough:GetIntrinsicModifierName()
    return "modifier_tank_1_tough"
end


function modifier_tank_1_tough:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_tank_1_tough:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_BONUS, --GetModifierHealthBonus
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, --GetModifierPhysicalArmorBonus
    }

    return funcs
end


function modifier_tank_1_tough:GetModifierHealthBonus()
    return self:GetParent():GetStrength() * (self:GetAbility():GetSpecialValueFor("hp_per_str"))
end

function modifier_tank_1_tough:GetModifierPhysicalArmorBonus()
    return self:GetParent():GetAgility() * (self:GetAbility():GetSpecialValueFor("armor_per_agi"))
end
