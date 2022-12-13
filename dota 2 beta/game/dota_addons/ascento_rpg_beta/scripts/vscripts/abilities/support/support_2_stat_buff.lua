support_2_stat_buff = class({})
modifier_support_2_stat_buff = class({})

LinkLuaModifier( "modifier_support_2_stat_buff", "abilities/support/support_2_stat_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function support_2_stat_buff:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local all_stats = self:GetSpecialValueFor("bonus_all_stats")
	local all_stats_pct = self:GetSpecialValueFor("bonus_all_stats_pct")
	local buffDuration = self:GetSpecialValueFor("duration_buff")

	if caster:HasModifier("modifier_donate_aura_damage") then
		all_stats = all_stats * 2
		all_stats_pct = all_stats_pct * 2
		buffDuration = buffDuration * 2
	end

	if target:HasModifier("modifier_support_2_stat_buff") then
		target:RemoveModifierByName("modifier_support_2_stat_buff")
		-- Add modifier
		target:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_support_2_stat_buff", -- modifier name
			{ duration = buffDuration } -- kv
		)
	else
		target:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_support_2_stat_buff", -- modifier name
			{ duration = buffDuration } -- kv
		)
	end

end


--------------------------------------------------------------------------------
-- Classifications
function modifier_support_2_stat_buff:IsHidden()
	return false
end

function modifier_support_2_stat_buff:IsDebuff()
	return false
end

function modifier_support_2_stat_buff:IsPurgable()
	return false
end

function modifier_support_2_stat_buff:IsStackable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_support_2_stat_buff:OnCreated( kv )
	if IsServer() then

		local all_stats = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
		local all_stats_pct = self:GetAbility():GetSpecialValueFor("bonus_all_stats_pct") / 100
		local buffDuration = self:GetAbility():GetSpecialValueFor("duration_buff")

		if self:GetCaster():HasModifier("modifier_donate_aura_damage") then
			all_stats = all_stats * 2
			all_stats_pct = all_stats_pct * 2
			buffDuration = buffDuration * 2
		end

		self.strength = all_stats + (self:GetParent():GetStrength() * all_stats_pct)
		self.agility = all_stats + (self:GetParent():GetAgility() * all_stats_pct)
		self.intellect = all_stats + (self:GetParent():GetIntellect() * all_stats_pct)
	
		self:SetDuration(buffDuration, true )
	end
end

function modifier_support_2_stat_buff:OnRefresh( kv )
	if IsServer() then
		local all_stats = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
		local all_stats_pct = self:GetAbility():GetSpecialValueFor("bonus_all_stats_pct") / 100

		if self:GetCaster():HasModifier("modifier_donate_aura_damage") then
			all_stats = all_stats * 2
			all_stats_pct = all_stats_pct * 2
		end

		self.strength = all_stats + (self:GetParent():GetStrength() * all_stats_pct)
		self.agility = all_stats + (self:GetParent():GetAgility() * all_stats_pct)
		self.intellect = all_stats + (self:GetParent():GetIntellect() * all_stats_pct)
	end
end

function modifier_support_2_stat_buff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_support_2_stat_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}

	return funcs
end

function modifier_support_2_stat_buff:GetModifierBonusStats_Strength()
	return self.strength
end

function modifier_support_2_stat_buff:GetModifierBonusStats_Agility()
	return self.agility
end

function modifier_support_2_stat_buff:GetModifierBonusStats_Intellect()
	return self.intellect
end



function modifier_support_2_stat_buff:GetTexture() return "support_2_stat_buff" end
