--[[
Copyright (c) Elfansoer

RESTRICTED MODIFICATION:
Any changes outside Editable Section is prohibited.
- There is no Editable Section in this file.
]]

--------------------------------------------------------------------------------
modifier_cosmetics = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_cosmetics:IsHidden()
	return true
end

function modifier_cosmetics:IsDebuff()
	return false
end

function modifier_cosmetics:IsPurgable()
	return false
end

function modifier_cosmetics:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_cosmetics:AllowIllusionDuplicate()
	return true
end

function modifier_cosmetics:GetTexture()
	return "midas_golden_valkyrie"
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_cosmetics:OnCreated( kv )
	if not IsServer() then return end
	-- init tables
	self.parent = self.parent or self:GetParent()
	self.original_model = self.original_model or self.parent:GetModelName()
	self.wearables = self.wearables or {}
	self.current_persona = self.current_persona or 0

	self:InitIllusion()

	self:Queries( kv )
end

function modifier_cosmetics:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_cosmetics:OnDestroy()
	if not IsServer() then return end

	-- destroy all wearables
	self:UnequipAll()
end

function modifier_cosmetics:RefreshAllCosmetics( requesterItemID, style )
	for slot,data in pairs(self.wearables) do
		data.handle:RefreshCosmetics( requesterItemID, style )
	end
end

--------------------------------------------------------------------------------
-- Queries
function modifier_cosmetics:Queries(kv)
	local query = kv.query
	local itemID = kv.itemID
	local style = kv.style
	local slot = kv.slot

	if not query then
		self:EquipDefault()
	elseif query == "add" then
		-- check if it is set or bundle
		local item = Cosmetics.wearables[ itemID ]
		if item.type=='bundle' then
			for id,_ in pairs(item.bundle) do
				self:Equip( id, style )
			end
		else
			self:Equip( itemID, style )
		end
	elseif query == "remove" then
		if slot == "all" then
			self:Destroy()
		elseif slot == "bundle" then
			self:EquipDefault( 0 )
		elseif self.wearables[ slot ] then
			self:Unequip( slot )
		end
	elseif query == "default" then
		self:EquipDefault( 0 )
	end
end


--------------------------------------------------------------------------------
-- Illusion
function modifier_cosmetics:InitIllusion()
	-- copy illusion wearable from parent
	if self.parent:IsIllusion() then
		-- check parent
		local hero = self.parent:GetPlayerOwner():GetAssignedHero()
		local modifier = hero:FindModifierByName( "modifier_cosmetics" )

		-- check parent model (if different, then it is not a self-illusion)
		if modifier and modifier.original_model==self.parent:GetModelName() then
			self:CopyWearables( hero )
			return
		end
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_cosmetics:Equip( itemID, style )
	-- get item
	local item = Cosmetics.wearables[ itemID ]

	-- handle persona
	if Cosmetics:GetSlotInfo( self.parent, item.slot ).persona_selector==1 then
		self:EquipPersona( itemID, style )
		return
	end

	-- kill existing wearables and modifiers in slot
	self:Unequip( item.slot )

	-- create wearable unit
	local wear = CreateUnitByName(
		"npc_dota_base_additive", -- szUnitName
		self.parent:GetOrigin(), -- vLocation,
		false, -- bFindClearSpace,
		nil, -- hNPCOwner,
		nil, -- hUnitOwner,
		self.parent:GetTeamNumber() -- iTeamNumber
	)

	-- create wearable ambient
	local modifier = wear:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_cosmetics_wearables", -- modifier name
		{
			owner = self.parent:entindex(),
			itemID = itemID,
			style = style,
		} -- kv
	)

	-- register wearable
	local data = {}
	data.handle = modifier
	data.itemID = itemID
	data.style = style
	self.wearables[ item.slot ] = data

	-- self:SpecialBehaviors( itemID, style )
end

function modifier_cosmetics:Unequip( slot )
	local data = self.wearables[ slot ]
	if not data then return end

	local modifier = data.handle
	if modifier and not modifier:IsNull() then
		modifier:Destroy()
	end

	-- remove reference
	self.wearables[ slot ] = nil
end

function modifier_cosmetics:UnequipAll()
	for slot,data in pairs(self.wearables) do
		self:Unequip( slot )
	end
	self.wearables = {}
end

function modifier_cosmetics:EquipDefault()
	-- undo all wearables
	self:UnequipAll()

	-- add default wearables
	local name = self.parent:GetUnitName()
	local default = Cosmetics.default_wearables[ self.parent:GetUnitName() ]

	for slot,id in pairs(default) do
		if not Cosmetics:GetSlotInfo( self.parent, slot ).persona then
			self:Equip( id )
		end
	end
end

