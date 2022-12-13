support_1_heal = class({})
modifier_support_1_heal = class({})

LinkLuaModifier( "modifier_support_1_heal", "abilities/support/support_1_heal", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function support_1_heal:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local heal = caster:GetAverageTrueAttackDamage(caster) * (self:GetSpecialValueFor("heal_from_dmg") / 100)
	local buffDuration = self:GetSpecialValueFor("duration_buff")
	local radius = 100
	local maxstacks = self:GetSpecialValueFor("max_stacks_buff")

	if caster:HasModifier("modifier_donate_aura_damage") then
		heal = heal * 2
		buffDuration = buffDuration * 2
		radius = radius * 2
		maxstacks = maxstacks * 2
	end


	target:Heal( heal, self )
	
	ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf",PATTACH_ABSORIGIN,target)

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, heal, nil) --ХИЛ

	self:PlayEffects1( target, radius )

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_support_1_heal", -- modifier name
		{ duration = buffDuration } -- kv
	)
	local targetModifier = target:FindModifierByName("modifier_support_1_heal")

	if targetModifier:GetStackCount() < maxstacks then
		targetModifier:IncrementStackCount()
	end

	-- Play Effects
	self:PlayEffects()


end

function support_1_heal:PlayEffects1( target, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf"
	local particle_target = "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf"
	local sound_target = "Hero_Omniknight.Purification"

	-- Create Target Effects
	local effect_target = ParticleManager:CreateParticle( particle_target, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_target, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_target )
	EmitSoundOn( sound_target, target )

	-- Create Caster Effects
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function support_1_heal:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_repel_cast.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end



--------------------------------------------------------------------------------
-- Classifications
function modifier_support_1_heal:IsHidden()
	return false
end

function modifier_support_1_heal:IsDebuff()
	return false
end

function modifier_support_1_heal:IsPurgable()
	return false
end

function modifier_support_1_heal:IsStackable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_support_1_heal:OnCreated( kv )
	if IsServer() then
		-- Play Effects
		self.sound_cast = "Hero_Omniknight.Repel"
		EmitSoundOn( self.sound_cast, self:GetParent() )

	self.duration_b = self:GetAbility():GetSpecialValueFor("duration_buff")

		-- refresh duration
	if self:GetCaster():HasModifier("modifier_donate_aura_damage") then
		self.duration_b = self.duration_b * 2
	end
	self:SetDuration( self.duration_b, true )
	end
end

function modifier_support_1_heal:OnRefresh( kv )
	
end

function modifier_support_1_heal:OnDestroy( kv )
	if IsServer() then
		StopSoundOn( self.sound_cast, self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_support_1_heal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_support_1_heal:GetModifierPhysicalArmorBonus()
	self.armor_buff = self:GetAbility():GetSpecialValueFor("armor_buff")
	if self:GetCaster():HasModifier("modifier_donate_aura_damage") then
		self.armor_buff = self.armor_buff * 2
	end
	return self:GetStackCount() * self.armor_buff
end


--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_support_1_heal:GetTexture() return "support_1_heal" end

function modifier_support_1_heal:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_repel_buff.vpcf"
end

function modifier_support_1_heal:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end