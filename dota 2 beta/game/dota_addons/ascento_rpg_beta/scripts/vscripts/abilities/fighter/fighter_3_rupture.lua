-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
fighter_3_rupture = class({})
LinkLuaModifier( "modifier_generic_ring_lua", "abilities/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fighter_3_rupture", "abilities/fighter/fighter_3_rupture", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fighter_poison", "abilities/fighter/fighter_poison", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function fighter_3_rupture:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()

    -- load data
    local duration = self:GetSpecialValueFor( "buff_duration" )

    -- add modifier
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_fighter_3_rupture", -- modifier name
        { duration = duration } -- kv
    )
end

--------------------------------------------------------------------------------
-- Projectile
function fighter_3_rupture:OnProjectileHit( target, location )
    if not target then return end

    local modifier = target:FindModifierByNameAndCaster( "modifier_fighter_3_rupture", self:GetCaster() )
    if not modifier then return end
    modifier:Absorb()
end


-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_fighter_3_rupture = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fighter_3_rupture:IsHidden()
    return false
end

function modifier_fighter_3_rupture:IsDebuff()
    return false
end

function modifier_fighter_3_rupture:IsPurgable()
    return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fighter_3_rupture:OnCreated( kv )
    -- references
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
    self.base_absorb = self:GetAbility():GetSpecialValueFor( "base_absorb_amount" )
    self.hero_absorb = self:GetAbility():GetSpecialValueFor( "absorb_per_hero_hit" )
    self.return_speed = self:GetAbility():GetSpecialValueFor( "return_projectile_speed" )
    self.dealDamage = self:GetAbility():GetSpecialValueFor( "dot_damage_pct" ) / 100

    if not IsServer() then return end

    self.damage = self:GetParent():GetAverageTrueAttackDamage(self:GetParent()) * ( self:GetAbility():GetSpecialValueFor( "damage" ) / 100)

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
        ApplyDamage(self.damageTable)



        if not enemy:HasModifier("modifier_fighter_poison") then

                enemy:AddNewModifier(
                    self:GetParent(), -- player source
                    self:GetAbility(), -- ability source
                    "modifier_fighter_poison", -- modifier name
                    { duration = 25, dps = self.dealDamage } -- kv
                )
            else
                enemy:RemoveModifierByName("modifier_fighter_poison")

                enemy:AddNewModifier(
                    self:GetParent(), -- player source
                    self:GetAbility(), -- ability source
                    "modifier_fighter_poison", -- modifier name
                    { duration = 25, dps = self.dealDamage } -- kv
                )
            end

        -- Play effects
        self:PlayEffects3( enemy )

        if not enemy:IsHero() then return end

        -- create projectile
        self.info.Source = enemy
        ProjectileManager:CreateTrackingProjectile(self.info)

        -- Play effects
        self:PlayEffects4( enemy )
    end)

    -- Play effects
    self:PlayEffects1()
    self:PlayEffects2()
end

function modifier_fighter_3_rupture:OnRefresh( kv )
    -- references
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
    self.base_absorb = self:GetAbility():GetSpecialValueFor( "base_absorb_amount" )
    self.hero_absorb = self:GetAbility():GetSpecialValueFor( "absorb_per_hero_hit" )
    self.return_speed = self:GetAbility():GetSpecialValueFor( "return_speed" )
    self.dealDamage = self:GetAbility():GetSpecialValueFor( "dot_damage_pct" ) / 100

    if not IsServer() then return end

    self.damage = self:GetParent():GetAverageTrueAttackDamage(self:GetParent()) * ( self:GetAbility():GetSpecialValueFor( "damage" ) / 100)

    -- set up shield
    self.shield = self.shield + self.base_absorb

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
        ApplyDamage(self.damageTable)


        if not enemy:HasModifier("modifier_fighter_poison") then

                enemy:AddNewModifier(
                    self:GetParent(), -- player source
                    self:GetAbility(), -- ability source
                    "modifier_fighter_poison", -- modifier name
                    { duration = 25, dps = self.dealDamage } -- kv
                )
            else
                enemy:RemoveModifierByName("modifier_fighter_poison")

                enemy:AddNewModifier(
                    self:GetParent(), -- player source
                    self:GetAbility(), -- ability source
                    "modifier_fighter_poison", -- modifier name
                    { duration = 25, dps = self.dealDamage } -- kv
                )
            end

        -- Play effects
        self:PlayEffects3( enemy )

        if not enemy:IsHero() then return end

        -- create projectile
        self.info.Source = enemy
        ProjectileManager:CreateTrackingProjectile(self.info)

        -- Play effects
        self:PlayEffects4( enemy )
    end)

    -- Play effects
    self:PlayEffects1()
end

function modifier_fighter_3_rupture:OnRemoved()
end

function modifier_fighter_3_rupture:OnDestroy()
    if not IsServer() then return end
    local sound_destroy = "Hero_VoidSpirit.Pulse.Destroy"
    EmitSoundOn( sound_destroy, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_fighter_3_rupture:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
    }

    return funcs
end

function modifier_fighter_3_rupture:GetModifierIncomingPhysicalDamageConstant( params )
    if not IsServer() then return end

    -- play effects
    self:PlayEffects5()

    -- block based on damage
    if params.damage>self.shield then
        self:Destroy()
        return -self.shield
    else
        self.shield = self.shield-params.damage
        return -params.damage
    end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_fighter_3_rupture:Absorb()
    self.shield = self.shield + self.hero_absorb
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_fighter_3_rupture:GetStatusEffectName()
    return "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
end

function modifier_fighter_3_rupture:StatusEffectPriority()
    return MODIFIER_PRIORITY_NORMAL
end

function modifier_fighter_3_rupture:PlayEffects1()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse.vpcf"
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

function modifier_fighter_3_rupture:PlayEffects2()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield.vpcf"
    local particle_cast2 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_buff.vpcf"
    local sound_cast = "Hero_VoidSpirit.Pulse.Cast"

    -- Get Data
    local radius = 100

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        0,
        self:GetParent(),
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        Vector(0,0,0), -- unknown
        true -- unknown, true
    )

    -- buff particle
    self:AddParticle(
        effect_cast,
        false, -- bDestroyImmediately
        false, -- bStatusEffect
        -1, -- iPriority
        false, -- bHeroEffect
        false -- bOverheadEffect
    )

    local effect_cast = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    -- Create Sound
    EmitSoundOn( sound_cast, self:GetParent() )
end


function modifier_fighter_3_rupture:PlayEffects3( target )
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_impact.vpcf"
    local particle_cast2 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf"
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

function modifier_fighter_3_rupture:PlayEffects4( target )
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf"

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
        self:GetParent(),
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        Vector(0,0,0), -- unknown
        true -- unknown, true
    )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_fighter_3_rupture:PlayEffects5()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield_deflect.vpcf"

    -- Get Data
    local radius = 100

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        0,
        self:GetParent(),
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        Vector(0,0,0), -- unknown
        true -- unknown, true
    )

    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end