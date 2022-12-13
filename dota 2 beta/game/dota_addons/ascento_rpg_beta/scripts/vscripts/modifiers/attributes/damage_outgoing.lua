modifier_custom_attribute_damage_outgoing = class({})

local public = modifier_custom_attribute_damage_outgoing

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
	return {MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE}
end

--------------------------------------------------------------------------------

function public:GetModifierTotalDamageOutgoing_Percentage()
	local giveDamage = (self:GetStackCount() / 200) * self:GetCaster():GetLevel()
	if giveDamage > 500 then
		return 500 + (self:GetStackCount())
	else
		return giveDamage + (self:GetStackCount())
	end

	return giveDamage + (self:GetStackCount())
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