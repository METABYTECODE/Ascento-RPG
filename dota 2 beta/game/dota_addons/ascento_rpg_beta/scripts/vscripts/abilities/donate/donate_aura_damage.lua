donate_aura_damage = class({})
LinkLuaModifier( "modifier_donate_aura_damage", "abilities/donate/donate_aura_damage", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_donate_aura_damage_effect", "abilities/donate/donate_aura_damage", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function donate_aura_damage:GetIntrinsicModifierName()
	return "modifier_donate_aura_damage"
end

modifier_donate_aura_damage = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_aura_damage:IsHidden()
	return true
end

function modifier_donate_aura_damage:IsDebuff()
	return false
end

function modifier_donate_aura_damage:IsPurgable()
	return false
end

function modifier_donate_aura_damage:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_donate_aura_damage:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_donate_aura_damage:GetModifierAura()
	return "modifier_donate_aura_damage_effect"
end

function modifier_donate_aura_damage:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_donate_aura_damage:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_donate_aura_damage:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_donate_aura_damage_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_donate_aura_damage_effect:IsHidden()
	return false
end

function modifier_donate_aura_damage_effect:IsDebuff()
	return true
end

function modifier_donate_aura_damage_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_donate_aura_damage_effect:OnCreated( kv )
	-- references
	if not IsServer() then return end
	self.damage_pct = self:GetAbility():GetLevelSpecialValueFor("damage_pct", self:GetAbility():GetLevel() - 1) / 100
	self.hp_heal = self:GetAbility():GetLevelSpecialValueFor("hp_heal", self:GetAbility():GetLevel() - 1) / 100
	self.hp_heal_ally = self:GetAbility():GetLevelSpecialValueFor("hp_heal_ally", self:GetAbility():GetLevel() - 1) / 100

	self.dps = self:GetCaster():GetAverageTrueAttackDamage(self:GetCaster()) * self.damage_pct
	self.heal = self.dps * self.hp_heal
	self.heal_ally = self.dps * self.hp_heal_ally

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self:GetAbility(), --Optional.
	}

	self:StartIntervalThink( 1 )
	self:OnIntervalThink()
end

function modifier_donate_aura_damage_effect:OnRefresh()

end

function modifier_donate_aura_damage_effect:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent() == self:GetCaster() then return end
	-- apply damage

	self.damage_pct = self:GetAbility():GetLevelSpecialValueFor("damage_pct", self:GetAbility():GetLevel() - 1) / 100
	self.hp_heal = self:GetAbility():GetLevelSpecialValueFor("hp_heal", self:GetAbility():GetLevel() - 1) / 100
	self.hp_heal_ally = self:GetAbility():GetLevelSpecialValueFor("hp_heal_ally", self:GetAbility():GetLevel() - 1) / 100

	self.dps = self:GetCaster():GetAverageTrueAttackDamage(self:GetCaster()) * self.damage_pct
	self.heal = self.dps * self.hp_heal
	self.heal_ally = self.dps * self.hp_heal_ally

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self:GetAbility(), --Optional.
	}

	ApplyDamage( self.damageTable )

	self:GetCaster():Heal(self.heal, self:GetCaster())
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetCaster(), self.heal, nil)

	local healUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, self:GetCaster():GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

    for i, hero in pairs(healUnits) do
    	if hero:IsRealHero() then
    		hero:Heal(self.heal_ally, self:GetCaster())
    		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, hero, self.heal_ally, nil)
    	end
    end



end


--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_donate_aura_damage_effect:GetTexture() return "donate_aura_damage" end

 function modifier_donate_aura_damage_effect:GetEffectName()
 	return "particles/econ/events/ti9/radiance_owner_ti9.vpcf"
 end

 function modifier_donate_aura_damage_effect:GetEffectAttachType()
 	return PATTACH_ABSORIGIN_FOLLOW
 end