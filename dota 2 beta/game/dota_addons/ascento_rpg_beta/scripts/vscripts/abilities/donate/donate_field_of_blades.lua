donate_field_of_blades = class({})
LinkLuaModifier( "modifier_donate_field_of_blades", "abilities/donate/donate_field_of_blades", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_donate_field_of_blades_effect", "abilities/donate/donate_field_of_blades", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function donate_field_of_blades:OnToggle(  )
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local toggle = self:GetToggleState()

	if toggle then
		-- add modifier
		self.modifier = caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_donate_field_of_blades", -- modifier name
			{  } -- kv
		)
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end
end

modifier_donate_field_of_blades = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_field_of_blades:IsHidden()
	return true
end

function modifier_donate_field_of_blades:IsDebuff()
	return false
end

function modifier_donate_field_of_blades:IsPurgable()
	return false
end

function modifier_donate_field_of_blades:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_donate_field_of_blades:IsAura()
	if self:GetAbility():GetLevel() > 0 then
		if not self:GetCaster():PassivesDisabled() then
			return true
		end
	end

	return false
end

function modifier_donate_field_of_blades:GetModifierAura()
	return "modifier_donate_field_of_blades_effect"
end

 function modifier_donate_field_of_blades:GetEffectName()
 	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_blade_fury_disk.vpcf"
 end

 function modifier_donate_field_of_blades:GetEffectAttachType()
 	return PATTACH_ABSORIGIN_FOLLOW
 end

function modifier_donate_field_of_blades:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_donate_field_of_blades:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_donate_field_of_blades:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_donate_field_of_blades_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_field_of_blades_effect:IsHidden()
	return true
end

function modifier_donate_field_of_blades_effect:IsDebuff()
	return true
end

function modifier_donate_field_of_blades_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_donate_field_of_blades_effect:OnCreated( kv )
	if not IsServer() then return end

	local caster = self:GetCaster()
	-- references

	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.puredamage = self:GetAbility():GetSpecialValueFor("damage_pure")
	
	self.dps = ((caster:GetAverageTrueAttackDamage(caster) * (self.damage / 100)) + (caster:GetLevel() * 10)) * 0.1
	self.puredps = self.dps * (self.puredamage / 100)

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self:GetAbility(), --Optional.
	}

	self.damageTablePure = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.puredps,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS,
		ability = self:GetAbility(), --Optional.
	}

	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()

end

function modifier_donate_field_of_blades_effect:OnRefresh()

end

function modifier_donate_field_of_blades_effect:OnIntervalThink()

	if not IsServer() then return end

	if self:GetParent() == self:GetCaster() then return end
	-- apply damage

	local caster = self:GetCaster()
	-- references

	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.puredamage = self:GetAbility():GetSpecialValueFor("damage_pure")
	
	self.dps = ((caster:GetAverageTrueAttackDamage(caster) * (self.damage / 100)) + (caster:GetLevel() * 10)) * 0.1
	self.puredps = self.dps * (self.puredamage / 100)

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self:GetAbility(), --Optional.
	}

	self.damageTablePure = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.puredps,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS,
		ability = self:GetAbility(), --Optional.
	}

	ApplyDamage( self.damageTable )
	ApplyDamage( self.damageTablePure )

end

function modifier_donate_field_of_blades_effect:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_donate_field_of_blades_effect:GetTexture() return "donate_field_of_blades" end

 function modifier_donate_field_of_blades_effect:GetEffectName()
 	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_blade_fury_dragon.vpcf"
 end

 function modifier_donate_field_of_blades_effect:GetEffectAttachType()
 	return PATTACH_ABSORIGIN_FOLLOW
 end