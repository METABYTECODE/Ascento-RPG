modifier_damage_reduction_99 = class ({})

function modifier_damage_reduction_99:IsHidden()
    return false
end

function modifier_damage_reduction_99:IsDebuff()
    return false
end

function modifier_damage_reduction_99:IsPurgable()
    return false
end

function modifier_damage_reduction_99:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_99:IsPurgeException()
    return false
end

function modifier_damage_reduction_99:GetTexture() return "shield" end