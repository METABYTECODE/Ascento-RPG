physical_resistance = class({
	GetIntrinsicModifierName = function()
		return "modifier_physical_resistance"
	end
})

modifier_physical_resistance = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
	IsDebuff = function()
		return false
	end,
    DeclareFunctions = function()
        return {
		    MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
        }
    end
})

function modifier_physical_resistance:OnCreated()
    self.ability = self:GetAbility()
    self:OnRefresh()
end

function modifier_physical_resistance:OnRefresh()
    self.incomingPhysicalDamagePct = -1 * self.ability:GetSpecialValueFor("physical_resistance_pct")
end

function modifier_physical_resistance:GetModifierIncomingPhysicalDamage_Percentage()
    return self.incomingPhysicalDamagePct
end

LinkLuaModifier("modifier_physical_resistance", "abilities/units/physical_resistance", LUA_MODIFIER_MOTION_NONE)