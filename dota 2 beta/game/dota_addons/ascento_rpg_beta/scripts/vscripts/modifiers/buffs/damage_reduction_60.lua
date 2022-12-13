modifier_damage_reduction_60 = class ({})

function modifier_damage_reduction_60:IsHidden()
    return false
end

function modifier_damage_reduction_60:IsDebuff()
    return false
end

function modifier_damage_reduction_60:IsPurgable()
    return false
end

function modifier_damage_reduction_60:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_60:IsPurgeException()
    return false
end

function modifier_damage_reduction_60:GetTexture() return "shield" end

