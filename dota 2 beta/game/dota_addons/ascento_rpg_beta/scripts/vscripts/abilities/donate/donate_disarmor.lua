LinkLuaModifier("modifier_donate_disarmor", "abilities/donate/donate_disarmor.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_generic_disarmor", "abilities/generic/modifier_generic_disarmor", LUA_MODIFIER_MOTION_NONE )

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

donate_disarmor = class(ItemBaseClass)
modifier_donate_disarmor = class(ItemBaseClass)
-------------
function donate_disarmor:GetIntrinsicModifierName()
    return "modifier_donate_disarmor"
end

function modifier_donate_disarmor:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_donate_disarmor:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_TOOLTIP,
    }

    return funcs
end

function modifier_donate_disarmor:OnTooltip( params )
    if self:GetStackCount() == 0 then return 0 end

    return self:GetStackCount()
end

function modifier_donate_disarmor:OnAttack(params)
    if params.attacker~=self:GetParent() then return end
    if self:GetParent():PassivesDisabled() then return end
    local attacker = params.attacker
    local victim = params.target
    local ability = self:GetAbility()
    --print(attacker:GetUnitName() .. " to " .. victim:GetUnitName())

    if not victim:HasModifier("modifier_generic_disarmor") then
        --print("Дали")
        local modifier = victim:AddNewModifier(attacker, ability, "modifier_generic_disarmor", {duration = -1})
        modifier:SetStackCount(1)
    else
        --print("Прибавили")
        local modifier = victim:FindModifierByName("modifier_generic_disarmor")
        modifier:IncrementStackCount()
    end
end