
if ItemDrop == nil then
	_G.ItemDrop = class({})

end

-------------------------------------------------------------------------------------------------------------------------------------
ItemDrop.chance_01 = 899
ItemDrop.chance_02 = 249
ItemDrop.chance_03 = 19
ItemDrop.chance_04 = 9

ItemDrop.chance_mini_04 = 500

ItemDrop.chance_boss_04 = 5000

ItemDrop.item_type = {"weapon", "trinket", "shoes", "hat", "gloves", "clothes"} --Типы предметов для дропа

ItemDrop.item_rang = {"novichok", "goblin", "dragon", "god"} --Ранги предметов для дропа

ItemDrop.unit_drops = {"npc_creep_farm_1", "npc_creep_farm_2", "npc_creep_farm_3", "npc_creep_farm_4"} --Дроп с крипов

ItemDrop.mini_boss_drops = {"npc_boss1", "npc_boss2", "npc_boss3", "npc_boss4"} --Дроп с мини боссов

ItemDrop.boss_drops = {"npc_b_1", "npc_b_2", "npc_b_3", "npc_b_4", "npc_b_5", "npc_b_6", "npc_b_7", "npc_b_8"} --Дроп с боссов

ItemDrop.item_units_01 = {"item_weapon_0701", "item_trinket_0101", "item_shoes_0101", "item_hat_0101", "item_gloves_0101", "item_clothes_0101"}
ItemDrop.item_units_02 = {"item_weapon_0801", "item_trinket_0201", "item_shoes_0201", "item_hat_0201", "item_gloves_0201", "item_clothes_0201"}
ItemDrop.item_units_03 = {"item_weapon_0901", "item_trinket_0301", "item_shoes_0301", "item_hat_0301", "item_gloves_0301", "item_clothes_0301"}
ItemDrop.item_units_04 = {"item_weapon_1001", "item_trinket_0401", "item_shoes_0401", "item_hat_0401", "item_gloves_0401", "item_clothes_0401"}
ItemDrop.item_mini_boss = {"item_weapon_0901", "item_trinket_0301", "item_shoes_0301", "item_hat_0301", "item_gloves_0301", "item_clothes_0301"}
ItemDrop.item_boss = {"item_weapon_0901", "item_trinket_0301", "item_shoes_0301", "item_hat_0301", "item_gloves_0301", "item_clothes_0301", "item_weapon_1001", "item_trinket_0401", "item_shoes_0401", "item_hat_0401", "item_gloves_0401", "item_clothes_0401"}
-------------------------------------------------------------------------------------------------------------------------------------

ItemDrop.item_drop = {

		{items = ItemDrop.item_units_01, chance = ItemDrop.chance_01, duration = 20, units = ItemDrop.unit_drops},
		{items = ItemDrop.item_units_02, chance = ItemDrop.chance_02, duration = 20, units = ItemDrop.unit_drops},
		{items = ItemDrop.item_units_03, chance = ItemDrop.chance_03, duration = 20, units = ItemDrop.unit_drops},
		{items = ItemDrop.item_units_04, chance = ItemDrop.chance_04, duration = 20, units = ItemDrop.unit_drops},


		-------------------------------------------------------------------------------------

		{items = ItemDrop.item_mini_boss, chance = chance_mini_04, units = ItemDrop.mini_boss_drops},

		-------------------------------------------------------------------------------------

		{items = ItemDrop.item_boss, chance = chance_boss_04, units = ItemDrop.boss_drops},

} --END DROP

ItemDrop.secret_items = {
--	["point_name"] = "item_name",
--	["item_spawner_1"] = "item_power_treads",
--	["item_spawner_2"] = "item_rapier",
--	["item_spawner_123"] = "item_rapier",

}

function ItemDrop:InitGameMode()
	ListenToGameEvent('entity_killed', Dynamic_Wrap(self, 'OnEntityKilled'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(self, 'OnGameRulesStateChange'), self)
end

function ItemDrop:OnGameRulesStateChange()
	local newState = GameRules:State_Get()

	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		ItemDrop:SpawnItems()
	end
end

function ItemDrop:SpawnItems()
	local items = self.secret_items
	for point_name,item_name in pairs(items) do
		local point = Entities:FindByName(nil, point_name)
		if point then
			point = point:GetAbsOrigin()
			local newItem = CreateItem( item_name, nil, nil )
			local drop = CreateItemOnPositionSync( point, newItem )
		else
			print("point with name "..point_name.." dont exist !")
		end
	end
end

function ItemDrop:OnEntityKilled( keys )
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	local name = killedUnit:GetUnitName()
	local team = killedUnit:GetTeam()

	    local hTpScroll = killedUnit:FindItemInInventory("item_tpscroll")
        if hTpScroll then
        	killedUnit:RemoveItem(hTpScroll)
        end

	if team == DOTA_TEAM_BADGUYS and name ~= "npc_dota_thinker" then
		ItemDrop:RollItemDrop(killedUnit)
	end

end




function ItemDrop:RollItemDrop(unit)
	local unit_name = unit:GetUnitName()

	for _,drop in ipairs(self.item_drop) do
		local items = drop.items or nil
		local items_num = #items
		local item_name = items[1] -- название предмета
		local units = drop.units or nil -- если юниты не были определены, то срабатывает для любого
		local chance = drop.chance or 90000 -- если шанс не был определен, то он равен 100
		local loot_duration = drop.duration or 60 -- длительность жизни предмета на земле
		local limit = drop.limit or nil -- лимит предметов
		local roll_chance = RandomFloat(0, 90000)
			
		if units then 
			for _,current_name in pairs(units) do
				if current_name == unit_name then
					units = nil
					break
				end
			end
		end

		if units == nil and (limit == nil or limit > 0) and roll_chance < chance then
			if limit then
				drop.limit = drop.limit - 1
			end

			if items_num > 1 then
				item_name = items[RandomInt(1, #items)]
			end

			local spawnPoint = unit:GetAbsOrigin()	
			local newItem = CreateItem( item_name, nil, nil )
			local drop = CreateItemOnPositionForLaunch( spawnPoint, newItem )
			local dropRadius = RandomFloat( 250, 350 )

			newItem:LaunchLootInitialHeight( false, 0, 150, 0.5, spawnPoint + RandomVector( dropRadius ) )
			if loot_duration then
				newItem:SetContextThink( "KillLoot", 
					function() 
						if drop:IsNull() then
							return
						end

						local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, drop )
						ParticleManager:SetParticleControl( nFXIndex, 0, drop:GetOrigin() )
						ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
						ParticleManager:ReleaseParticleIndex( nFXIndex )
					--	EmitGlobalSound("Item.PickUpWorld")

						UTIL_Remove( item )
						UTIL_Remove( drop )
					end, loot_duration )
			end
		end
	end	
end

function KillLoot( item, drop )

	if drop:IsNull() then
		return
	end

	local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, drop )
	ParticleManager:SetParticleControl( nFXIndex, 0, drop:GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
--	EmitGlobalSound("Item.PickUpWorld")

	UTIL_Remove( item )
	UTIL_Remove( drop )
end

ItemDrop:InitGameMode()