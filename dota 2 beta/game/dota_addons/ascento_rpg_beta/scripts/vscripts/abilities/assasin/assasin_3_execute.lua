
LinkLuaModifier( "modifier_assasin_3_execute", "abilities/assasin/assasin_3_execute", LUA_MODIFIER_MOTION_NONE )
local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

assasin_3_execute = class(ItemBaseClass)
modifier_assasin_3_execute = class(ItemBaseClass)
-------------
function assasin_3_execute:GetIntrinsicModifierName()
    return "modifier_assasin_3_execute"
end

function modifier_assasin_3_execute:OnCreated( kv )
    self.parent = self:GetParent()

end


function modifier_assasin_3_execute:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
---
function modifier_assasin_3_execute:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK,
    }

    return funcs
end

function modifier_assasin_3_execute:OnAttack(params)
    if params.attacker~=self.parent then return end
    if self.parent:PassivesDisabled() then return end

    local attacker = params.attacker
    local victim = params.target
    local ability = self:GetAbility()

    local need_hp_pct = self:GetAbility():GetSpecialValueFor("kill_threshold") / 100

    local max_hp_victim = victim:GetMaxHealth()
    local cur_hp_victim = victim:GetHealth()

    -- Check success / not
	local success = false

	if cur_hp_victim<=max_hp_victim*need_hp_pct then success = true end

	if success then

		self:PlayEffects( victim )

		-- Success:
		-- Damage as HPLoss 
		local damageTable = {
			victim = victim,
			attacker = attacker,
			damage = cur_hp_victim,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self, --Optional.
			damage_flags = DOTA_DAMAGE_FLAG_HPLOSS, DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS, --Optional.
		}
		ApplyDamage(damageTable)		
	end

end

--------------------------------------------------------------------------------
function modifier_assasin_3_execute:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf"
	local sound_cast = "Hero_Axe.Culling_Blade_Success"

	-- load data
	local direction = (target:GetOrigin()-self:GetCaster():GetOrigin()):Normalized()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 4, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 3, direction )
	ParticleManager:SetParticleControlForward( effect_cast, 4, direction )
	-- assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_target)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end