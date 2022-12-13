--LinkLuaModifier(" modifier_ricko_mount_hidden", "abilities/heroes/hero_ricko/mount", LUA_MODIFIER_MOTION_NONE ,  modifier_ricko_mount_hidden)
--LinkLuaModifier(" modifier_ricko_mount_host", "abilities/heroes/hero_ricko/mount", LUA_MODIFIER_MOTION_NONE ,  modifier_ricko_mount_host)

LinkLuaModifier("modifier_ricko_mount_host", "abilities/heroes/hero_ricko/mount.lua", LUA_MODIFIER_MOTION_NONE, modifier_ricko_mount_host)
LinkLuaModifier("modifier_ricko_mount_hidden", "abilities/heroes/hero_ricko/mount.lua", LUA_MODIFIER_MOTION_NONE, modifier_ricko_mount_hidden)

ricko_unmount = class({})

function ricko_unmount:OnSpellStart()
	if(not IsServer()) then
		return
	end
	local caster = self:GetCaster()

	EmitSoundOn("Hero_LifeStealer.unmount",caster)

	caster:RemoveNoDraw()
	caster:RemoveModifierByName("modifier_ricko_mount_hidden")
	caster:SwapAbilities("ricko_unmount", "ricko_mount", false, true) 
	caster:Hold()

	local mount_ability = caster:FindAbilityByName("ricko_mount")
	local ability_cooldown = mount_ability:GetSpecialValueFor("ability_cooldown")
	mount_ability:StartCooldown(ability_cooldown)

	if caster.host and IsValidEntity(caster.host) then
		caster.host:RemoveModifierByName("modifier_ricko_mount_host")
    	--caster.host:RemoveModifierByName("modifier_ricko_rage_buff")
		caster.host = nil
	end
end

ricko_mount = class({})

function ricko_mount:CastFilterResultTarget(hTarget)
	if(not IsServer()) then
		return UF_SUCCESS
	end
	local caster = self:GetCaster()
	if(caster == hTarget) then
		return UF_FAIL_OTHER
	end
	local result = UnitFilter( 
		hTarget, 
		self:GetAbilityTargetTeam(), 
		self:GetAbilityTargetType(), 
		self:GetAbilityTargetFlags(), 
		caster:GetTeamNumber()
	)
	if result ~= UF_SUCCESS then
		return result
	end
	return UF_SUCCESS
end

function ricko_mount:Precache(context)
	PrecacheResource("particle", "particles/custom/units/heroes/ricko/infest/infested_unit.vpcf", context)
end

function ricko_mount:OnSpellStart()
	if(not IsServer()) then
		return
	end
    local target = self:GetCursorTarget()
    local caster = self:GetCaster()
    local ability = self

	caster:AddNewModifier(caster, ability, "modifier_ricko_mount_hidden", nil)
	target:AddNewModifier(caster, ability, "modifier_ricko_mount_host", nil)
    caster.host = target

	caster:AddNoDraw()
	EmitSoundOn("Hero_LifeStealer.mount",unit)
	caster:SwapAbilities("ricko_mount", "ricko_unmount", false, true) 

end

modifier_ricko_mount_hidden = class({
	IsHidden 				= function(self) return true end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	RemoveOnDeath 			= function(self) return false end,
	CheckState				= function(self) return 
		{
			[MODIFIER_STATE_DISARMED] = true,
			[MODIFIER_STATE_INVULNERABLE] = true,
			[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
			[MODIFIER_STATE_ROOTED] = true,
			[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
			[MODIFIER_STATE_UNSELECTABLE] = true,
			[MODIFIER_STATE_OUT_OF_GAME] = true,
			[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		} end,
})

function modifier_ricko_mount_hidden:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_EXP_RATE_BOOST,
    }

    return funcs
end

function modifier_ricko_mount_hidden:OnCreated()
	self:StartIntervalThink(0.03)
end

function modifier_ricko_mount_hidden:OnIntervalThink()
	local caster = self:GetCaster()

	if IsValidEntity(caster.host) and caster.host:IsAlive() then
		caster:SetAbsOrigin(caster.host:GetAbsOrigin())
	end
end

function modifier_ricko_mount_hidden:GetModifierPercentageExpRateBoost()
	return self:GetAbility():GetSpecialValueFor("bonus_xp")
end



modifier_ricko_mount_host = class({
	IsHidden 				= function(self) return false end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	RemoveOnDeath 			= function(self) return true end,
	ShouldUseOverheadOffset = function()
		return true
	end
})

function modifier_ricko_mount_host:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_EXP_RATE_BOOST,
        MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_DEATH,
    }

    return funcs
end

function modifier_ricko_mount_host:OnCreated()
	if(not IsServer()) then
		return
	end
	self.parent = self:GetParent()
	local particle = ParticleManager:CreateParticle(
		"particles/custom/units/heroes/ricko/infest/infested_unit.vpcf", 
		PATTACH_ABSORIGIN_FOLLOW, 
		self.parent
	)
	ParticleManager:SetParticleControlEnt(particle, 2, self.parent, PATTACH_OVERHEAD_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
	self:AddParticle(particle, false, false, 1, false, true)
	self.addDamage = self:GetCaster():GetAverageTrueAttackDamage(self:GetCaster())

end

function modifier_ricko_mount_host:OnDeath(data)
    local caster = self:GetCaster()
	local parent = self:GetParent()
	local attacker = data.attacker
	local unit = data.unit
    local ability = self:GetAbility()
	local ability_cooldown = ability:GetSpecialValueFor("ability_cooldown")


    if parent == unit or caster == unit  then 
		caster:SetAbsOrigin(parent:GetAbsOrigin())
		caster:RemoveNoDraw()
		caster:RemoveModifierByName("modifier_ricko_mount_hidden")
		parent:RemoveModifierByName("modifier_ricko_mount_host")
		caster:SwapAbilities("ricko_unmount", "ricko_mount", false, true) 
		caster:Hold()
    	--caster.host:RemoveModifierByName("modifier_ricko_rage_buff")
		caster.host = nil

		ability:StartCooldown(ability_cooldown)


		local playerID = caster:GetPlayerID()
    	local player = PlayerResource:GetPlayer(playerID)
    	
	elseif parent == attacker then
		if IsCreepASCENTO(unit) then
			caster.creep_kills = caster.creep_kills + 1
			CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_creeps", {playerKilledCreeps = tonumber(caster.creep_kills), need_kill_creeps = tonumber(CREEP_KILLS_DEFAULT)})
            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(caster.all_creep_kills + 1)})
            
		end
		if IsBossASCENTO(unit) then
			caster.boss_kills = caster.boss_kills + 1
			CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_boss", {playerKilledBoss = tonumber(caster.boss_kills), need_kill_boss = tonumber(BOSS_KILLS_DEFAULT)})
            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_boss", {playerKilledBoss = tonumber(caster.all_boss_kills + 1)})
		end
   end
end

function modifier_ricko_mount_host:GetModifierPercentageExpRateBoost()
	return self:GetAbility():GetSpecialValueFor("bonus_xp")
end

function modifier_ricko_mount_host:OnTooltip()
	return self.addDamage
end

function modifier_ricko_mount_host:GetModifierBaseAttack_BonusDamage()
	return self.addDamage
end

function modifier_ricko_mount_host:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_as")
end

