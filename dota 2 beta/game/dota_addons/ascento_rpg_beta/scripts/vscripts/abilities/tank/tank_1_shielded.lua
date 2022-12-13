LinkLuaModifier("modifier_tank_1_shielded", "abilities/tank/tank_1_shielded.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

local ModifierBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return true end,
    IsHidden = function(self) return false end,
    IsStackable = function(self) return false end,
}

tank_1_shielded = class(ItemBaseClass)
modifier_tank_1_shielded = class(ModifierBaseClass)
-------------

function tank_1_shielded:OnSpellStart()
    local caster = self:GetCaster()

    caster:AddNewModifier(caster, self, "modifier_tank_1_shielded", {duration=self:GetSpecialValueFor("duration")})
end

function modifier_tank_1_shielded:GetTexture() return "tank_1_shielded" end

---
function modifier_tank_1_shielded:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
    }

    return funcs
end

function modifier_tank_1_shielded:OnCreated()
    local caster = self:GetCaster()
    local parent = self:GetParent()
    if caster == parent then
        self.attack_speed = (parent:GetBaseAttackTime() * (1+(self:GetAbility():GetLevelSpecialValueFor("slow_attack_speed_pct", (self:GetAbility():GetLevel() - 1)) / 100)))

    end
end

function modifier_tank_1_shielded:GetModifierBaseAttackTimeConstant()
    return self.attack_speed
end