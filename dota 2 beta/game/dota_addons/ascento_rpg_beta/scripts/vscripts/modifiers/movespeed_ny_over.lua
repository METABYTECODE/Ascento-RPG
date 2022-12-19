modifier_ny_over = class({})

function modifier_ny_over:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MOVESPEED_MAX,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
    }

    return funcs
end



function modifier_ny_over:IsHidden() return true end
function modifier_ny_over:RemoveOnDeath() return false end
function modifier_ny_over:IsPurgable() return false end
function modifier_ny_over:IsPurgeException() return false end

function modifier_ny_over:GetModifierMoveSpeed_Max( params )
    return 1000
end

function modifier_ny_over:GetModifierMoveSpeedOverride( params )
    return 400
end



function modifier_ny_over:GetModifierMoveSpeed_Limit( params )
    return 1000
end

function modifier_ny_over:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

function modifier_ny_over:CheckState() 
  local state = {
    [MODIFIER_STATE_NO_HEALTH_BAR] = true
  }
  return state
end