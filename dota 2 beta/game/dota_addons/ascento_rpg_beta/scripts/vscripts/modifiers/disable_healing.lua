modifier_disable_healing = class({})

function modifier_disable_healing:IsHidden() return false end
function modifier_disable_healing:IsDebuff() return true end
function modifier_disable_healing:RemoveOnDeath() return true end

function modifier_disable_healing:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    }

    return funcs
end

function modifier_disable_healing:GetModifierHealthRegenPercentage()
    return -1000000000
end