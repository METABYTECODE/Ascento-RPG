

ricko_tree_throw = class({
	GetAOERadius = function(self)
		return self:GetSpecialValueFor("radius")
	end
})

function ricko_tree_throw:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_tiny/tiny_tree_proj.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tiny.vsndevts", context)
end

function ricko_tree_throw:OnSpellStart()
	if(not IsServer()) then
		return
	end
	local target = self:GetCursorTarget()
	local info = {
		EffectName = "particles/units/heroes/hero_tiny/tiny_tree_proj.vpcf",
		Ability = self,
		iMoveSpeed = 1000,
		Source = self:GetCaster(),
		Target = target,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
	}

	ProjectileManager:CreateTrackingProjectile( info )
	EmitSoundOn( "Hero_Tiny.Tree.Throw", self:GetCaster() )
end

function ricko_tree_throw:OnProjectileHit(hTarget, vLocation)
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) and ( not hTarget:TriggerSpellAbsorb( self ) )  then
		local caster = self:GetCaster()
		local damage = self:GetSpecialValueFor("base_dmg")
		local radius = self:GetSpecialValueFor("radius")
		local stun_duration = self:GetSpecialValueFor("stun_duration")
		local debuff_duration = self:GetSpecialValueFor("debuff_duration")

		EmitSoundOn( "Hero_Tiny.Tree.Target", hTarget )
		local enemies = FindUnitsInRadius(
			caster:GetTeam(), 
			hTarget:GetAbsOrigin(), 
			nil, 
			radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 
			DOTA_UNIT_TARGET_FLAG_NONE, 
			FIND_ANY_ORDER, false
		)
		local damageTable = {
			victim = nil,
			attacker = caster,
			damage = damage * (1+caster:GetSpellAmplification(false)),
			damage_type = self:GetAbilityDamageType(),
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
			ability = self
		}
		for i=1,#enemies do
			local enemy = enemies[i]
			damageTable.victim = enemy
			ApplyDamage(damageTable)
			enemy:AddNewModifier(caster, self, "modifier_stunned", {duration = stun_duration})
			enemy:AddNewModifier(caster, self, "modifier_ricko_tree_throw_debuff", {duration = debuff_duration})
			
		end
	end
 end 
--------------------------------------------------------------------------------

modifier_ricko_tree_throw_debuff = class({
	IsHidden 				= function(self) return false end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return true end,
	IsBuff                  = function(self) return false end,
	RemoveOnDeath 			= function(self) return true end,
	RegisterFunctions		= function(self) return 
		{
			MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		} end,
})

function modifier_ricko_tree_throw_debuff:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("armor_decrease")*(-1)
end


LinkLuaModifier(" modifier_ricko_tree_throw_debuff", "abilities/heroes/hero_ricko/tree_throw", LUA_MODIFIER_MOTION_NONE ,  modifier_ricko_tree_throw_debuff)
