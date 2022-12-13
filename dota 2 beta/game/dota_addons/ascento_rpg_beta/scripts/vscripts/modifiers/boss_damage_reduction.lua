modifier_boss_damage_reduction = class ({})

function modifier_boss_damage_reduction:IsHidden()
    return false
end

function modifier_boss_damage_reduction:IsDebuff()
    return false
end

function modifier_boss_damage_reduction:IsPurgable()
    return false
end

function modifier_boss_damage_reduction:RemoveOnDeath()
    return false
end

function modifier_boss_damage_reduction:IsPurgeException()
    return false
end

function modifier_boss_damage_reduction:GetTexture() return "cursed_shield" end

function modifier_boss_damage_reduction:DeclareFunctions()
    local funcs = {
 --       MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
    }
 
    return funcs
end

--function modifier_boss_damage_reduction:GetModifierIncomingDamage_Percentage( params )
--    return 0 ---15
--end

function modifier_boss_damage_reduction:GetModifierIncomingPhysicalDamage_Percentage( params )
    return -15
end