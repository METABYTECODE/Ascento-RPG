modifier_custom_attribute_mana_regen = class({})

local public = modifier_custom_attribute_mana_regen

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
	return {MODIFIER_PROPERTY_MANA_REGEN_CONSTANT}
end

--------------------------------------------------------------------------------

function public:GetModifierConstantManaRegen()
	local giveDamage = (self:GetStackCount() / 20) * self:GetCaster():GetLevel()
	if giveDamage > 5000 then
		return 5000 + (self:GetStackCount() * 5)
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