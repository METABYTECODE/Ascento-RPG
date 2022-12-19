LinkLuaModifier("modifier_item_piercing_blade", "items/items_thunder/piercing_blade/item_piercing_blade.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

item_piercing_blade = class(ItemBaseClass)
item_piercing_blade2 = item_piercing_blade
item_piercing_blade3 = item_piercing_blade
item_piercing_blade4 = item_piercing_blade
item_piercing_blade5 = item_piercing_blade
modifier_item_piercing_blade = class(ItemBaseClass)
---
function item_piercing_blade:GetIntrinsicModifierName()
    return "modifier_item_piercing_blade"
end

function modifier_item_piercing_blade:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }

    return funcs
end

function modifier_item_piercing_blade:GetModifierPreAttack_BonusDamage()
    if not self then return end
    if not self:GetAbility() or self:GetAbility():IsNull() then return end
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_piercing_blade:OnAttackLanded(event)
    if not IsServer() then return end

    local attacker = event.attacker

    if attacker ~= self:GetParent() then return end
    if not attacker:IsRealHero() or attacker:IsTempestDouble() or attacker:IsIllusion() then return end

    local ability = self:GetAbility()

    local target = event.target

    ApplyDamage({
        victim = target,
        attacker = attacker,
        damage = attacker:GetAverageTrueAttackDamage(attacker) * ability:GetSpecialValueFor("attack_damage_to_pure_pct") * 0.01,
        damage_type = ability:GetAbilityDamageType(),
        damage_flags = bit.bor(DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS),
    })
end