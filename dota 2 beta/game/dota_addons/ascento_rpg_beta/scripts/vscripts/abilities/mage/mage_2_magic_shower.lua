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
mage_2_magic_shower = class({})
LinkLuaModifier( "modifier_mage_2_magic_shower", "abilities/mage/mage_2_magic_shower", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function mage_2_magic_shower:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function mage_2_magic_shower:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetAbsOrigin()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_mage_2_magic_shower", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
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
modifier_mage_2_magic_shower = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mage_2_magic_shower:IsHidden()
	return false
end

function modifier_mage_2_magic_shower:IsDebuff()
	return true
end

function modifier_mage_2_magic_shower:IsStunDebuff()
	return false
end

function modifier_mage_2_magic_shower:IsPurgable()
	return false
end

function modifier_mage_2_magic_shower:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mage_2_magic_shower:OnCreated( kv )
	if not IsServer() then return end
	-- references
	self.magic_resistance_debuff = self:GetAbility():GetSpecialValueFor( "magic_resistance_debuff" )
	self.tickrate = self:GetAbility():GetSpecialValueFor( "tickrate" )
	self.magic_damage = self:GetAbility():GetSpecialValueFor( "magic_damage" ) / 100
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	self.thinker = kv.isProvidedByAura~=1

	
	--if not self.thinker then return end



	-- precache effects
	--self.sound_cast = "Hero_Alchemist.AcidSpray.Damage"

	-- Play effects
	self:PlayEffects()

	self.dps = self:GetCaster():GetAverageTrueAttackDamage(self:GetCaster()) * self.magic_damage

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}

	self:StartIntervalThink( self.tickrate )
	self:OnIntervalThink()
end

function modifier_mage_2_magic_shower:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent() == self:GetCaster() then return end
	-- apply damage

	ApplyDamage( self.damageTable )

end

function modifier_mage_2_magic_shower:OnRefresh( kv )

end

function modifier_mage_2_magic_shower:OnRemoved()
end

function modifier_mage_2_magic_shower:OnDestroy()
	if not IsServer() then return end
	if not self.thinker then return end

	UTIL_Remove( self:GetParent() )
end



--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_mage_2_magic_shower:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}

	return funcs
end

function modifier_mage_2_magic_shower:GetModifierMagicalResistanceBonus( params )
	return self:GetAbility():GetSpecialValueFor( "magic_resistance_debuff" )
end


--------------------------------------------------------------------------------
-- Aura Effects
function modifier_mage_2_magic_shower:IsAura()
	return self.thinker
end

function modifier_mage_2_magic_shower:GetModifierAura()
	return "modifier_mage_2_magic_shower"
end

function modifier_mage_2_magic_shower:GetAuraRadius()
	return self.radius
end

function modifier_mage_2_magic_shower:GetAuraDuration()
	return self.duration
end

function modifier_mage_2_magic_shower:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_mage_2_magic_shower:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mage_2_magic_shower:GetEffectName()
	return "particles/econ/items/necrolyte/necro_sullen_harvest/necro_ti7_immortal_scythe_cage_tickle.vpcf"
end

function modifier_mage_2_magic_shower:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_mage_2_magic_shower:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura.vpcf"
	local sound_cast = "Hero_Alchemist.AcidSpray"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )

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
	--EmitSoundOn( sound_cast, self:GetParent() )
end