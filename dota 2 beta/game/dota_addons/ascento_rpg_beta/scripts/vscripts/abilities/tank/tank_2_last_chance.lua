--[[
    Author: Noya
    Date: 9.1.2015.
    Checks if the caster HP dropped below the threshold
]]
function BorrowedTimeActivate( event )
    -- Variables
    local caster = event.caster
    local ability = event.ability
    local threshold = ability:GetLevelSpecialValueFor( "hp_threshold" , ability:GetLevel() - 1  )
    local cooldown = ability:GetCooldown( ability:GetLevel() )
    local dur = ability:GetLevelSpecialValueFor( "duration" , ability:GetLevel() - 1  )

    -- Apply the modifier
    if (caster:GetHealth() < (caster:GetMaxHealth()*(threshold/100))) and ability:GetCooldownTimeRemaining() == 0 then
        BorrowedTimePurge( event )
        ability:ApplyDataDrivenModifier( caster, caster, "modifier_tank_2_last_chance", { duration = dur })
        ability:StartCooldown( cooldown )
        caster:EmitSound("Hero_Abaddon.BorrowedTime")
        caster:Heal(caster:GetMaxHealth(), caster)
    end
end

--[[
    Author: Noya
    Date: 9.1.2015.
    Heals for twice the damage taken
]]
function BorrowedTimeHeal( event )
    -- Variables
    local damage = event.DamageTaken
    local caster = event.caster
    local ability = event.ability
    local damageHeal = ability:GetLevelSpecialValueFor( "damage_reduction" , ability:GetLevel() - 1  )
    
    caster:Heal(damage*(damageHeal / 100), caster)
end

function BorrowedTimePurge( event )
    local caster = event.caster


    -- Strong Dispel
    local RemovePositiveBuffs = false
    local RemoveDebuffs = true
    local BuffsCreatedThisFrameOnly = false
    local RemoveStuns = true
    local RemoveExceptions = false
    caster:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
end