burning_of_allies = class({
	GetCastRange = function(self)
		return self:GetSpecialValueFor("aura_radius")
	end
})

function burning_of_allies:OnSpellStart()
    local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local duration = self:GetSpecialValueFor( "duration" )

	target:AddNewModifier(caster, self, "modifier_burning_of_allies",{ duration = duration } 
	)
end

modifier_burning_of_allies = class({
    IsHidden = function()
        return false
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
		return true
	end,
    IsAura = function() 
        return true 
    end,
    GetAuraRadius = function(self) 
        return self.radius
    end,
    GetAuraSearchTeam = function(self) 
        return DOTA_UNIT_TARGET_TEAM_FRIENDLY
    end,
    GetAuraSearchType = function(self) 
        return self.targetType
    end,
    GetModifierAura = function() 
        return "modifier_burning_of_allies_debuff" 
    end,
	GetAuraDuration = function()
		return 0
	end
})

function modifier_burning_of_allies:OnCreated()
	self.parent = self:GetParent()
	self:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.targetType = self.ability:GetAbilityTargetType()
end

function modifier_burning_of_allies:OnRefresh()
    if(not IsServer()) then
		return
	end
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.radius = self.ability:GetCastRange()
end

modifier_burning_of_allies_debuff = class({
    IsHidden = function()
        return true
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

function modifier_burning_of_allies_debuff:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self:OnRefresh()
    self:StartIntervalThink(1)
end

function modifier_burning_of_allies_debuff:OnRefresh()
    self.timeToBash = self.ability:GetSpecialValueFor("time_to_bash")
    self.bashDuration = self.ability:GetSpecialValueFor("bash_duration")
    self.damage = self.ability:GetSpecialValueFor("damage")
end

function modifier_burning_of_allies_debuff:OnIntervalThink()
	if self.parent:HasModifier("modifier_burning_of_allies") then
		return
	end
    ApplyDamage({attacker = self.caster, 
		victim = self.parent,  
		damage = self.damage,
		ability = self.ability, 
		damage_type = DAMAGE_TYPE_MAGICAL})
end

LinkLuaModifier("modifier_burning_of_allies", "abilities/units/burning_of_allies", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_burning_of_allies_debuff", "abilities/units/burning_of_allies", LUA_MODIFIER_MOTION_NONE)