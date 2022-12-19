unit_suicide = class({
    GetIntrinsicModifierName = function()
		return "modifier_unit_suicide"
	end,
})

function unit_suicide:OnOwnerDied()
 	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor('radius')
    local damage = self:GetSpecialValueFor('damage_basic')

    
 

	local units = FindUnitsInRadius(
		DOTA_TEAM_GOODGUYS,
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)


	for _,unit in pairs(units) do
    ApplyDamage({attacker = caster, 
        victim = unit,  
        damage = damage,
        ability = self, 
        damage_type = DAMAGE_TYPE_MAGICAL})
	end

 
	caster:EmitSound("Hero_Techies.Suicide")
	local nfx = ParticleManager:CreateParticle('particles/units/heroes/hero_techies/techies_suicide.vpcf', PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(nfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(nfx, 1, Vector(radius/2, 0, 0))
	ParticleManager:SetParticleControl(nfx, 2, Vector(radius, 1, 1))
end

modifier_unit_suicide = class({
    IsHidden = function()
        return true
    end
})

function modifier_unit_suicide:OnCreated()
end

LinkLuaModifier( "modifier_unit_suicide", "abilities/units/unit_suicide", LUA_MODIFIER_MOTION_NONE )