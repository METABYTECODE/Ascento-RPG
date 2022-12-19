LinkLuaModifier("modifier_item_havoc", "items/items_thunder/item_havoc/item_havoc.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_havoc_stunned", "items/items_thunder/item_havoc/item_havoc.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_havoc_slowed", "items/items_thunder/item_havoc/item_havoc.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

local ItemBaseClassDebuff = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return true end,
    IsHidden = function(self) return false end,
    IsStackable = function(self) return false end,
    IsDebuff = function(self) return true end,
}

item_havoc = class(ItemBaseClass)
item_havoc_2 = item_havoc
item_havoc_3 = item_havoc
item_havoc_4 = item_havoc
item_havoc_5 = item_havoc
item_havoc_6 = item_havoc
item_havoc_7 = item_havoc
modifier_item_havoc = class(item_havoc)
modifier_item_havoc_stunned = class(ItemBaseClassDebuff)
modifier_item_havoc_slowed = class(ItemBaseClassDebuff)
-------------
function item_havoc:GetIntrinsicModifierName()
    return "modifier_item_havoc"
end

function modifier_item_havoc:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, --GetModifierPreAttack_BonusDamage
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, --GetModifierBonusStats_Strength
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, --GetModifierAttackSpeedBonus_Constant
        MODIFIER_EVENT_ON_ATTACK 
    }
    return funcs
end

function modifier_item_havoc:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_havoc:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_havoc:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_havoc:OnAttack(event)
    if not IsServer() then return end

    local parent = self:GetParent()

    if event.attacker ~= parent or event.target == parent then return end

    local ability = self:GetAbility()
    local chance = ability:GetSpecialValueFor("chance")
    local radius = ability:GetSpecialValueFor("radius")
    local damage = ability:GetSpecialValueFor("damage") + (parent:GetStrength() * (ability:GetSpecialValueFor("damage_strength_pct")/100))
    local stun_duration = ability:GetSpecialValueFor("stun_duration")
    local slow_duration = ability:GetSpecialValueFor("slow_duration")

    if not RollPercentage(chance) then return end

    local victims = FindUnitsInRadius(parent:GetTeam(), parent:GetAbsOrigin(), nil,
        radius, DOTA_UNIT_TARGET_TEAM_ENEMY, bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_BASIC), DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_CLOSEST, false)

    for _,victim in ipairs(victims) do
        if not victim:IsAlive() then break end

        ApplyDamage({
            victim = victim, 
            attacker = parent, 
            damage = damage, 
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = ability
        })

        victim:AddNewModifier(parent, ability, "modifier_item_havoc_stunned", {
            duration = stun_duration
        })

        victim:AddNewModifier(parent, ability, "modifier_item_havoc_slowed", {
            duration = slow_duration+stun_duration
        })

        self:PlayEffects(parent)
    end
end

function modifier_item_havoc:PlayEffects(target)
    -- Get Resources
    local particle_cast = "particles/items5_fx/havoc_hammer.vpcf"
    local sound_cast = "DOTA_Item.HavocHammer.Cast"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        0,
        target,
        PATTACH_ABSORIGIN_FOLLOW,
        "attach_hitloc",
        target:GetAbsOrigin(), -- unknown
        true -- unknown, true
    )
    ParticleManager:SetParticleControl( effect_cast, 0, target:GetAbsOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    -- Create Sound
    EmitSoundOn( sound_cast, target )
end
---
function modifier_item_havoc_stunned:CheckState()
    return {
        [MODIFIER_STATE_STUNNED] = true
    }
end

function modifier_item_havoc_stunned:GetTexture()
    return "havoc"
end
------------
function modifier_item_havoc_slowed:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE 
    }
end

function modifier_item_havoc_slowed:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_item_havoc_slowed:GetTexture()
    return "havoc"
end