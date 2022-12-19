stun_for_time = class({
	GetIntrinsicModifierName = function()
		return "modifier_stun_for_time"
	end,
	GetCastRange = function(self)
		return self:GetSpecialValueFor("aura_radius")
	end
})

modifier_stun_for_time = class({
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
        return "modifier_stun_for_time_buff" 
    end,
	GetAuraDuration = function()
		return 0
	end
})

function modifier_stun_for_time:OnCreated()
	self.parent = self:GetParent()
	self:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.targetTeam = self.ability:GetAbilityTargetTeam()
    self.targetType = self.ability:GetAbilityTargetType()
end

function modifier_stun_for_time:OnRefresh()
    if(not IsServer()) then
		return
	end
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.radius = self.ability:GetCastRange()
end

modifier_stun_for_time_buff = class({
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
		return true
	end
})

function modifier_stun_for_time_buff:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    if not IsServer() then
        return
    end
    self:OnRefresh()
    self:StartIntervalThink(1)
    self.timer = 0
end

function modifier_stun_for_time_buff:OnRefresh()
    self.timeToBash = self.ability:GetSpecialValueFor("time_to_bash")
    self.bashDuration = self.ability:GetSpecialValueFor("bash_duration")
    self.damage = self.ability:GetSpecialValueFor("damage")
end

function modifier_stun_for_time_buff:OnIntervalThink()
    self.timer = self.timer + 1
    if self.timer == self.timeToBash then
        self.parent:AddNewModifier(self.parent, nil, "modifier_bash", {duration = self.bashDuration})
        ApplyDamage({attacker = self.caster, 
		        victim = self.parent,  
				damage = self.damage,
				ability = self.ability, 
				damage_type = DAMAGE_TYPE_MAGICAL})
        self.timer = 0
    end
end

LinkLuaModifier("modifier_bash", "modifiers/modifier_bash", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_stun_for_time", "abilities/units/stun_for_time", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_stun_for_time_buff", "abilities/units/stun_for_time", LUA_MODIFIER_MOTION_NONE)