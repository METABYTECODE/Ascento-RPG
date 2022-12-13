modifier_damage_reduction_70 = class ({})

function modifier_damage_reduction_70:IsHidden()
    return false
end

function modifier_damage_reduction_70:IsDebuff()
    return false
end

function modifier_damage_reduction_70:IsPurgable()
    return false
end

function modifier_damage_reduction_70:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_70:IsPurgeException()
    return false
end

function modifier_damage_reduction_70:GetTexture() return "shield" end

