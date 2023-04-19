if donate_muerta_disarm == nil then donate_muerta_disarm = class({}) end

LinkLuaModifier("modifier_donate_muerta_disarm_passive","abilities/donate/donate_muerta_disarm.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_donate_muerta_disarm_aura","abilities/donate/donate_muerta_disarm.lua",LUA_MODIFIER_MOTION_NONE)

function donate_muerta_disarm:GetIntrinsicModifierName()
	return "modifier_donate_muerta_disarm_passive"
end

if modifier_donate_muerta_disarm_passive == nil then modifier_donate_muerta_disarm_passive = class({}) end

function modifier_donate_muerta_disarm_passive:IsHidden()
	return true
end

function modifier_donate_muerta_disarm_passive:IsAura()
	if self:GetAbility():GetLevel() > 0 and not self:GetCaster():PassivesDisabled() then
		return true
	else
		return false
	end
end

function modifier_donate_muerta_disarm_passive:IsPurgable()
    return false
end

function modifier_donate_muerta_disarm_passive:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("range")
end

function modifier_donate_muerta_disarm_passive:GetModifierAura()
    return "modifier_donate_muerta_disarm_aura"
end
   
function modifier_donate_muerta_disarm_passive:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_donate_muerta_disarm_passive:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_donate_muerta_disarm_passive:GetAuraDuration()
    return 0.1
end

if modifier_donate_muerta_disarm_aura == nil then modifier_donate_muerta_disarm_aura = class({}) end

function modifier_donate_muerta_disarm_aura:IsPurgable(  )
	return false
end

function modifier_donate_muerta_disarm_aura:DeclareFunctions(  )
	return { MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_donate_muerta_disarm_aura:GetTexture()
	return "elder_titan_natural_order"
end

function modifier_donate_muerta_disarm_aura:IsDebuff(  )
	return true
end

function modifier_donate_muerta_disarm_aura:OnCreated(  )
	self.ability = self:GetAbility()
end

function modifier_donate_muerta_disarm_aura:GetModifierPhysicalArmorBonus()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then return nil; end
	local parent_armor = parent:GetPhysicalArmorBaseValue()
	if self:GetAbility() == nil then return end
	local prc = ability:GetSpecialValueFor("disarmor") / 100
	local armor = 0
	return -parent_armor * prc
end

function modifier_donate_muerta_disarm_aura:GetModifierMagicalResistanceBonus()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then return nil; end
	local parent_armor = parent:GetBaseMagicalResistanceValue()
	local prc = ability:GetSpecialValueFor("disresist") / 100
	local armor = 0
	return -parent_armor * prc
end