modifier_event_shield = class({})

function modifier_event_shield:IsHidden()
    return true
end

function modifier_event_shield:IsPurgable()
    return false
end

function modifier_event_shield:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_event_shield:GetModifierIncomingDamage_Percentage(keys)
    if not IsServer() then return end
    if keys.target ~= self:GetParent() then return end
    if keys.target:IsHero() then
        if RollPercentage(50) then
            return -50
        end
    end
end