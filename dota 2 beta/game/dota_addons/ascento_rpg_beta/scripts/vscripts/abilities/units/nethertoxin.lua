nethertoxin = class({
	GetCastRange = function(self)
		return self:GetSpecialValueFor("radius")
	end
})

function nethertoxin:OnSpellStart()
	self.caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local vector = point-self.caster:GetOrigin()

	local projectile_name = ""
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )
	local projectile_distance = vector:Length2D()
	local projectile_direction = vector
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	local info = {
		Source = self.caster,
		Ability = self,
		vSpawnOrigin = self.caster:GetAbsOrigin(),
		
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_NONE,
	    fProjectileSpeed = projectile_speed,
	    EffectName = projectile_name,
		fExpireTime = GameRules:GetGameTime() + 10,
	    fDistance = projectile_distance,
	    fStartRadius = 0,
	    fEndRadius = 0,
		vVelocity = projectile_direction * projectile_speed,
	}
	ProjectileManager:CreateLinearProjectile(info)

	self:PlayEffects( point )
end

function nethertoxin:OnProjectileHit( target, location )
	if target then 
        return false 
    end

	self.duration = self:GetSpecialValueFor( "duration" )

	CreateModifierThinker(
		self.caster,
		self,
		"modifier_nethertoxin",
		{ duration = self.duration },
		location,
		self.caster:GetTeamNumber(),
		false
	)
end

function nethertoxin:PlayEffects( point )
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin_proj.vpcf"
	local sound_cast = "Hero_Viper.Nethertoxin.Cast"

	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0),
		true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( projectile_speed, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 5, point )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self.caster )
end

modifier_nethertoxin = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
	IsDebuff = function()
		return false
	end,
	IsAura = function(self)
		return self.owner
	end,
	GetModifierAura = function()
		return "modifier_nethertoxin"
	end,
	GetAuraRadius = function(self) 
        return self.radius
    end,
	GetAuraDuration = function()
		return 0.5
	end,
	GetAuraSearchTeam = function(self) 
        return self.targetTeam
    end,
    GetAuraSearchType = function(self) 
        return self.targetType
    end,
	GetEffectAttachType = function()
		return 1
	end,
    DeclareFunctions = function()
        return {
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
            
        }
    end,
    GetModifierMagicalResistanceBonus = function(self)
        return self.magic_resist
    end,
	CheckState = function()
		return {
			[MODIFIER_STATE_PASSIVES_DISABLED] = true
		}
	end
})

function modifier_nethertoxin:OnCreated( kv )
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	if not IsServer() then return end
	
	self.targetTeam = self.ability:GetAbilityTargetTeam()
    self.targetType = self.ability:GetAbilityTargetType()
	

	self.owner = kv.isProvidedByAura~=1

	

	self:OnRefresh()
end

function modifier_nethertoxin:OnRefresh( kv )
	self.damage = self.ability:GetSpecialValueFor( "damage" )
	self.magic_resist = self.ability:GetSpecialValueFor( "magic_resistance" )
	self.radius = self.ability:GetCastRange()

	if not self.owner then
		self.damageTable = {
			victim = self.parent,
			attacker = self.caster,
			damage = self.damage,
			damage_type = self.ability:GetAbilityDamageType(),
			ability = self.ability,
		}
		self:StartIntervalThink( 1 )
	else
		self:PlayEffects()
	end
end

function modifier_nethertoxin:OnDestroy()
	if not IsServer() then return end
	if not self.owner then return end
	UTIL_Remove( self.parent )
end

function modifier_nethertoxin:CheckState()
	local state = {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}
	return state
end

function modifier_nethertoxin:OnIntervalThink()
	ApplyDamage( self.damageTable )
	local sound_cast = "Hero_Viper.NetherToxin.Damage"
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_nethertoxin:GetEffectName()
	if not self.owner then
		return "particles/units/heroes/hero_viper/viper_nethertoxin_debuff.vpcf"
	end
end

function modifier_nethertoxin:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin.vpcf"
	local sound_cast = "Hero_Viper.NetherToxin"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )

	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)

	EmitSoundOn( sound_cast, self.parent )
end

LinkLuaModifier("modifier_nethertoxin", "abilities/units/nethertoxin", LUA_MODIFIER_MOTION_NONE)