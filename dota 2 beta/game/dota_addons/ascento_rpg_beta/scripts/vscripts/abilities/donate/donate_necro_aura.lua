donate_necro_aura = class({})
LinkLuaModifier( "modifier_donate_necro_aura", "abilities/donate/donate_necro_aura", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_donate_necro_aura_effect", "abilities/donate/donate_necro_aura", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function donate_necro_aura:OnToggle(  )
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local toggle = self:GetToggleState()

	if toggle then
		-- add modifier
		self.modifier = caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_donate_necro_aura", -- modifier name
			{  } -- kv
		)
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end
end


modifier_donate_necro_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_necro_aura:IsHidden()
	return true
end

function modifier_donate_necro_aura:IsDebuff()
	return false
end

function modifier_donate_necro_aura:IsPurgable()
	return false
end

function modifier_donate_necro_aura:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_donate_necro_aura:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_donate_necro_aura:GetModifierAura()
	return "modifier_donate_necro_aura_effect"
end

 function modifier_donate_necro_aura:GetEffectName()
 	return "particles/items4_fx/scepter_aura_ring_detail.vpcf"
 end

 function modifier_donate_necro_aura:GetEffectAttachType()
 	return PATTACH_ABSORIGIN_FOLLOW
 end



function modifier_donate_necro_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_donate_necro_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_donate_necro_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_donate_necro_aura_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_necro_aura_effect:IsHidden()
	return true
end

function modifier_donate_necro_aura_effect:IsDebuff()
	return true
end

function modifier_donate_necro_aura_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_donate_necro_aura_effect:OnCreated( kv )
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

function modifier_donate_necro_aura_effect:OnRefresh()

end

function modifier_donate_necro_aura_effect:OnIntervalThink()
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

	
	ApplyDamage( self.damageTable )

	

end

function modifier_donate_necro_aura_effect:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_donate_necro_aura_effect:GetTexture() return "necrolyte_heartstopper_aura" end

 function modifier_donate_necro_aura_effect:GetEffectName()
 	return "particles/items4_fx/scepter_aura_ring_detail.vpcf"
 end

 function modifier_donate_necro_aura_effect:GetEffectAttachType()
 	return PATTACH_ABSORIGIN_FOLLOW
 end