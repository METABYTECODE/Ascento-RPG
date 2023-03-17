--Example:
--Ascento:ApplyDDModifier(caster, "ability_name", "modifier_name")

--  Марся:
--  models/items/marci/marci_combat_maid_armor/marci_combat_maid_armor.vmdl
--  models/items/marci/marci_combat_maid_back/marci_combat_maid_back.vmdl
--  models/items/marci/marci_combat_maid_head/marci_combat_maid_head.vmdl
--  models/items/marci/marci_combat_maid_shoulder/marci_combat_maid_shoulder.vmdl

if not Ascento then
  Ascento = class({})
end

function Ascento:RandomEndlessModifier(hero, endlvl, PackName)

local playerID = hero:GetPlayerID()
local player = PlayerResource:GetPlayer(playerID)
local mode = KILL_VOTE_RESULT:upper()
local chance = 25
local firstchance = 1

if endlvl >= 100 then
    firstchance = 3
elseif endlvl >= 300 then
    firstchance = 5
elseif endlvl >= 500 then
    firstchance = 7
elseif endlvl >= 700 then
    firstchance = 9
elseif endlvl >= 900 then
    firstchance = 11
elseif endlvl >= 1100 then
    firstchance = 12
elseif endlvl >= 1300 then
    firstchance = 13
elseif endlvl >= 1500 then
    firstchance = 14
elseif endlvl >= 1700 then
    firstchance = 15
elseif endlvl >= 1900 then
    firstchance = 16
elseif endlvl >= 2100 then
    firstchance = 17
elseif endlvl >= 2300 then
    firstchance = 18
elseif endlvl >= 2500 then
    firstchance = 19
elseif endlvl >= 2700 then
    firstchance = 20
end

if PackName == "pack9" then
    firstchance = firstchance + 15
end

    if RollPercentage(firstchance) then
        if mode == "NORMAL" then
            chance = 75
        elseif mode == "HARD" then
            chance = 80
        elseif mode == "UNFAIR" then
            chance = 85
        elseif mode == "IMPOSSIBLE" then
            chance = 90
        elseif mode == "HELL" then
            chance = 95
        elseif mode == "HARDCORE" then
            chance = 100
        end

        if RollPercentage(chance) then

            local modifiers = LoadKeyValues('scripts/kv/endless_modifiers.kv')
        
            local giveNumber = RandomInt(1, 15)
            --print("giveNumber " .. giveNumber)
              
            for k, v in pairs(modifiers) do
                if k ~= nil and v ~= nil then
                    if v == giveNumber then
        
                        local givemodifier = k
        
                        if not hero:HasModifier(givemodifier) then
                      
                            local modifier = hero:AddNewModifier (hero, nil, givemodifier, {duration = -1})
                            if modifier then
                                modifier:SetStackCount(1)
                            end
                        else
                            local modifier = hero:FindModifierByName(givemodifier)
                            if modifier then
                              modifier:IncrementStackCount()
                            end
                        end
        
                      

                        if hero:HasModifier(givemodifier) then
                            local modifier = hero:FindModifierByName(givemodifier)
                            local modifStack = modifier:GetStackCount()

                            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = tonumber(giveNumber), modifierValue = tonumber(modifStack)})

                            --print(giveNumber .. ": Записываем в " .. givemodifier .. " Число " .. modifStack)\
                            if giveNumber == 1 then
                              hero.endless_1 = modifStack
                              --print(hero.endless_1)
                            elseif giveNumber == 2 then
                              hero.endless_2 = modifStack
                              --print(hero.endless_2)
                            elseif giveNumber == 3 then
                              hero.endless_3 = modifStack
                              --print(hero.endless_3)
                            elseif giveNumber == 4 then
                              hero.endless_4 = modifStack
                              --print(hero.endless_4)
                            elseif giveNumber == 5 then
                              hero.endless_5 = modifStack
                              --print(hero.endless_5)
                            elseif giveNumber == 6 then
                              hero.endless_6 = modifStack
                              --print(hero.endless_6)
                            elseif giveNumber == 7 then
                              hero.endless_7 = modifStack
                              --print(hero.endless_7)
                            elseif giveNumber == 8 then
                              hero.endless_8 = modifStack
                              --print(hero.endless_8)
                            elseif giveNumber == 9 then
                              hero.endless_9 = modifStack
                              --print(hero.endless_9)
                            elseif giveNumber == 10 then
                              hero.endless_10 = modifStack
                              --print(hero.endless_10)
                            elseif giveNumber == 11 then
                              hero.endless_11 = modifStack
                              --print(hero.endless_11)
                            elseif giveNumber == 12 then
                              hero.endless_12 = modifStack
                              --print(hero.endless_12)
                            elseif giveNumber == 13 then
                              hero.endless_13 = modifStack
                              --print(hero.endless_13)
                            elseif giveNumber == 14 then
                                hero.endless_14 = modifStack
                              --print(hero.endless_14)
                            elseif giveNumber == 15 then
                                hero.endless_15 = modifStack
                              --print(hero.endless_15)
                            end

                            hero.allEndless = hero.endless_1 + hero.endless_2 + hero.endless_3 + hero.endless_4 + hero.endless_5 + hero.endless_6 + hero.endless_7 + hero.endless_8 + hero.endless_9 + hero.endless_10 + hero.endless_11 + hero.endless_12 + hero.endless_13 + hero.endless_14 + hero.endless_15
                            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_update_all_endless", {AllModifiers = tonumber(hero.allEndless)})

                        end
                    end
                end
            end
        end
    end
