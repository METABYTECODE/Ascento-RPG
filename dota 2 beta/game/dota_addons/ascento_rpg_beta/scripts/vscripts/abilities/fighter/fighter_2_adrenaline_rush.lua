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
fighter_2_adrenaline_rush = class({})
LinkLuaModifier( "modifier_fighter_2_adrenaline_rush", "abilities/fighter/fighter_2_adrenaline_rush", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------
-- Ability Start
function fighter_2_adrenaline_rush:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_fighter_2_adrenaline_rush", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_Alchemist.ChemicalRage.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end


modifier_fighter_2_adrenaline_rush = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fighter_2_adrenaline_rush:IsHidden()
	return false
end

function modifier_fighter_2_adrenaline_rush:IsDebuff()
	return false
end

function modifier_fighter_2_adrenaline_rush:IsStunDebuff()
	return false
end

function modifier_fighter_2_adrenaline_rush:IsPurgable()
	return false
end

function modifier_fighter_2_adrenaline_rush:AllowIllusionDuplicate()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fighter_2_adrenaline_rush:OnCreated( kv )
	local parent = self:GetParent()
	local ability = self:GetAbility()
	-- references
	self.attack_speed_bonus = ability:GetSpecialValueFor("attack_speed_bonus")
	self.attack_damage_bonus = ability:GetSpecialValueFor( "bonus_percent" )
	self.movespeed_bonus = ability:GetSpecialValueFor( "bonus_percent" )

	if not IsServer() then return end

	-- disjoint & purge
	ProjectileManager:ProjectileDodge( parent )
	parent:Purge( false, true, false, false, false )

	-- play effects
	self:PlayEffects()
end

function modifier_fighter_2_adrenaline_rush:OnRefresh( kv )
	local parent = self:GetParent()
	local ability = self:GetAbility()
	-- references
	self.attack_speed_bonus = ability:GetSpecialValueFor("attack_speed_bonus")
	self.attack_damage_bonus = ability:GetSpecialValueFor( "bonus_percent" )
	self.movespeed_bonus = ability:GetSpecialValueFor( "bonus_percent" )

	if not IsServer() then return end

	-- disjoint & purge
	ProjectileManager:ProjectileDodge( parent )
	parent:Purge( false, true, false, false, false )
end

function modifier_fighter_2_adrenaline_rush:OnRemoved()
end

function modifier_fighter_2_adrenaline_rush:OnDestroy()
	if not IsServer() then return end

	-- stop effects
	local sound_cast = "Hero_Alchemist.ChemicalRage"
	StopSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_fighter_2_adrenaline_rush:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_fighter_2_adrenaline_rush:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed_bonus
end

function modifier_fighter_2_adrenaline_rush:GetModifierAttackSpeedBonus_Constant()
    return self.attack_speed_bonus
end

function modifier_fighter_2_adrenaline_rush:GetModifierDamageOutgoing_Percentage()
    return self.attack_damage_bonus
end


-- Graphics & Animations
function modifier_fighter_2_adrenaline_rush:GetHeroEffectName()
	return "particles/units/heroes/hero_alchemist/alchemist_chemical_rage_hero_effect.vpcf"
end

function modifier_fighter_2_adrenaline_rush:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf"
	local sound_cast = "Hero_Alchemist.ChemicalRage"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

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
	EmitSoundOn( sound_cast, self:GetParent() )
end