LinkLuaModifier("modifier_item_gladiator_armor", "items/items_thunder/gladiator_armor/item_gladiator_armor.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gladiator_armor_enrage", "items/items_thunder/gladiator_armor/item_gladiator_armor.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

local ItemBaseClassEnrage = {
    IsPurgable = function(self) return true end,
    RemoveOnDeath = function(self) return true end,
    IsHidden = function(self) return false end,
    IsStackable = function(self) return false end,
    IsDebuff = function(self) return false end,
}

item_gladiator_armor = class(ItemBaseClass)
item_gladiator_armor_2 = item_gladiator_armor
item_gladiator_armor_3 = item_gladiator_armor
item_gladiator_armor_4 = item_gladiator_armor
item_gladiator_armor_5 = item_gladiator_armor
item_gladiator_armor_6 = item_gladiator_armor
item_gladiator_armor_7 = item_gladiator_armor
item_gladiator_armor_8 = item_gladiator_armor
modifier_item_gladiator_armor = class(item_gladiator_armor)
modifier_item_gladiator_armor_enrage = class(ItemBaseClassEnrage)

function modifier_item_gladiator_armor:GetTexture() return "gladiator_armor" end
function modifier_item_gladiator_armor_enrage:GetTexture() return "gladiator_armor" end
-------------
function item_gladiator_armor:GetIntrinsicModifierName()
    return "modifier_item_gladiator_armor"
end

function modifier_item_gladiator_armor:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, --GetModifierPreAttack_BonusDamage
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, --GetModifierPhysicalArmorBonus
    }
    return funcs
end

function modifier_item_gladiator_armor:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_gladiator_armor:GetModifierHealthBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_gladiator_armor:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_gladiator_armor:OnCreated()
    if not IsServer() then return end

    local parent = self:GetParent()

    self.ability = self:GetAbility()
    self.strengthRet = self.ability:GetSpecialValueFor("strength_ret")
    self.flatRet = self.ability:GetSpecialValueFor("flat_ret")
    self.pctRet = self.ability:GetSpecialValueFor("pct_ret")
    self.bossReflection = self.ability:GetSpecialValueFor("boss_reflection_pct")
    self.enrageDuration = self.ability:GetSpecialValueFor("duration")

    --self.strengthDamageTable = {
    --    attacker = parent, 
    --    damage_type = DAMAGE_TYPE_MAGICAL,
    --    damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
    --    ability = self.ability
    --}

    self.reflectDamageTable = {
        attacker = parent, 
        damage_type = DAMAGE_TYPE_MAGICAL,
        damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_BYPASSES_BLOCK + DOTA_DAMAGE_FLAG_REFLECTION,
        ability = self.ability
    }
end

function modifier_item_gladiator_armor:OnAttackLanded(event)
    if not IsServer() then return end

    local attacker = event.attacker
    local parent = self:GetParent()
    local caster = self:GetCaster()
    local victim = event.target

    if victim ~= parent or attacker == victim or attacker == parent or event.damage_type ~= DAMAGE_TYPE_PHYSICAL or event.inflictor ~= nil or event.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK or not victim:IsAlive() or victim:IsMuted() then
        return
    end

    -- reflects a portion of your strength and a portion of the damage taken back to the attacker as the same damage type --

    local strengthDamage = (victim:GetStrength() * (self.strengthRet/100)) + self.flatRet
    local damageReturned = event.original_damage * (self.pctRet/100)

    --if IsBossTCOTRPG(attacker) then
        --damageReturned = damageReturned * (1-(self.bossReflection/100))
    --end

    -- Will return strength damage to bosses --
    --self.strengthDamageTable.victim = attacker
    --self.strengthDamageTable.damage = strengthDamage
    --ApplyDamage(self.strengthDamageTable)

    -- Will not return damage taken back to bosses --
    if (victim:GetLevel() >= attacker:GetLevel()) then
        self.reflectDamageTable.victim = attacker
        self.reflectDamageTable.damage = damageReturned + strengthDamage
        ApplyDamage(self.reflectDamageTable)
    end

    -- applies an enrage effect when the attacker hits you --
    local modifierName = "modifier_item_gladiator_armor_enrage"
    if not attacker:HasModifier(modifierName) then
        local enrage = attacker:AddNewModifier(victim, self.ability, modifierName, {
            duration = self.enrageDuration
        })
    end
end
--------
function modifier_item_gladiator_armor_enrage:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT , --GetModifierAttackSpeedBonus_Constant
    }
    return funcs
end

function modifier_item_gladiator_armor_enrage:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("enrage_atk_spd")
end