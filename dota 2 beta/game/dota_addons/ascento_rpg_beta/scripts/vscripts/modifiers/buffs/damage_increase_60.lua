modifier_damage_increase_60 = class ({})

function modifier_damage_increase_60:IsHidden()
    return false
end

function modifier_damage_increase_60:IsDebuff()
    return true
end

function modifier_damage_increase_60:IsPurgable()
    return false
end

function modifier_damage_increase_60:RemoveOnDeath()
    return false
end

function modifier_damage_increase_60:IsPurgeException()
    return false
end

function modifier_damage_increase_60:GetTexture() return "shield" end

--function modifier_damage_increase_60:DeclareFunctions()
--    local funcs = {
--        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
--    }
-- 
--    return funcs
--end
--
--function modifier_damage_increase_60:GetModifierIncomingDamage_Percentage( params )
--    return 160
--end