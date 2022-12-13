modifier_damage_reduction_85 = class ({})

function modifier_damage_reduction_85:IsHidden()
    return false
end

function modifier_damage_reduction_85:IsDebuff()
    return false
end

function modifier_damage_reduction_85:IsPurgable()
    return false
end

function modifier_damage_reduction_85:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_85:IsPurgeException()
    return false
end

function modifier_damage_reduction_85:GetTexture() return "shield" end