modifier_damage_reduction_50 = class ({})

function modifier_damage_reduction_50:IsHidden()
    return false
end

function modifier_damage_reduction_50:IsDebuff()
    return false
end

function modifier_damage_reduction_50:IsPurgable()
    return false
end

function modifier_damage_reduction_50:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_50:IsPurgeException()
    return false
end

function modifier_damage_reduction_50:GetTexture() return "shield" end
