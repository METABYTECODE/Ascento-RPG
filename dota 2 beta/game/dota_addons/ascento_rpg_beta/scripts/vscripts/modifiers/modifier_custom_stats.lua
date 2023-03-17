modifier_custom_stats = class({
    IsHidden = function()
        return true
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
    RemoveOnDeath = function()
        return false
    end,
    DeclareFunctions = function()
        return {
            MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
            MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
            MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
            MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
			MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
			MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT
        }
    end
})

function modifier_custom_stats:OnCreated()
    self.parent = self:GetParent()
    self.bonusSpellAmpPerAttribute = self.bonusSpellAmpPerAttribute or 0
    self.bonusMagicalResistancePerAttribute = self.bonusMagicalResistancePerAttribute or 0
    self.bonusMoveSpeedPerAttribute = self.bonusMoveSpeedPerAttribute or 0
    self.bonusStrengthPctValue = self.bonusStrengthPctValue or 0
    self.bonusAgilityPctValue = self.bonusAgilityPctValue or 0
    self.bonusIntellectPctValue = self.bonusIntellectPctValue or 0
    self.bonusArmorPctValue = self.bonusArmorPctValue or 0
    self._ignoreThisBATBonus = true
    self.bonusBat = self.bonusBat or self.parent:GetBaseAttackTime()
    self._ignoreThisBATBonus = nil

    self.isHero = self.parent:IsHero()
    if(not IsServer()) then
        return
    end
    self.bonusSpellAmpPerAttribute = GameSettings:GetSettingValueAsNumber("dota_attribute_spell_ampification_per_intelligence")
    self.bonusMagicalResistancePerAttribute = GameSettings:GetSettingValueAsNumber("dota_attribute_magic_resistance_per_strength")
    self.bonusMoveSpeedPerAttribute = GameSettings:GetSettingValueAsNumber("dota_attribute_move_speed_per_agility")
    self:SetHasCustomTransmitterData(true)
    self._isFirstTick = true
    self:StartIntervalThink(0.05)
end

function modifier_custom_stats:OnRefresh()
    if(not IsServer()) then
        return
    end
    self:OnIntervalThink()
end

function modifier_custom_stats:OnIntervalThink()
    local precision = 0.01
    local propertiesRequireUpdate = 0
    local propertiesAmount = 2
    local propertiesWithoutValue = 0

    if(self.isHero == true) then
        propertiesAmount = propertiesAmount + 3
    end

    local modifiers = self.parent:FindAllModifiers()

    local customProperiesPropertiesRequireUpdate, customProperiesPropertiesWithoutValue = self:CalculateCustomStats(modifiers, precision)
    propertiesRequireUpdate = propertiesRequireUpdate + customProperiesPropertiesRequireUpdate
    propertiesWithoutValue = propertiesWithoutValue + customProperiesPropertiesWithoutValue

    local heroOnlyPropertiesRequireUpdate, heroOnlyPropertiesWithoutValue = self:CalculateHeroOnlyCustomStats(modifiers, precision)
    propertiesRequireUpdate = propertiesRequireUpdate + heroOnlyPropertiesRequireUpdate
    propertiesWithoutValue = propertiesWithoutValue + heroOnlyPropertiesWithoutValue

    if(propertiesWithoutValue == propertiesAmount and self.isHero == false) then
        self:Destroy()
        return
    end

    if(self._isFirstTick or propertiesRequireUpdate > 0) then
        self:SendBuffRefreshToClients()
    end

    if(self._isFirstTick) then
        self:StartIntervalThink(1)
        self._isFirstTick = nil
    end
end

function modifier_custom_stats:CalculateCustomStats(modifiers, precision)
    local propertiesRequireUpdate = 0
    local propertiesWithoutValue = 0
    local status, result = false, 0

    -- Armor %
    local bonusArmorPercent = 0
    for _, modifier in pairs(modifiers) do
        if(modifier.GetModifierPhysicalArmorTotal_Percentage) then
            status, result = xpcall(modifier.GetModifierPhysicalArmorTotal_Percentage, Debug_PrintError, modifier)
            if(status == true) then
                bonusArmorPercent = bonusArmorPercent + (tonumber(result or 0) or 0)
            end
        end
    end
    local armorWithoutBonus = self.parent:GetPhysicalArmorValue(false) - self.bonusArmorPctValue
    local newBonusArmorPctValue = self:RountToInteger(armorWithoutBonus * (bonusArmorPercent / 100))
    if(math.abs(newBonusArmorPctValue - self.bonusArmorPctValue) > precision) then
        propertiesRequireUpdate = propertiesRequireUpdate + 1
    end
    if(math.abs(newBonusArmorPctValue - 0) < precision) then
        propertiesWithoutValue = propertiesWithoutValue + 1
    end
    self.bonusArmorPctValue = newBonusArmorPctValue

    -- BAT stacking (count as one)
    self._ignoreThisBATBonus = true
    local batValue = self.parent:GetBaseAttackTime()
    self._ignoreThisBATBonus = nil
    local batBonusConstant = 0
    local batBonusPercent = 1
    for _, modifier in pairs(modifiers) do
        if(modifier.GetModifierConstantBaseAttackTime) then
            status, result = xpcall(modifier.GetModifierConstantBaseAttackTime, Debug_PrintError, modifier)
            result = tonumber(result)
            if(status == true and result ~= nil) then
                if(result < batValue) then
                    batValue = result
                end
            end
        end
        if(modifier.GetModifierBonusBaseAttackTimeConstant) then
            status, result = xpcall(modifier.GetModifierBonusBaseAttackTimeConstant, Debug_PrintError, modifier)
            if(status == true) then
                batBonusConstant = batBonusConstant + (tonumber(result or 0) or 0)
            end
        end
        if(modifier.GetModifierBonusBaseAttackTimePercentage) then
            status, result = xpcall(modifier.GetModifierBonusBaseAttackTimePercentage, Debug_PrintError, modifier)
            if(status == true) then
                batBonusPercent = batBonusPercent + ((tonumber(result or 0) or 0) / 100)
            end
        end
    end
    batValue = (batValue + batBonusConstant) * batBonusPercent
    if(math.abs(batValue - self.bonusBat) > precision) then
        propertiesRequireUpdate = propertiesRequireUpdate + 1
    end
    if(math.abs(batValue - 0) < precision) then
        propertiesWithoutValue = propertiesWithoutValue - 1
    end
    self.bonusBat = batValue

    return propertiesRequireUpdate, propertiesWithoutValue
