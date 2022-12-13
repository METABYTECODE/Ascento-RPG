sheep_march = class({})
LinkLuaModifier( "modifier_sheep_march_thinker", "abilities/enemy/sheep_march", LUA_MODIFIER_MOTION_NONE )




--------------------------------------------------------------------------------
-- Ability Start
function sheep_march:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local direction = self:GetSpecialValueFor("direction")
	local point = self:GetCursorPosition()

	if direction == 1 then
		point = point + Vector(10, 0, 0)
	elseif direction == 2 then
		point = point + Vector(-10, 0, 0)
	elseif direction == 3 then
		point = point + Vector(0, 10, 0)
	elseif direction == 4 then
		point = point + Vector(0, -10, 0)
	end


	-- create thinker
	CreateModifierThinker(
		caster,
		self,
		"modifier_sheep_march_thinker",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)

	-- Play effects
	self:PlayEffects()
end
--------------------------------------------------------------------------------
-- Projectile
function sheep_march:OnProjectileHit_ExtraData( target, location, extraData )
	if not target then return true end

	-- find units in radius
	local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),	-- int, your team number
			location,	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			extraData.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

	-- explode
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = extraData.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
		enemy:ForceKill(true)
	end

	return true
end

--------------------------------------------------------------------------------
function sheep_march:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_motm.vpcf"
	local sound_cast = "Hero_Tinker.March_of_the_Machines.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationForAllies( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
end


modifier_sheep_march_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sheep_march_thinker:IsHidden()
	return true
end

function modifier_sheep_march_thinker:IsDebuff()
	return false
end

function modifier_sheep_march_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sheep_march_thinker:OnCreated( kv )
	if IsServer() then
		-- references
		local duration = self:GetAbility():GetSpecialValueFor( "duration" ) -- special value
		self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
		
		local speed = self:GetAbility():GetSpecialValueFor( "speed" ) -- special value
		local distance = self:GetAbility():GetSpecialValueFor( "distance" ) -- special value
		if self:GetCaster():HasScepter() then
			distance = self:GetAbility():GetSpecialValueFor( "distance_scepter" ) -- special value
		end

		local machines_per_sec = self:GetAbility():GetSpecialValueFor( "machines_per_sec" ) -- special value
		local collision_radius = self:GetAbility():GetSpecialValueFor( "collision_radius" ) -- special value
		local splash_radius = self:GetAbility():GetSpecialValueFor( "splash_radius" ) -- special value
		local splash_damage = self:GetAbility():GetAbilityDamage()

		-- generate Data
		local projectile_name = "particles/ascento/sheep_sheep.vpcf"
		local interval = 1/machines_per_sec
		local center = self:GetParent():GetOrigin()

		local direction = (center-self:GetCaster():GetOrigin())
		direction = Vector( direction.x, direction.y, 0 ):Normalized()
		self:GetParent():SetForwardVector( direction )
		
		self.spawn_vector = self:GetParent():GetRightVector()

		self.center_start = center - direction*self.radius

		-- Precache projectile info
		self.projectile_info = {
			Source = self:GetCaster(),
			Ability = self:GetAbility(),
			-- vSpawnOrigin = spawn,
			
		    bDeleteOnHit = true,
		    
		    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		    
		    EffectName = projectile_name,
		    fDistance = distance,
		    fStartRadius = collision_radius,
		    fEndRadius = collision_radius,
			vVelocity = direction * speed,

			ExtraData = {
				radius = splash_radius,
				damage = splash_damage,
			}
		}

		-- add duration
		self:SetDuration( duration, false )

		-- Start interval
		self:StartIntervalThink( interval )
		self:OnIntervalThink()

		-- effects
		local sound_cast = "Hero_Tinker.March_of_the_Machines"
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end

function modifier_sheep_march_thinker:OnRefresh( kv )
	
end

function modifier_sheep_march_thinker:OnDestroy( kv )
	if IsServer() then
		-- effects
		local sound_cast = "Hero_Tinker.March_of_the_Machines"
		StopSoundOn( sound_cast, self:GetParent() )

		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sheep_march_thinker:OnIntervalThink()
	-- generate spawn point
	local spawn = self.center_start + self.spawn_vector*RandomInt( -self.radius, self.radius )

	-- spawn machines
	self.projectile_info.vSpawnOrigin = spawn
	ProjectileManager:CreateLinearProjectile(self.projectile_info)
end

sheep_march_top = sheep_march
sheep_march_left = sheep_march
sheep_march_bottom = sheep_march
sheep_march_right = sheep_march