invisible_aura = class({
	GetIntrinsicModifierName = function()
		return "modifier_invisible_aura"
	end,
	GetCastRange = function(self)
		return self:GetSpecialValueFor("aura_radius")
	end
})

modifier_invisible_aura = class({
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
        return "modifier_invisible_aura_aura_buff" 
    end,
	GetAuraDuration = function()
		return 0
	end
})

function modifier_invisible_aura:OnCreated()
	self.parent = self:GetParent()
	self:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.targetTeam = self.ability:GetAbilityTargetTeam()
    self.targetType = self.ability:GetAbilityTargetType()
end

function modifier_invisible_aura:OnRefresh()
    if(not IsServer()) then
		return
	end
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.radius = self.ability:GetCastRange()
end

modifier_invisible_aura_aura_buff = class({
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
	CheckState = function()
		return {
			[MODIFIER_STATE_INVISIBLE] = true
		}
	end
})

function modifier_invisible_aura_aura_buff:OnCreated()
end

function modifier_invisible_aura_aura_buff:CheckState()
    return {
        [MODIFIER_STATE_INVISIBLE] = true
    }
end

LinkLuaModifier("modifier_invisible_aura", "abilities/units/invisible_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invisible_aura_aura_buff", "abilities/units/invisible_aura", LUA_MODIFIER_MOTION_NONE)