function modifier_cosmetics:EquipPersona( itemID, style )
	-- for now, persona is 1 if wearable, 0 if default

	-- get item
	local item = Cosmetics.wearables[ itemID ]
	local persona = 0
	if item.type=="wearable" then
		persona = 1
	end

	-- undo all wearables
	self:UnequipAll()

	-- add default wearables
	local name = self.parent:GetUnitName()
	local default = Cosmetics.default_wearables[ self.parent:GetUnitName() ]

	for slot,id in pairs(default) do
		local slot_info = Cosmetics:GetSlotInfo( self.parent, slot )
		local thisPersona = 0
		if slot_info.persona then
			thisPersona = slot_info.persona
		end

		if (not slot_info.persona_selector) and thisPersona==persona then
			self:Equip( id )
		end
	end

	-- equip persona's own feature
	if persona==1 then
		-- create wearable unit
		local wear = CreateUnitByName(
			"npc_dota_base_additive", -- szUnitName
			self.parent:GetOrigin(), -- vLocation,
			false, -- bFindClearSpace,
			nil, -- hNPCOwner,
			nil, -- hUnitOwner,
			self.parent:GetTeamNumber() -- iTeamNumber
		)

		-- create wearable ambient
		local modifier = wear:AddNewModifier(
			self.parent, -- player source
			self:GetAbility(), -- ability source
			"modifier_cosmetics_wearables", -- modifier name
			{
				owner = self.parent:entindex(),
				itemID = itemID,
				style = style,
			} -- kv
		)

		-- register wearable
		local data = {}
		data.handle = modifier
		data.itemID = itemID
		data.style = style
		self.wearables[ item.slot ] = data
	end
end

--------------------------------------------------------------------------------
function modifier_cosmetics:CopyWearables( hero )
	-- get modifier
	local modifier = hero:FindModifierByName( "modifier_cosmetics" )
	if not modifier then return false end

	-- obtain wearables
	local wearables = modifier.wearables
	if not wearables then return false end

	-- copy wearables
	for slot,data in pairs(wearables) do
		self:Equip( data.itemID )
	end
end

function modifier_cosmetics:GetEquippedWearables()
	local ret = {}
	for k,v in pairs(self.wearables) do
		ret[ k ] = v.itemID
	end

	return ret
end

--------------------------------------------------------------------------------
-- Special behaviors
function modifier_cosmetics:SpecialBehaviors( itemID, style )
	local f = self.SpecialBehaviorList[ self.parent:GetUnitName() ]
	if not f then return end
	f( self, itemID, style )
end

modifier_cosmetics.SpecialBehaviorList = {
["npc_dota_hero_invoker"] = function( self, itemID, style )
	-- get item handle
	local item = Cosmetics.wearables[ itemID ]

	-- check persona slot
	if item.slot=="head_persona_1" or
		item.slot=="shoulder_persona_1" or
		item.slot=="summon_persona_1" or
		item.slot=="back_persona_1" or
		item.slot=="arms_persona_1" or
		item.slot=="armor_persona_1" or
		item.slot=="taunt_persona_1"
	then
		-- check has kid persona enabled
		if not Cosmetics:IsHeroHasEquippedWearables( self.parent, 13042 ) then
			-- unequip
			self:Unequip( item.slot )
		end
	elseif item.slot=="persona_selector" then
		-- equip default, except persona_selector slot
		for slot,data in pairs(self.wearables) do
			if slot~='persona_selector' then
				self:Unequip( slot )
			end
		end

		local default = Cosmetics.default_wearables[ self.parent:GetUnitName() ]

		for slot,id in pairs(default) do
			if slot~='persona_selector' then
				self:Equip( id )
			end
		end	

	elseif item.slot=="ambient_effects" then
		-- do nothing
	else
		-- check has default persona enabled
		if not Cosmetics:IsHeroHasEquippedWearables( self.parent, 683 ) then
			-- unequip
			self:Unequip( item.slot )
		end
	end
end,

["npc_dota_hero_dragon_knight"] = function( self, itemID, style )
	-- get item handle
	local item = Cosmetics.wearables[ itemID ]

	-- check persona slot
	if item.slot=="head_persona_1" or
		item.slot=="weapon_persona_1" or
		item.slot=="armor_persona_1" or
		item.slot=="shapeshift_persona_1" or
		item.slot=="taunt_persona_1"
	then
		-- check has kid persona enabled
		if not Cosmetics:IsHeroHasEquippedWearables( self.parent, 18113 ) then
			-- unequip
			self:Unequip( item.slot )
		end
	elseif item.slot=="persona_selector" then
		-- equip default, except persona_selector slot
		for slot,data in pairs(self.wearables) do
			if slot~='persona_selector' then
				self:Unequip( slot )
			end
		end

		local default = Cosmetics.default_wearables[ self.parent:GetUnitName() ]

		for slot,id in pairs(default) do
			if slot~='persona_selector' then
				self:Equip( id )
			end
		end	

	elseif item.slot=="ambient_effects" then
		-- do nothing
	else
		-- check has default persona enabled
		if not Cosmetics:IsHeroHasEquippedWearables( self.parent, 732 ) then
			-- unequip
			self:Unequip( item.slot )
		end
	end
end,
}