end

function Ascento:ApplyDDModifier(target, ability_name, modifier_name)

	local ability = target:AddAbility(ability_name) 
  ability:UpgradeAbility(true)
  ability:ApplyDataDrivenModifier(target, target, modifier_name, {})

end

function Ascento:Obnulenie(hero)
    if GetMapName() == "ascento_rpg" then
          --print("0")
          if not hero then return end
          if not hero:GetUnitName() then return end
          --if not IsServer() then return end
          --print("1")

          local playerID = hero:GetPlayerOwnerID()
          local player = PlayerResource:GetPlayer(playerID)
          local heroname = hero:GetUnitName()

          local neutral_item = hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)

          if neutral_item ~= nil then
            neutral_item_name = neutral_item:GetName()
          end

          EndlessSpawn:ClearPack(playerID)


          CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_boss", {playerKilledBoss = 0})
          CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_creeps", {playerKilledCreeps = 0})

          GameMode:FastWin(playerID)

          ClearPlayerItems(hero)

          if hero:GetUnitName() == "npc_dota_hero_nevermore" then
            UTIL_Remove(hero.arcanaitem1)
            UTIL_Remove(hero.arcanaitem2)
            UTIL_Remove(hero.arcanaitem3)
              
            --UTIL_Remove(Entities:FindByModelWithin(nil, "models/heroes/shadow_fiend/arcana_wings.vmdl", hero:GetAbsOrigin(), 200))
            --UTIL_Remove(Entities:FindByModelWithin(nil, "models/heroes/shadow_fiend/head_arcana.vmdl", hero:GetAbsOrigin(), 200))
            --UTIL_Remove(Entities:FindByModelWithin(nil, "models/items/shadow_fiend/arms_deso/arms_deso.vmdl", hero:GetAbsOrigin(), 200))
          end




          local new_hero = PlayerResource:ReplaceHeroWith(playerID, heroname, 0, 0)



          --print(neutral_item_name)
            if neutral_item_name ~= nil then
              new_hero:AddItemByName(neutral_item_name)
            end

            if new_hero:GetUnitName() == "npc_dota_hero_nevermore" or new_hero:GetUnitName() == "npc_dota_hero_juggernaut" then
              if new_hero:HasModifier("modifier_profession") then
                local CurrentProf = new_hero:FindModifierByName("modifier_profession")
                CurrentProf:SetStackCount(3)
              else
                local CurrentProf = new_hero:AddNewModifier (new_hero, nil, "modifier_profession", {duration = -1})
                CurrentProf:SetStackCount(3)
              end
            end

            if new_hero:GetUnitName() == "npc_dota_hero_nevermore" then
              local item = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/shadow_fiend/arcana_wings.vmdl"})
              item:FollowEntity(new_hero, true)
              new_hero.arcanaitem1 = item
          
              local item = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/shadow_fiend/head_arcana.vmdl"})
              item:FollowEntity(new_hero, true)
              new_hero.arcanaitem2 = item
              
              local item = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/items/shadow_fiend/arms_deso/arms_deso.vmdl"})
              item:FollowEntity(new_hero, true)
              new_hero.arcanaitem3 = item
            end

        local newplayerID = new_hero:GetPlayerOwnerID()
          local newplayer = PlayerResource:GetPlayer(newplayerID)

            CustomGameEventManager:Send_ServerToPlayer(newplayer, 'on_player_reinc_success', {})

          --Say(new_hero, "You hero Reincarnate successfull!", false)

          Timers:CreateTimer(3,function()
                GameMode:FirstLoadNoReq(new_hero)
                ClearPlayerItems(new_hero)
                UTIL_Remove(hero)

          --print("3")
          return nil
          end) 
          
    end
  --print("2")
