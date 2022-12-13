modifier_damage_increase_70 = class ({})

function modifier_damage_increase_70:IsHidden()
    return false
end

function modifier_damage_increase_70:IsDebuff()
    return true
end

function modifier_damage_increase_70:IsPurgable()
    return false
end

function modifier_damage_increase_70:RemoveOnDeath()
    return false
end

function modifier_damage_increase_70:IsPurgeException()
    return false
end

function modifier_damage_increase_70:GetTexture() return "shield" end

--function modifier_damage_increase_70:DeclareFunctions()
--    local funcs = {
--        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
--    }
-- 
--    return funcs
--end
--
--function modifier_damage_increase_70:GetModifierIncomingDamage_Percentage( params )
--    return 170
--end