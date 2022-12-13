LinkLuaModifier("modifier_boss_raging_blood", "abilities/enemy/boss_raging_blood.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

boss_raging_blood = class(ItemBaseClass)
modifier_boss_raging_blood = class(ItemBaseClass)
-------------
function boss_raging_blood:GetIntrinsicModifierName()
    return "modifier_boss_raging_blood"
end

function modifier_boss_raging_blood:OnCreated( kv )
    if not self:GetAbility() then return end
    -- references
    self.max_as = self:GetAbility():GetSpecialValueFor( "maximum_attack_speed" )
    --self.max_mr = self:GetAbility():GetSpecialValueFor( "maximum_resistance" )
    self.max_threshold = self:GetAbility():GetSpecialValueFor( "hp_threshold_max" )
    self.max_regen = self:GetAbility():GetSpecialValueFor( "maximum_regen" ) 
    self.range = 100-self.max_threshold
    self.max_size = 10

    -- effects
    self:PlayEffects()
end

function modifier_boss_raging_blood:OnRefresh( kv )
    if not self:GetAbility() then return end
    -- references
    self.max_as = self:GetAbility():GetSpecialValueFor( "maximum_attack_speed" )
    --self.max_mr = self:GetAbility():GetSpecialValueFor( "maximum_resistance" )
    self.max_threshold = self:GetAbility():GetSpecialValueFor( "hp_threshold_max" )
    self.max_regen = self:GetAbility():GetSpecialValueFor( "maximum_regen" ) 
    self.range = 100-self.max_threshold
end

function modifier_boss_raging_blood:OnRemoved()
end

function modifier_boss_raging_blood:OnDestroy()
end


function modifier_boss_raging_blood:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_boss_raging_blood:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MODEL_SCALE,
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
    }

    return funcs
end



function modifier_boss_raging_blood:GetModifierAttackSpeedBonus_Constant()
    -- interpolate missing health
    local pct = math.max((self:GetParent():GetHealthPercent()-self.max_threshold)/self.range,0)
    return (1-pct)*self.max_as
end

function modifier_boss_raging_blood:GetModifierHealthRegenPercentage()
    -- interpolate missing health
    local pct = math.max((self:GetParent():GetHealthPercent()-self.max_threshold)/self.range,0)
    return (1-pct)*self.max_regen
end

function modifier_boss_raging_blood:GetModifierModelScale()
    if IsServer() then
        local pct = math.max((self:GetParent():GetHealthPercent()-self.max_threshold)/self.range,0)

        -- set dynamic effects
        ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( (1-pct)*100,0,0 ) )

        return (1-pct)*self.max_size
    end
end

function modifier_boss_raging_blood:PlayEffects()
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


