

LinkLuaModifier("tome_consumed_str", "tome.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("tome_consumed_agi", "tome.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("tome_consumed_int", "tome.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("tome_consumed_primary", "tome.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return false end,
    IsStackable = function(self) return true end,
}

tome_consumed_str = class(ItemBaseClass)
tome_consumed_agi = class(ItemBaseClass)
tome_consumed_int = class(ItemBaseClass)
tome_consumed_primary = class(ItemBaseClass)

function tome_consumed_str:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function tome_consumed_str:GetTexture() return "tome_str" end
function tome_consumed_agi:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function tome_consumed_agi:GetTexture() return "tome_agi" end
function tome_consumed_int:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function tome_consumed_int:GetTexture() return "tome_int" end
function tome_consumed_primary:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function tome_consumed_primary:GetTexture() return "halloween_candy" end

---------------------------------------------
function tome_consumed_str:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS 
	}

	return funcs
end


function tome_consumed_str:GetModifierBonusStats_Strength()

	return self:GetStackCount()
end

---------------------------------------------
function tome_consumed_agi:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS  
	}

	return funcs
end


function tome_consumed_agi:GetModifierBonusStats_Agility()

	return self:GetStackCount()
end

---------------------------------------------
function tome_consumed_int:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS   
	}

	return funcs
end


function tome_consumed_int:GetModifierBonusStats_Intellect()

	return self:GetStackCount()
end



---------------------------------------------
function tome_consumed_primary:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,   
	}

	return funcs
end


function tome_consumed_primary:GetModifierBonusStats_Strength()
    local primary_attribute = self:GetParent():GetPrimaryAttribute()
    if primary_attribute == DOTA_ATTRIBUTE_STRENGTH then
        return self:GetStackCount()
    end
    return 0
end

function tome_consumed_primary:GetModifierBonusStats_Agility()
    local primary_attribute = self:GetParent():GetPrimaryAttribute()
    if primary_attribute == DOTA_ATTRIBUTE_AGILITY then
        return self:GetStackCount()
    end
    return 0
end

function tome_consumed_primary:GetModifierBonusStats_Intellect()
    local primary_attribute = self:GetParent():GetPrimaryAttribute()
    if primary_attribute == DOTA_ATTRIBUTE_INTELLECT then
        return self:GetStackCount()
    end
    return 0
end


------------------------------------------------------

function UpgradeStats(keys)
	local caster = keys.caster
	local cost = keys.ability:GetCost() 
	local str = keys.Str
	local agi = keys.Agi
	local int = keys.Int
	local primary = keys.Primary

	if not caster or not caster:IsRealHero() then return end
	if caster:HasModifier("modifier_arc_warden_tempest_double") then return end


	if str then
		if IsServer() then
			local mod = caster:FindModifierByNameAndCaster("tome_consumed_str", caster)
			if mod == nil then
				mod = caster:AddNewModifier(caster, nil, "tome_consumed_str", {
					statsToAdd = str
				})
			end
				mod:SetStackCount(mod:GetStackCount() + str)
			
		end
	end

	if agi then
		if IsServer() then
			local mod = caster:FindModifierByNameAndCaster("tome_consumed_agi", caster)
			if mod == nil then
				mod = caster:AddNewModifier(caster, nil, "tome_consumed_agi", {
					statsToAdd = agi
				})

			end
				mod:SetStackCount(mod:GetStackCount() + agi)
			
		end
	end

	if int then
		if IsServer() then
			local mod = caster:FindModifierByNameAndCaster("tome_consumed_int", caster)
			if mod == nil then
				mod = caster:AddNewModifier(caster, nil, "tome_consumed_int", {
					statsToAdd = int
				})
			
			end
				mod:SetStackCount(mod:GetStackCount() + int)
			
		end
	end

	if primary then
		if IsServer() then
			local mod = caster:FindModifierByNameAndCaster("tome_consumed_primary", caster)
			if mod == nil then
				mod = caster:AddNewModifier(caster, nil, "tome_consumed_primary", {
					statsToAdd = primary
				})
			
			end
				mod:SetStackCount(mod:GetStackCount() + primary)

			
		end
	end
	UTIL_Remove(self)
end
