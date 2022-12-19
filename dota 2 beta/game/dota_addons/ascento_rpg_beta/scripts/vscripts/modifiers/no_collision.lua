modifier_no_collision_custom = class({})

function modifier_no_collision_custom:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MOVESPEED_MAX,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
    }

    return funcs
end



function modifier_no_collision_custom:IsHidden() return true end
function modifier_no_collision_custom:RemoveOnDeath() return false end
function modifier_no_collision_custom:IsPurgable() return false end
function modifier_no_collision_custom:IsPurgeException() return false end

function modifier_no_collision_custom:GetModifierMoveSpeed_Max( params )
    return 1000
end

function modifier_no_collision_custom:GetModifierMoveSpeedOverride( params )
    return 400
end



function modifier_no_collision_custom:GetModifierMoveSpeed_Limit( params )
    return 1000
end

function modifier_no_collision_custom:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

function modifier_no_collision_custom:CheckState() 
  local state = {
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true
  }
  return state
end