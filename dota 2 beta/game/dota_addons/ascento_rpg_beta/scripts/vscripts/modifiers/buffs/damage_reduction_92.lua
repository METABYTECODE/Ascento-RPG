modifier_damage_reduction_92 = class ({})

function modifier_damage_reduction_92:IsHidden()
    return false
end

function modifier_damage_reduction_92:IsDebuff()
    return false
end

function modifier_damage_reduction_92:IsPurgable()
    return false
end

function modifier_damage_reduction_92:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_92:IsPurgeException()
    return false
end

function modifier_damage_reduction_92:GetTexture() return "shield" end