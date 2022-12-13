modifier_damage_increase_50 = class ({})

function modifier_damage_increase_50:IsHidden()
    return false
end

function modifier_damage_increase_50:IsDebuff()
    return true
end

function modifier_damage_increase_50:IsPurgable()
    return false
end

function modifier_damage_increase_50:RemoveOnDeath()
    return false
end

function modifier_damage_increase_50:IsPurgeException()
    return false
end

function modifier_damage_increase_50:GetTexture() return "shield" end

--function modifier_damage_increase_50:DeclareFunctions()
--    local funcs = {
--        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
--    }
-- 
--    return funcs
--end
--
--function modifier_damage_increase_50:GetModifierIncomingDamage_Percentage( params )
--    return 150
--end