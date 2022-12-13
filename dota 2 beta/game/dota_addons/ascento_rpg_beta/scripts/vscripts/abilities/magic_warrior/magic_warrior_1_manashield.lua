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
magic_warrior_1_manashield = class({})
LinkLuaModifier( "modifier_magic_warrior_1_manashield", "abilities/magic_warrior/magic_warrior_1_manashield.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function magic_warrior_1_manashield:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

end
--------------------------------------------------------------------------------
-- Toggle
function magic_warrior_1_manashield:OnToggle()
	-- unit identifier
	local caster = self:GetCaster()
	local modifier = caster:FindModifierByName( "modifier_magic_warrior_1_manashield" )

	if self:GetToggleState() then
		if not modifier then
			caster:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_magic_warrior_1_manashield", -- modifier name
				{} -- kv
			)
		end
	else
		if modifier then
			modifier:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Ability Events
function magic_warrior_1_manashield:OnUpgrade()
	-- refresh values if on
	local modifier = self:GetCaster():FindModifierByName( "modifier_magic_warrior_1_manashield" )
	if modifier then
		modifier:ForceRefresh()
	end
end


--------------------------------------------------------------------------------
modifier_magic_warrior_1_manashield = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_magic_warrior_1_manashield:IsHidden()
	return false
end

function modifier_magic_warrior_1_manashield:IsDebuff()
	return false
end

function modifier_magic_warrior_1_manashield:IsPurgable()
	return false
end

function modifier_magic_warrior_1_manashield:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_magic_warrior_1_manashield:OnCreated( kv )
	-- references
	self.damage_per_mana = 1
	self.absorb_pct = self:GetAbility():GetSpecialValueFor( "damage_to_mana" ) / 100

	if not IsServer() then return end
	-- Play effects
	local sound_cast = "Hero_Medusa.ManaShield.On"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_magic_warrior_1_manashield:OnRefresh( kv )
	-- references
	self.damage_per_mana = 1
	self.absorb_pct = self:GetAbility():GetSpecialValueFor( "damage_to_mana" ) / 100
end

function modifier_magic_warrior_1_manashield:OnRemoved()
end

function modifier_magic_warrior_1_manashield:OnDestroy()
	if not IsServer() then return end
	-- Play effects
	local sound_cast = "Hero_Medusa.ManaShield.Off"
	EmitSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_magic_warrior_1_manashield:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_magic_warrior_1_manashield:GetModifierIncomingDamage_Percentage( params )
	local absorb = -100*self.absorb_pct

	-- calculate mana spent
	local damage_absorbed = params.damage * self.absorb_pct
	local manacost = damage_absorbed/self.damage_per_mana
	local mana = self:GetParent():GetMana()

	-- if not enough mana, calculate damage blocked by remaining mana
	if mana<manacost then
		damage_absorbed = mana * self.damage_per_mana
		absorb = -damage_absorbed/params.damage*100

		manacost = mana
	end

	-- spend mana
	self:GetParent():SpendMana( manacost, self:GetAbility() )

	-- play effects
	self:PlayEffects( damage_absorbed )

	return absorb
end

--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_magic_warrior_1_manashield:GetTexture() return "magic_warrior_1_manashield" end


function modifier_magic_warrior_1_manashield:GetEffectName()
	return "particles/units/heroes/hero_medusa/medusa_mana_shield.vpcf"
end

function modifier_magic_warrior_1_manashield:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_magic_warrior_1_manashield:PlayEffects( damage )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_medusa/medusa_mana_shield_impact.vpcf"
	local sound_cast = "Hero_Medusa.ManaShield.Proc"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( damage, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end