modifier_damage_reduction_94 = class ({})

function modifier_damage_reduction_94:IsHidden()
    return false
end

function modifier_damage_reduction_94:IsDebuff()
    return false
end

function modifier_damage_reduction_94:IsPurgable()
    return false
end

function modifier_damage_reduction_94:RemoveOnDeath()
    return false
end

function modifier_damage_reduction_94:IsPurgeException()
    return false
end

function modifier_damage_reduction_94:GetTexture() return "shield" end