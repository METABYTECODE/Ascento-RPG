modifier_movespeed_cap = class({})

function modifier_movespeed_cap:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MOVESPEED_MAX,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
    }

    return funcs
end



function modifier_movespeed_cap:IsHidden() return true end
function modifier_movespeed_cap:RemoveOnDeath() return false end
function modifier_movespeed_cap:IsPurgable() return false end
function modifier_movespeed_cap:IsPurgeException() return false end

function modifier_movespeed_cap:GetModifierMoveSpeed_Max( params )
    return 5000
end



function modifier_movespeed_cap:GetModifierMoveSpeed_Limit( params )
    return 5000
end

function modifier_movespeed_cap:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

function modifier_movespeed_cap:CheckState() 
  local state = {
    [MODIFIER_STATE_NO_HEALTH_BAR] = true
  }
  return state
end