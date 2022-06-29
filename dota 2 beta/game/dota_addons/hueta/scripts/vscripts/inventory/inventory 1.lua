inventory_INTERVAL_THINK = 0.01
inventory_PLUGS = {[1] = 'item_inventory_plug_slot_1',
				   [2] = 'item_inventory_plug_slot_2',
				   [3] = 'item_inventory_plug_slot_3',
				   [4] = 'item_inventory_plug_slot_4',
				   [5] = 'item_inventory_plug_slot_5',
				   [6] = 'item_inventory_plug_slot_6',}

inventory = class({})

function inventory:Init()
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(self, 'NPCSpawned'), self)
end


COUNT_PLAYER_IN_TEAM = {[0] = 0, [1] = 0, [2] = 0, [3] = 0}
CUSTOMS_PLAYER_ID = {}


function inventory:NPCSpawned(data)
	local npc = EntIndexToHScript(data.entindex)

	
	if npc:IsRealHero() and npc.IsFirstSpawned == nil then

		npc.IsFirstSpawned = true

		COUNT_PLAYER_IN_TEAM[npc:GetTeam() - 6] = COUNT_PLAYER_IN_TEAM[npc:GetTeam() - 6] + 1
       --npc.PlayerID = COUNT_PLAYER_IN_TEAM[npc:GetTeam() - 6] + (npc:GetTeam() - 6) * 4 - 1
       CUSTOMS_PLAYER_ID[npc:GetPlayerID()] = COUNT_PLAYER_IN_TEAM[npc:GetTeam() - 6] + (npc:GetTeam() - 6) * 4 - 1
       print(CUSTOMS_PLAYER_ID[npc:GetPlayerID()])

		npc:AddNewModifier(npc, nil, 'inventory', nil)
		local item = npc:AddItem(CreateItem("item_tpfarm",npc,npc))

		for i = 1, 6 do npc:AddItemByName(inventory_PLUGS[i]) end

	end
end

inventory:Init()

LinkLuaModifier('inventory', 'inventory/inventory', LUA_MODIFIER_MOTION_NONE)

function inventory:IsHidden() return true end
function inventory:RemoveOnDeath() return false end
function inventory:IsPurgable() return false end
function inventory:IsPurgeException() return false end

function inventory:OnCreated() self:StartIntervalThink(inventory_INTERVAL_THINK) end

