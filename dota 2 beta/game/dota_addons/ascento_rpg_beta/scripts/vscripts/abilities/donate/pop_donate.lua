--LinkLuaModifier(" modifier_pop_donate_hidden", "abilities/heroes/hero_ricko/mount", LUA_MODIFIER_MOTION_NONE ,  modifier_pop_donate_hidden)
--LinkLuaModifier(" modifier_pop_donate_host", "abilities/heroes/hero_ricko/mount", LUA_MODIFIER_MOTION_NONE ,  modifier_pop_donate_host)

LinkLuaModifier("modifier_pop_donate_host", "abilities/donate/pop_donate", LUA_MODIFIER_MOTION_NONE, modifier_pop_donate_host)
LinkLuaModifier("modifier_pop_donate_hidden", "abilities/donate/pop_donate", LUA_MODIFIER_MOTION_NONE, modifier_pop_donate_hidden)

pop_donate_bue = class({})

function pop_donate_bue:OnSpellStart()
	if(not IsServer()) then
		return
	end
	local caster = self:GetCaster()

	if caster.host ~= nil then

		EmitSoundOn("Item.GreevilWhistle.Return",caster.host)
	
		caster.host:RemoveNoDraw()
		caster.host:RemoveModifierByName("modifier_pop_donate_hidden")
		caster:SwapAbilities("pop_donate_bue", "pop_donate", false, true) 
		caster.host:Hold()
	
		local mount_ability = caster:FindAbilityByName("pop_donate")
		local ability_cooldown = mount_ability:GetSpecialValueFor("ability_cooldown")
		mount_ability:StartCooldown(ability_cooldown)
	
		if caster and IsValidEntity(caster) then
			caster:RemoveModifierByName("modifier_pop_donate_host")
			caster.host = nil
		end

	else
		caster:SwapAbilities("pop_donate_bue", "pop_donate", false, true) 

		local mount_ability = caster:FindAbilityByName("pop_donate")
		local ability_cooldown = mount_ability:GetSpecialValueFor("ability_cooldown")
		mount_ability:StartCooldown(ability_cooldown)

		if caster and IsValidEntity(caster) then
			caster:RemoveModifierByName("modifier_pop_donate_host")
			caster.host = nil
		end

	end

end

pop_donate = class({})

function pop_donate:CastFilterResultTarget(hTarget)
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


function pop_donate:OnSpellStart()
	if(not IsServer()) then
		return
	end
    local target = self:GetCursorTarget()
    local caster = self:GetCaster()
    local ability = self

	target:AddNewModifier(caster, ability, "modifier_pop_donate_hidden", nil)
	caster:AddNewModifier(caster, ability, "modifier_pop_donate_host", nil)
    caster.host = target

	target:AddNoDraw()
	EmitSoundOn("Item.GreevilWhistle",caster)
	caster:SwapAbilities("pop_donate", "pop_donate_bue", false, true) 

end

modifier_pop_donate_hidden = class({
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



modifier_pop_donate_host = class({
	IsHidden 				= function(self) return false end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	RemoveOnDeath 			= function(self) return true end,
	ShouldUseOverheadOffset = function()
		return true
	end
})

function modifier_pop_donate_host:DeclareFunctions()
    local funcs = {
		MODIFIER_EVENT_ON_DEATH,
    }

    return funcs
end

function modifier_pop_donate_host:OnCreated()
	if(not IsServer()) then
		return
	end
	self.parent = self:GetParent()

	self:StartIntervalThink(0.03)
end

function modifier_pop_donate_host:OnIntervalThink()
	local caster = self:GetCaster()

	if IsValidEntity(caster) and caster:IsAlive() then
		caster.host:SetAbsOrigin(caster:GetAbsOrigin())
	end
end

function modifier_pop_donate_host:OnDeath(data)
    local caster = self:GetCaster()
	local parent = caster.host
	local attacker = data.attacker
	local unit = data.unit
    local ability = self:GetAbility()
	local ability_cooldown = ability:GetSpecialValueFor("ability_cooldown")


    if parent == unit or caster == unit  then 
		parent:SetAbsOrigin(caster:GetAbsOrigin())
		parent:RemoveNoDraw()
		parent:RemoveModifierByName("modifier_pop_donate_hidden")
		caster:RemoveModifierByName("modifier_pop_donate_host")
		caster:SwapAbilities("pop_donate_bue", "pop_donate", false, true) 
		parent:Hold()
    	--caster.host:RemoveModifierByName("modifier_ricko_rage_buff")
		caster.host = nil

		ability:StartCooldown(ability_cooldown)


		local playerID = parent:GetPlayerID()
    	local player = PlayerResource:GetPlayer(playerID)



	elseif caster == attacker then
		if IsCreepASCENTO(unit) then
			parent.creep_kills = parent.creep_kills + 1
			--CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_creeps", {playerKilledCreeps = tonumber(parent.creep_kills)})
            --CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(parent.all_creep_kills + parent.creep_kills)})

		end
		if IsBossASCENTO(unit) then
			parent.boss_kills = parent.boss_kills + 1
			--CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_boss", {playerKilledBoss = tonumber(parent.boss_kills)})
            --CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_boss", {playerKilledBoss = tonumber(parent.all_boss_kills + parent.boss_kills)})

		end

		--if unit:GetUnitName() == "npc_creep_endless_1" and caster:IsRealHero() then
		--	Ascento:RandomEndlessModifier(parent, unit:GetLevel())
		--end
   end
end


