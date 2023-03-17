LinkLuaModifier("modifier_cultist_3_demon_form", "abilities/cultist/cultist_3_demon_form.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_generic_poison_lua_cultist", "abilities/generic/modifier_generic_poison_lua_cultist", LUA_MODIFIER_MOTION_NONE )

local ItemBaseClassHidden = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}
local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return false end,
    IsStackable = function(self) return false end,
}

cultist_3_demon_form = class(ItemBaseClassHidden)
modifier_cultist_3_demon_form = class(ItemBaseClass)
-------------
-- Ability Start
function cultist_3_demon_form:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()

    -- load data
    local duration = self:GetSpecialValueFor( "duration" )

    -- add modifier
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_cultist_3_demon_form", -- modifier name
        { duration = duration } -- kv
    )

    -- play effects
    local sound_cast = "Hero_Terrorblade.Metamorphosis"
    EmitSoundOn( sound_cast, self:GetCaster() )
end

function modifier_cultist_3_demon_form:OnCreated( kv )
    self.parent = self:GetParent()
    local abilityLevel = self:GetAbility():GetLevel() - 1

    -- references
    self.damage = self:GetAbility():GetLevelSpecialValueFor( "skill_damage", abilityLevel )
    self.interval = self:GetAbility():GetLevelSpecialValueFor( "skill_tick", abilityLevel )
    self.duration = self:GetAbility():GetLevelSpecialValueFor( "skill_duration", abilityLevel )

    if not IsServer() then return end
    -- ability properties
    self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

    self:StartIntervalThink( 1 )
    self:OnIntervalThink()

end

function modifier_cultist_3_demon_form:OnIntervalThink(kv)
   self:OnRefresh(kv)
end

function modifier_cultist_3_demon_form:OnRefresh( kv )
    self.parent = self:GetParent()
    local abilityLevel = self:GetAbility():GetLevel() - 1

    -- references
    self.damage = self:GetAbility():GetLevelSpecialValueFor( "skill_damage", abilityLevel )
    self.interval = self:GetAbility():GetLevelSpecialValueFor( "skill_tick", abilityLevel )
    self.duration = self:GetAbility():GetLevelSpecialValueFor( "skill_duration", abilityLevel )

    if not IsServer() then return end
    -- ability properties
    self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
end

function modifier_cultist_3_demon_form:OnRemoved()
end

function modifier_cultist_3_demon_form:OnDestroy()
end

function modifier_cultist_3_demon_form:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_cultist_3_demon_form:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_MAX_ATTACK_RANGE,
        MODIFIER_PROPERTY_MODEL_CHANGE,
    }

    return funcs
end

function modifier_cultist_3_demon_form:GetModifierBaseAttackTimeConstant()
    return self:GetAbility():GetLevelSpecialValueFor( "attack_time", self:GetAbility():GetLevel() - 1)
end

function modifier_cultist_3_demon_form:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetLevelSpecialValueFor( "bonus_armor", self:GetAbility():GetLevel() - 1)
end

function modifier_cultist_3_demon_form:GetModifierMagicalResistanceBonus()
    return self:GetAbility():GetLevelSpecialValueFor( "bonus_magic_resistance", self:GetAbility():GetLevel() - 1)
end

function modifier_cultist_3_demon_form:GetModifierMaxAttackRange()
    return self:GetAbility():GetLevelSpecialValueFor( "attack_range", self:GetAbility():GetLevel() - 1)
end

function modifier_cultist_3_demon_form:GetModifierModelChange()
    return "models/items/warlock/golem/hellsworn_golem/hellsworn_golem.vmdl"
end


function modifier_cultist_3_demon_form:OnAttack(params)
    if params.attacker~=self.parent then return end
    if self.parent:PassivesDisabled() then return end

    local attacker = params.attacker
    local victim = params.target
    local ability = self:GetAbility()


    local heroDamage = attacker:GetAverageTrueAttackDamage(attacker)
    if heroDamage ~= nil and heroDamage > 0 then
        local dealDamage = heroDamage * (self.damage / 100)

        if not victim:HasModifier("modifier_generic_poison_lua_cultist") then

            victim:AddNewModifier(
                attacker, -- player source
                ability, -- ability source
                "modifier_generic_poison_lua_cultist", -- modifier name
                { dps = dealDamage, duration = self.duration, interval = self.interval } -- kv
            )
        else
            local modifchange = victim:FindModifierByName("modifier_generic_poison_lua_cultist")
            modifchange:SetStackCount(modifchange:GetStackCount() + 1)
            modifchange:SetDuration(self.duration, true)
        end

    end

end