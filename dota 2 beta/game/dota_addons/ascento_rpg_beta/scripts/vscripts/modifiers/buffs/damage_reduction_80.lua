modifier_damage_reduction_80 = class ({})

function modifier_damage_reduction_80:IsHidden()
    return false
end

function modifier_damage_reduction_80:IsDebuff()
    return false
end

function modifier_damage_reduction_80:IsPurgable()
    return false
end

function modifier_damage_reduction_80:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_80:IsPurgeException()
    return false
end

function modifier_damage_reduction_80:GetTexture() return "shield" end