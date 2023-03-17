


mage_2_magic_shower = class({
	GetCastRange = function(self)
		return self:GetSpecialValueFor("radius")
	end
})

function mage_2_magic_shower:OnSpellStart()
	self.caster = self:GetCaster()
	local point = self.caster:GetAbsOrigin()
	
	self.duration = self:GetSpecialValueFor( "duration" )

	CreateModifierThinker(
		self.caster,
		self,
		"modifier_mage_2_magic_shower",
		{ duration = self.duration },
		point,
		self.caster:GetTeamNumber(),
		false
	)

end


modifier_mage_2_magic_shower = class({
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
	IsAura = function(self)
		return self.owner
	end,
	GetModifierAura = function()
		return "modifier_mage_2_magic_shower"
	end,
	GetAuraRadius = function(self) 
        return self.radius
    end,
	GetAuraDuration = function()
		return 0.5
	end,
	GetAuraSearchTeam = function(self) 
        return self.targetTeam
    end,
    GetAuraSearchType = function(self) 
        return self.targetType
    end,
	GetEffectAttachType = function()
		return 1
	end,
    DeclareFunctions = function()
        return {
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
            
        }
    end,
    GetModifierMagicalResistanceBonus = function(self)
        return self.magic_resist
    end
})



function modifier_mage_2_magic_shower:OnCreated( kv )
	self.ability = self:GetAbility()
	if self.ability then
		self.parent = self:GetParent()
		self.caster = self:GetCaster()
		if not IsServer() then return end
		
		self.targetTeam = self.ability:GetAbilityTargetTeam()
    	self.targetType = self.ability:GetAbilityTargetType()
		
	
		self.owner = kv.isProvidedByAura~=1
	
		
	
		self:OnRefresh()
	end
end

function modifier_mage_2_magic_shower:OnRefresh( kv )
	self.damage = self.ability:GetSpecialValueFor( "magic_damage" ) / 100
	self.magic_resist = self.ability:GetSpecialValueFor( "magic_resistance_debuff" )
	self.radius = self.ability:GetCastRange()
	self.tickrate = self:GetAbility():GetSpecialValueFor( "tickrate" )


	self.dps = self.caster:GetAverageTrueAttackDamage(self.caster) * self.damage

	if self.caster:HasModifier("modifier_mage_3_magic_crit") then
        if IsServer() then
            local ability = self.caster:FindAbilityByName("mage_3_magic_crit")
            local chance = ability:GetSpecialValueFor("critical_chance")

            if RollPercentage(chance) then
                self.dps = self.dps * (ability:GetSpecialValueFor("critical_damage") / 100)
                EmitSoundOn( "Ability.static.start", self.caster )

    
            end
        end
    end

	if not self.owner then
		self.damageTable = {
			victim = self.parent,
			attacker = self.caster,
			damage = self.dps,
			damage_type = self.ability:GetAbilityDamageType(),
			ability = self.ability,
		}
		self:StartIntervalThink( self.tickrate )
	else
		self:PlayEffects()
	end
end

function modifier_mage_2_magic_shower:OnDestroy()
	if not IsServer() then return end
	if not self.owner then return end
	UTIL_Remove( self.parent )
end



function modifier_mage_2_magic_shower:OnIntervalThink()
	ApplyDamage( self.damageTable )
	--local sound_cast = "Hero_Viper.mage_2_magic_shower.Damage"
	--EmitSoundOn( sound_cast, self.parent )
end

function modifier_mage_2_magic_shower:GetEffectName()
	if not self.owner then
		return "particles/econ/items/necrolyte/necro_sullen_harvest/necro_ti7_immortal_scythe_cage_tickle.vpcf"
	end
end

function modifier_mage_2_magic_shower:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura.vpcf"
	--local sound_cast = "Hero_Viper.mage_2_magic_shower"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )

	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)

	--EmitSoundOn( sound_cast, self.parent )
end

LinkLuaModifier("modifier_mage_2_magic_shower", "abilities/mage/mage_2_magic_shower", LUA_MODIFIER_MOTION_NONE)