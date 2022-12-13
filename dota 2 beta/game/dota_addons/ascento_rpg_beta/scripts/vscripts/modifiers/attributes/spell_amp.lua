modifier_custom_attribute_spell_amp = class({})

local public = modifier_custom_attribute_spell_amp

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
	return {MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE}
end

--------------------------------------------------------------------------------

function public:GetModifierSpellAmplify_Percentage()
	local giveDamage = (self:GetStackCount() / 100) * self:GetCaster():GetLevel()
	if giveDamage > 200 then
		return 200 + (self:GetStackCount() * 1.5)
	else
		return giveDamage + (self:GetStackCount() * 1.5)
	end

	return giveDamage + (self:GetStackCount() * 1.5)
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