

ricko_rage = class({})

function ricko_rage:GetAbilityTextureName()
	if self:GetToggleState() then
		return "ricko/onrage"
	else
		return "ricko/rage"
	end

end

function ricko_rage:OnToggle()
	local caster = self:GetCaster()
    local host = self:GetCaster().host

	if self:GetToggleState() then
		caster:AddNewModifier( caster, self, "modifier_ricko_rage_toogle", nil )
	else
		caster:RemoveModifierByName("modifier_ricko_rage_toogle")
		if host and IsValidEntity(host) then
    		host:RemoveModifierByName("modifier_ricko_rage_buff")
     	end
	end

end
--------------------------------------------------------------------------------

modifier_ricko_rage_toogle = class({
	IsHidden 				= function(self) return true end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	RemoveOnDeath 			= function(self) return true end,
})

function modifier_ricko_rage_toogle:OnCreated()
	if IsServer() then
		local ability = self:GetAbility()
		self:StartIntervalThink(1)
		
		self:OnIntervalThink()
	end
end

function modifier_ricko_rage_toogle:OnIntervalThink()
	local host = self:GetCaster().host
	if host and IsValidEntity(host) then
		host:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ricko_rage_buff", {})
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local current_mana  = caster:GetMana()
	local mana_required = ability:GetManaCost(-1)
	
	if current_mana > mana_required then
		caster:SetMana(caster:GetMana() - mana_required)
	else
		ability:ToggleAbility()
	end
end

modifier_ricko_rage_buff = class({
	IsHidden 				= function(self) return false end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	RemoveOnDeath 			= function(self) return true end,
	RegisterFunctions		= function(self) return 
		{
			MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		} end,
})

function modifier_ricko_rage_buff:OnCreated()
	if(not IsServer()) then
		return
	end
	self:StartIntervalThink(0.1)
end

function modifier_ricko_rage_buff:OnIntervalThink()
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local dmg_pct = self:GetAbility():GetSpecialValueFor("dmg_pct")/100
	
	local damage = caster:GetAverageTrueAttackDamage(caster)*dmg_pct
	self:SetStackCount(damage)
end

function modifier_ricko_rage_buff:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end


LinkLuaModifier(" modifier_ricko_rage_buff", "abilities/heroes/hero_ricko/rage", LUA_MODIFIER_MOTION_NONE ,  modifier_ricko_rage_buff)
LinkLuaModifier(" modifier_ricko_rage_toogle", "abilities/heroes/hero_ricko/rage", LUA_MODIFIER_MOTION_NONE ,  modifier_ricko_rage_toogle)
