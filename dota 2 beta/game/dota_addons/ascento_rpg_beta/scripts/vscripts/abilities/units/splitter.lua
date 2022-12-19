splitter = class({
	GetIntrinsicModifierName = function()
		return "modifier_splitter"
	end
})

modifier_splitter = class({
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
    DeclareFunctions = function()
        return {
		    MODIFIER_EVENT_ON_DEATH,
        }
    end
})

function modifier_splitter:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.count = self.ability:GetSpecialValueFor("count")
end

function modifier_splitter:OnDeath(kv)
    if kv.unit ~= self.parent then
        return
    end
    
    for i = 0, self.count, 1 do
        unit = CreateUnitByName(self.parent:GetUnitName(), self.parent:GetAbsOrigin() + RandomVector(RandomFloat(0, 100)), true, nil, nil, DOTA_TEAM_BADGUYS)
        unit.clone = true
    end;
end

LinkLuaModifier("modifier_splitter", "abilities/units/splitter", LUA_MODIFIER_MOTION_NONE)