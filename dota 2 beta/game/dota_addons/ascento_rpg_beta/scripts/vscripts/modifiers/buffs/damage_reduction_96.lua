modifier_damage_reduction_96 = class ({})

function modifier_damage_reduction_96:IsHidden()
    return false
end

function modifier_damage_reduction_96:IsDebuff()
    return false
end

function modifier_damage_reduction_96:IsPurgable()
    return false
end

function modifier_damage_reduction_96:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_96:IsPurgeException()
    return false
end

function modifier_damage_reduction_96:GetTexture() return "shield" end