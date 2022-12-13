LinkLuaModifier("modifier_assasin_2_darkness", "abilities/assasin/assasin_2_darkness.lua", LUA_MODIFIER_MOTION_NONE)

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

assasin_2_darkness = class(ItemBaseClass)
modifier_assasin_2_darkness = class(ModifierBaseClass)
-------------

function assasin_2_darkness:OnSpellStart()
    local caster = self:GetCaster()

    caster:AddNewModifier(caster, self, "modifier_assasin_2_darkness", {duration=self:GetSpecialValueFor("duration")})
end

function modifier_assasin_2_darkness:GetTexture() return "assasin_2_darkness" end

---
function modifier_assasin_2_darkness:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_EVASION_CONSTANT,
    }

    return funcs
end

function modifier_assasin_2_darkness:CheckState()
    local state = {
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
    }

    return state
end

function modifier_assasin_2_darkness:OnCreated()
    local caster = self:GetCaster()
    local parent = self:GetParent()
    if caster == parent then
        self.evasion = self:GetAbility():GetLevelSpecialValueFor("evasion", (self:GetAbility():GetLevel() - 1))
        self.magic_resistance = self:GetAbility():GetLevelSpecialValueFor("magic_resistance", (self:GetAbility():GetLevel() - 1))
    end
end

function modifier_assasin_2_darkness:GetModifierMagicalResistanceBonus()
    return self.magic_resistance
end

function modifier_assasin_2_darkness:GetModifierEvasion_Constant()
    return self.evasion
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_assasin_2_darkness:GetEffectName()
    return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end

function modifier_assasin_2_darkness:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end