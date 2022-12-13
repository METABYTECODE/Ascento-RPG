
ricko_hunger = class({})

function ricko_hunger:OnSpellStart()
	local buff_duration= self:GetSpecialValueFor("buff_duration")
	local caster = self:GetCaster()
	local host = self:GetCaster().host
	if host and IsValidEntity(host) then
		host:AddNewModifier( caster, self, "modifier_ricko_hunger", {duration = buff_duration} )
		host:EmitSound("DOTA_Item.MaskOfMadness.Activate")
	end
end

modifier_ricko_hunger = class({
	IsHidden 				= function(self) return false end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	RemoveOnDeath 			= function(self) return true end,
	RegisterFunctions = function()
		return {
            MODIFIER_EVENT_ON_TAKEDAMAGE,
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
		}
	end,
})

function modifier_ricko_hunger:GetEffectName()
	return "particles/items2_fx/mask_of_madness.vpcf"
end

function modifier_ricko_hunger:GetModifierLifestealPercantage()
	return self:GetAbility():GetSpecialValueFor("lifesteal_pct")
end

function modifier_ricko_hunger:GetModifierAttackSpeedBonus_Constant( )
	return self:GetAbility():GetSpecialValueFor("bonus_as")
end


LinkLuaModifier(" modifier_ricko_hunger", "abilities/heroes/hero_ricko/hunger", LUA_MODIFIER_MOTION_NONE ,  modifier_ricko_hunger)
