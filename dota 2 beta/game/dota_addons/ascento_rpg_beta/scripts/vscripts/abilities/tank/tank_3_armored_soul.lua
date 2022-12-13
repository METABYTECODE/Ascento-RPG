LinkLuaModifier("modifier_tank_3_armored_soul", "abilities/tank/tank_3_armored_soul.lua", LUA_MODIFIER_MOTION_NONE)

--Armored soul provides armor bonus and prevents part of incoming damage. 
--500 +(10 20 30 40 50 60 70 80 90 100 110 120 130 104 150 160 170 180 190 200)% bonus armor 
--Prevents (2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40)% of damage. 

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

tank_3_armored_soul = class(ItemBaseClass)
modifier_tank_3_armored_soul = class(ItemBaseClass)
-------------
function tank_3_armored_soul:GetIntrinsicModifierName()
    return "modifier_tank_3_armored_soul"
end


function modifier_tank_3_armored_soul:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_tank_3_armored_soul:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, --GetModifierPhysicalArmorBonus
    }

    return funcs
end


function modifier_tank_3_armored_soul:GetModifierPhysicalArmorBonus()
    return 500 + ( self:GetParent():GetPhysicalArmorBaseValue() * self:GetAbility():GetLevelSpecialValueFor("armor_pct", (self:GetAbility():GetLevel() - 1)) )
end
