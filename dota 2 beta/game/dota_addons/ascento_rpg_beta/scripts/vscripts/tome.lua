

LinkLuaModifier("tome_consumed_str", "tome.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("tome_consumed_agi", "tome.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("tome_consumed_int", "tome.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return false end,
    IsStackable = function(self) return true end,
}

tome_consumed_str = class(ItemBaseClass)
tome_consumed_agi = class(ItemBaseClass)
tome_consumed_int = class(ItemBaseClass)

function tome_consumed_str:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function tome_consumed_str:GetTexture() return "tome_str" end
function tome_consumed_agi:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function tome_consumed_agi:GetTexture() return "tome_agi" end
function tome_consumed_int:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function tome_consumed_int:GetTexture() return "tome_int" end

---------------------------------------------
function tome_consumed_str:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS 
	}

	return funcs
end

function tome_consumed_str:OnCreated(params)
	self:SetHasCustomTransmitterData(true)

	if not IsServer() then return end

	self.statsToAdd = params.statsToAdd
	self.parentAttr = self:GetParent():GetPrimaryAttribute()

	self:InvokerBonusStats()
end

function tome_consumed_str:GetModifierBonusStats_Strength()
	if self.fParentAttr == DOTA_ATTRIBUTE_STRENGTH then return 0 end

	return self:GetStackCount()
end

function tome_consumed_str:OnStackCountChanged(stackCount)
	if not IsServer() then return end

	if self.fParentAttr ~= DOTA_ATTRIBUTE_STRENGTH then return end

	self:GetParent():ModifyStrength(self:GetStackCount() - stackCount)

	self.parentAttr = self:GetParent():GetPrimaryAttribute()

	self:InvokerBonusStats()
end

function tome_consumed_str:AddCustomTransmitterData()
    return
    {
        parentAttr = self.fParentAttr
    }
end

function tome_consumed_str:HandleCustomTransmitterData(data)
    if data.parentAttr ~= nil then
        self.fParentAttr = tonumber(data.parentAttr)
    end
end

function tome_consumed_str:InvokerBonusStats()
    if IsServer() == true then
        self.fParentAttr = self.parentAttr

        self:SendBuffRefreshToClients()
    end
end
---------------------------------------------
function tome_consumed_agi:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS  
	}

	return funcs
end

function tome_consumed_agi:OnCreated(params)
	self:SetHasCustomTransmitterData(true)

	if not IsServer() then return end

	self.statsToAdd = params.statsToAdd
	self.parentAttr = self:GetParent():GetPrimaryAttribute()

	self:InvokerBonusStats()
end

function tome_consumed_agi:GetModifierBonusStats_Agility()
	if self.fParentAttr == DOTA_ATTRIBUTE_AGILITY then return 0 end

	return self:GetStackCount()
end

function tome_consumed_agi:OnStackCountChanged(stackCount)
	if not IsServer() then return end

	if self.fParentAttr ~= DOTA_ATTRIBUTE_AGILITY then return end

	self:GetParent():ModifyAgility(self:GetStackCount() - stackCount)

	self.parentAttr = self:GetParent():GetPrimaryAttribute()

	self:InvokerBonusStats()
end

function tome_consumed_agi:AddCustomTransmitterData()
    return
    {
        parentAttr = self.fParentAttr
    }
end

function tome_consumed_agi:HandleCustomTransmitterData(data)
    if data.parentAttr ~= nil then
        self.fParentAttr = tonumber(data.parentAttr)
    end
end

function tome_consumed_agi:InvokerBonusStats()
    if IsServer() == true then
        self.fParentAttr = self.parentAttr

        self:SendBuffRefreshToClients()
    end
end
---------------------------------------------
function tome_consumed_int:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS   
	}

	return funcs
end

function tome_consumed_int:OnCreated(params)
	self:SetHasCustomTransmitterData(true)

	if not IsServer() then return end

	self.statsToAdd = params.statsToAdd
	self.parentAttr = self:GetParent():GetPrimaryAttribute()

	self:InvokerBonusStats()
end

function tome_consumed_int:GetModifierBonusStats_Intellect()
	if self.fParentAttr == DOTA_ATTRIBUTE_INTELLECT then return 0 end

	return self:GetStackCount()
end

