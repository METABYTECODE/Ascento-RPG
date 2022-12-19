tombstoun_creep = class({})

function tombstoun_creep:OnSpellStart()
	local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local unit = CreateUnitByName("npc_scythe_of_vyse", point, true, caster, caster, caster:GetTeamNumber())
    unit:AddNewModifier(unit, self, "modifier_tombstoun_creep", { duration = -1 })
    unit:AddNewModifier(unit, self, "modifier_phased", { duration = 0.05 })
    unit:AddNewModifier(unit, self, "modifier_kill", { duration = self:GetSpecialValueFor("duration") })
end

modifier_tombstoun_creep = class({
	IsHidden = function()
        return true
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
	IsDebuff = function()
		return false
	end,
	GetAbsoluteNoDamagePhysical = function() 
        return 1
    end,
    GetAbsoluteNoDamageMagical = function() 
        return 1
    end,
    GetAbsoluteNoDamagePure = function() 
        return 1
    end,
	DeclareFunctions = function() 
		return 
		{
			MODIFIER_EVENT_ON_ATTACK_LANDED,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
            MODIFIER_PROPERTY_DISABLE_HEALING
		}
	end,
    CheckState = function()
        return {
            [MODIFIER_STATE_STUNNED] = true
        }
    end
})

function modifier_tombstoun_creep:OnCreated()
	self.parent = self:GetParent()
    self.caster = self:GetCaster()
    if(not IsServer()) then
        return
    end
    self.ability = self:GetAbility()
    self.healthPerAttack = self.ability:GetSpecialValueFor("health_per_attack")
    local spawnInterval = self.ability:GetSpecialValueFor("spawn_interval")
    local maxHealth = self.ability:GetSpecialValueFor("health")
    self.parent:SetBaseMaxHealth(maxHealth)
    self.parent:SetMaxHealth(maxHealth)
    self.parent:SetHealth(maxHealth)
    self.parent:CalculateGenericBonuses()
    self:StartIntervalThink(spawnInterval)
end

function modifier_tombstoun_creep:OnIntervalThink()
    local unit = CreateUnitByName("npc_scythe_of_vyse", self.parent:GetAbsOrigin() + RandomVector(RandomFloat(15, 50)), true, self.caster, self.caster, self.caster:GetTeamNumber())
    unit:AddNewModifier(unit, self, "modifier_phased", { duration = 0.05 })
end

function modifier_tombstoun_creep:OnAttackLanded(kv)
	if(kv.target ~= self.parent) then
		return
	end
    local healthPerAttack = self.healthPerAttack
    local newHealth = self.parent:GetHealth() - healthPerAttack
    if(newHealth < 1) then
        self.parent:Kill(kv.inflictor, kv.attacker)
    else
        self.parent:SetHealth(newHealth)
    end
end

function modifier_tombstoun_creep:OnDestroy()
    if(not IsServer()) then
        return
    end
    UTIL_Remove(self.parent)
end

LinkLuaModifier("modifier_tombstoun_creep", "abilities/units/tombstoun_creep", LUA_MODIFIER_MOTION_NONE)