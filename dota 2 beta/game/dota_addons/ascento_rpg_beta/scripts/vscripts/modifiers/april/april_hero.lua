modifier_april_hero = class({})

local public = modifier_april_hero

--------------------------------------------------------------------------------

function public:IsDebuff()
	return false
end


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

function public:GetTexture() return "endless_bonus" end
--------------------------------------------------------------------------------

function public:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function public:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_MISS_PERCENTAGE,
    }

    return funcs
end

function public:OnCreated( kv )
    -- references
    self.current_bonus = 1
    self.max_bonus = 200
    self.min_bonus = 50

    self.type = 1

    self:StartIntervalThink( 0.05 )
    self:OnIntervalThink()
end

function public:OnIntervalThink()
    if not IsServer() then return end

    if self.type == 1 and self.current_bonus < self.max_bonus then
    	self.current_bonus = self.current_bonus + 1
    end
    if self.type == 0 and self.current_bonus > self.min_bonus then
    	self.current_bonus = self.current_bonus - 1
    end
    if self.current_bonus == self.max_bonus and self.type == 1 then
    	self.type = 0
    end
    if self.current_bonus == self.min_bonus and self.type == 0 then
    	self.type = 1
    end

    self:SetStackCount(self.current_bonus)

end

--------------------------------------------------------------------------------

function public:GetModifierBaseDamageOutgoing_Percentage()
	local giveDamage = self:GetStackCount()

	if self:GetStackCount() < 100 then
		giveDamage = giveDamage - 100
	end

	--giveDamage = giveDamage / 100

	return giveDamage
end

function public:GetModifierMiss_Percentage()
	return 22
end