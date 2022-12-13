--------------------------------------------------------------------------------
modifier_fighter_poison = class({})
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
function modifier_fighter_poison:IsHidden()
	return false
end

function modifier_fighter_poison:IsDebuff()
	return true
end

function modifier_fighter_poison:IsPurgable()
	return self.isPurgable
end

-- Optional Classifications
function modifier_fighter_poison:IsStunDebuff()
	return false
end

function modifier_fighter_poison:RemoveOnDeath()
	return true
end

function modifier_fighter_poison:DestroyOnExpire()
	return true
end

function modifier_fighter_poison:AllowIllusionDuplicate()
	return false
end

function modifier_fighter_poison:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fighter_poison:OnCreated( kv )

	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- get data
	self.DealDamage = kv.dps or 0
	self.dps = self.DealDamage * self:GetParent():GetHealth()
	self.isPurgable = kv.isPurgable==1

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self:GetCaster():FindAbilityByName("fighter_3_rupture"), --Optional.
	}

	-- Start interval
	self:StartIntervalThink( 5 )
	self:OnIntervalThink()
end

function modifier_fighter_poison:OnIntervalThink()
	-- apply damage
	self.damageTable.damage = self.DealDamage * self:GetParent():GetHealth() or 0
	ApplyDamage( self.damageTable )

end

function modifier_fighter_poison:OnRefresh( kv )
	self:OnCreated(kv)
end

function modifier_fighter_poison:OnRemoved()
end

function modifier_fighter_poison:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_fighter_poison:AddCustomTransmitterData()
	-- on server
	local data = {
		dps = self.dps,
	}

	return data
end

function modifier_fighter_poison:HandleCustomTransmitterData( data )
	-- on client
	self.dps = data.dps
end


function modifier_fighter_poison:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_poison_debuff.vpcf"
end

function modifier_fighter_poison:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_fighter_poison:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_dazzle_copy.vpcf"
end