end

function Ascento:CheckItem(hero, item)
    if GetMapName() == "ascento_rpg" then

        if hero ~= nil and item ~= nil then


            if item:GetName() == "item_tpscroll" then
                hero:RemoveItem(item)
                return
            end

          if item:GetName() == "item_lia_health_elixir" or item:GetName() == "item_lia_health_stone_potion" or item:GetName() == "item_lia_health_stone_potion_two" or item:GetName() == "item_hallowen_legendary_pet_datadriven" then return end 

          --Timers:CreateTimer(0.01,function()
            if hero ~= nil and item ~= nil and item:GetName() ~= "item_lia_health_elixir" and item:GetName() ~= "item_lia_health_stone_potion" and item:GetName() ~= "item_lia_health_stone_potion_two" and item:GetName() ~= "item_hallowen_legendary_pet_datadriven" then
              if item:IsMuted() then
                hero:DropItemAtPositionImmediate(item, hero:GetAbsOrigin())
                CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(), "create_error_message", {message = "YOU CAN'T TAKE ALLY ITEMS"})
                return
              end
            end
            --return nil
          --end) 

          local holy_shit =
          {
            "item_holy_1",
            "item_holy_2",
            "item_holy_3",
            "item_holy_4",
            "item_holy_5",
            "item_holy_6",
            "item_holy_7",
            "item_holy_8",
            "item_holy_9",
            "item_holy_10",
            "item_holy_11",
            "item_holy_12",
            "item_holy_13",
            "item_holy_14",
            "item_holy_15",
            "item_holy_16",
            "item_holy_17",
            "item_holy_18",
            "item_holy_19",
            "item_holy_20",
            "item_holy_21",
            "item_holy_22",
            "item_holy_23",
            "item_holy_24",
            "item_holy_25",
            "item_holy_26",
            "item_holy_27",
            "item_holy_28",
            "item_holy_29",
            "item_holy_30",
            "item_holy_31",
            "item_holy_32",
            "item_holy_33",
            "item_holy_34",
            "item_holy_35",
            "item_holy_36",
            "item_holy_37",
            "item_holy_38",
            "item_holy_39",
            "item_holy_40",
            "item_holy_41",
            "item_holy_42",
            "item_holy_43",
            "item_holy_44",
            "item_holy_45",
            "item_holy_46",
            "item_holy_47",
            "item_holy_48",
            "item_holy_49",
            "item_holy_50",
            "item_holy_51",
            "item_holy_52",
            "item_holy_53",
            "item_holy_54",
            "item_holy_55",
            "item_holy_56",
            "item_holy_57",
            "item_holy_58",
            "item_holy_59",
            "item_holy_60",
            "item_holy_61",
            "item_holy_62",
            "item_holy_63",
            "item_holy_64",
            "item_holy_65",
            "item_holy_66",
            "item_holy_67",
            "item_holy_68",
            "item_holy_69",
            "item_holy_70",
            "item_holy_71",
            "item_holy_72",
            "item_holy_73",
            "item_holy_74",
            "item_holy_75",
            "item_holy_76",
            "item_holy_77",
            "item_holy_78",
            "item_holy_79",
            "item_holy_80",
            "item_holy_81",
            "item_holy_82",
            "item_holy_83",
            "item_holy_84",
            "item_holy_85",
            "item_holy_86",
            "item_holy_87",
            "item_holy_88",
            "item_holy_89",
            "item_holy_90",
            "item_holy_91",
            "item_holy_92",
            "item_holy_93",
            "item_holy_94",
            "item_holy_95",
            "item_holy_96",
            "item_holy_97",
            "item_holy_98",
            "item_holy_99",
            "item_holy_100"
          }

          local agility =
          {
            "item_agility_1",
            "item_agility_2",
            "item_agility_3",
            "item_agility_4",
            "item_agility_5",
            "item_agility_6",
            "item_agility_7",
            "item_agility_8",
            "item_agility_9",
            "item_agility_10",
            "item_agility_11",
            "item_agility_12",
            "item_agility_13",
            "item_agility_14",
            "item_agility_15",
            "item_agility_16",
            "item_agility_17",
            "item_agility_18",
            "item_agility_19",
            "item_agility_20",
            "item_agility_21",
            "item_agility_22",
            "item_agility_23",
            "item_agility_24",
            "item_agility_25",
            "item_agility_26",
            "item_agility_27",
            "item_agility_28",
            "item_agility_29",
            "item_agility_30",
            "item_agility_31"
          }
        
          local armor =
          {
            "item_armor_1",
            "item_armor_2",
            "item_armor_3",
            "item_armor_4",
            "item_armor_5",
            "item_armor_6",
            "item_armor_7",
            "item_armor_8",
            "item_armor_9",
            "item_armor_10",
            "item_armor_11",
            "item_armor_12",
            "item_armor_13",
            "item_armor_14",
            "item_armor_15",
            "item_armor_16",
            "item_armor_17",
            "item_armor_18",
            "item_armor_19",
            "item_armor_20",
            "item_armor_21",
            "item_armor_22",
            "item_armor_23",
            "item_armor_24",
            "item_armor_25",
            "item_armor_26",
            "item_armor_27",
            "item_armor_28",
            "item_armor_29",
            "item_armor_30",
            "item_armor_31"
          }
        
        
          local artifact =
          {
            "item_artifact_1",
            "item_artifact_2",
            "item_artifact_3",
            "item_artifact_4",
            "item_artifact_5",
            "item_artifact_6",
            "item_artifact_7",
            "item_artifact_8",
            "item_artifact_9",
            "item_artifact_10",
            "item_artifact_11",
            "item_artifact_12",
            "item_artifact_13",
            "item_artifact_14",
            "item_artifact_15",
            "item_artifact_16",
            "item_artifact_17",
            "item_artifact_18",
            "item_artifact_19",
            "item_artifact_20",
            "item_artifact_21",
            "item_artifact_22",
            "item_artifact_23",
            "item_artifact_24",
            "item_artifact_25",
            "item_artifact_26",
            "item_artifact_27",
            "item_artifact_28",
            "item_artifact_29",
            "item_artifact_30",
            "item_artifact_31"
          }
        
          local health =
          {
            "item_health_1",
            "item_health_2",
            "item_health_3",
            "item_health_4",
            "item_health_5",
            "item_health_6",
            "item_health_7",
            "item_health_8",
            "item_health_9",
            "item_health_10",
            "item_health_11",
            "item_health_12",
            "item_health_13",
            "item_health_14",
            "item_health_15",
            "item_health_16",
            "item_health_17",
            "item_health_18",
            "item_health_19",
            "item_health_20",
            "item_health_21",
            "item_health_22",
            "item_health_23",
            "item_health_24",
            "item_health_25",
            "item_health_26",
            "item_health_27",
            "item_health_28",
            "item_health_29",
            "item_health_30",
            "item_health_31"
          }
        
          local mage =
          {
            "item_mage_1",
            "item_mage_2",
            "item_mage_3",
            "item_mage_4",
            "item_mage_5",
            "item_mage_6",
            "item_mage_7",
            "item_mage_8",
            "item_mage_9",
            "item_mage_10",
            "item_mage_11",
            "item_mage_12",
            "item_mage_13",
            "item_mage_14",
            "item_mage_15",
            "item_mage_16",
            "item_mage_17",
            "item_mage_18",
            "item_mage_19",
            "item_mage_20",
            "item_mage_21",
            "item_mage_22",
            "item_mage_23",
            "item_mage_24",
            "item_mage_25",
            "item_mage_26",
            "item_mage_27",
            "item_mage_28",
            "item_mage_29",
            "item_mage_30",
            "item_mage_31"
          }
        
          local ring =
          {
            "item_ring_1",
            "item_ring_2",
            "item_ring_3",
            "item_ring_4",
            "item_ring_5",
            "item_ring_6",
            "item_ring_7",
            "item_ring_8",
            "item_ring_9",
            "item_ring_10",
            "item_ring_11",
            "item_ring_12",
            "item_ring_13",
            "item_ring_14",
            "item_ring_15",
            "item_ring_16",
            "item_ring_17",
            "item_ring_18",
            "item_ring_19",
            "item_ring_20",
            "item_ring_21",
            "item_ring_22",
            "item_ring_23",
            "item_ring_24",
            "item_ring_25",
            "item_ring_26",
            "item_ring_27",
            "item_ring_28",
            "item_ring_29",
            "item_ring_30",
            "item_ring_31"
          }
        
          local strength =
          {
            "item_strength_1",
            "item_strength_2",
            "item_strength_3",
            "item_strength_4",
            "item_strength_5",
            "item_strength_6",
            "item_strength_7",
            "item_strength_8",
            "item_strength_9",
            "item_strength_10",
            "item_strength_11",
            "item_strength_12",
            "item_strength_13",
            "item_strength_14",
            "item_strength_15",
            "item_strength_16",
            "item_strength_17",
            "item_strength_18",
            "item_strength_19",
            "item_strength_20",
            "item_strength_21",
            "item_strength_22",
            "item_strength_23",
            "item_strength_24",
            "item_strength_25",
            "item_strength_26",
            "item_strength_27",
            "item_strength_28",
            "item_strength_29",
            "item_strength_30",
            "item_strength_31"
          }
        
          local weapon =
          {
            "item_weapon_1",
            "item_weapon_2",
            "item_weapon_3",
            "item_weapon_4",
            "item_weapon_5",
            "item_weapon_6",
            "item_weapon_7",
            "item_weapon_8",
            "item_weapon_9",
            "item_weapon_10",
            "item_weapon_11",
            "item_weapon_12",
            "item_weapon_13",
            "item_weapon_14",
            "item_weapon_15",
            "item_weapon_16",
            "item_weapon_17",
            "item_weapon_18",
            "item_weapon_19",
            "item_weapon_20",
            "item_weapon_21",
            "item_weapon_22",
            "item_weapon_23",
            "item_weapon_24",
            "item_weapon_25",
            "item_weapon_26",
            "item_weapon_27",
            "item_weapon_28",
            "item_weapon_29",
            "item_weapon_30",
            "item_weapon_31"
          }
        
        
          local AdvancedTableMT = {__index = {
          HasValue = function(self, value)
              for _, v in pairs(self) do
                  if v == value then
                      return true
                  end
              end
              return false
          end
          }}

          if type(holy_shit) ~= "table" then
              holy_shit = {holy_shit}
          end
          setmetatable(holy_shit, AdvancedTableMT)
        
          if type(weapon) ~= "table" then
              weapon = {weapon}
          end
          setmetatable(weapon, AdvancedTableMT)
        
          if type(strength) ~= "table" then
              strength = {strength}
          end
          setmetatable(strength, AdvancedTableMT)
        
          if type(artifact) ~= "table" then
              artifact = {artifact}
          end
          setmetatable(artifact, AdvancedTableMT)
        
          if type(ring) ~= "table" then
              ring = {ring}
          end
          setmetatable(ring, AdvancedTableMT)
        
          if type(mage) ~= "table" then
              mage = {mage}
          end
          setmetatable(mage, AdvancedTableMT)
        
          if type(health) ~= "table" then
              health = {health}
          end
          setmetatable(health, AdvancedTableMT)
        
          if type(agility) ~= "table" then
              agility = {agility}
          end
          setmetatable(agility, AdvancedTableMT)
        
          if type(armor) ~= "table" then
              armor = {armor}
          end
          setmetatable(armor, AdvancedTableMT)
        
                local itemName = item:GetName()
                local drop = 0
                local ans = 0
                local ans1 = 0
                local ans2 = 0
                local ans3 = 0
                local ans4 = 0
                local ans5 = 0
                local ans6 = 0
                local ans7 = 0
                local ans8 = 0
                for slot = 0, 8 do
                  local itemIN = hero:GetItemInSlot(slot)



                  if itemIN ~= nil then

                    if holy_shit:HasValue(itemName) and itemIN:GetName() == itemName then
                      hero:SwapItems( slot, DOTA_ITEM_NEUTRAL_SLOT )
                    end


                    --if itemIN:GetName() == itemName then
                      if weapon:HasValue(itemName) and weapon:HasValue(itemIN:GetName()) then
                        ans1 = ans1 + 1
                        if ans1 > 1 then
                          Ascento:DropDoubleItem(hero, itemIN)
                        end
                      end
                      if armor:HasValue(itemName) and armor:HasValue(itemIN:GetName()) then
                        ans2 = ans2 + 1
                        if ans2 > 1 then
                          Ascento:DropDoubleItem(hero, itemIN)
                        end
                      end
                      if artifact:HasValue(itemName) and artifact:HasValue(itemIN:GetName()) then
                        ans3 = ans3 + 1
                        if ans3 > 1 then
                          Ascento:DropDoubleItem(hero, itemIN)
                        end
                      end
                      if agility:HasValue(itemName) and agility:HasValue(itemIN:GetName()) then
                        ans4 = ans4 + 1
                        if ans4 > 1 then
                          Ascento:DropDoubleItem(hero, itemIN)
                        end
                      end
                      if health:HasValue(itemName) and health:HasValue(itemIN:GetName()) then
                        ans5 = ans5 + 1
                        if ans5 > 1 then
                          Ascento:DropDoubleItem(hero, itemIN)
                        end
                      end
                      if mage:HasValue(itemName) and mage:HasValue(itemIN:GetName()) then
                        ans6 = ans6 + 1
                        if ans6 > 1 then
                          Ascento:DropDoubleItem(hero, itemIN)
                        end
                      end
                      if ring:HasValue(itemName) and ring:HasValue(itemIN:GetName()) then
                        ans7 = ans7 + 1
                        if ans7 > 1 then
                          Ascento:DropDoubleItem(hero, itemIN)
                        end
                      end
                      if strength:HasValue(itemName) and strength:HasValue(itemIN:GetName()) then
                        ans8 = ans8 + 1
                        if ans8 > 1 then
                          Ascento:DropDoubleItem(hero, itemIN)
                        end
                      end


                      if itemIN:GetName() == itemName then
                          ans = ans + 1
                          --print("ans: " .. ans)
                          if ans > 1 then
                              for doit = 1, ans do
                                  if weapon:HasValue(itemName) then 
                                    Ascento:DropDoubleItem(hero, itemIN)
                                  end
                                  if armor:HasValue(itemName) then 
                                    Ascento:DropDoubleItem(hero, itemIN)
                                  end
                                  if artifact:HasValue(itemName) then 
                                    Ascento:DropDoubleItem(hero, itemIN)
                                  end
                                  if agility:HasValue(itemName) then 
                                    Ascento:DropDoubleItem(hero, itemIN)
                                  end
                                  if health:HasValue(itemName) then 
                                    Ascento:DropDoubleItem(hero, itemIN)
                                  end
                                  if mage:HasValue(itemName) then 
                                    Ascento:DropDoubleItem(hero, itemIN)
                                  end
                                  if ring:HasValue(itemName) then 
                                    Ascento:DropDoubleItem(hero, itemIN)
                                  end
                                  if strength:HasValue(itemName) then 
                                    Ascento:DropDoubleItem(hero, itemIN)
                                  end
                              end
                              ans = 1
                          end
                      end




                  end

            end
        end
    end
