modifier_damage_increase_30 = class ({})

function modifier_damage_increase_30:IsHidden()
    return false
end

function modifier_damage_increase_30:IsDebuff()
    return true
end

function modifier_damage_increase_30:IsPurgable()
    return false
end

function modifier_damage_increase_30:RemoveOnDeath()
    return false
end

function modifier_damage_increase_30:IsPurgeException()
    return false
end

function modifier_damage_increase_30:GetTexture() return "shield" end

--function modifier_damage_increase_30:DeclareFunctions()
--    local funcs = {
--        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
--    }
-- 
--    return funcs
--end
--
--function modifier_damage_increase_30:GetModifierIncomingDamage_Percentage( params )
--    return 130
--end