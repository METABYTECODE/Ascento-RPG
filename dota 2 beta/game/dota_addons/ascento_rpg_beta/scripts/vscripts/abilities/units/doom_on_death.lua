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
    self.duration = self.ability:GetSpecialValueFor("duration")
end

function modifier_doom_on_death:OnDeath(kv)
    if kv.unit ~= self.parent then
        return
    end
    
    local killer = kv.attacker
    killer:AddNewModifier(self.parent, nil, "modifier_doom_on_death_debuff", {duration = self.duration})
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
	end,
	CheckState = function()
		return {
			[MODIFIER_STATE_MUTED] = true,
            [MODIFIER_STATE_SILENCED] = true
		}
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