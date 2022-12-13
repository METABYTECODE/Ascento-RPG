modifier_custom_invulnerable_res = modifier_custom_invulnerable_res or class({})

function modifier_custom_invulnerable_res:IsHidden()
    return true
end

function modifier_custom_invulnerable_res:IsPurgable()
    return false
end

function modifier_custom_invulnerable_res:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }

    return funcs
end

function modifier_custom_invulnerable_res:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target == self:GetCaster() then return end

    if self:GetCaster():HasModifier("modifier_custom_invulnerable_res") then
        self:GetCaster():RemoveModifierByName("modifier_custom_invulnerable_res")
    end
end

function modifier_custom_invulnerable_res:GetAbsoluteNoDamageMagical(params)
    return 1
end

function modifier_custom_invulnerable_res:GetAbsoluteNoDamagePhysical(params)
    return 1
end

function modifier_custom_invulnerable_res:GetAbsoluteNoDamagePure(params)
    return 1
end

function modifier_custom_invulnerable_res:GetModifierMoveSpeedBonus_Percentage(params)
    return 100
end

function modifier_custom_invulnerable_res:CheckState() 
  local state = {
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_ATTACK_IMMUNE] = true,
    [MODIFIER_STATE_MUTED] = true,
    [MODIFIER_STATE_MAGIC_IMMUNE] = true,
    [MODIFIER_STATE_SILENCED] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true
  }
  return state
end