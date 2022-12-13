donate_steal_kills = class({})
modifier_donate_steal_kills = class({})

LinkLuaModifier( "modifier_donate_steal_kills", "abilities/donate/donate_steal_kills", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function donate_steal_kills:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if caster == target then return end
	if not target:IsHero() then return end

	-- Cancel if blocked
	if target:TriggerSpellAbsorb( self ) then
		return
	end

	local projectile_name = "particles/units/heroes/hero_rubick/rubick_spell_steal.vpcf"
	local projectile_speed = 1000

	-- Create Projectile
	local info = {
		Target = caster,
		Source = target,
		Ability = self,	
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		vSourceLoc = target:GetAbsOrigin(),                -- Optional (HOW)
		bDrawsOnMinimap = false,                          -- Optional
		bDodgeable = false,                                -- Optional
		bVisibleToEnemies = true,                         -- Optional
		bReplaceExisting = false,                         -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)

	-- Play effects
	local sound_cast = "Hero_Rubick.SpellSteal.Cast"
	EmitSoundOn( sound_cast, caster )
	local sound_target = "Hero_Rubick.SpellSteal.Target"
	EmitSoundOn( sound_target, target )

	local playerID = caster:GetPlayerID()
    local player = PlayerResource:GetPlayer(playerID)

	local targetplayerID = target:GetPlayerID()
    local targetplayer = PlayerResource:GetPlayer(targetplayerID)

    local pctsteal = self:GetSpecialValueFor("steal_kills") / 100


    if target.creep_kills ~= nil and target.creep_kills > 0 then

    	local stealcreeps = math.floor(target.creep_kills * pctsteal)
    	if stealcreeps > 2000 then
    		stealcreeps = 2000
    	end

    	if stealcreeps > 0 then
	
			caster.creep_kills = caster.creep_kills + stealcreeps
			target.creep_kills = 0
			CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_creeps", {playerKilledCreeps = tonumber(caster.creep_kills)})
	    	CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(caster.all_creep_kills + caster.creep_kills)})
	    	
			CustomGameEventManager:Send_ServerToPlayer(targetplayer, "on_player_kill_creeps", {playerKilledCreeps = tonumber(target.creep_kills)})
	    	CustomGameEventManager:Send_ServerToPlayer(targetplayer, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(target.all_creep_kills + target.creep_kills)})
	    end
	end

	if target.boss_kills ~= nil and target.boss_kills > 0 then

    	local stealboss = math.floor(target.boss_kills * pctsteal)
    	if stealboss > 500 then
    		stealboss = 500
    	end
    	if stealboss > 0 then

			caster.boss_kills = caster.boss_kills + stealboss
			target.boss_kills = 0
			CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_boss", {playerKilledBoss = tonumber(caster.boss_kills)})
	    	CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_boss", {playerKilledBoss = tonumber(caster.all_boss_kills + caster.boss_kills)})
	
			CustomGameEventManager:Send_ServerToPlayer(targetplayer, "on_player_kill_creeps", {playerKilledCreeps = tonumber(target.boss_kills)})
	    	CustomGameEventManager:Send_ServerToPlayer(targetplayer, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(target.all_boss_kills + target.boss_kills)})
	    end
	end

	GameMode:FastSaveNoReq(targetplayerID)

end