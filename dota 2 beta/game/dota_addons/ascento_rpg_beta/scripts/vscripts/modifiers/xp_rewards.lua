modifier_xp_rewards = class({})

function modifier_xp_rewards:DeclareFunctions()
    local funcs = {
        -- MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_TOOLTIP,
    }

    return funcs
end

-- function modifier_xp_rewards:GetBehavior()
    -- return 
-- end

function modifier_xp_rewards:IsPurgable()
    return false
end

function modifier_xp_rewards:IsPurgeException()
    return false
end

function modifier_xp_rewards:OnTooltip()
    --print("UNITNAME", self:GetParent():GetUnitName())
    UnitsXPTable = UnitsXPTable or LoadKeyValues("scripts/kv/units_xp.kv")
    if not UnitsXPTable then
        return 0
    end

    return math.floor(UnitsXPTable[self:GetParent():GetUnitName()]/3 or 0)
end

function modifier_xp_rewards:GetTexture()
    return "alchemist_goblins_greed"
end

-- function modifier_xp_rewards:OnCreated()
-- end

-- function modifier_xp_rewards:OnDeath(keys)
    -- print("SOMEONE DIE")
    -- PrintTable(keys)
    -- local owner = keys.unit
    -- local killer = keys.attacker
    -- if not owner.XPRewardGiven and owner:GetLevel() <= killer:GetLevel() then
        -- owner.XPRewardGiven = true
        -- print("EXP GIVEN", self:OnTooltip(), IsServer())
        -- killer:AddExperience(self:OnTooltip(), 0, false, true)
    -- end
-- end

function modifier_xp_rewards:RemoveOnDeath()
    return true
end
