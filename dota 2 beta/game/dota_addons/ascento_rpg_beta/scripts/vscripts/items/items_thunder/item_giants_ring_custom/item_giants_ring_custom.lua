LinkLuaModifier("modifier_giants_ring_custom_buff", "items/items_thunder/item_giants_ring_custom/item_giants_ring_custom.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

local ItemBaseClassBuff = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return false end,
    IsStackable = function(self) return false end,
    IsDebuff = function(self) return false end,
    IsPurgeException = function(self) return false end,
}

item_giants_ring_custom = class(ItemBaseClass)
item_giants_ring_custom_2 = item_giants_ring_custom
item_giants_ring_custom_3 = item_giants_ring_custom
item_giants_ring_custom_4 = item_giants_ring_custom
item_giants_ring_custom_5 = item_giants_ring_custom
item_giants_ring_custom_6 = item_giants_ring_custom
modifier_giants_ring_custom_buff = class(ItemBaseClassBuff)
-------------
function item_giants_ring_custom:GetIntrinsicModifierName()
    return "modifier_giants_ring_custom_buff"
end
-------------------
function modifier_giants_ring_custom_buff:CheckState()
    return {
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end

function modifier_giants_ring_custom_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_MODEL_SCALE 
    }

    return funcs
end

function modifier_giants_ring_custom_buff:OnCreated()
    if not IsServer() then return end

    local parent = self:GetParent()
    local ability = self:GetAbility()

    self.radius = ability:GetSpecialValueFor("damage_radius")

    self:StartIntervalThink(1)
end

function modifier_giants_ring_custom_buff:OnIntervalThink()
    local caster = self:GetParent()

    local victims = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil,
        self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_BASIC), DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_CLOSEST, false)

    for _,victim in ipairs(victims) do
        if not victim:IsAlive() then break end

        ApplyDamage({
            victim = victim,
            attacker = caster,
            damage = (caster:GetStrength() * (self:GetAbility():GetSpecialValueFor("pct_str_damage_per_second")/100)),
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self:GetAbility()
        })
    end

    self.vfx = ParticleManager:CreateParticle("particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(self.vfx, 0, caster:GetOrigin())
    ParticleManager:SetParticleControl(self.vfx, 1, Vector(self.radius*2, self.radius*2, self.radius*2))
    ParticleManager:ReleaseParticleIndex(self.vfx)
end

function modifier_giants_ring_custom_buff:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_giants_ring_custom_buff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_speed")
end

function modifier_giants_ring_custom_buff:GetModifierModelScale()
    return self:GetAbility():GetSpecialValueFor("model_scale")
end