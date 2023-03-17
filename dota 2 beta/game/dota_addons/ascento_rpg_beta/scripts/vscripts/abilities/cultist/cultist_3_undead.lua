-- Define the ability
LinkLuaModifier("modifier_cultist_3_undead", "abilities/cultist/cultist_3_undead.lua", LUA_MODIFIER_MOTION_NONE )

cultist_3_undead = class({})

function cultist_3_undead:GetIntrinsicModifierName()
    return "modifier_cultist_3_undead"
end

-- Define the modifier
modifier_cultist_3_undead = class({})

function modifier_cultist_3_undead:IsHidden()
    return false
end

function modifier_cultist_3_undead:IsPurgable()
    return false
end

function modifier_cultist_3_undead:RemoveOnDeath()
    return false
end

function modifier_cultist_3_undead:OnCreated()
    self.undead_buff_max_stacks = 500
    self.undead_buff_int_bonus_per_stack = self:GetAbility():GetLevelSpecialValueFor("int_bonus", self:GetAbility():GetLevel() - 1) / 100
    self.undead_buff_int_bonus = self.undead_buff_int_bonus_per_stack * self:GetStackCount()


    self:StartIntervalThink(0.1)
    self:OnIntervalThink()
end

function modifier_cultist_3_undead:OnIntervalThink()
    if not IsServer() then return end
    --if self:GetParent() ~= self:GetCaster() then return end

    self.undead_buff_int_bonus_per_stack = self:GetAbility():GetLevelSpecialValueFor("int_bonus", self:GetAbility():GetLevel() - 1)
    self.undead_buff_int_bonus = self.undead_buff_int_bonus_per_stack * self:GetStackCount()


    --self:GetCaster():CalculateStatBonus(true) 

end

function modifier_cultist_3_undead:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }

    return funcs
end

function modifier_cultist_3_undead:OnDeath(kv)
    if kv.unit == self:GetParent() and not self:GetParent():IsIllusion() and kv.attacker ~= self:GetParent() and kv.attacker ~= nil then
        -- Check if the maximum stacks have been reached
        if self:GetStackCount() >= self.undead_buff_max_stacks then
            return
        end

        -- Increment the stack count and update the modifier
        self:SetStackCount(self:GetStackCount() + 1)

        self.undead_buff_int_bonus = self.undead_buff_int_bonus_per_stack * self:GetStackCount()

    end
end

function modifier_cultist_3_undead:GetModifierBonusStats_Intellect()
    return self:GetParent():GetBaseIntellect() * (self.undead_buff_int_bonus / 100)
end

function modifier_cultist_3_undead:OnTooltip()
    return self:GetAbility():GetLevelSpecialValueFor("int_bonus", self:GetAbility():GetLevel() - 1) * self:GetStackCount()
end