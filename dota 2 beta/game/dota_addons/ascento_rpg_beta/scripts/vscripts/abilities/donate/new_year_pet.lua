modifier_new_year_pet = class({})

function modifier_new_year_pet:IsHidden()
    return false
end

function modifier_new_year_pet:IsDebuff()
    return false
end

function modifier_new_year_pet:IsPurgable()
    return false
end

function modifier_new_year_pet:RemoveOnDeath()
    return false
end

function modifier_new_year_pet:GetTexture()
    return "new_year_pet"
end

--function modifier_new_year_pet:DeclareFunctions()
--    local funcs = {
--        MODIFIER_EVENT_ON_DEATH,
--    }
--
--    return funcs
--end
--
--function modifier_new_year_pet:OnDeath(keys)
--    if not IsServer() then
--        return
--    end
--
--    local attacker = keys.attacker
--    local target = keys.unit
--
--    if attacker:IsRealHero() and RollPercentage(10) then
--        local candy = CreateItem("item_candy", nil, nil)
--        local pos = target:GetAbsOrigin()
--
--        CreateItemOnPositionSync(pos, candy)
--        candy.owner = attacker
--    end
--end

