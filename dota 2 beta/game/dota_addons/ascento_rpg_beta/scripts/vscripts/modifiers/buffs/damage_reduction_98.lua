modifier_damage_reduction_98 = class ({})

function modifier_damage_reduction_98:IsHidden()
    return false
end

function modifier_damage_reduction_98:IsDebuff()
    return false
end

function modifier_damage_reduction_98:IsPurgable()
    return false
end

function modifier_damage_reduction_98:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_98:IsPurgeException()
    return false
end

function modifier_damage_reduction_98:GetTexture() return "shield" end