end



function Ascento:DropDoubleItem(hero, item)
    if GetMapName() == "ascento_rpg" then
        Timers:CreateTimer(0.01,function()
            hero:DropItemAtPositionImmediate(item, hero:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
        
    end
end



CustomGameEventManager:RegisterListener("ReincEvent", function(_, event)

    local playerID = event.playerID
    local player = PlayerResource:GetPlayer(playerID)
    local steamID = PlayerResource:GetSteamAccountID(playerID)

    local hero = PlayerResource:GetSelectedHeroEntity(playerID)
    if not hero then return end

    local heroname = hero:GetUnitName()
    if not heroname then return end


    if hero.boss_kills >= BOSS_KILLS_DEFAULT and hero.creep_kills >= CREEP_KILLS_DEFAULT and hero.canreinc == 1 then
        local zapasCreeps = hero.creep_kills - CREEP_KILLS_DEFAULT
        local zapasBoss = hero.boss_kills - BOSS_KILLS_DEFAULT


        if not hero:GetUnitName() then return end
        --if not IsServer() then return end

        
        local neutral_item = hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
        
        if neutral_item ~= nil then
          neutral_item_name = neutral_item:GetName()
        end

        if steamID ~= 908758431 then --Остатки сладки Night Wolf
            zapasCreeps = 0
            zapasBoss = 0
        end

        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_boss", {playerKilledBoss = 0})
        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_creeps", {playerKilledCreeps = 0})
        

        GameMode:FastWin(playerID)

        
        ClearPlayerItems(hero)

        
        if hero:GetUnitName() == "npc_dota_hero_nevermore" then
          UTIL_Remove(hero.arcanaitem1)
          UTIL_Remove(hero.arcanaitem2)
          UTIL_Remove(hero.arcanaitem3)
        end


        UTIL_Remove(hero.SPpet)
        UTIL_Remove(hero.HWpet)
        UTIL_Remove(hero.COpet)
        UTIL_Remove(hero.UNpet)
        UTIL_Remove(hero.RApet)
        UTIL_Remove(hero.EPpet)
        UTIL_Remove(hero.LEpet)
        UTIL_Remove(hero.ANpet)


        local new_hero = PlayerResource:ReplaceHeroWith(playerID, heroname, 0, 0)


        print(neutral_item_name)
        if neutral_item_name ~= nil then
          new_hero:AddItemByName(neutral_item_name)
        end


        if new_hero:GetUnitName() == "npc_dota_hero_nevermore" or new_hero:GetUnitName() == "npc_dota_hero_juggernaut" then
          if new_hero:HasModifier("modifier_profession") then
            local CurrentProf = new_hero:FindModifierByName("modifier_profession")
            CurrentProf:SetStackCount(3)
          else
            local CurrentProf = new_hero:AddNewModifier (new_hero, nil, "modifier_profession", {duration = -1})
            CurrentProf:SetStackCount(3)
          end
        end



        if new_hero:GetUnitName() == "npc_dota_hero_nevermore" then
          local item = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/shadow_fiend/arcana_wings.vmdl"})
          item:FollowEntity(new_hero, true)
          new_hero.arcanaitem1 = item
    
          local item = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/shadow_fiend/head_arcana.vmdl"})
          item:FollowEntity(new_hero, true)
          new_hero.arcanaitem2 = item
          
          local item = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/items/shadow_fiend/arms_deso/arms_deso.vmdl"})
          item:FollowEntity(new_hero, true)
          new_hero.arcanaitem3 = item
        end


        local newplayerID = new_hero:GetPlayerOwnerID()
        local newplayer = PlayerResource:GetPlayer(newplayerID)

        CustomGameEventManager:Send_ServerToPlayer(newplayer, 'on_player_reinc_success', {})

        if steamID == 908758431 then --Остатки сладки Night Wolf
            new_hero.creep_kills = zapasCreeps
            new_hero.boss_kills = zapasBoss
        end

        --Say(new_hero, "You hero Reincarnate successfull!", false)

        Timers:CreateTimer(3,function()
            GameMode:FirstLoadNoReq(new_hero)
            ClearPlayerItems(new_hero)
            UTIL_Remove(hero)
            new_hero.creep_kills = zapasCreeps
            new_hero.boss_kills = zapasBoss
            return nil
        end) 
  


    else

        CustomGameEventManager:Send_ServerToPlayer(player, "create_error_message", {message = "You hero can`t Reincarnate!"})
    end

end)