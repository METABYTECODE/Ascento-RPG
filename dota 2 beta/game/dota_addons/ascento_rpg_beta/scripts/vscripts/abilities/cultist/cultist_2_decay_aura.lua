cultist_2_decay_aura = class({})
LinkLuaModifier( "modifier_cultist_2_decay_aura", "abilities/cultist/cultist_2_decay_aura", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_cultist_2_decay_aura_effect", "abilities/cultist/cultist_2_decay_aura", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function cultist_2_decay_aura:OnToggle(  )
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local toggle = self:GetToggleState()

	if toggle then
		-- add modifier
		self.modifier = caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_cultist_2_decay_aura", -- modifier name
			{  } -- kv
		)
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end
end


modifier_cultist_2_decay_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_cultist_2_decay_aura:IsHidden()
	return true
end

function modifier_cultist_2_decay_aura:IsDebuff()
	return false
end

function modifier_cultist_2_decay_aura:IsPurgable()
	return false
end

function modifier_cultist_2_decay_aura:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_cultist_2_decay_aura:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_cultist_2_decay_aura:GetModifierAura()
	return "modifier_cultist_2_decay_aura_effect"
end

function modifier_cultist_2_decay_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_cultist_2_decay_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_cultist_2_decay_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_cultist_2_decay_aura_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_cultist_2_decay_aura_effect:IsHidden()
	return false
end

function modifier_cultist_2_decay_aura_effect:IsDebuff()
	return true
end

function modifier_cultist_2_decay_aura_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_cultist_2_decay_aura_effect:OnCreated( kv )
	-- references
	self.hp_lose = self:GetAbility():GetLevelSpecialValueFor("hp_lose", self:GetAbility():GetLevel() - 1) / 100
	self.hp_heal = self:GetAbility():GetLevelSpecialValueFor("hp_heal", self:GetAbility():GetLevel() - 1) / 100

	self.dps = self:GetParent():GetHealth() * self.hp_lose
	self.heal = self.dps * self.hp_heal

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS,
		ability = self:GetAbility(), --Optional.
	}

	self:StartIntervalThink( 2.5 )
	self:OnIntervalThink()
end

function modifier_cultist_2_decay_aura_effect:OnRefresh()

end

function modifier_cultist_2_decay_aura_effect:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent() == self:GetCaster() then return end
	-- apply damage

	self.hp_lose = self:GetAbility():GetLevelSpecialValueFor("hp_lose", self:GetAbility():GetLevel() - 1) / 100
	self.hp_heal = self:GetAbility():GetLevelSpecialValueFor("hp_heal", self:GetAbility():GetLevel() - 1) / 100

	self.dps = self:GetParent():GetHealth() * self.hp_lose

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS,
		ability = self:GetAbility(), --Optional.
	}

	
	--if IsBossASCENTO(self:GetParent()) then
	--	self.dps = self.dps / 2
	--end

	--self:GetParent():SetHealth(curHealth - damage)
	
    --SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_POISON_DAMAGE, self:GetParent(), damage, nil)

	ApplyDamage( self.damageTable )

	self.heal = self.dps * self.hp_heal

	self:GetCaster():Heal(self.heal, self:GetCaster())

    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetCaster(), self.heal, nil)

end

function modifier_cultist_2_decay_aura_effect:OnDestroy( kv )

end



--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_cultist_2_decay_aura_effect:GetTexture() return "cultist_2_decay_aura" end

 function modifier_cultist_2_decay_aura_effect:GetEffectName()
 	return "particles/econ/items/necrolyte/necro_ti9_immortal/necro_ti9_immortal_loadout.vpcf"
 end

 function modifier_cultist_2_decay_aura_effect:GetEffectAttachType()
 	return PATTACH_ABSORIGIN_FOLLOW
 end