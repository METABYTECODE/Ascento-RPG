-- Избранный. Каждая ед силы даёт (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) хп и если силы >5000, 
-- тогда даёт 75% споротивления магии. Каждая ед ловкости 
-- (0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33) брони и если ловкости >5000,
-- тогда увеличивает весь урон на 250%. 
-- Каждая ед интеллекта даёт 1 ед урона, 3 маны и если больше >5000, тогда даёт 50% доп базового урона

support_3_chosen = class({})
LinkLuaModifier( "modifier_support_3_chosen", "abilities/support/support_3_chosen", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

support_3_chosen = class(ItemBaseClass)
modifier_support_3_chosen = class(ItemBaseClass)
-------------
function support_3_chosen:GetIntrinsicModifierName()
    return "modifier_support_3_chosen"
end


function modifier_support_3_chosen:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_support_3_chosen:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_BONUS, --GetModifierHealthBonus
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, --GetModifierPhysicalArmorBonus
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE, --GetModifierBaseAttack_BonusDamage
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE, --GetModifierBaseDamageOutgoing_Percentage
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS, --GetModifierMagicalResistanceBonus
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, --GetModifierTotalDamageOutgoing_Percentage
        MODIFIER_PROPERTY_MANA_BONUS, --GetModifierManaBonus
    }

    return funcs
end


function modifier_support_3_chosen:GetModifierHealthBonus()
    return self:GetParent():GetStrength() * (self:GetAbility():GetSpecialValueFor("hp_per_str"))
end

function modifier_support_3_chosen:GetModifierPhysicalArmorBonus()
    return self:GetParent():GetAgility() * (self:GetAbility():GetSpecialValueFor("armor_per_agi"))
end

function modifier_support_3_chosen:GetModifierBaseAttack_BonusDamage()
    return self:GetParent():GetIntellect() * (self:GetAbility():GetSpecialValueFor("dmg_per_int"))
end

function modifier_support_3_chosen:GetModifierBaseDamageOutgoing_Percentage()
	if self:GetParent():GetIntellect() > 5000 then
		return 50 -- Increase base damage by 50% 
	else
		return 0
	end

	return 0
    
end

function modifier_support_3_chosen:GetModifierManaBonus()
	return self:GetParent():GetIntellect() * (self:GetAbility():GetSpecialValueFor("mp_per_int"))
    
end

function modifier_support_3_chosen:GetModifierMagicalResistanceBonus()
	if self:GetParent():GetStrength() > 5000 then
		return 75 -- Increase magic resistance by 75% 
	else
		return 0
	end

	return 0
    
end

function modifier_support_3_chosen:GetModifierTotalDamageOutgoing_Percentage()
	if self:GetParent():GetAgility() > 5000 then
		return 250 -- Increase total damage by 250% 
	else
		return 0
	end

	return 0
    
end

