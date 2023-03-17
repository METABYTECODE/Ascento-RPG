
--------------------------------------------------------------------------------
mage_3_elemental_boom = class({})
LinkLuaModifier( "modifier_generic_ring_lua", "abilities/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mage_3_elemental_boom", "abilities/mage/mage_3_elemental_boom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mage_3_elemental_boom_dmg_inc", "abilities/mage/mage_3_elemental_boom", LUA_MODIFIER_MOTION_NONE )

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}


modifier_mage_3_elemental_boom_dmg_inc = class(ItemBaseClass)

function mage_3_elemental_boom:GetIntrinsicModifierName()
    return "modifier_mage_3_elemental_boom_dmg_inc"
end


function modifier_mage_3_elemental_boom_dmg_inc:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_mage_3_elemental_boom_dmg_inc:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }

    return funcs
end

function modifier_mage_3_elemental_boom_dmg_inc:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetAbility():GetSpecialValueFor("dmg_inc") 
end

--------------------------------------------------------------------------------
-- Ability Start
function mage_3_elemental_boom:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()

    -- load data
    local duration = self:GetSpecialValueFor( "buff_duration" )

    -- add modifier
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_mage_3_elemental_boom", -- modifier name
        { duration = duration } -- kv
    )
end

--------------------------------------------------------------------------------
-- Projectile
function mage_3_elemental_boom:OnProjectileHit( target, location )
    if not target then return end

    local modifier = target:FindModifierByNameAndCaster( "modifier_mage_3_elemental_boom", self:GetCaster() )
    if not modifier then return end
    modifier:Absorb()
end


--------------------------------------------------------------------------------
modifier_mage_3_elemental_boom = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mage_3_elemental_boom:IsHidden()
    return false
end

function modifier_mage_3_elemental_boom:IsDebuff()
    return false
end

function modifier_mage_3_elemental_boom:IsPurgable()
    return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mage_3_elemental_boom:OnCreated( kv )
    -- references
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
    self.base_absorb = self:GetAbility():GetSpecialValueFor( "base_absorb_amount" )
    self.hero_absorb = self:GetAbility():GetSpecialValueFor( "absorb_per_hero_hit" )
    self.return_speed = self:GetAbility():GetSpecialValueFor( "return_projectile_speed" )

    if not IsServer() then return end

    self.damage = self:GetParent():GetAverageTrueAttackDamage(self:GetParent()) * ( self:GetAbility():GetSpecialValueFor( "damage" ) / 100)

    if self:GetParent():HasModifier("modifier_mage_3_magic_crit") then
        if IsServer() then
            local ability = self:GetParent():FindAbilityByName("mage_3_magic_crit")
            local chance = ability:GetSpecialValueFor("critical_chance")

            if RollPercentage(chance) then
                self.damage = self.damage * (ability:GetSpecialValueFor("critical_damage") / 100)
                EmitSoundOn( "Ability.static.start", self:GetParent() )

            end
        end
    end

    -- set up shield
    self.shield = self.base_absorb

    -- precache damage
    self.damageTable = {
        -- victim = target,
        attacker = self:GetParent(),
        damage = self.damage,
        damage_type = self:GetAbility():GetAbilityDamageType(),
        ability = self:GetAbility(), --Optional.
    }

    -- precache projectile
    self.info = {
        Target = self:GetParent(),
        -- Source = caster,
        Ability = self:GetAbility(),    
        EffectName = "",
        iMoveSpeed = self.return_speed,
        bDodgeable = false,                           -- Optional
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
    }

    -- Create pulse
    local pulse = self:GetParent():AddNewModifier(
        self:GetParent(), -- player source
        self:GetAbility(), -- ability source
        "modifier_generic_ring_lua", -- modifier name
        {
            end_radius = self.radius,
            speed = self.speed,
            target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
            target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        } -- kv
    )
    pulse:SetCallback( function( enemy )
        -- apply damage
        self.damageTable.victim = enemy

        if enemy:HasModifier("modifier_mage_2_magic_horizont") then
            local tmdf = enemy:FindModifierByName("modifier_mage_2_magic_horizont")
            self.damageTable.damage = self.damageTable.damage * ( 1 + (0.1 * tmdf:GetStackCount()) )
        end

        ApplyDamage(self.damageTable)



        -- Play effects
        self:PlayEffects3( enemy )

        if not enemy:IsHero() then return end

        -- create projectile
        self.info.Source = enemy
        ProjectileManager:CreateTrackingProjectile(self.info)

    end)

    -- Play effects
    self:PlayEffects1()
