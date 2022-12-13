donate_leha_doom_aura = class({})
LinkLuaModifier( "modifier_donate_leha_doom_aura", "abilities/donate/donate_leha_doom_aura", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_donate_leha_doom_aura_effect", "abilities/donate/donate_leha_doom_aura", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function donate_leha_doom_aura:GetIntrinsicModifierName()
	return "modifier_donate_leha_doom_aura"
end

modifier_donate_leha_doom_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_leha_doom_aura:IsHidden()
	return true
end

function modifier_donate_leha_doom_aura:IsDebuff()
	return false
end

function modifier_donate_leha_doom_aura:IsPurgable()
	return false
end

function modifier_donate_leha_doom_aura:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_donate_leha_doom_aura:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_donate_leha_doom_aura:GetModifierAura()
	return "modifier_donate_leha_doom_aura_effect"
end

function modifier_donate_leha_doom_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_donate_leha_doom_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_donate_leha_doom_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_donate_leha_doom_aura_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_leha_doom_aura_effect:IsHidden()
	return true
end

function modifier_donate_leha_doom_aura_effect:IsDebuff()
	return true
end

function modifier_donate_leha_doom_aura_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_donate_leha_doom_aura_effect:OnCreated( kv )
	-- references

	self.damage = self:GetAbility():GetLevelSpecialValueFor("damage", self:GetAbility():GetLevel() - 1)

	self.dps = self.damage * self:GetCaster():GetLevel() * 0.1

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility(), --Optional.
	}

	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()
end

function modifier_donate_leha_doom_aura_effect:OnRefresh()

end

function modifier_donate_leha_doom_aura_effect:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent() == self:GetCaster() then return end
	-- apply damage
	local victim = self:GetParent()

	self.damage = self:GetAbility():GetLevelSpecialValueFor("damage", self:GetAbility():GetLevel() - 1)

	self.dps = self.damage * self:GetCaster():GetLevel() * 0.1



	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility(), --Optional.
	}

	if victim:GetUnitName() == "npc_creep_endless_1" then
		if victim.pack == "pack9" then
			ApplyDamage( self.damageTable )
		end
	else
		ApplyDamage( self.damageTable )
	end

	

end

function modifier_donate_leha_doom_aura_effect:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_donate_leha_doom_aura_effect:GetTexture() return "donate_leha_doom_aura" end

 function modifier_donate_leha_doom_aura_effect:GetEffectName()
 	return "particles/units/heroes/hero_doom_bringer/doom_bringer_doom_ring.vpcf"
 end

 function modifier_donate_leha_doom_aura_effect:GetEffectAttachType()
 	return PATTACH_ABSORIGIN_FOLLOW
 end