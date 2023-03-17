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
function cultist_2_magic_health:OnToggle(  )
    -- unit identifier
    local caster = self:GetCaster()

    -- load data
    local toggle = self:GetToggleState()

    if toggle then
        -- add modifier
        self.modifier = caster:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_cultist_2_magic_health", -- modifier name
            {  } -- kv
        )
    else
        if self.modifier and not self.modifier:IsNull() then
            self.modifier:Destroy()
        end
        self.modifier = nil
    end
end

function modifier_cultist_2_magic_health:OnCreated( kv )
    -- references
    self.hp_lose = self:GetAbility():GetSpecialValueFor( "hp_lose" ) / 100 -- special value

    self.giveMANA = self:GetCaster():GetIntellect() * self:GetAbility():GetLevelSpecialValueFor("extra_mana", self:GetAbility():GetLevel() - 1)
    self.giveHP = self:GetCaster():GetMaxMana() * self:GetAbility():GetLevelSpecialValueFor("hp_from_mana", self:GetAbility():GetLevel() - 1) / 100

    if self:GetCaster():HasModifier("modifier_cultist_3_undead") then
        self.hp_lose = self.hp_lose * 2
        self.giveMANA = self.giveMANA * 2
        self.giveHP = self.giveHP * 2
    end

    self:StartIntervalThink( 1 )
    self:OnIntervalThink()
end



function modifier_cultist_2_magic_health:OnIntervalThink()
    if not IsServer() then return end
    --if self:GetParent() ~= self:GetCaster() then return end

    self.hp_lose = self:GetAbility():GetSpecialValueFor( "hp_lose" ) / 100 -- special value
    self.giveMANA = self:GetCaster():GetIntellect() * self:GetAbility():GetLevelSpecialValueFor("extra_mana", self:GetAbility():GetLevel() - 1)
    self.giveHP = self:GetCaster():GetMaxMana() * self:GetAbility():GetLevelSpecialValueFor("hp_from_mana", self:GetAbility():GetLevel() - 1) / 100

    if self:GetCaster():HasModifier("modifier_cultist_3_undead") then
        self.hp_lose = self.hp_lose * 2
        self.giveMANA = self.giveMANA * 2
        self.giveHP = self.giveHP * 2
    end
    

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
    return self.giveHP
end


function modifier_cultist_2_magic_health:GetModifierManaBonus()
    return self.giveMANA
end