end

function modifier_custom_stats:CalculateHeroOnlyCustomStats(modifiers, precision)
    local propertiesRequireUpdate = 0
    local propertiesWithoutValue = 0

    if(self.isHero == false) then
        return propertiesRequireUpdate, propertiesWithoutValue
    end

    local status, result = false, 0

    -- Strength %
    local bonusStrengthPercent = 0
    for _, modifier in pairs(modifiers) do
        if(modifier.GetModifierBonusStats_Strength_Percentage) then
            status, result = xpcall(modifier.GetModifierBonusStats_Strength_Percentage, Debug_PrintError, modifier)
            if(status == true) then
                bonusStrengthPercent = bonusStrengthPercent + (tonumber(result or 0) or 0)
            end
        end
    end
    local heroStrength = self.parent:GetStrength() - self.bonusStrengthPctValue
    local newBonusStrengthPctValue = self:RountToInteger(heroStrength * (bonusStrengthPercent / 100))
    if(math.abs(newBonusStrengthPctValue - self.bonusStrengthPctValue) > precision) then
        propertiesRequireUpdate = propertiesRequireUpdate + 1
    end
    if(math.abs(newBonusStrengthPctValue - 0) < precision) then
        propertiesWithoutValue = propertiesWithoutValue + 1
    end
    self.bonusStrengthPctValue = newBonusStrengthPctValue

    -- Agility %
    local bonusAgilityPercent = 0
    for _, modifier in pairs(modifiers) do
        if(modifier.GetModifierBonusStats_Agility_Percentage) then
            status, result = xpcall(modifier.GetModifierBonusStats_Agility_Percentage, Debug_PrintError, modifier)
            if(status == true) then
                bonusAgilityPercent = bonusAgilityPercent + (tonumber(result or 0) or 0)
            end
        end
    end
    local heroAgiltiy = self.parent:GetAgility() - self.bonusAgilityPctValue
    local newBonusAgilityPctValue = self:RountToInteger(heroAgiltiy * (bonusAgilityPercent / 100))
    if(math.abs(newBonusAgilityPctValue - self.bonusAgilityPctValue) > precision) then
        propertiesRequireUpdate = propertiesRequireUpdate + 1
    end
    if(math.abs(newBonusAgilityPctValue - 0) < precision) then
        propertiesWithoutValue = propertiesWithoutValue + 1
    end
    self.bonusAgilityPctValue = newBonusAgilityPctValue

    -- Intellect %
    local bonusIntellectPercent = 0
    for _, modifier in pairs(modifiers) do
        if(modifier.GetModifierBonusStats_Intellect_Percentage) then
            status, result = xpcall(modifier.GetModifierBonusStats_Intellect_Percentage, Debug_PrintError, modifier)
            if(status == true) then
                bonusIntellectPercent = bonusIntellectPercent + (tonumber(result or 0) or 0)
            end
        end
    end
    local heroIntellect = self.parent:GetIntellect() - self.bonusIntellectPctValue
    local newBonusIntellectPctValue = self:RountToInteger(heroIntellect * (bonusIntellectPercent / 100))
    if(math.abs(newBonusIntellectPctValue - self.bonusIntellectPctValue) > precision) then
        propertiesRequireUpdate = propertiesRequireUpdate + 1
    end
    if(math.abs(newBonusIntellectPctValue - 0) < precision) then
        propertiesWithoutValue = propertiesWithoutValue + 1
    end
    self.bonusIntellectPctValue = newBonusIntellectPctValue

    return propertiesRequireUpdate, propertiesWithoutValue
end

