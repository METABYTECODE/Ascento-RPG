strengthening_creeps = class({
	GetIntrinsicModifierName = function()
		return "modifier_strengthening_creeps"
	end,
	GetCastRange = function(self)
		return self:GetSpecialValueFor("aura_radius")
	end
})

modifier_strengthening_creeps = class({
    IsHidden = function()
        return true
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
    RemoveOnDeath = function()
        return false
    end,
	IsDebuff = function()
		return false
	end,
    IsAura = function() 
        return true 
    end,
    GetAuraRadius = function(self) 
        return self.radius
    end,
    GetAuraSearchTeam = function(self) 
        return self.targetTeam
    end,
    GetAuraSearchType = function(self) 
        return self.targetType
    end,
    GetModifierAura = function() 
        return "modifier_strengthening_creeps_aura_buff" 
    end,
	GetAuraDuration = function()
		return 0
	end
})

function modifier_strengthening_creeps:OnCreated()
	self.parent = self:GetParent()
	self:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.targetTeam = self.ability:GetAbilityTargetTeam()
    self.targetType = self.ability:GetAbilityTargetType()
end

function modifier_strengthening_creeps:OnRefresh()
    if(not IsServer()) then
		return
	end
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.radius = self.ability:GetCastRange()
end

modifier_strengthening_creeps_aura_buff = class({
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
            MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		    MODIFIER_PROPERTY_MODEL_SCALE,
		    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
        }
    end,
    GetModifierExtraHealthPercentage = function(self)
        return self.healthPercentage
    end,
    GetModifierModelScale = function(self)
        return self.modelScale
    end,
    GetModifierDamageOutgoing_Percentage = function(self)
        return self.damageOutgoingPct
    end
})

function modifier_strengthening_creeps_aura_buff:OnCreated()
    self.ability = self:GetAbility()
    self:OnRefresh()
end

function modifier_strengthening_creeps_aura_buff:OnRefresh()
    self.healthPercentage = self.ability:GetSpecialValueFor("buff_heal_pct")
    self.modelScale = self.ability:GetSpecialValueFor("buff_model_scale")
    self.damageOutgoingPct = self.ability:GetSpecialValueFor("buff_damage_pct")
end

LinkLuaModifier("modifier_strengthening_creeps", "abilities/units/strengthening_creeps", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_strengthening_creeps_aura_buff", "abilities/units/strengthening_creeps", LUA_MODIFIER_MOTION_NONE)