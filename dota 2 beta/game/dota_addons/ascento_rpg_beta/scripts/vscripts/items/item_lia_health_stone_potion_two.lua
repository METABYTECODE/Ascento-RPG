item_lia_health_stone_potion_two = class({})
LinkLuaModifier("modifier_item_lia_health_stone_potion_two","items/item_lia_health_stone_potion_two.lua",LUA_MODIFIER_MOTION_NONE)

function item_lia_health_stone_potion_two:GetIntrinsicModifierName()
	return "modifier_item_lia_health_stone_potion_two"
end

function item_lia_health_stone_potion_two:CastFilterResult()
	if self:GetCaster():GetHealthPercent() == 100 then
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end

function item_lia_health_stone_potion_two:GetCustomCastError()
	return "You have full health"
end

function item_lia_health_stone_potion_two:OnSpellStart()
	self:GetCaster():Heal(self:GetSpecialValueFor("heal_amount"), self)
	self:GetCaster():EmitSound("DOTA_Item.Mango.Activate") --Emit sound for the health
	
	local particle = ParticleManager:CreateParticle("particles/items_fx/healing_flask.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(particle,false)
		ParticleManager:ReleaseParticleIndex(particle)
	end)
	
	self:SetCurrentCharges(self:GetCurrentCharges()-1)
	if self:GetCurrentCharges() == 0 then
		self:RemoveSelf()
	end
end

-----------------------------------------------------------------------

modifier_item_lia_health_stone_potion_two = class({})

function modifier_item_lia_health_stone_potion_two:IsHidden()
	return true
end

function modifier_item_lia_health_stone_potion_two:IsPurgable()
	return false
end

function modifier_item_lia_health_stone_potion_two:RemoveOnDeath()
	return false
end

function modifier_item_lia_health_stone_potion_two:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
 
	return funcs
end

function modifier_item_lia_health_stone_potion_two:GetModifierConstantHealthRegen()
	return self.healthRegen
end

function modifier_item_lia_health_stone_potion_two:OnCreated()
	self.healthRegen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end