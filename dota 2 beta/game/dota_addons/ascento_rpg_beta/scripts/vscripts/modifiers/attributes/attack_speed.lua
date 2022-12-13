modifier_custom_attribute_attack_speed = class({})

local public = modifier_custom_attribute_attack_speed

--------------------------------------------------------------------------------

function public:IsDebuff()
	return false
end

function public:GetTexture() return "endless_bonus" end

--------------------------------------------------------------------------------

function public:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function public:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function public:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------

function public:DeclareFunctions()
	return {MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT}
end

--------------------------------------------------------------------------------

function public:GetModifierAttackSpeedBonus_Constant()
	local giveDamage = (self:GetStackCount() / 10) * self:GetCaster():GetLevel()
	if giveDamage > 1000 then
		return 1000 + (self:GetStackCount() * 5)
	else
		return giveDamage + (self:GetStackCount() * 5)
	end

	return giveDamage + (self:GetStackCount() * 5)
end

function public:OnStackCountChanged()
	if IsServer then
		if self.CurrentStackCount ~= self:GetStackCount() then
			local hero = self:GetCaster()
			if hero ~= nil and hero:IsNull() == false and hero.CalculateStatBonus then
				hero:CalculateStatBonus(false)
			end
		end

		self.CurrentStackCount = self:GetStackCount()
	end
end