item_bow = class({
    GetIntrinsicModifierName = function()
        return "modifier_item_bow"
    end
})

function item_bow:OnProjectileHit(target, location)
    if(not target) then
        return
    end
    local attacker = self:GetCaster()
    ApplyDamage({
        victim = target,
        attacker = attacker,
        damage = attacker:GetAverageTrueAttackDamage(target) * self:GetSpecialValueFor("damage_percent") / 100,
        damage_type = self:GetAbilityDamageType(),
        damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
        ability = self
    })
end

item_bow2 = class(item_bow)
item_bow3 = class(item_bow)
item_bow4 = class(item_bow)
item_bow5 = class(item_bow)
item_bow6 = class(item_bow)
item_bow7 = class(item_bow)
item_bow8 = class(item_bow)

modifier_item_bow = class({
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
            MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
            MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
            MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
            MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE,
            MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
            MODIFIER_EVENT_ON_ATTACK_LANDED
        }
    end,
    GetModifierBonusStats_Intellect = function(self)
        return self.bonusInt
    end,
    GetModifierBonusStats_Agility = function(self)
        return self.bonusAgi
    end,
    GetModifierPreAttack_BonusDamage = function(self)
        return self.bonusAttackDamage
    end,
    GetModifierPhysicalArmorBonus = function(self)
        return self.bonusArmor
    end,
    GetModifierAttackSpeedBonus_Constant = function(self)
        return self.bonusAttackSpeed
    end,
    GetModifierConstantManaRegen = function(self)
        return self.bonusManaRegen
    end,
    GetModifierMoveSpeedBonus_Percentage_Unique = function(self)
        return self.bonusMovementSpeed
    end,
    GetModifierBonusStats_Strength = function(self)
        return self.bonusStr
    end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_MULTIPLE
    end
})

function modifier_item_bow:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.targetTeam = self.ability:GetAbilityTargetTeam()
	self.targetType = self.ability:GetAbilityTargetType()
	self.targetFlags = self.ability:GetAbilityTargetFlags()
    self.projectile = {
        EffectName = nil,
		Ability = self.ability,
		iMoveSpeed = nil,
		Source = self.parent,
		Target = nil,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
    }
end

function modifier_item_bow:OnRefresh()
    self.ability = self:GetAbility() or self.ability
    if(not self.ability or self.ability:IsNull()) then
        return
    end
    self.bonusInt = self.ability:GetSpecialValueFor("bonus_int")
    self.bonusAgi = self.ability:GetSpecialValueFor("bonus_agility")
    self.bonusAttackDamage = self.ability:GetSpecialValueFor("bonus_attack")
    self.bonusArmor = self.ability:GetSpecialValueFor("bonus_armor")
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("bonus_attackspeed")
    self.bonusManaRegen = self.ability:GetSpecialValueFor("bonus_manaregen")
    self.bonusMovementSpeed = self.ability:GetSpecialValueFor("bonus_speed")
    self.bonusStr = self.ability:GetSpecialValueFor("bonus_strength")
    self.splashRadius = self.ability:GetSpecialValueFor("radius")
end

function modifier_item_bow:OnAttackLanded(kv)
    if(kv.attacker ~= self.parent) then
        return
    end
    if(kv.attacker:IsIllusion()) then
        return
    end
    local teamNumber = self.parent:GetTeamNumber()
    if(UnitFilter(kv.target, self.targetTeam, self.targetType, self.targetFlags, teamNumber) ~= UF_SUCCESS) then
        return
    end
    local enemies = FindUnitsInRadius(
		teamNumber, 
		kv.target:GetAbsOrigin(), 
		nil, 
		self.splashRadius, 
		self.targetTeam,
		self.targetType,
		self.targetFlags,
		FIND_ANY_ORDER, 
		false
	)
    local isRanged = self.parent:GetAttackCapability() == DOTA_UNIT_CAP_RANGED_ATTACK
    if(isRanged) then
        self.projectile.iMoveSpeed = self.parent:GetProjectileSpeed()
        self.projectile.EffectName = self.parent:GetRangedProjectileName()
    end
    self.projectile.Source = kv.target
    for _, enemy in pairs(enemies) do
        if(enemy ~= kv.target) then
            if(isRanged) then
                self.projectile.Target = enemy
                ProjectileManager:CreateTrackingProjectile(self.projectile)
            else
                self.ability:OnProjectileHit(enemy, nil)
            end
        end
    end
end

LinkLuaModifier("modifier_item_bow", "items/item_bow", LUA_MODIFIER_MOTION_NONE)