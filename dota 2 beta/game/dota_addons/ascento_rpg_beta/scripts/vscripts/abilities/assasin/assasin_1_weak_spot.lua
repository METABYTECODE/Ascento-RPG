LinkLuaModifier("modifier_assasin_1_weak_spot", "abilities/assasin/assasin_1_weak_spot.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

assasin_1_weak_spot = class(ItemBaseClass)
modifier_assasin_1_weak_spot = class(ItemBaseClass)
-------------
function assasin_1_weak_spot:GetIntrinsicModifierName()
    return "modifier_assasin_1_weak_spot"
end

function modifier_assasin_1_weak_spot:OnCreated( kv )
    -- references
    self.crit_chance = self:GetAbility():GetSpecialValueFor( "critical_chance" ) / 100
    self.crit_bonus = self:GetAbility():GetSpecialValueFor( "critical_damage" )
    if self:GetCaster():HasModifier("modifier_assasin_2_darkness") then
        self.crit_chance = self.crit_chance * 2
    end
    self.rng = PseudoRNG.create( self.crit_chance )
    print(self.crit_chance)

    self:StartIntervalThink( 1 )
    self:OnIntervalThink()
end

function modifier_assasin_2_poison:OnIntervalThink(kv)
   self:OnRefresh(kv)
end

function modifier_assasin_1_weak_spot:OnRefresh( kv )
    -- references
    self.crit_chance = self:GetAbility():GetSpecialValueFor( "critical_chance" ) / 100
    self.crit_bonus = self:GetAbility():GetSpecialValueFor( "critical_damage" )
    if self:GetCaster():HasModifier("modifier_assasin_2_darkness") then
        self.crit_chance = self.crit_chance * 2
    end
    print(self.crit_chance)
    self.rng = PseudoRNG.create( self.crit_chance )
end

function modifier_assasin_1_weak_spot:OnDestroy( kv )

end

function modifier_assasin_1_weak_spot:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_assasin_1_weak_spot:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
    }

    return funcs
end


function modifier_assasin_1_weak_spot:GetModifierPreAttack_CriticalStrike( params )
    if IsServer() then
        if self.rng:Next() then
            self:PlayEffects( params.target )
            return self.crit_bonus
        else
            --didn't proc
        end
        --if self:RollChance( self.crit_chance ) then
        --    
        --    self:PlayEffects( params.target )
        --    print("Сработал крит")
        --    return self.crit_bonus
        --end
    end
end



--------------------------------------------------------------------------------
-- Helper
function modifier_assasin_1_weak_spot:RollChance( chance )
    local rand = math.random()
     print("Рандом крит говорит: " .. rand)
    if rand<chance/100 then
        return true
    end
    return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_assasin_1_weak_spot:PlayEffects( target )
    -- Load effects
    local particle_cast = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf"
    local sound_cast = "Hero_PhantomAssassin.CoupDeGrace"

    -- if target:IsMechanical() then
    --  particle_cast = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact_mechanical.vpcf"
    --  sound_cast = "Hero_PhantomAssassin.CoupDeGrace.Mech"
    -- end

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        0,
        target,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        target:GetOrigin(), -- unknown
        true -- unknown, true
    )
    ParticleManager:SetParticleControlForward( effect_cast, 1, (self:GetParent():GetOrigin()-target:GetOrigin()):Normalized() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    EmitSoundOn( sound_cast, target )
end