end

function modifier_mage_3_elemental_boom:OnRefresh( kv )
    -- references
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
    self.base_absorb = self:GetAbility():GetSpecialValueFor( "base_absorb_amount" )
    self.hero_absorb = self:GetAbility():GetSpecialValueFor( "absorb_per_hero_hit" )
    self.return_speed = self:GetAbility():GetSpecialValueFor( "return_speed" )

    if not IsServer() then return end

    self.damage = self:GetParent():GetAverageTrueAttackDamage(self:GetParent()) * ( self:GetAbility():GetSpecialValueFor( "damage" ) / 100)

    if self:GetParent():HasModifier("modifier_mage_3_magic_crit") then
        if IsServer() then
            local ability = self:GetParent():FindAbilityByName("mage_3_magic_crit")
            local chance = ability:GetSpecialValueFor("critical_chance")

            if RollPercentage(chance) then
                self.damage = self.damage * (ability:GetSpecialValueFor("critical_damage") / 100)
                EmitSoundOn( "Ability.static.start", self:GetParent() )

            end
        end
    end

    -- precache damage
    self.damageTable = {
        -- victim = target,
        attacker = self:GetParent(),
        damage = self.damage,
        damage_type = self:GetAbility():GetAbilityDamageType(),
        ability = self:GetAbility(), --Optional.
    }

    -- Create pulse
    local pulse = self:GetParent():AddNewModifier(
        self:GetParent(), -- player source
        self:GetAbility(), -- ability source
        "modifier_generic_ring_lua", -- modifier name
        {
            end_radius = self.radius,
            speed = self.speed,
            target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
            target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        } -- kv
    )
    pulse:SetCallback( function( enemy )
        -- apply damage
        self.damageTable.victim = enemy

        if enemy:HasModifier("modifier_mage_2_magic_horizont") then
            local tmdf = enemy:FindModifierByName("modifier_mage_2_magic_horizont")
            self.damageTable.damage = self.damageTable.damage * ( 1 + (0.1 * tmdf:GetStackCount()) )
        end

        ApplyDamage(self.damageTable)


        -- Play effects
        self:PlayEffects3( enemy )

        if not enemy:IsHero() then return end

        -- create projectile
        self.info.Source = enemy
        ProjectileManager:CreateTrackingProjectile(self.info)

    end)

    -- Play effects
    self:PlayEffects1()
end

function modifier_mage_3_elemental_boom:OnRemoved()
end

function modifier_mage_3_elemental_boom:OnDestroy()
    if not IsServer() then return end
    local sound_destroy = "Hero_VoidSpirit.Pulse.Destroy"
    EmitSoundOn( sound_destroy, self:GetParent() )
end


--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mage_3_elemental_boom:GetStatusEffectName()
    return "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
end

function modifier_mage_3_elemental_boom:StatusEffectPriority()
    return MODIFIER_PRIORITY_NORMAL
end

function modifier_mage_3_elemental_boom:PlayEffects1()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_arc_warden/arc_warden_death_ground.vpcf"
    local sound_cast = "Hero_VoidSpirit.Pulse"

    -- adjustment
    local radius = self.radius * 2

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    -- Create Sound
    EmitSoundOn( sound_cast, self:GetParent() )
end



function modifier_mage_3_elemental_boom:PlayEffects3( target )
    -- Get Resources
    local particle_cast = "particles/econ/items/slark/slark_head_immortal/slark_immortal_dark_pact_pulses_pnt.vpcf"
    local sound_cast = "Hero_VoidSpirit.Pulse.Target"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        0,
        target,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        Vector(0,0,0), -- unknown
        true -- unknown, true
    )
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        1,
        target,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        Vector(0,0,0), -- unknown
        true -- unknown, true
    )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    -- Create Sound
    EmitSoundOn( sound_cast, target )
end
