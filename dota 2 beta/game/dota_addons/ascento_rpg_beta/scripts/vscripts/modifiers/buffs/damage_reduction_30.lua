modifier_damage_reduction_30 = class ({})

function modifier_damage_reduction_30:IsHidden()
    return false
end

function modifier_damage_reduction_30:IsDebuff()
    return false
end

function modifier_damage_reduction_30:IsPurgable()
    return false
end

function modifier_damage_reduction_30:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_30:IsPurgeException()
    return false
end

function modifier_damage_reduction_30:GetTexture() return "shield" end
