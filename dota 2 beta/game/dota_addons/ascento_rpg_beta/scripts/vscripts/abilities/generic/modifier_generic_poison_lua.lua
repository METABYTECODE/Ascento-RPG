--------------------------------------------------------------------------------
modifier_generic_poison_lua = class({})
--[[
KV (default):
	isPurgable (1)
	interval (1)
	duration (0)
	as_slow (0), flat, positive means slower
	ms_slow (0), percentage, positive means slower
	dps (0), damage per second, not per interval
]]

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_poison_lua:IsHidden()
	return false
end

function modifier_generic_poison_lua:IsDebuff()
	return true
end

function modifier_generic_poison_lua:IsPurgable()
	return self.isPurgable
end

-- Optional Classifications
function modifier_generic_poison_lua:IsStunDebuff()
	return false
end

function modifier_generic_poison_lua:RemoveOnDeath()
	return true
end

function modifier_generic_poison_lua:DestroyOnExpire()
	return true
end

function modifier_generic_poison_lua:AllowIllusionDuplicate()
	return false
end

function modifier_generic_poison_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_poison_lua:OnCreated( kv )

	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- get data
	local as_slow = kv.as_slow or 0
	self.ms_slow = kv.ms_slow or 0
	self.less_damage = kv.less_damage or 0
	self.interval = kv.interval or 1
	self.dps = kv.dps or 0
	self.isPurgable = kv.isPurgable==1

	as_slow = as_slow / 100

	local heroBaseAttackTime = self:GetParent():GetBaseAttackTime()


	as_slow = heroBaseAttackTime * (1 + as_slow)

	-- calculate status resistance
	local resist = 1-self:GetParent():GetStatusResistance()

	-- set slow value
	as_slow = as_slow*resist
	self.ms_slow = self.ms_slow*resist

	self.as_slow = as_slow

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self, --Optional.
	}

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_generic_poison_lua:OnIntervalThink()
	-- apply damage
	ApplyDamage( self.damageTable )

	-- Play effects
	local sound_cast = "Hero_Dazzle.Poison_Tick"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_generic_poison_lua:OnRefresh( kv )
	self:OnCreated(kv)
end

function modifier_generic_poison_lua:OnRemoved()
end

function modifier_generic_poison_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_generic_poison_lua:AddCustomTransmitterData()
	-- on server
	local data = {
		as_slow = self.as_slow,
		ms_slow = self.ms_slow,
		less_damage = self.less_damage,
		interval = self.interval,
		dps = self.dps,
	}

	return data
end

function modifier_generic_poison_lua:HandleCustomTransmitterData( data )
	-- on client
	self.as_slow = data.as_slow
	self.ms_slow = data.ms_slow
	self.less_damage = data.less_damage
	self.interval = data.interval
	self.dps = data.dps
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_poison_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_generic_poison_lua:GetModifierBaseAttackTimeConstant()
	return self.as_slow
end

function modifier_generic_poison_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end

function modifier_generic_poison_lua:GetModifierBaseDamageOutgoing_Percentage()
	return -self.less_damage
end



function modifier_generic_poison_lua:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_poison_debuff.vpcf"
end

function modifier_generic_poison_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_generic_poison_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_dazzle_copy.vpcf"
end