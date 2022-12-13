mage_2_magic_horizont = class({})
modifier_mage_2_magic_horizont = class({})

LinkLuaModifier( "modifier_mage_2_magic_horizont", "abilities/mage/mage_2_magic_horizont", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function mage_2_magic_horizont:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local damagePerStack = self:GetSpecialValueFor("damage_per_stack") / 100

	local damage = caster:GetAverageTrueAttackDamage(caster) * (self:GetSpecialValueFor("damage") / 100)
	if target:HasModifier("modifier_mage_2_magic_horizont") then
		local tmdf = target:FindModifierByName("modifier_mage_2_magic_horizont")
		damage = damage * ( 1 + (damagePerStack * tmdf:GetStackCount()) )
	end
	print(damage)

	local debuffDuration = self:GetSpecialValueFor("duration_debuff")

	local radius = 100
	

	self:PlayEffects1( target, radius )

	if not target:HasModifier("modifier_mage_2_magic_horizont") then
		-- Add modifier
		target:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_mage_2_magic_horizont", -- modifier name
			{ duration = debuffDuration } -- kv
		)
		local targetModifier = target:FindModifierByName("modifier_mage_2_magic_horizont")
		targetModifier:IncrementStackCount()
	else
		local targetModifier = target:FindModifierByName("modifier_mage_2_magic_horizont")
		targetModifier:IncrementStackCount()
	end


	self.damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}


	-- Play Effects
	--self:PlayEffects()
	ApplyDamage(self.damageTable)


end

function mage_2_magic_horizont:PlayEffects1( target, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf"
	local particle_target = "particles/units/heroes/hero_arc_warden/arc_warden_tempest_cast_rays.vpcf"
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
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

--function mage_2_magic_horizont:PlayEffects()
--	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_repel_cast.vpcf"
--	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
--	ParticleManager:SetParticleControlEnt(
--		effect_cast,
--		0,
--		self:GetCaster(),
--		PATTACH_POINT_FOLLOW,
--		"attach_attack2",
--		self:GetCaster():GetOrigin(), -- unknown
--		true -- unknown, true
--	)
--	ParticleManager:ReleaseParticleIndex( effect_cast )
--end



--------------------------------------------------------------------------------
-- Classifications
function modifier_mage_2_magic_horizont:IsHidden()
	return false
end

function modifier_mage_2_magic_horizont:IsDebuff()
	return true
end

function modifier_mage_2_magic_horizont:IsPurgable()
	return false
end

function modifier_mage_2_magic_horizont:IsStackable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mage_2_magic_horizont:OnCreated( kv )
	if IsServer() then
		-- Play Effects
		--self.sound_cast = "Hero_Omniknight.Repel"
		--EmitSoundOn( self.sound_cast, self:GetParent() )

		-- refresh duration

	self:SetDuration( self:GetAbility():GetSpecialValueFor("duration_debuff"), true )
	end
end

function modifier_mage_2_magic_horizont:OnRefresh( kv )
	
end

function modifier_mage_2_magic_horizont:OnDestroy( kv )
	if IsServer() then
		--StopSoundOn( self.sound_cast, self:GetParent() )
	end
end




--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_mage_2_magic_horizont:GetTexture() return "mage_2_magic_horizont" end

function modifier_mage_2_magic_horizont:GetEffectName()
	return "particles/units/heroes/hero_spirit_breaker/spirit_breaker_magnet_aura.vpcf"
end

function modifier_mage_2_magic_horizont:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end