LinkLuaModifier("modifier_assasin_2_poison", "abilities/assasin/assasin_2_poison.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_generic_poison_lua", "abilities/generic/modifier_generic_poison_lua", LUA_MODIFIER_MOTION_NONE )

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

assasin_2_poison = class(ItemBaseClass)
modifier_assasin_2_poison = class(ItemBaseClass)
-------------
function assasin_2_poison:GetIntrinsicModifierName()
    return "modifier_assasin_2_poison"
end

function modifier_assasin_2_poison:OnCreated( kv )
    self.parent = self:GetParent()
    local abilityLevel = self:GetAbility():GetLevel() - 1

    -- references
    self.chance = self:GetAbility():GetLevelSpecialValueFor("chance", abilityLevel)
    self.slow = self:GetAbility():GetLevelSpecialValueFor( "slow", abilityLevel)
    self.damage = self:GetAbility():GetLevelSpecialValueFor( "damage", abilityLevel )
    self.interval = self:GetAbility():GetLevelSpecialValueFor( "interval", abilityLevel )
    self.duration = self:GetAbility():GetLevelSpecialValueFor( "duration", abilityLevel )

    if not IsServer() then return end
    -- ability properties
    self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

    self:StartIntervalThink( 1 )
    self:OnIntervalThink()

end

function modifier_assasin_2_poison:OnIntervalThink(kv)
   self:OnRefresh(kv)
end

function modifier_assasin_2_poison:OnRefresh( kv )
    self.parent = self:GetParent()
    local abilityLevel = self:GetAbility():GetLevel() - 1

    -- references
    self.chance = self:GetAbility():GetLevelSpecialValueFor("chance", abilityLevel)
    self.slow = self:GetAbility():GetLevelSpecialValueFor( "slow", abilityLevel)
    self.damage = self:GetAbility():GetLevelSpecialValueFor( "damage", abilityLevel )
    self.interval = self:GetAbility():GetLevelSpecialValueFor( "interval", abilityLevel )
    self.duration = self:GetAbility():GetLevelSpecialValueFor( "duration", abilityLevel )

    if not IsServer() then return end
    -- ability properties
    self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
end

function modifier_assasin_2_poison:OnRemoved()
end

function modifier_assasin_2_poison:OnDestroy()
end

function modifier_assasin_2_poison:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_assasin_2_poison:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK,
    }

    return funcs
end

function modifier_assasin_2_poison:OnAttack(params)
    if params.attacker~=self.parent then return end
    if self.parent:PassivesDisabled() then return end

    local attacker = params.attacker
    local victim = params.target
    local ability = self:GetAbility()

    if self:RollChance( self.chance ) then

        local heroDamage = attacker:GetAverageTrueAttackDamage(attacker)
        if heroDamage ~= nil and heroDamage > 0 then
            local dealDamage = heroDamage * (self.damage / 100)

            if not victim:HasModifier("modifier_generic_poison_lua") then

                victim:AddNewModifier(
                    attacker, -- player source
                    ability, -- ability source
                    "modifier_generic_poison_lua", -- modifier name
                    { dps = dealDamage, duration = self.duration, as_slow = self.slow, ms_slow = self.slow, less_damage = self.slow, interval = self.interval } -- kv
                )
            else
                victim:RemoveModifierByName("modifier_generic_poison_lua")

                victim:AddNewModifier(
                    attacker, -- player source
                    ability, -- ability source
                    "modifier_generic_poison_lua", -- modifier name
                    { dps = dealDamage, duration = self.duration, as_slow = self.slow, ms_slow = self.slow, less_damage = self.slow, interval = self.interval } -- kv
                )
            end

        end

    end
end

function modifier_assasin_2_poison:RollChance( chance )
    local rand = math.random()
    if rand<chance/100 then
        return true
    end
    return false
end