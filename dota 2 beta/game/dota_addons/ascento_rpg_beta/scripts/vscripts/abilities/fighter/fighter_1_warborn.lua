LinkLuaModifier("modifier_fighter_1_warborn", "abilities/fighter/fighter_1_warborn.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

fighter_1_warborn = class(ItemBaseClass)
modifier_fighter_1_warborn = class(ItemBaseClass)
-------------
function fighter_1_warborn:GetIntrinsicModifierName()
    return "modifier_fighter_1_warborn"
end

function modifier_fighter_1_warborn:OnCreated( kv )
    -- references
    self.max_as = self:GetAbility():GetSpecialValueFor( "maximum_attack_speed" )
    --self.max_mr = self:GetAbility():GetSpecialValueFor( "maximum_resistance" )
    self.max_threshold = self:GetAbility():GetSpecialValueFor( "hp_threshold_max" )
    self.max_lifesteal = self:GetAbility():GetSpecialValueFor( "maximum_lifesteal" ) 
    self.range = 100-self.max_threshold
    self.max_size = 35

    -- effects
    self:PlayEffects()
end

function modifier_fighter_1_warborn:OnRefresh( kv )
    -- references
    self.max_as = self:GetAbility():GetSpecialValueFor( "maximum_attack_speed" )
    --self.max_mr = self:GetAbility():GetSpecialValueFor( "maximum_resistance" )
    self.max_threshold = self:GetAbility():GetSpecialValueFor( "hp_threshold_max" )
    self.max_lifesteal = self:GetAbility():GetSpecialValueFor( "maximum_lifesteal" ) 
    self.range = 100-self.max_threshold
end

function modifier_fighter_1_warborn:OnRemoved()
end

function modifier_fighter_1_warborn:OnDestroy()
end


function modifier_fighter_1_warborn:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_fighter_1_warborn:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MODEL_SCALE,
    }

    return funcs
end

function modifier_fighter_1_warborn:GetModifierProcAttack_Feedback( params )
    if IsServer() then
        -- filter
        local pass = false
        if params.target:GetTeamNumber()~=self:GetParent():GetTeamNumber() then
            if (not params.target:IsBuilding()) and (not params.target:IsOther()) then
                pass = true
            end
        end

        -- logic
        if pass then
            -- save attack record
            self.attack_record = params.record
        end
    end
end

function modifier_fighter_1_warborn:OnTakeDamage( params )
    if IsServer() then
        -- filter
        local pass = false
        if self.attack_record and params.record == self.attack_record then
            pass = true
            self.attack_record = nil
        end

        -- logic
        if pass then
            -- get heal value
            local pct = math.max((self:GetParent():GetHealthPercent()-self.max_threshold)/self.range,0)
            local heal = params.damage * (((1-pct)*self.max_lifesteal) / 100 )
            self:GetParent():Heal( heal, self:GetAbility() )
            self:PlayEffects1( self:GetParent() )
        end
    end
end

function modifier_fighter_1_warborn:GetModifierAttackSpeedBonus_Constant()
    -- interpolate missing health
    local pct = math.max((self:GetParent():GetHealthPercent()-self.max_threshold)/self.range,0)
    return (1-pct)*self.max_as
end

function modifier_fighter_1_warborn:GetModifierModelScale()
    if IsServer() then
        local pct = math.max((self:GetParent():GetHealthPercent()-self.max_threshold)/self.range,0)

        -- set dynamic effects
        ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( (1-pct)*100,0,0 ) )

        return (1-pct)*self.max_size
    end
end

function modifier_fighter_1_warborn:PlayEffects()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_huskar/huskar_berserkers_blood_glow.vpcf"

    -- Create Particle
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

    -- buff particle
    self:AddParticle(
        self.effect_cast,
        false, -- bDestroyImmediately
        false, -- bStatusEffect
        -1, -- iPriority
        false, -- bHeroEffect
        false -- bOverheadEffect
    )
end


-- Graphics & Animations
function modifier_fighter_1_warborn:PlayEffects1( target )
    -- get resource
    local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"

    -- play effects
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
    ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end
