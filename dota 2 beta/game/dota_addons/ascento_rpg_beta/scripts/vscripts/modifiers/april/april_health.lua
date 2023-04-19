modifier_april_health = class({})

local public = modifier_april_health

--------------------------------------------------------------------------------

function public:IsDebuff()
	return false
end

function public:GetTexture() return "april_health" end

--------------------------------------------------------------------------------

function public:IsHidden()
	return false
end

--------------------------------------------------------------------------------

function public:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function public:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------

function public:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
    }
 
    return funcs
end

--------------------------------------------------------------------------------

function public:GetModifierHealthBonus()
	return 1000
end

function public:GetModifierExtraHealthPercentage()
	return 1
end