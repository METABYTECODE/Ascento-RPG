LinkLuaModifier("modifier_assasin_1_hidden_blade", "abilities/assasin/assasin_1_hidden_blade.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

assasin_1_hidden_blade = class(ItemBaseClass)
modifier_assasin_1_hidden_blade = class(ItemBaseClass)
-------------
function assasin_1_hidden_blade:GetIntrinsicModifierName()
    return "modifier_assasin_1_hidden_blade"
end

function modifier_assasin_1_hidden_blade:OnCreated( kv )
    -- references
    self.double_attack_chance = self:GetAbility():GetSpecialValueFor( "double_attack_chance" )
end

function modifier_assasin_1_hidden_blade:OnRefresh( kv )
    -- references
    self.double_attack_chance = self:GetAbility():GetSpecialValueFor( "double_attack_chance" )
end

function modifier_assasin_1_hidden_blade:OnDestroy( kv )
end

function modifier_assasin_1_hidden_blade:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_assasin_1_hidden_blade:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK,
    }

    return funcs
end

function modifier_assasin_1_hidden_blade:OnAttack(event)
    if not IsServer() then return end

    local attacker = event.attacker
    local victim = event.target
    local ability = self:GetAbility()

    if not ability or ability == nil then return end

    if self:GetCaster() ~= attacker then
        return
    end

    if not attacker:IsRealHero() then return end


     if self:RollChance( self.double_attack_chance ) then

            attacker:PerformAttack(victim, true, true, true, false, true, false, true)
            ability:UseResources(false, false, true)

        end
end


--------------------------------------------------------------------------------
-- Helper
function modifier_assasin_1_hidden_blade:RollChance( chance )
    local rand = math.random()
    if rand<chance/100 then
        return true
    end
    return false
end
