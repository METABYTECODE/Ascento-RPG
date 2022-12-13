modifier_custom_attribute_mana_regen_percentage = class({})

local public = modifier_custom_attribute_mana_regen_percentage

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
	return {MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE}
end

--------------------------------------------------------------------------------

function public:GetModifierTotalPercentageManaRegen()
	local giveDamage = (self:GetStackCount() / 100) * self:GetCaster():GetLevel()
	if giveDamage > 5 then
		return 5 + (self:GetStackCount() * 0.1)
	else
		return giveDamage + (self:GetStackCount() * 0.1)
	end

	return giveDamage + (self:GetStackCount() * 0.1)
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