function tome_consumed_int:OnStackCountChanged(stackCount)
	if not IsServer() then return end

	if self.fParentAttr ~= DOTA_ATTRIBUTE_INTELLECT then return end

	self:GetParent():ModifyIntellect(self:GetStackCount() - stackCount)

	self.parentAttr = self:GetParent():GetPrimaryAttribute()

	self:InvokerBonusStats()
end

function tome_consumed_int:AddCustomTransmitterData()
    return
    {
        parentAttr = self.fParentAttr
    }
end

function tome_consumed_int:HandleCustomTransmitterData(data)
    if data.parentAttr ~= nil then
        self.fParentAttr = tonumber(data.parentAttr)
    end
end

function tome_consumed_int:InvokerBonusStats()
    if IsServer() == true then
        self.fParentAttr = self.parentAttr

        self:SendBuffRefreshToClients()
    end
end
------------------------------------------------------

function UpgradeStats(keys)
	local caster = keys.caster
    local primaryAttribute = caster:GetPrimaryAttribute()
	local cost = keys.ability:GetCost() 
	local str = keys.Str
	local agi = keys.Agi
	local int = keys.Int

	if not caster or not caster:IsRealHero() then return end
	if caster:HasModifier("modifier_arc_warden_tempest_double") then return end

    if caster:HasModifier("modifier_chicken_ability_1_self_transmute") then
        local chickenMod = caster:FindModifierByName("modifier_chicken_ability_1_self_transmute")
        if chickenMod ~= nil then
            local newKeys = keys
            newKeys.caster = chickenMod:GetCaster()
            UpgradeStats(newKeys)
        end
    end

	if IsServer() then
		local limit = 1000000

        if str then
            local mod = caster:FindModifierByNameAndCaster("tome_consumed_str", caster)
            if mod ~= nil then
                if primaryAttribute == DOTA_ATTRIBUTE_STRENGTH then
                    if caster:GetBaseStrength()+str > limit or caster:GetBaseStrength() > limit then
                        mod:SetStackCount(limit)
                        str = 0
                    end
                else
                    if caster:GetStrength()+str > limit or caster:GetStrength() > limit then
                        mod:SetStackCount(limit)
                        str = 0
                    end
                end
            end
        end

        if agi then
            local mod = caster:FindModifierByNameAndCaster("tome_consumed_agi", caster)
            if mod ~= nil then
                if primaryAttribute == DOTA_ATTRIBUTE_AGILITY then
                    if caster:GetBaseAgility()+agi > limit or caster:GetBaseAgility() > limit then
                        mod:SetStackCount(limit)
                        agi = 0
                    end
                else
                    if caster:GetAgility()+agi > limit or caster:GetAgility() > limit then
                        mod:SetStackCount(limit)
                        agi = 0
                    end
                end
            end
        end

        if int then
            local mod = caster:FindModifierByNameAndCaster("tome_consumed_int", caster)
            if mod ~= nil then
                if primaryAttribute == DOTA_ATTRIBUTE_INTELLECT then
                    if caster:GetBaseIntellect()+int > limit or caster:GetBaseIntellect() > limit then
                        mod:SetStackCount(limit)
                        int = 0
                    end
                else
                    if caster:GetIntellect()+int > limit or caster:GetIntellect() > limit then
                        mod:SetStackCount(limit)
                        int = 0
                    end
                end
            end
        end
	end

    --DisplayError(caster:GetPlayerID(), "#max_stats") return

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
end



function MedicalTractat(keys)
	local caster = keys.caster
	if not caster then return end
	
	if not(caster.medical_tractates) then
		caster.medical_tractates = 0
	end
	local cost = keys.ability:GetCost() 
	_G.tPlayers[caster:GetPlayerOwnerID() ] = _G.tPlayers[caster:GetPlayerOwnerID() ] or {}
	_G.tPlayers[caster:GetPlayerOwnerID() ].books = _G.tPlayers[caster:GetPlayerOwnerID() ].books or 0
	_G.tPlayers[caster:GetPlayerOwnerID() ].books = _G.tPlayers[caster:GetPlayerOwnerID() ].books + cost

	caster.medical_tractates = caster.medical_tractates + 1
	
	caster:RemoveModifierByName("modifier_medical_tractate") 
	while (caster:HasModifier("modifier_medical_tractate")) do
		caster:RemoveModifierByName("modifier_medical_tractate") 
	end
	caster:AddNewModifier(caster, nil, "modifier_medical_tractate", null)

end
