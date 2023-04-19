donate_leha_genocid = class({})
LinkLuaModifier( "modifier_donate_leha_genocid", "abilities/donate/donate_leha_genocid", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_donate_leha_genocid_effect", "abilities/donate/donate_leha_genocid", LUA_MODIFIER_MOTION_NONE )

function donate_leha_genocid:OnToggle(  )
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local toggle = self:GetToggleState()

	if toggle then
		-- add modifier
		self.modifier = caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_donate_leha_genocid", -- modifier name
			{  } -- kv
		)
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end
end

modifier_donate_leha_genocid = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_leha_genocid:IsHidden()
	return true
end

function modifier_donate_leha_genocid:IsDebuff()
	return false
end

function modifier_donate_leha_genocid:IsPurgable()
	return false
end

function modifier_donate_leha_genocid:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_donate_leha_genocid:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_donate_leha_genocid:GetModifierAura()
	return "modifier_donate_leha_genocid_effect"
end

function modifier_donate_leha_genocid:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_donate_leha_genocid:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_donate_leha_genocid:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_donate_leha_genocid_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_leha_genocid_effect:IsHidden()
	return true
end

function modifier_donate_leha_genocid_effect:IsDebuff()
	return true
end

function modifier_donate_leha_genocid_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_donate_leha_genocid_effect:OnCreated( kv )
	-- references

	self.damage = self:GetAbility():GetLevelSpecialValueFor("damage", self:GetAbility():GetLevel() - 1)

	self.dps = self.damage * self:GetCaster():GetLevel() * 0.5

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility(), --Optional.
	}

	self:StartIntervalThink( 0.5 )
	self:OnIntervalThink()
end

function modifier_donate_leha_genocid_effect:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent() == self:GetCaster() then return end
	-- apply damage
	local victim = self:GetParent()

	self.damage = self:GetAbility():GetLevelSpecialValueFor("damage", self:GetAbility():GetLevel() - 1)

	self.dps = self.damage * self:GetCaster():GetLevel() * 0.5



	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility(), --Optional.
	}

	ApplyDamage( self.damageTable )

end

function modifier_donate_leha_genocid_effect:GetTexture() return "donate_leha_genocid" end
