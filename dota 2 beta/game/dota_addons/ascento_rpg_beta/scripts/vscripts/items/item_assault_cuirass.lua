item_assault_cuirass_custom = class({
	GetIntrinsicModifierName = function()
		return "modifier_item_assault_cuirass_custom"
	end,
	GetCastRange = function(self)
		return self:GetSpecialValueFor("aura_radius")
	end
})

item_assault_cuirass_custom2 = class(item_assault_cuirass_custom)
item_assault_cuirass_custom3 = class(item_assault_cuirass_custom)
item_assault_cuirass_custom4 = class(item_assault_cuirass_custom)
item_assault_cuirass_custom5 = class(item_assault_cuirass_custom)
item_assault_cuirass_custom6 = class(item_assault_cuirass_custom)
item_assault_cuirass_custom7 = class(item_assault_cuirass_custom)
item_assault_cuirass_custom8 = class(item_assault_cuirass_custom)

modifier_item_assault_cuirass_custom = class({
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
	IsDebuff = function()
		return false
	end,
    DeclareFunctions = function()
        return {
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
        }
    end,
    GetModifierAttackSpeedBonus_Constant = function(self)
        return self.bonusAttackSpeed
    end,
    GetModifierPhysicalArmorBonus = function(self)
        return self.bonusArmor
    end,
	GetAttributes = function()
		return MODIFIER_ATTRIBUTE_MULTIPLE
	end
})

function modifier_item_assault_cuirass_custom:OnCreated()
	self.parent = self:GetParent()
	self:OnRefresh()
end

function modifier_item_assault_cuirass_custom:OnRefresh()
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.bonusArmor = self.ability:GetSpecialValueFor("bonus_armor")
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("bonus_attack_speed")
	if(not IsServer()) then
		return
	end
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_assault_cuirass_custom_aura", {duration = -1})
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_assault_cuirass_custom_aura_enemy", {duration = -1})
end

function modifier_item_assault_cuirass_custom:OnDestroy()
	if(not IsServer()) then
		return
	end
	if(self.parent:HasModifier(self:GetName())) then
		return
	end
	self.parent:RemoveModifierByName("modifier_item_assault_cuirass_custom_aura")
	self.parent:RemoveModifierByName("modifier_item_assault_cuirass_custom_aura_enemy")
end

modifier_item_assault_cuirass_custom_aura = class({
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
	IsDebuff = function()
		return false
	end,
    IsAura = function() 
        return true 
    end,
    GetAuraRadius = function(self) 
        return self.radius
    end,
    GetAuraSearchTeam = function(self) 
        return DOTA_UNIT_TARGET_TEAM_FRIENDLY
    end,
    GetAuraSearchType = function(self) 
        return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING
    end,
    GetAuraSearchFlags = function(self)
        return DOTA_UNIT_TARGET_FLAG_NONE
    end,
    GetModifierAura = function() 
        return "modifier_item_assault_cuirass_custom_aura_buff" 
    end,
	GetAuraDuration = function()
		return 0
	end
})

function modifier_item_assault_cuirass_custom_aura:OnCreated()
	self.parent = self:GetParent()
	self:OnRefresh()
end

function modifier_item_assault_cuirass_custom_aura:OnRefresh()
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.bonusArmor = self.ability:GetSpecialValueFor("bonus_armor")
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("bonus_attack_speed")
	self.radius = self.ability:GetCastRange()
end

modifier_item_assault_cuirass_custom_aura_buff = class({
    IsHidden = function()
        return false
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
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
        }
    end,
    GetModifierAttackSpeedBonus_Constant = function(self)
        return self.bonusAttackSpeed
    end,
    GetModifierPhysicalArmorBonus = function(self)
        return self.bonusArmor
    end
})

function modifier_item_assault_cuirass_custom_aura_buff:OnCreated()
	self:OnRefresh()
end

function modifier_item_assault_cuirass_custom_aura_buff:OnRefresh()
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
		self:Destroy()
        return
    end
    self.bonusArmor = self.ability:GetSpecialValueFor("aura_positive_armor")
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("aura_attack_speed")
end

modifier_item_assault_cuirass_custom_aura_enemy = class({
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
	IsDebuff = function()
		return false
	end,
    IsAura = function() 
        return true 
    end,
    GetAuraRadius = function(self) 
        return self.radius
    end,
    GetAuraSearchTeam = function(self) 
        return DOTA_UNIT_TARGET_TEAM_ENEMY
    end,
    GetAuraSearchType = function(self) 
        return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING
    end,
    GetAuraSearchFlags = function(self)
        return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
    end,
    GetModifierAura = function() 
        return "modifier_item_assault_cuirass_custom_aura_enemy_debuff" 
    end,
	GetAuraDuration = function()
		return 0
	end
})

function modifier_item_assault_cuirass_custom_aura_enemy:OnCreated()
	self:OnRefresh()
end

function modifier_item_assault_cuirass_custom_aura_enemy:OnRefresh()
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
        return
    end
	self.radius = self.ability:GetCastRange()
end

modifier_item_assault_cuirass_custom_aura_enemy_debuff = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
	IsDebuff = function()
		return true
	end,
    DeclareFunctions = function()
        return {
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
        }
    end,
    GetModifierPhysicalArmorBonus = function(self)
        return self.bonusArmor
    end
})

function modifier_item_assault_cuirass_custom_aura_enemy_debuff:OnCreated()
	self:OnRefresh()
end

function modifier_item_assault_cuirass_custom_aura_enemy_debuff:OnRefresh()
    self.ability = self:GetAbility()
    if(not self.ability or self.ability:IsNull()) then
		self:Destroy()
        return
    end
    self.bonusArmor = self.ability:GetSpecialValueFor("aura_negative_armor")
end

LinkLuaModifier("modifier_item_assault_cuirass_custom", "items/item_assault_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_assault_cuirass_custom_aura", "items/item_assault_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_assault_cuirass_custom_aura_buff", "items/item_assault_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_assault_cuirass_custom_aura_enemy", "items/item_assault_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_assault_cuirass_custom_aura_enemy_debuff", "items/item_assault_cuirass", LUA_MODIFIER_MOTION_NONE)