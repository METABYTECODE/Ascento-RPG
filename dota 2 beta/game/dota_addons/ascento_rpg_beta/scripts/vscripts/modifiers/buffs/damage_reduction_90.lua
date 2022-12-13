modifier_damage_reduction_90 = class ({})

function modifier_damage_reduction_90:IsHidden()
    return false
end

function modifier_damage_reduction_90:IsDebuff()
    return false
end

function modifier_damage_reduction_90:IsPurgable()
    return false
end

function modifier_damage_reduction_90:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_90:IsPurgeException()
    return false
end

function modifier_damage_reduction_90:GetTexture() return "shield" end