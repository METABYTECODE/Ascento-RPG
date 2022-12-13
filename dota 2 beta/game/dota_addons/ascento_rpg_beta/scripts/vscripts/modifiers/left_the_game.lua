modifier_left_the_game = class({})

local public = modifier_left_the_game

--------------------------------------------------------------------------------

function public:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function public:IsHidden()
	return true
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

function public:CheckState() 
  local state = {
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_MUTED] = true,
    [MODIFIER_STATE_SILENCED] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_FROZEN] = true,
    [MODIFIER_STATE_HEXED] = true,
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_NIGHTMARED] = true,
    [MODIFIER_STATE_BLIND] = true,
    [MODIFIER_STATE_PASSIVES_DISABLED] = true,
    [MODIFIER_STATE_UNSELECTABLE] = true,
    [MODIFIER_STATE_ROOTED] = true
  }
  return state
end