LinkLuaModifier("modifier_magic_warrior_2_manablood", "abilities/magic_warrior/magic_warrior_2_manablood.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

magic_warrior_2_manablood = class(ItemBaseClass)
modifier_magic_warrior_2_manablood = class(ItemBaseClass)
-------------
function magic_warrior_2_manablood:GetIntrinsicModifierName()
    return "modifier_magic_warrior_2_manablood"
end

function modifier_magic_warrior_2_manablood:OnCreated( kv )
    -- references
    
    self.health_regen = self:GetAbility():GetSpecialValueFor( "health_regen" )
    self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen" )
end

function modifier_magic_warrior_2_manablood:OnRefresh( kv )
    -- references
    self.health_regen = self:GetAbility():GetSpecialValueFor( "health_regen" )
    self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen" )
end

function modifier_magic_warrior_2_manablood:OnDestroy( kv )
end

function modifier_magic_warrior_2_manablood:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_magic_warrior_2_manablood:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK,
    }

    return funcs
end

function modifier_magic_warrior_2_manablood:OnAttack(event)
    if not IsServer() then return end

    local attacker = event.attacker
    local victim = event.target
    local ability = self:GetAbility()

    if not ability or ability == nil then return end

    if self:GetCaster() ~= attacker then
        return
    end

    if not attacker:IsRealHero() then return end

        local health = attacker:GetMaxHealth() * (self:GetAbility():GetSpecialValueFor( "health_regen" ) / 100)
        local mana = attacker:GetMaxMana() * (self:GetAbility():GetSpecialValueFor( "mana_regen" ) / 100)
        attacker:Heal(health, attacker)
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, attacker, health, nil) --ХИЛ
        attacker:GiveMana(mana)
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, attacker, mana, nil) --МАНА

end
