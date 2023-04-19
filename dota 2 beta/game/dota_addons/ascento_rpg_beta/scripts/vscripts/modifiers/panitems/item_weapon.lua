modifier_item_weapon = class({})

local public = modifier_item_weapon

--------------------------------------------------------------------------------

function public:IsHidden() return true end
function public:IsDebuff() return false end
function public:RemoveOnDeath() return false end
function public:IsPurgable() return false end

-------------------------------------------------------------------------------- 
 
function public:OnCreated( kv )

	self:SetHasCustomTransmitterData( true )

	self.item_name = kv.item_name or nil
	self.kvalues = LoadKeyValues("scripts/npc/items/weapon/weapon.kv")
	self.item_damage = {}
	self.item_damage_pct = {}

	-- Parse the key values file to get the bonus damage values for each item.
	for item_name_from_kv, item_data in pairs(self.kvalues) do
		for AbilitySpecial, kv_num in pairs(item_data) do
			for kv_attr, kv_val in pairs(kv_num) do
				if kv_attr == "bonus_damage" then
					self.item_damage[item_name_from_kv] = kv_val
				end
				if kv_attr == "bonus_damage_pct" then
					self.item_damage_pct[item_name_from_kv] = kv_val
				end
			end
		end
	end

end

function public:AddCustomTransmitterData()
	-- on server
	local data = {
		item_name = self.item_name
	}

	return data
end

function public:HandleCustomTransmitterData( data )
	-- on client
	self.item_name = data.item_name
end

function public:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
	}

	return funcs
end

--------------------------------------------------------------------------------

function public:GetModifierBaseAttack_BonusDamage()
	return self.item_damage[self.item_name] or 0
end

function public:GetModifierBaseDamageOutgoing_Percentage()
	return self.item_damage_pct[self.item_name] or 0
end