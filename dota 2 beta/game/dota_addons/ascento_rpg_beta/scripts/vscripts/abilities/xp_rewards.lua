function GiveModifier(keys)
    local caster = keys.caster
    if GameRules:State_Get() < DOTA_GAMERULES_STATE_HERO_SELECTION then -- fix bug with no display
        _G.DelayedModifiersTable = _G.DelayedModifiersTable or {}
        _G.DelayedModifiersTable[caster] = "modifier_xp_rewards"
    else
        caster:AddNewModifier(caster, nil, "modifier_xp_rewards", {})
    end
end
