support_2_dot_heal = class({})
modifier_support_2_dot_heal = class({})

LinkLuaModifier( "modifier_support_2_dot_heal", "abilities/support/support_2_dot_heal", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function support_2_dot_heal:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	
	local buffDuration = self:GetSpecialValueFor("duration_buff")

	if caster:HasModifier("modifier_donate_aura_damage") then
		buffDuration = buffDuration * 2
	end

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_support_2_dot_heal", -- modifier name
		{ duration = buffDuration } -- kv
	)

end

--------------------------------------------------------------------------------
-- Classifications
function modifier_support_2_dot_heal:IsHidden()
	return false
end

function modifier_support_2_dot_heal:IsDebuff()
	return false
end

function modifier_support_2_dot_heal:IsPurgable()
	return false
end

function modifier_support_2_dot_heal:IsStackable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_support_2_dot_heal:OnCreated( kv )
	if IsServer() then

	local caster = self:GetCaster()
	local parent = self:GetParent()

	self.casterDamage = caster:GetAverageTrueAttackDamage(caster)
	self.heal = self.casterDamage * (self:GetAbility():GetSpecialValueFor("heal_from_dmg") / 100)
	self.duration = self:GetAbility():GetSpecialValueFor("duration_buff")
	self.interval = self:GetAbility():GetSpecialValueFor("tick_heal")


	if caster:HasModifier("modifier_donate_aura_damage") then
		self.heal = self.heal * 2
		self.duration = self.duration * 2
		self.interval = self.interval / 2
	end

	self:SetDuration(self.duration, true )

	self:StartIntervalThink( self.interval )
    self:OnIntervalThink()
	end
end

function modifier_support_2_dot_heal:OnIntervalThink(kv)
	local caster = self:GetCaster()
	local parent = self:GetParent()

	parent:Heal( self.heal, self )
	ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf",PATTACH_ABSORIGIN, parent)

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, self.heal, nil) --ХИЛ
end

function modifier_support_2_dot_heal:OnRefresh( kv )
	
end

function modifier_support_2_dot_heal:OnDestroy( kv )

end

function modifier_support_2_dot_heal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOOLTIP,
	}

	return funcs
end

function modifier_support_2_dot_heal:OnTooltip()
	return self.heal
end

--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_support_2_dot_heal:GetTexture() return "support_2_dot_heal" end
