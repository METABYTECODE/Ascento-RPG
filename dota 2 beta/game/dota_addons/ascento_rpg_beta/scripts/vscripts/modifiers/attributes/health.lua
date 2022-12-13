modifier_custom_attribute_health = class({})

local public = modifier_custom_attribute_health

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
	return {MODIFIER_PROPERTY_HEALTH_BONUS}
end

--------------------------------------------------------------------------------

function public:GetModifierHealthBonus()
	local giveDamage = self:GetStackCount() * self:GetCaster():GetLevel()
	if giveDamage > 1000000 then
		return 1000000 + (self:GetStackCount() * 50)
	else
		return giveDamage + (self:GetStackCount() * 50)
	end

	return giveDamage + (self:GetStackCount() * 50)
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