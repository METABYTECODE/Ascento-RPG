modifier_fow_vision = class({})

function modifier_fow_vision:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
    }
    return funcs
end

function modifier_fow_vision:IsHidden() return true end
function modifier_fow_vision:RemoveOnDeath() return false end
function modifier_fow_vision:IsPurgable() return false end
function modifier_fow_vision:IsPurgeException() return false end

function modifier_fow_vision:GetModifierProvidesFOWVision()
    return 1
end

function modifier_fow_vision:CheckState() 
  local state = {
    [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = false,
    [MODIFIER_STATE_FLYING] = false,
    [MODIFIER_STATE_FORCED_FLYING_VISION] = false,
    [MODIFIER_STATE_ALLOW_PATHING_THROUGH_CLIFFS] = false,
    [MODIFIER_STATE_ALLOW_PATHING_THROUGH_FISSURE] = false,
    [MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
    [MODIFIER_STATE_SPECIALLY_DENIABLE] = false
  }
  return state
end