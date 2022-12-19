damage_reduction_aura = class({
	GetIntrinsicModifierName = function()
		return "modifier_damage_reduction_aura"
	end,
	GetCastRange = function(self)
		return self:GetSpecialValueFor("aura_radius")
	end
})

modifier_damage_reduction_aura = class({
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
        return "modifier_damage_reduction_aura_buff" 
    end,
	GetAuraDuration = function()
		return 0
	end
})

function modifier_damage_reduction_aura:OnCreated()
	self.parent = self:GetParent()
	self:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.targetTeam = self.ability:GetAbilityTargetTeam()
    self.targetType = self.ability:GetAbilityTargetType()
end

function modifier_damage_reduction_aura:OnRefresh()
    if(not IsServer()) then
		return
	end
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.radius = self.ability:GetCastRange()
end

modifier_damage_reduction_aura_buff = class({
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
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
            
        }
    end,
    GetModifierIncomingDamage_Percentage = function(self)
        return self.totaDamageIncomingPct
    end
})

function modifier_damage_reduction_aura_buff:OnCreated()
    self.totaDamageIncomingPct = self.totaDamageIncomingPct or 0
    self.ability = self:GetAbility()
    self:OnRefresh()
    self:StartIntervalThink(self.tickInterval)
end

function modifier_damage_reduction_aura_buff:OnRefresh()
    self.tickInterval = self.ability:GetSpecialValueFor("tick_interval")
    self.damageReductionPerTick = self.ability:GetSpecialValueFor("tick_damage_reduction")
end

function modifier_damage_reduction_aura_buff:OnIntervalThink()
    local newDamageReduction = self.totaDamageIncomingPct - self.damageReductionPerTick
    if self.totaDamageIncomingPct ~= newDamageReduction and self.totaDamageIncomingPct > -90 then
        self.totaDamageIncomingPct = newDamageReduction
    end
end

LinkLuaModifier("modifier_damage_reduction_aura", "abilities/units/damage_reduction_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_damage_reduction_aura_buff", "abilities/units/damage_reduction_aura", LUA_MODIFIER_MOTION_NONE)