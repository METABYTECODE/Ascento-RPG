shell = class({
    GetIntrinsicModifierName = function()
		return "modifier_shell"
	end,
	GetCastRange = function(self)
		return self:GetSpecialValueFor("aura_radius")
	end
})

function shell:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell.vpcf", context )
end

modifier_shell = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
    RemoveOnDeath = function()
        return true
    end,
	IsDebuff = function()
		return false
	end,
})

function modifier_shell:OnCreated()
	self:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
    self.abilityTargetType = self.ability:GetAbilityTargetType()
    self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

    local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	local tick = self:GetAbility():GetSpecialValueFor( "tick_interval" )

	self.damageTable = {
		attacker = self:GetCaster(),
		damage = damage*tick,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(),
	}

	-- Start interval
	self:StartIntervalThink( tick )
    self:PlayEffects1()
end

function modifier_shell:OnRefresh()
    if(not IsServer()) then
		return
	end
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.team = self.caster:GetTeamNumber()
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.radius = self.ability:GetCastRange()
end

function modifier_shell:OnRemoved()
end

function modifier_shell:OnDestroy()
	if not IsServer() then return end

	-- Play effects
	local sound_loop = "Hero_Dark_Seer.Ion_Shield_lp"
	local sound_end = "Hero_Dark_Seer.Ion_Shield_end"
	StopSoundOn( sound_loop, self.parent )
	EmitSoundOn( sound_end, self.parent )
end

function modifier_shell:OnIntervalThink()
    if not self.parent:IsAlive() then
        return
    end
    local enemies = FindUnitsInRadius(
		self.team,
		self.parent:GetOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		self.abilityTargetType,
		self.abilityTargetFlags,
		0,
		false
	)

	for _,enemy in pairs(enemies) do
		if enemy~=self.parent then
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )
			self:PlayEffects2( enemy )
		end
	end
end

function modifier_shell:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell.vpcf"
	local sound_cast = "Hero_Dark_Seer.Ion_Shield_Start"
	local sound_loop = "Hero_Dark_Seer.Ion_Shield_lp"

	-- Get Data
	local hull1 = 40
	local hull2 = 40

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( hull1, hull2, 0 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
	EmitSoundOn( sound_loop, self.parent )
end

function modifier_shell:PlayEffects2( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell_damage.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
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
end

LinkLuaModifier("modifier_shell", "abilities/units/shell", LUA_MODIFIER_MOTION_NONE)