modifier_damage_increase_80 = class ({})

function modifier_damage_increase_80:IsHidden()
    return false
end

function modifier_damage_increase_80:IsDebuff()
    return true
end

function modifier_damage_increase_80:IsPurgable()
    return false
end

function modifier_damage_increase_80:RemoveOnDeath()
    return false
end

function modifier_damage_increase_80:IsPurgeException()
    return false
end

function modifier_damage_increase_80:GetTexture() return "shield" end

--function modifier_damage_increase_80:DeclareFunctions()
--    local funcs = {
--        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
--    }
-- 
--    return funcs
--end
--
--function modifier_damage_increase_80:GetModifierIncomingDamage_Percentage( params )
--    return 180
--end