function inventory:OnIntervalThink()



	local hero = self:GetParent()

		    	local hTpScroll = hero:FindItemInInventory("item_tpscroll")
        if hTpScroll then
        	hero:RemoveItem(hTpScroll)
        end


		local finditem1 = hero:FindItemInInventory("item_upgrade_1")
        if finditem1 then

		local finditem = hero:FindItemInInventory("item_clothes_0101")
        local replace = "item_clothes_0102"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_clothes_0102")
        		local replace = "item_clothes_0103"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_clothes_0103")
        		local replace = "item_clothes_0104"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_clothes_0104")
        		local replace = "item_clothes_0105"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_gloves_0101")
        		local replace = "item_gloves_0102"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_gloves_0102")
        		local replace = "item_gloves_0103"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_gloves_0103")
        		local replace = "item_gloves_0104"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_gloves_0104")
        		local replace = "item_gloves_0105"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_hat_0101")
        		local replace = "item_hat_0102"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_hat_0102")
        		local replace = "item_hat_0103"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_hat_0103")
        		local replace = "item_hat_0104"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_hat_0104")
        		local replace = "item_hat_0105"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_shoes_0101")
        		local replace = "item_shoes_0102"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_shoes_0102")
        		local replace = "item_shoes_0103"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_shoes_0103")
        		local replace = "item_shoes_0104"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_shoes_0104")
        		local replace = "item_shoes_0105"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_trinket_0101")
        		local replace = "item_trinket_0102"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_trinket_0102")
        		local replace = "item_trinket_0103"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_trinket_0103")
        		local replace = "item_trinket_0104"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_trinket_0104")
        		local replace = "item_trinket_0105"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_weapon_0701")
        		local replace = "item_weapon_0702"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_weapon_0702")
        		local replace = "item_weapon_0703"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_weapon_0703")
        		local replace = "item_weapon_0704"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)
		    else
		    	local finditem = hero:FindItemInInventory("item_weapon_0704")
        		local replace = "item_weapon_0705"
 			if finditem then
		        hero:RemoveItem(finditem1)
		        hero:RemoveItem(finditem)
		        hero:AddItemByName(replace)


        	end



    	end





	local slots = {}

	for i = 1, 9 do slots[i] = hero:GetItemInSlot(i - 1) end

	for i = 1, 6 do
		if slots[i] == nil then hero:AddItemByName(inventory_PLUGS[i])
		else

			local slot = slots[i]:GetSpecialValueFor('inventory_slot')

			if slot ~= i then
				if slot ~= 0 then

					if tostring(slots[i]:GetAbilityName()):match('item_inventory_plug_slot_') ~= nil then
						hero:RemoveItem(slots[i])
						hero:AddItemByName(inventory_PLUGS[i])
					else
						if tostring(slots[slot]:GetAbilityName()):match('item_inventory_plug_slot_') ~= nil then

							local ItemName = tostring(slots[i]:GetAbilityName())
							local ItemPurchaseTime = slots[i]:GetPurchaseTime()
							local ItemCharges = slots[i]:GetCurrentCharges()
							hero:RemoveItem(slots[i])
							hero:AddItemByName(inventory_PLUGS[i])

							hero:RemoveItem(slots[slot])
							local item = hero:AddItemByName(ItemName)
							item:SetPurchaseTime(ItemPurchaseTime)
							item:SetCurrentCharges(ItemCharges)

						else
							if slots[slot]:GetSpecialValueFor('inventory_slot') == slot then

								local ItemName = tostring(slots[i]:GetAbilityName())
								local ItemPurchaseTime = slots[i]:GetPurchaseTime()
								local ItemCharges = slots[i]:GetCurrentCharges()
								hero:RemoveItem(slots[i])
								hero:AddItemByName(inventory_PLUGS[i])

								local inventory_FULL = true
								for j = 7, 9 do if slots[j] == nil then inventory_FULL = false end end

								if inventory_FULL then
									local item = CreateItem(ItemName, hero, hero)
									item:SetPurchaseTime(ItemPurchaseTime)
									item:SetCurrentCharges(ItemCharges)
									CreateItemOnPositionSync(hero:GetAbsOrigin(), item)
								else
									local item = hero:AddItemByName(ItemName)
									item:SetPurchaseTime(ItemPurchaseTime)
									item:SetCurrentCharges(ItemCharges)
								end

							else
								if slots[slot]:GetSpecialValueFor('inventory_slot') == i then

									local ItemName1 = tostring(slots[i]:GetAbilityName())
									local ItemPurchaseTime1 = slots[i]:GetPurchaseTime()
									local ItemCharges1 = slots[i]:GetCurrentCharges()
									local ItemName2 = tostring(slots[slot]:GetAbilityName())
									local ItemPurchaseTime2 = slots[slot]:GetPurchaseTime()
									local ItemCharges2 = slots[slot]:GetCurrentCharges()

									hero:RemoveItem(slots[slot])
									local item = hero:AddItemByName(ItemName1)
									item:SetPurchaseTime(ItemPurchaseTime1)
									item:SetCurrentCharges(ItemCharges1)

									hero:RemoveItem(slots[i])
									item = hero:AddItemByName(ItemName2)
									item:SetPurchaseTime(ItemPurchaseTime2)
									item:SetCurrentCharges(ItemCharges2)

								else

									local ItemName = tostring(slots[slot]:GetAbilityName())
									local ItemPurchaseTime = slots[slot]:GetPurchaseTime()
									local ItemCharges = slots[slot]:GetCurrentCharges()
									hero:RemoveItem(slots[slot])
									hero:AddItemByName(inventory_PLUGS[slot])

									local inventory_FULL = true
									for j = 7, 9 do if slots[j] == nil then inventory_FULL = false end end

									if inventory_FULL then
										local item = CreateItem(ItemName, hero, hero)
										item:SetPurchaseTime(ItemPurchaseTime)
										item:SetCurrentCharges(ItemCharges)
										CreateItemOnPositionSync(hero:GetAbsOrigin(), item)
									else
										local item = hero:AddItemByName(ItemName)
										item:SetPurchaseTime(ItemPurchaseTime)
										item:SetCurrentCharges(ItemCharges)
									end

								end
							end
						end
					end

				else

					local inventory_SWAP = false
					local SWAP_ITEM
					for j = 7, 9 do
						if slots[j]:GetSpecialValueFor('inventory_slot') == i then inventory_SWAP = true SWAP_ITEM = slots[j] end
					end

					if inventory_SWAP then

						local ItemName1 = tostring(slots[i]:GetAbilityName())
						local ItemPurchaseTime1 = slots[i]:GetPurchaseTime()
						local ItemCharges1 = slots[i]:GetCurrentCharges()
						local ItemName2 = tostring(SWAP_ITEM:GetAbilityName())
						local ItemPurchaseTime2 = SWAP_ITEM:GetPurchaseTime()
						local ItemCharges2 = SWAP_ITEM:GetCurrentCharges()

						hero:RemoveItem(SWAP_ITEM)
						local item = hero:AddItemByName(ItemName1)
						item:SetPurchaseTime(ItemPurchaseTime1)
						item:SetCurrentCharges(ItemCharges1)

						hero:RemoveItem(slots[i])
						item = hero:AddItemByName(ItemName2)
						item:SetPurchaseTime(ItemPurchaseTime2)
						item:SetCurrentCharges(ItemCharges2)

					else

						local ItemName = tostring(slots[i]:GetAbilityName())
						local ItemPurchaseTime = slots[i]:GetPurchaseTime()
						local ItemCharges = slots[i]:GetCurrentCharges()
						hero:RemoveItem(slots[i])
						hero:AddItemByName(inventory_PLUGS[i])

						local inventory_FULL = true
						for j = 7, 9 do if slots[j] == nil then inventory_FULL = false end end

						if inventory_FULL then
							local item = CreateItem(ItemName, hero, hero)
							item:SetPurchaseTime(ItemPurchaseTime)
							item:SetCurrentCharges(ItemCharges)
							CreateItemOnPositionSync(hero:GetAbsOrigin(), item)
						else
							local item = hero:AddItemByName(ItemName)
							item:SetPurchaseTime(ItemPurchaseTime)
							item:SetCurrentCharges(ItemCharges)
						end

					end

				end
			end

		end
	end

	for i = 7, 9 do
		if slots[i] ~= nil then

			local slot = slots[i]:GetSpecialValueFor('inventory_slot')

			if slot ~= 0 and tostring(slots[slot]:GetAbilityName()):match('item_inventory_plug_slot_') ~= nil then

				local ItemName = tostring(slots[i]:GetAbilityName())
				local ItemPurchaseTime = slots[i]:GetPurchaseTime()
				local ItemCharges = slots[i]:GetCurrentCharges()
				hero:RemoveItem(slots[i])

				hero:RemoveItem(slots[slot])
				local item = hero:AddItemByName(ItemName)
				item:SetPurchaseTime(ItemPurchaseTime)
				item:SetCurrentCharges(ItemCharges)
				
			end

		end
	end

end