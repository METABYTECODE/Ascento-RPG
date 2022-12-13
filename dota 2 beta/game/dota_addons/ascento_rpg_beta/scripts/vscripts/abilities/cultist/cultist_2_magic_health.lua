LinkLuaModifier("modifier_cultist_2_magic_health", "abilities/cultist/cultist_2_magic_health.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
    IsPurgeException = function(self) return false end,

}

cultist_2_magic_health = class(ItemBaseClass)
modifier_cultist_2_magic_health = class(ItemBaseClass)
-------------
function cultist_2_magic_health:GetIntrinsicModifierName()
    return "modifier_cultist_2_magic_health"
end

function modifier_cultist_2_magic_health:OnCreated( kv )
    -- references
    self.hp_lose = self:GetAbility():GetSpecialValueFor( "hp_lose" ) / 100 -- special value

    self.giveMANA = self:GetCaster():GetIntellect() * self:GetAbility():GetLevelSpecialValueFor("extra_mana", self:GetAbility():GetLevel() - 1)
    self.giveHP = self:GetCaster():GetMaxMana() * self:GetAbility():GetLevelSpecialValueFor("hp_from_mana", self:GetAbility():GetLevel() - 1) / 100

    self:StartIntervalThink( 1 )
    self:OnIntervalThink()
end



function modifier_cultist_2_magic_health:OnIntervalThink()
    if not IsServer() then return end
    --if self:GetParent() ~= self:GetCaster() then return end

    self.hp_lose = self:GetAbility():GetSpecialValueFor( "hp_lose" ) / 100 -- special value
    self.giveMANA = self:GetCaster():GetIntellect() * self:GetAbility():GetLevelSpecialValueFor("extra_mana", self:GetAbility():GetLevel() - 1)
    self.giveHP = self:GetCaster():GetMaxMana() * self:GetAbility():GetLevelSpecialValueFor("hp_from_mana", self:GetAbility():GetLevel() - 1) / 100


    

    local curHealth = self:GetCaster():GetHealth()

    local damage =  curHealth * self.hp_lose
    self:GetCaster():SetHealth(curHealth - damage)

    --self:GetCaster():CalculateStatBonus(true) 

end


function modifier_cultist_2_magic_health:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end


---
function modifier_cultist_2_magic_health:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MANA_BONUS,
    }

    return funcs
end


function modifier_cultist_2_magic_health:GetModifierHealthBonus()
    return self:GetCaster():GetMaxMana() * self:GetAbility():GetLevelSpecialValueFor("hp_from_mana", self:GetAbility():GetLevel() - 1) / 100 --self.giveHP
end


function modifier_cultist_2_magic_health:GetModifierManaBonus()
    return self:GetCaster():GetIntellect() * self:GetAbility():GetLevelSpecialValueFor("extra_mana", self:GetAbility():GetLevel() - 1) --self.giveMANA
end