function modifier_custom_stats:RountToInteger(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function modifier_custom_stats:AddCustomTransmitterData()
    local dataToSend = {
        bonusStrengthPctValue = self.bonusStrengthPctValue,
        bonusAgilityPctValue = self.bonusAgilityPctValue,
        bonusIntellectPctValue = self.bonusIntellectPctValue,
        bonusArmorPctValue = self.bonusArmorPctValue,
        bonusBat = self.bonusBat
	}
    if(self.isHero == true) then
		dataToSend.bonusSpellAmpPerAttribute = self.bonusSpellAmpPerAttribute
		dataToSend.bonusMagicalResistancePerAttribute = self.bonusMagicalResistancePerAttribute
		dataToSend.bonusMoveSpeedPerAttribute = self.bonusMoveSpeedPerAttribute
    end
    return dataToSend
end

function modifier_custom_stats:HandleCustomTransmitterData(data)
    for k,v in pairs(data) do
        self[k] = v
    end
end

function modifier_custom_stats:GetModifierSpellAmplify_Percentage()
    if(self.isHero == false) then
        return 0
    end
    return self.parent:GetIntellect() * self.bonusSpellAmpPerAttribute
end

function modifier_custom_stats:GetModifierMagicalResistanceBonus()
    if(self.isHero == false) then
        return 0
    end
    return self.parent:GetStrength() * self.bonusMagicalResistancePerAttribute
end

function modifier_custom_stats:GetModifierMoveSpeedBonus_Constant()
    if(self.isHero == false) then
        return 0
    end
    return self.parent:GetAgility() * self.bonusMoveSpeedPerAttribute
end

function modifier_custom_stats:GetModifierIgnoreMovespeedLimit()
    if(self.isHero == false) then
        return 0
    end
    return 1
end

function modifier_custom_stats:GetModifierBaseAttackTimeConstant()
    if(self._ignoreThisBATBonus) then
        return nil
    end
    return self.bonusBat
end

function modifier_custom_stats:GetModifierBonusStats_Strength()
    return self.bonusStrengthPctValue
end

function modifier_custom_stats:GetModifierBonusStats_Agility()
    return self.bonusAgilityPctValue
end

function modifier_custom_stats:GetModifierBonusStats_Intellect()
    return self.bonusIntellectPctValue
end

function modifier_custom_stats:GetModifierPhysicalArmorBonus()
    return self.bonusArmorPctValue
end

LinkLuaModifier("modifier_custom_stats", "modifiers/modifier_custom_stats", LUA_MODIFIER_MOTION_NONE)

function _IsModifierHasCustomStats(modifier)
    if(modifier.GetModifierBonusStats_Strength_Percentage
    or modifier.GetModifierBonusStats_Agility_Percentage
    or modifier.GetModifierBonusStats_Intellect_Percentage
    or modifier.GetModifierConstantBaseAttackTime
    or modifier.GetModifierBonusBaseAttackTimeConstant
    or modifier.GetModifierBonusBaseAttackTimePercentage
    or modifier.GetModifierPhysicalArmorTotal_Percentage) then
        return true
    end
    return false
end

function _RefreshCustomStatsForUnit(unit, checkModifierExistance)
    if(type(unit) ~= "table" or unit.GetUnitName == nil) then
        return
    end
    if(checkModifierExistance == nil) then
        checkModifierExistance = true
    end
    local customStatsModifier = unit:GetCustomStatsModifier()
    if(checkModifierExistance == true and customStatsModifier == nil) then
        return
    end
    if(unit:IsCustomStatsModifierJustAdded() == true) then
        return
    end
    unit:SetIsCustomStatsModifierJustAdded(true)
    customStatsModifier = unit:AddCustomStatsModifier()
    if(customStatsModifier and customStatsModifier:IsNull() == false) then
        customStatsModifier:ForceRefresh()
    end
    unit:SetIsCustomStatsModifierJustAdded(false)
end

function _OnCustomStatsRefreshRequired(modifier)
    if(not modifier or modifier:IsNull() == true) then
        return
    end
    if(modifier:GetName() == "modifier_custom_stats") then
        return
    end
    if(_IsModifierHasCustomStats(modifier) == false) then
        return
    end
    local parent = modifier:GetParent()
    _RefreshCustomStatsForUnit(parent, false)
end

if(IsServer() and not _G._modifierCustomStatsInit) then
    CustomEvents:RegisterEventHandler(CUSTOM_EVENT_ON_MODIFIER_ADDED, function(kv)
        _OnCustomStatsRefreshRequired(kv.modifier)
    end)
    CustomEvents:RegisterEventHandler(CUSTOM_EVENT_ON_MODIFIER_DESTROYED, function(kv)
        _OnCustomStatsRefreshRequired(kv.modifier)
    end)
    CustomEvents:RegisterEventHandler(CUSTOM_EVENT_ON_MODIFIER_REFRESHED, function(kv)
        _OnCustomStatsRefreshRequired(kv.modifier)
    end)
    CustomEvents:RegisterEventHandler(CUSTOM_EVENT_ON_MODIFIER_STACKS_COUNT_CHANGED, function(kv)
        _OnCustomStatsRefreshRequired(kv.modifier)
    end)
    _G._modifierCustomStatsInit = true
end