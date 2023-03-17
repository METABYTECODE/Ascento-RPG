--------------------------------------------------------------------------------
modifier_generic_poison_lua_cultist = class({})
--[[
KV (default):
	isPurgable (1)
	interval (1)
	duration (0)
	dps (0), damage per second, not per interval
]]

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_poison_lua_cultist:IsHidden()
	return false
end

function modifier_generic_poison_lua_cultist:IsDebuff()
	return true
end

function modifier_generic_poison_lua_cultist:IsPurgable()
	return false
end

-- Optional Classifications
function modifier_generic_poison_lua_cultist:IsStunDebuff()
	return false
end

function modifier_generic_poison_lua_cultist:RemoveOnDeath()
	return true
end

function modifier_generic_poison_lua_cultist:DestroyOnExpire()
	return true
end

function modifier_generic_poison_lua_cultist:IsStackable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_poison_lua_cultist:OnCreated( kv )

	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- get data
	self.interval = kv.interval or 1
	self.dps = kv.dps or 0

	-- calculate status resistance
	local resist = 1-self:GetParent():GetStatusResistance()

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

function modifier_generic_poison_lua_cultist:OnIntervalThink()
	-- apply damage
	self.damageTable.damage = self.dps * (1+self:GetStackCount())
	print(self.damageTable.damage)
	ApplyDamage( self.damageTable )

	-- Play effects
	local sound_cast = "Hero_Dazzle.Poison_Tick"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_generic_poison_lua_cultist:OnRefresh( kv )
	self:OnCreated(kv)
end

function modifier_generic_poison_lua_cultist:OnRemoved()
end

function modifier_generic_poison_lua_cultist:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_generic_poison_lua_cultist:AddCustomTransmitterData()
	-- on server
	local data = {
		interval = self.interval,
		dps = self.dps,
	}

	return data
end

function modifier_generic_poison_lua_cultist:HandleCustomTransmitterData( data )
	-- on client
	self.interval = data.interval
	self.dps = data.dps
end


function modifier_generic_poison_lua_cultist:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_poison_debuff.vpcf"
end

function modifier_generic_poison_lua_cultist:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_generic_poison_lua_cultist:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_dazzle_copy.vpcf"
end