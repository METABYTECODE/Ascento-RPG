doom_on_death = class({
	GetIntrinsicModifierName = function()
		return "modifier_doom_on_death"
	end
})

modifier_doom_on_death = class({
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
		return false
	end,
    DeclareFunctions = function()
        return {
		    MODIFIER_EVENT_ON_DEATH,
        }
    end
})

function modifier_doom_on_death:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    if not IsServer then
        return
    end
    self.duration = self.ability:GetSpecialValueFor("duration")
end

function modifier_doom_on_death:OnDeath(data)
    local attacker = data.attacker
    local unit = data.unit

    if self.parent == unit or self.caster == unit  then 
        attacker:AddNewModifier(self.caster, self.ability, "modifier_doom_on_death_debuff", {duration = self.duration})
    end
end

modifier_doom_on_death_debuff = class({
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

function modifier_doom_on_death_debuff:OnCreated()
end

function modifier_doom_on_death_debuff:CheckState()
    return {
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_SILENCED] = true
    }
end

function modifier_doom_on_death_debuff:GetEffectName()
    return "particles/units/heroes/hero_doom_bringer/doom_bringer_doom_ring.vpcf"
end

function modifier_doom_on_death_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end


LinkLuaModifier("modifier_doom_on_death", "abilities/units/doom_on_death", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_doom_on_death_debuff", "abilities/units/doom_on_death", LUA_MODIFIER_MOTION_NONE)