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
mage_1_magic_area = class({})
LinkLuaModifier( "modifier_mage_1_magic_area", "abilities/mage/mage_1_magic_area", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function mage_1_magic_area:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function mage_1_magic_area:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetAbsOrigin()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_mage_1_magic_area", -- modifier name
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
modifier_mage_1_magic_area = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mage_1_magic_area:IsHidden()
	return false
end

function modifier_mage_1_magic_area:IsDebuff()
	return false
end

function modifier_mage_1_magic_area:IsStunDebuff()
	return false
end

function modifier_mage_1_magic_area:IsPurgable()
	return false
end

function modifier_mage_1_magic_area:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mage_1_magic_area:OnCreated( kv )
	-- references
	self.bonus_magic_damage = self:GetAbility():GetSpecialValueFor( "bonus_magic_damage" )
	self.regen_hp_pct = self:GetAbility():GetSpecialValueFor( "regen_hp_pct" )
	self.regen_mana_pct = self:GetAbility():GetSpecialValueFor( "regen_mana_pct" ) / 100
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	self.thinker = kv.isProvidedByAura~=1

	if not IsServer() then return end
	if not self.thinker then return end



	-- precache effects
	--self.sound_cast = "Hero_Alchemist.AcidSpray.Damage"

	-- Play effects
	self:PlayEffects()
end

function modifier_mage_1_magic_area:OnRefresh( kv )
	self.bonus_magic_damage = self:GetAbility():GetSpecialValueFor( "bonus_magic_damage" )
	self.regen_hp_pct = self:GetAbility():GetSpecialValueFor( "regen_hp_pct" )
	self.regen_mana_pct = self:GetAbility():GetSpecialValueFor( "regen_mana_pct" ) / 100
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_mage_1_magic_area:OnRemoved()
end

function modifier_mage_1_magic_area:OnDestroy()
	if not IsServer() then return end
	if not self.thinker then return end

	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_mage_1_magic_area:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}

	return funcs
end

function modifier_mage_1_magic_area:GetModifierSpellAmplify_Percentage( params )
	if IsClient() then return 0 end
	return self.bonus_magic_damage
end

function modifier_mage_1_magic_area:GetModifierConstantManaRegen( params )
	return self:GetCaster():GetMaxMana() * self.regen_mana_pct
end

function modifier_mage_1_magic_area:GetModifierHealthRegenPercentage( params )
	return self.regen_hp_pct
end


--------------------------------------------------------------------------------
-- Aura Effects
function modifier_mage_1_magic_area:IsAura()
	return self.thinker
end

function modifier_mage_1_magic_area:GetModifierAura()
	return "modifier_mage_1_magic_area"
end

function modifier_mage_1_magic_area:GetAuraRadius()
	return self.radius
end

function modifier_mage_1_magic_area:GetAuraDuration()
	return 0.01
end

function modifier_mage_1_magic_area:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_mage_1_magic_area:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_mage_1_magic_area:GetAuraSearchFlags()
	return 0
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mage_1_magic_area:GetEffectName()
	return "particles/econ/items/huskar/huskar_ti8/huskar_ti8_shoulder_heal.vpcf"
end

function modifier_mage_1_magic_area:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_mage_1_magic_area:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/underlord/underlord_ti8_immortal_weapon/underlord_ti8_immortal_pitofmalice_core.vpcf"
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