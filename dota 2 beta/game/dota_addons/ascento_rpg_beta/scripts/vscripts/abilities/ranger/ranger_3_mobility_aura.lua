ranger_3_mobility_aura = class({})
LinkLuaModifier( "modifier_ranger_3_mobility_aura", "abilities/ranger/ranger_3_mobility_aura", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ranger_3_mobility_aura_effect", "abilities/ranger/ranger_3_mobility_aura", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function ranger_3_mobility_aura:GetIntrinsicModifierName()
	return "modifier_ranger_3_mobility_aura"
end

modifier_ranger_3_mobility_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_ranger_3_mobility_aura:IsHidden()
	return true
end

function modifier_ranger_3_mobility_aura:IsDebuff()
	return false
end

function modifier_ranger_3_mobility_aura:IsPurgable()
	return false
end

function modifier_ranger_3_mobility_aura:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_ranger_3_mobility_aura:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_ranger_3_mobility_aura:GetModifierAura()
	return "modifier_ranger_3_mobility_aura_effect"
end

function modifier_ranger_3_mobility_aura:GetAuraRadius()
	return FIND_UNITS_EVERYWHERE
end

function modifier_ranger_3_mobility_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_ranger_3_mobility_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_ranger_3_mobility_aura_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_ranger_3_mobility_aura_effect:IsHidden()
	return false
end

function modifier_ranger_3_mobility_aura_effect:IsDebuff()
	return false
end

function modifier_ranger_3_mobility_aura_effect:IsPurgable()
	return false
end

function modifier_ranger_3_mobility_aura_effect:GetTexture() return "drow_ranger_trueshot" end

--------------------------------------------------------------------------------
-- Initializations
function modifier_ranger_3_mobility_aura_effect:OnCreated( kv )
	-- references
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" ) -- special value
	self.movespeed_pct = self:GetAbility():GetSpecialValueFor( "movespeed_pct" ) -- special value
	

end

function modifier_ranger_3_mobility_aura_effect:OnRefresh( kv )
	-- references
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" ) -- special value
	self.movespeed_pct = self:GetAbility():GetSpecialValueFor( "movespeed_pct" ) -- special value

end

function modifier_ranger_3_mobility_aura_effect:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects

function modifier_ranger_3_mobility_aura_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_ranger_3_mobility_aura_effect:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end

function modifier_ranger_3_mobility_aura_effect:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed_pct
end


--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_ranger_3_mobility_aura_effect:GetTexture() return "ranger_3_mobility_aura" end

 function modifier_ranger_3_mobility_aura_effect:GetEffectName()
 	return "particles/units/heroes/hero_drow/drow_aura_buff.vpcf"
 end

 function modifier_ranger_3_mobility_aura_effect:GetEffectAttachType()
 	return PATTACH_ABSORIGIN_FOLLOW
 end