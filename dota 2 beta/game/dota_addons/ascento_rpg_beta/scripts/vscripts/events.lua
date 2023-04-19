--local SaveLoad = require("libraries/autoload/saveload")

function GameMode:GiveDropItems(unit)
    local DropInfo = GameRules.DropTable[unit:GetUnitName()]    
    if DropInfo then
        for item_name, chance in pairs(DropInfo) do
            if not unit:HasItemInInventory(item_name) then
                unit:AddItemByName(item_name)
            end

            for slot = 0, 5 do
                local itemSLOT = unit:GetItemInSlot(slot)
                if itemSLOT ~= nil then
                    if itemSLOT:GetName() == "item_weapon_1" then
                        unit:SwapItems( slot, 6 )
                    end
                    if itemSLOT:GetName() == "item_armor_1" then
                        unit:SwapItems( slot, 7 )
                    end
                    if itemSLOT:GetName() == "item_health_1" then
                        unit:SwapItems( slot, 8 )
                    end
                end
            end
            --print("Выдали ".. item_name)
        end
    end
end


function GameMode:OnOrder(event)

    if event.units then
        if event.units["0"] then
            if not EntIndexToHScript(event.units["0"]):IsHero() then return true end
        end

    end

    if event.units["0"] ~= nil then
        local hero          = EntIndexToHScript(event.units["0"])

        if hero ~= nil then
            if not hero:IsHero() then return true end
        end

        if event.order_type then
            --print(event.order_type)
            --PrintTable(event)
            if event.order_type == 13 then
                return false
            end

            if event.order_type == 14 then
                if event.entindex_target then
                    if EntIndexToHScript(event.entindex_target) then
                        local item = EntIndexToHScript(event.entindex_target):GetContainedItem()
                        if item then
                            if item.owner ~= hero and item.owner ~= nil then
                                return false
                            end
                        end
                    end
                end
            end
        end
    end
    
    return true
end


function GameMode:InventoryFilter(event)
  if GameRules:State_Get() == DOTA_GAMERULES_STATE_STRATEGY_TIME or GameRules:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then
    return false
  end

  if not event.item_entindex_const then return end
  if not event.inventory_parent_entindex_const then return end

  local item = EntIndexToHScript(event.item_entindex_const)
  if not item or item:IsNull() then return true end

  local itemName = item:GetAbilityName()
  
  local player = EntIndexToHScript(event.inventory_parent_entindex_const)
  if not player then return true end
  if player:IsNull() then return end

  if itemName == "item_phantom_assassin_phantom_strike_datadriven" then
    event.suggested_slot = DOTA_ITEM_TP_SCROLL
    return true
  end


  local noPurchaseTimeItems = {
    "item_lia_health_elixir",
    "item_lia_health_stone_potion",
    "item_lia_health_stone_potion_two",
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

  for _,npItem in ipairs(noPurchaseTimeItems) do
    if item:GetAbilityName() == npItem then
      item:SetPurchaseTime(0)
      event.suggested_slot = DOTA_ITEM_NEUTRAL_SLOT
      return true
    end
  end

  if NeutralSlot:NeedToNeutralSlot( item:GetName() ) and not player:IsCourier() then
    local slotIndex = NeutralSlot:GetSlotIndex()
    local itemInSlot = player:GetItemInSlot(slotIndex)

    if not itemInSlot then
      -- just practical heuristic, when hero take item from another unit/from ground event.item_parent_entindex_const != event.inventory_parent_entindex_const
      -- never ask me about this dirty hack.
      local isStash = event.item_parent_entindex_const == event.inventory_parent_entindex_const

      if not isStash or player:IsInRangeOfShop(DOTA_SHOP_HOME, true) then
        event.suggested_slot = NeutralSlot:GetSlotIndex()
      end
    end
  end



  return true
end

function GameMode:DamageFilter(filterDamage)
    local attacker = filterDamage.entindex_attacker_const and EntIndexToHScript(filterDamage.entindex_attacker_const) 
    if not attacker then
        return true 
    end 
    local ability,abilityName
    local victim = EntIndexToHScript(filterDamage.entindex_victim_const)
    local typeDamage = filterDamage.damagetype_const

    if filterDamage.entindex_inflictor_const then
        ability = EntIndexToHScript(filterDamage.entindex_inflictor_const )
        if ability and ability.GetAbilityName and ability:GetAbilityName() then
            abilityName = ability:GetAbilityName()
        end
    end

    local damageIncoming = filterDamage.damage

    if attacker:IsRealHero() then
        if attacker:GetPrimaryAttribute() == DOTA_ATTRIBUTE_INTELLECT then
            if typeDamage == DAMAGE_TYPE_PHYSICAL then
                typeDamage = DAMAGE_TYPE_MAGICAL
                damageIncoming = damageIncoming * 0.5
            end
        end
    end

    if damageIncoming > 0 then

        local buff_ring = 0
        local buff_reinc = 0

        local buff_1 = 0
        local buff_2 = 0
        local buff_3 = 0
        local buff_4 = 0
        local buff_5 = 0
        local buff_6 = 0
        local buff_7 = 0
        local buff_8 = 0
        local buff_9 = 0

        local buff_10 = 0
        local buff_11 = 0
        local buff_12 = 0
        local buff_13 = 0
        local buff_14 = 0
        local buff_15 = 0
        local buff_16 = 0

        local tank_3_armored_soul = 0
        local donate_bonus_reduction_hojyk = 0

        local debuff_1 = 0
        local debuff_2 = 0
        local debuff_3 = 0
        local debuff_4 = 0
        local debuff_5 = 0
        local debuff_6 = 0

        local dazzleDebuff = 0



        if victim:GetUnitName() == "npc_creep_endless_1" and typeDamage == DAMAGE_TYPE_PURE then
            --typeDamage = DAMAGE_TYPE_MAGICAL
        end


        if attacker:HasModifier("modifier_donate_bruiser_tb") then
            --Nalis#0489
            if IsServer() then
                if RollPercentage(35) then
                    damageIncoming = damageIncoming * 4.5
                    EmitSoundOn( "Hero_Juggernaut.BladeDance", attacker )
                end
            end
        end

        


        if attacker:HasModifier("modifier_assasin_1_weak_spot") then
            if IsServer() then
                local ability = attacker:FindAbilityByName("assasin_1_weak_spot")
                local chance = ability:GetSpecialValueFor("critical_chance")
                if attacker:HasModifier("modifier_assasin_2_darkness") then
                    chance = chance * 2
                end
                if RollPercentage(chance) then
                    damageIncoming = damageIncoming * (ability:GetSpecialValueFor("critical_damage") / 100)
                    EmitSoundOn( "Hero_Juggernaut.BladeDance", attacker )

            
                end
            end
        end

        if attacker:HasModifier("modifier_ranger_1_heavy_bolts") and typeDamage == DAMAGE_TYPE_PHYSICAL then
            if IsServer() then
                local ability = attacker:FindAbilityByName("ranger_1_heavy_bolts")
                if ability ~= nil then
                    if ability:GetSpecialValueFor("bonus_damage_pct") > 0 then
                        damageIncoming = damageIncoming * (ability:GetSpecialValueFor("bonus_damage_pct") / 100)
                    end
                end
            end
        end

        if attacker:HasModifier("modifier_donate_bonus_damage_sf") then
            if IsServer() then
                local ability = attacker:FindAbilityByName("donate_bonus_damage_sf")
                if ability ~= nil then
                    if ability:GetSpecialValueFor("bonus_damage_pct") > 0 then
                        damageIncoming = damageIncoming * (1+(ability:GetSpecialValueFor("bonus_damage_pct") / 100))
                    end
                end
            end
        end

        if attacker:HasModifier("modifier_donate_bonus_damage_hojyk") then
            if IsServer() then
                local ability = attacker:FindAbilityByName("donate_bonus_damage_hojyk")
                if ability ~= nil then
                    if ability:GetSpecialValueFor("bonus_damage_pct") > 0 then
                        damageIncoming = damageIncoming * (1+(ability:GetSpecialValueFor("bonus_damage_pct") / 100))
                    end
                end
            end
        end

        if attacker:HasModifier("modifier_item_ring_primary") then
            local ability = attacker:FindModifierByName("modifier_item_ring_primary"):GetAbility()

            if ability:GetSpecialValueFor("crit_chance") ~= nil and ability:GetSpecialValueFor("crit_damage") ~= nil then
                local chance = ability:GetSpecialValueFor("crit_chance")
                if RollPercentage(chance) then
                    damageIncoming = damageIncoming * (ability:GetSpecialValueFor("crit_damage") / 100)
                    EmitSoundOn( "Hero_Juggernaut.BladeDance", attacker )
                end
            end

        end

        if victim:HasModifier("modifier_item_ring_primary") then
            local ability = victim:FindModifierByName("modifier_item_ring_primary"):GetAbility()

            if ability:GetSpecialValueFor("damage_reduction") ~= nil then
                buff_ring = ability:GetSpecialValueFor("damage_reduction")
            end
        end

        if victim:HasModifier("modifier_incarnation") then
            local modifier = victim:FindModifierByName("modifier_incarnation")

            if modifier:GetStackCount() ~= nil and modifier:GetStackCount() > 0 then
                if modifier:GetStackCount() > 39 and modifier:GetStackCount() < 175 then -- 40: -5% получаемого урона
                    buff_reinc = -5
                elseif modifier:GetStackCount() > 174 and modifier:GetStackCount() < 450 then -- 175: -7.5% получаемого урона
                    buff_reinc = -12.5
                elseif modifier:GetStackCount() > 449 and modifier:GetStackCount() < 1000 then -- 450: -10% получаемого урона
                    buff_reinc = -22.5
                elseif modifier:GetStackCount() > 999 and modifier:GetStackCount() < 12500 then -- 1000: -12.5% получаемого урона
                    buff_reinc = -35
                elseif modifier:GetStackCount() > 12499 and modifier:GetStackCount() < 35000 then -- 12500: -15% получаемого урона
                    buff_reinc = -50
                elseif modifier:GetStackCount() > 34999 and modifier:GetStackCount() < 80000 then -- 35000: -17.5% получаемого урона
                    buff_reinc = -67.5
                elseif modifier:GetStackCount() > 79999 then -- 80000: -20% получаемого урона
                    buff_reinc = -87.5
                end

            end
        end


        if attacker:HasModifier("modifier_cultist_1_decay_curse") then
            local ability = attacker:FindModifierByName("modifier_cultist_1_decay_curse"):GetAbility()

            if ability:GetSpecialValueFor("damage_less") ~= nil then
                dazzleDebuff = ability:GetSpecialValueFor("damage_less")
            end
        end

        if victim:HasModifier("modifier_pet_rare_buff") then
            buff_1 = -20
        end
        
        if victim:HasModifier("modifier_tank_1_shielded") then
            local ability = victim:FindAbilityByName("tank_1_shielded")
            if ability ~= nil then
                buff_2 = ability:GetLevelSpecialValueFor("damage_reduction_pct", (ability:GetLevel() - 1))
                if buff_2 > 0 then
                    buff_2 = buff_2 * -1
                else
                    buff_2 = 0
                end
            end
        end

        if victim:HasModifier("modifier_tank_3_armored_soul") then
            local ability = victim:FindAbilityByName("tank_3_armored_soul")
            if ability ~= nil then
                tank_3_armored_soul = ability:GetLevelSpecialValueFor("damage_prevents", (ability:GetLevel() - 1))
                if tank_3_armored_soul > 0 then
                    tank_3_armored_soul = tank_3_armored_soul * -1
                else
                    tank_3_armored_soul = 0
                end
            end
        end

        if victim:HasModifier("modifier_donate_bonus_reduction_hojyk") then
            local ability = victim:FindAbilityByName("donate_bonus_reduction_hojyk")
            if ability ~= nil then
                donate_bonus_reduction_hojyk = ability:GetLevelSpecialValueFor("damage_prevents", (ability:GetLevel() - 1))
                if donate_bonus_reduction_hojyk > 0 then
                    donate_bonus_reduction_hojyk = donate_bonus_reduction_hojyk * -1
                else
                    donate_bonus_reduction_hojyk = 0
                end
            end
        end

        if victim:HasModifier("modifier_pet_special_hardcore_buff") then
            buff_3 = -10
        end

        if victim:HasModifier("modifier_damage_reduction_30") then
            buff_4 = -30
        end

        if victim:HasModifier("modifier_damage_reduction_50") then
            buff_5 = -50
        end

        if victim:HasModifier("modifier_damage_reduction_60") then
            buff_6 = -60
        end

        if victim:HasModifier("modifier_damage_reduction_70") then
            buff_7 = -70
        end

        if victim:HasModifier("modifier_damage_reduction_80") then
            buff_8 = -80
        end

        if victim:HasModifier("modifier_boss_power_reduct") then
            local ability = victim:FindModifierByName("modifier_boss_power_reduct"):GetAbility()

            if ability:GetSpecialValueFor("damage_reduction") ~= nil then
                buff_9 = ability:GetSpecialValueFor("damage_reduction")
            end
        end

        if victim:HasModifier("modifier_damage_reduction_85") then
            buff_10 = -85
        end

        if victim:HasModifier("modifier_damage_reduction_90") then
            buff_11 = -90
        end

        if victim:HasModifier("modifier_damage_reduction_92") then
            buff_12 = -92
        end

        if victim:HasModifier("modifier_damage_reduction_94") then
            buff_13 = -94
        end

        if victim:HasModifier("modifier_damage_reduction_96") then
            buff_14 = -96
        end

        if victim:HasModifier("modifier_damage_reduction_98") then
            buff_15 = -98
        end

        if victim:HasModifier("modifier_damage_reduction_99") then
            buff_16 = -99
        end




        if victim:HasModifier("modifier_damage_increase_30") then
            debuff_1 = 30
        end

        if victim:HasModifier("modifier_damage_increase_50") then
            debuff_2 = 40
        end

        if victim:HasModifier("modifier_damage_increase_60") then
            debuff_3 = 50
        end

        if victim:HasModifier("modifier_damage_increase_70") then
            debuff_4 = 60
        end

        if victim:HasModifier("modifier_damage_increase_80") then
            debuff_5 = 70
        end

        if victim:HasModifier("modifier_fighter_2_adrenaline_rush") then
            debuff_6 = 20
        end

        local damage_reduction_pct = (1 - (1+dazzleDebuff/100) * (1+buff_ring/100) * (1+buff_1/100) * (1+buff_2/100) * (1+buff_3/100) * (1+buff_4/100) * (1+buff_5/100) * (1+buff_6/100) * (1+buff_7/100) * (1+buff_8/100) * (1+buff_9/100) * (1+buff_10/100) * (1+buff_11/100) * (1+buff_12/100) * (1+buff_13/100) * (1+buff_14/100) * (1+buff_15/100) * (1+buff_16/100) * (1+tank_3_armored_soul/100) * (1+donate_bonus_reduction_hojyk/100) * (1+debuff_1/100) * (1+debuff_2/100) * (1+debuff_3/100) * (1+debuff_4/100) * (1+debuff_5/100) * (1+debuff_6/100) )*100

        local damageChanging = damageIncoming - damageIncoming * (damage_reduction_pct / 100)

        if victim:HasModifier("modifier_fighter_1_bruiser") then
            local modifier = victim:FindModifierByName("modifier_fighter_1_bruiser")
            local ability = modifier:GetAbility()
            local block_chance = ability:GetSpecialValueFor("block_chance")
            if RollPercentage(block_chance) then
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, victim, damageChanging, nil) --БЛОК
                damageChanging = 0
            end
        end

        if victim:HasModifier("modifier_donate_bruiser") then
            local modifier = victim:FindModifierByName("modifier_donate_bruiser")
            local ability = modifier:GetAbility()
            local block_chance = ability:GetSpecialValueFor("block_chance")
            if RollPercentage(block_chance) then
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, victim, damageChanging, nil) --БЛОК
                damageChanging = 0
            end
        end

        if victim:GetUnitName() == "npc_special_event_halloween" then
            typeDamage = DAMAGE_TYPE_HP_REMOVAL
            damageChanging = 1
        end

        if attacker:GetUnitName() == "npc_special_event_halloween" then
            typeDamage = DAMAGE_TYPE_PURE
            damageChanging = damageChanging + victim:GetMaxHealth() * 0.1
            --victim:AddNewModifier(attacker, nil, "modifier_disable_healing", {duration = 1})
        end

        local userPack

        if attacker:GetUnitName() == "npc_creep_endless_1" then

            userPack = "pack"..victim:GetPlayerID()+1

            if victim.isLeha == 1 then
                userPack = "pack9"
            end
            if victim.isHojyk == 1 then
                userPack = "pack10"
            end

            if attacker.pack ~= nil and victim:IsRealHero() then
                if attacker.pack ~= userPack then
                    damageChanging = 0
                end
            end

        end

        if victim:GetUnitName() == "npc_creep_endless_1" then

            userPack = "pack"..attacker:GetPlayerID()+1

            if attacker.isLeha == 1 then
                userPack = "pack9"
            end
            if attacker.isHojyk == 1 then
                userPack = "pack10"
            end

            if victim.pack ~= nil and attacker:IsRealHero() then
                if victim.pack ~= userPack then
                    damageChanging = 0
                end
            end

        end


        if attacker:HasModifier("modifier_hojyk_tether") and typeDamage ~= DAMAGE_TYPE_PHYSICAL  then
            local modifier = attacker:FindModifierByName("modifier_hojyk_tether")
            local ability = modifier:GetAbility()

            local spell_amp = ability:GetSpecialValueFor("spell_amp")

            damageChanging = damageChanging * (1+(spell_amp / 100))
        end

        if attacker:HasModifier("modifier_hojyk_tether_ally") and typeDamage ~= DAMAGE_TYPE_PHYSICAL  then
            local modifier = attacker:FindModifierByName("modifier_hojyk_tether_ally")
            local ability = modifier:GetAbility()

            local spell_amp = ability:GetSpecialValueFor("spell_amp")

            damageChanging = damageChanging * (1+(spell_amp / 100))
        end

        if victim:HasModifier("modifier_hojyk_tether") then
            local modifier = victim:FindModifierByName("modifier_hojyk_tether")
            local ability = modifier:GetAbility()

            local damage_reduction = ability:GetSpecialValueFor("damage_reduction")

            damageChanging = damageChanging * (1-(damage_reduction / 100))
        end

        if victim:HasModifier("modifier_hojyk_tether_ally") then
            local modifier = victim:FindModifierByName("modifier_hojyk_tether_ally")
            local ability = modifier:GetAbility()

            local damage_reduction = ability:GetSpecialValueFor("damage_reduction")

            damageChanging = damageChanging * (1-(damage_reduction / 100))
        end

        if attacker:GetUnitName() == "npc_dota_hero_nevermore" and typeDamage ~= DAMAGE_TYPE_PHYSICAL  then
            local heroLevel = attacker:GetLevel()
            local amplifyDamage = 0

            if heroLevel > 0 then
                amplifyDamage = heroLevel / 2
            end

            damageChanging = damageChanging * (1+(amplifyDamage / 100))
        end

        if damageChanging then
            if damageChanging > 2000000000 then
                damageChanging = 2000000000
            end
        end
    
        local data = {
            victim = victim,
            attacker = attacker,
            typeDamage = typeDamage,
            ability = ability,
            abilityName = abilityName,
            damage = damageChanging,
        }

        
        local applyFilter = GameMode:OnApplyDamage(data)
        if applyFilter then 
            filterDamage.damage = GameMode:OnTakeDamageFilter(applyFilter)
            if applyFilter.typeDamage == DAMAGE_TYPE_MAGICAL or applyFilter.typeDamage == DAMAGE_TYPE_PURE then

                if attacker:HasAbility("special_bonus_spell_lifesteal_10") then
                    local ability = attacker:FindAbilityByName("special_bonus_spell_lifesteal_10")
                    if ability:GetLevel() > 0 then
                        local healSPECIAL = filterDamage.damage * (ability:GetSpecialValueFor("value") / 100)
                        
                        attacker:Heal(healSPECIAL, attacker)
                        SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, attacker, healSPECIAL, nil)
                    end
                end

                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, victim, filterDamage.damage, nil) --МАГИЧЕСКИЙ УРОН
            else
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, victim, filterDamage.damage, nil) --ФИЗ УРОН
            end

            return not not filterDamage.damage
        end 

    else
        if damageIncoming > 2000000000 then
            damageIncoming = 2000000000
        end

        local data = {
            victim = victim,
            attacker = attacker,
            typeDamage = typeDamage,
            ability = ability,
            abilityName = abilityName,
            damage = damageIncoming,
        }

        local applyFilter = GameMode:OnApplyDamage(data)
        if applyFilter then 
            filterDamage.damage = GameMode:OnTakeDamageFilter(applyFilter)
            return not not filterDamage.damage
        end 

    end

    
    return false  

end

function GameMode:OnApplyDamage(data)
    return data
end

function GameMode:OnTakeDamageFilter(data)
    return data.damage
end


-- Experience filter function
function GameMode:ExperienceFilter(keys)
    --keys.experience
    --keys.hero_entindex_const
    --keys.player_id_const
    --keys.reason_const
    --keys.source_entindex_const

    local killedUnit = EntIndexToHScript( keys.source_entindex_const )
    local killerUnit = EntIndexToHScript( keys.hero_entindex_const )


    local player_id = keys.player_id_const
    local reason = keys.reason_const
    local experience = keys.experience
    --PrintTable(keys)

    local hero = player_id and PlayerResource:GetSelectedHeroEntity(player_id)
    local heroAbs = hero:GetAbsOrigin()

    if IsCreepASCENTO(hero) or IsBossASCENTO(hero) or not hero:IsRealHero() then
        return false
    end

    local shareUnits = FindUnitsInRadius(PlayerResource:GetTeam(player_id), heroAbs, nil, 1000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    local count = #shareUnits

    if hero:HasModifier("modifier_pet_special_hardcore_buff") then
        experience = experience * 1.5
    end

    if hero:HasModifier("modifier_incarnation") then
        local modifier = hero:FindModifierByName("modifier_incarnation")
        if modifier:GetStackCount() ~= nil and modifier:GetStackCount() > 0 then
            if modifier:GetStackCount() > 299 and modifier:GetStackCount() < 600 then -- 300: 25% получаемого опыта
                experience = experience * 1.25
            elseif modifier:GetStackCount() > 599 and modifier:GetStackCount() < 6000 then -- 600: 50% получаемого опыта
                experience = experience * 1.75
            elseif modifier:GetStackCount() > 5999 then -- 6000: 100% получаемого опыта
                experience = experience * 2.75
            end
        end
    end

    if hero:HasModifier("modifier_hojyk_tether") then
        local modifier = hero:FindModifierByName("modifier_hojyk_tether")
        local ability = modifier:GetAbility()

        local exp_bonus = ability:GetSpecialValueFor("exp_bonus")

        experience = experience * (1+(exp_bonus / 100))

    end

    if hero:HasModifier("modifier_hojyk_tether_ally") then
        local modifier = hero:FindModifierByName("modifier_hojyk_tether_ally")
        local ability = modifier:GetAbility()

        local exp_bonus = ability:GetSpecialValueFor("exp_bonus")

        experience = experience * (1+(exp_bonus / 100))

    end

    if experience > INT_MAX_LIMIT then
        experience = INT_MAX_LIMIT
    end


    if experience == nil then
        experience = 0
    else
        experience = experience / count
    end
    
    
    experience = math.floor(experience)

    for i, hero in pairs(shareUnits) do
        if hero:HasModifier("modifier_profession") and hero:IsRealHero() then
            local modProf = hero:FindModifierByName("modifier_profession")
            local modProfLvl = modProf:GetStackCount()

            if hero ~= nil then
                if hero:HasModifier("modifier_incarnation") then
                    local CurrentInc = hero:FindModifierByName("modifier_incarnation")
                    if CurrentInc ~= nil then
                        local CurrentIncId = CurrentInc:GetStackCount()
                        if ( hero:GetLevel() < 120 + ( math.floor(CurrentIncId / 10) ) ) then
                            if experience > 0 then
    
                                hero:AddExperience( experience, DOTA_ModifyXP_Unspecified, false, true)
                                if hero.host ~= nil and hero.host ~= hero then
                                    if IsValidEntity(hero.host) and hero:IsAlive() then
                                        hero.host:AddExperience( experience, DOTA_ModifyXP_Unspecified, false, true)
                                    end
                                end
                            else
                                return false
                            end
                        else
                            return false
                        end
                    end
                end
            end
        end
    end
    -- End Share XP

    return false
end



function GameMode:OnHeroPick(event)                           

    local hero      = EntIndexToHScript(event.heroindex)
    local player    = EntIndexToHScript(event.player)
    if not player then return end
    local playerId  = player:GetPlayerID()
    local steamId   = PlayerResource:GetSteamAccountID(playerId)

    CustomGameEventManager:Send_ServerToPlayer(player, 'on_connect_full', {})

    CustomGameEventManager:Send_ServerToPlayer(player, 'event_hide_shop', {})

    hero.damageDone = 0

end




-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)

    local new_state = GameRules:State_Get()
    if new_state == DOTA_GAMERULES_STATE_INIT then



    elseif new_state == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
        
        GameMode.bSeenWaitForPlayers = true

    elseif new_state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
        GameRules:SetCustomGameSetupAutoLaunchDelay(CUSTOM_GAME_SETUP_TIME)
        GameMode:OnFirstPlayerLoaded()

        print("Cosmetics: Starts loading...")
        Cosmetics:Start()

    elseif new_state == DOTA_GAMERULES_STATE_HERO_SELECTION then
        if USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS then
          for i=0,9 do
            if PlayerResource:IsValidPlayer(i) then
              local color = TEAM_COLORS[PlayerResource:GetTeam(i)]
              PlayerResource:SetCustomPlayerColor(i, color[1], color[2], color[3])
            end
          end
        end
        _G.DelayedModifiersTable = _G.DelayedModifiersTable or {}
        for caster, modifier in pairs(_G.DelayedModifiersTable) do
            caster:AddNewModifier(caster, nil, modifier, {})
            GameMode:GiveDropItems(caster)
        end
        --GameMode:PostLoadPrecache()
        GameMode:OnAllPlayersLoaded()


        
    elseif new_state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
    elseif new_state == DOTA_GAMERULES_STATE_TEAM_SHOWCASE then
    elseif new_state == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD then
    elseif new_state == DOTA_GAMERULES_STATE_PRE_GAME then
        GameRules:GetGameModeEntity():SetCustomDireScore(0) -- Thanks for Diretide
    elseif new_state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameMode:OnGameInProgress()
    elseif new_state == DOTA_GAMERULES_STATE_POST_GAME then
    elseif new_state == DOTA_GAMERULES_STATE_DISCONNECT then
    end
end


-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
    if IsClient() then
        SendToConsole("dota_hud_healthbars 1")
    end

    if IsServer() then
        SendToServerConsole("dota_hud_healthbars 1")
    end

    local npc = EntIndexToHScript(keys.entindex)

    if not npc or npc:GetClassname() == "npc_dota_thinker" or npc:IsPhantom() then
        return
    end




    

    if IsBossASCENTO(npc) or IsCreepASCENTO(npc) and KILL_VOTE_RESULT:upper() ~= nil then

        if npc:GetUnitName() ~= "npc_dota_creature_final_tron" then

            local mode = KILL_VOTE_RESULT:upper()
    
            GameMode:GiveDropItems(npc)
    
            local givedXP = GameRules.UnitsXPTable[npc:GetUnitName()]
    
            if givedXP ~= nil then
                if givedXP <= 0 then
                    givedXP = 10
                end
                
            else
                givedXP = 10
            end
    
            givedXP = givedXP / 3

            local hpScale = 1
            local dmgScale = 1

            if mode ~= "EASY" then
                if IsBossASCENTO(npc) then
                    if not npc:FindAbilityByName("boss_power_reduct") then
                        npc:AddAbility("boss_power_reduct")
                    end
                    if not npc:FindAbilityByName("boss_raging_blood") then
                        npc:AddAbility("boss_raging_blood")
                    end
                end
            end
    
            if mode == "EASY" then
                if not npc:HasModifier("modifier_damage_increase_30") then
                    modifier = npc:AddNewModifier(npc, nil, "modifier_damage_increase_30", {})
                end
                givedXP = givedXP * 0.75
    
            elseif mode == "NORMAL" then
                givedXP = givedXP * 1
                hpScale = 2.25
                dmgScale = 2
    
            elseif mode == "HARD" then
                if not npc:HasModifier("modifier_damage_reduction_30") then
                    modifier = npc:AddNewModifier(npc, nil, "modifier_damage_reduction_30", {})
                end
                givedXP = givedXP * 1.25
                hpScale = 5
                dmgScale = 4
    
            elseif mode == "UNFAIR" then
                if not npc:HasModifier("modifier_damage_reduction_50") then
                    modifier = npc:AddNewModifier(npc, nil, "modifier_damage_reduction_50", {})
                end
                givedXP = givedXP * 1.5
                hpScale = 11
                dmgScale = 8

            elseif mode == "IMPOSSIBLE" then
                if not npc:HasModifier("modifier_damage_reduction_60") then
                    modifier = npc:AddNewModifier(npc, nil, "modifier_damage_reduction_60", {})
                end
                givedXP = givedXP * 1.75
                hpScale = 23
                dmgScale = 16
    
            elseif mode == "HELL" then
                if not npc:HasModifier("modifier_damage_reduction_70") then
                    modifier = npc:AddNewModifier(npc, nil, "modifier_damage_reduction_70", {})
                end
                givedXP = givedXP * 2.0
                hpScale = 48
                dmgScale = 32
    
            elseif mode == "HARDCORE" then
                if not npc:HasModifier("modifier_damage_reduction_80") then
                    modifier = npc:AddNewModifier(npc, nil, "modifier_damage_reduction_80", {})
                end
                givedXP = givedXP * 2.25
                hpScale = 100
                dmgScale = 64
    
            end

        

            --if npc:GetUnitName() == "npc_dota_creature_final_tron" and npc.bFirstSpawned == nil then
            --    npc.bFirstSpawned = true
            --    npc:AddNewModifier(npc, nil, "modifier_custom_invulnerable", {})
            --end
    
            --if givedXP > INT_MAX_LIMIT or givedXP < 0 then
            --    givedXP = INT_MAX_LIMIT
            --end
        
            givedXP = math.floor(givedXP)
    
            npc:SetDeathXP(givedXP)

            local playersUpscale = 1 + ( 0.2 * ( #get_team_heroes(DOTA_TEAM_GOODGUYS) - 1) )
            --PrintTable(get_team_heroes(DOTA_TEAM_GOODGUYS))
            --print(#get_team_heroes(DOTA_TEAM_GOODGUYS))
            if playersUpscale > 0 then

                local giveHP = npc:GetMaxHealth() * hpScale * playersUpscale
                if giveHP > INT_MAX_LIMIT then
                    giveHP = INT_MAX_LIMIT
                end
    
                npc:SetBaseMaxHealth(giveHP)
                npc:SetMaxHealth(giveHP)
                npc:SetHealth(giveHP)

                npc:Heal(giveHP, npc)
    
                local giveDMG = npc:GetBaseDamageMax() * dmgScale * playersUpscale
                if giveDMG > INT_MAX_LIMIT then
                    giveDMG = INT_MAX_LIMIT
                end
    
                npc:SetBaseDamageMin(giveDMG)
                npc:SetBaseDamageMax(giveDMG)

            end


    
            npc:SetMaximumGoldBounty(0)
            npc:SetMinimumGoldBounty(0)

            if npc:GetUnitName() == "npc_special_event_halloween" then
                npc:SetCustomHealthLabel("??? lvl", 255, 0, 0)
                --GameRules:SetOverlayHealthBarUnit(npc, 1)
                if not npc:HasModifier("modifier_movespeed_cap") then
                    modifier = npc:AddNewModifier(npc, nil, "modifier_movespeed_cap", {})
                end
            end



        end
            
        

    end

    if npc:IsRealHero() and npc.bFirstSpawned == nil then
      npc.bFirstSpawned = true
      npc.creep_kills = 0
      npc.boss_kills = 0
      npc.deaths = 0
      npc.RespawnPos = 0

      GameMode:OnHeroInGame(npc)
    end


    if npc:IsRealHero() then 


        local item_to_remove = npc:FindItemInInventory("item_tpscroll")
        local item_to_remove2 = npc:FindItemInInventory("item_tpscroll_fake")
        if item_to_remove ~= nil then
            npc:RemoveItem(item_to_remove)
        end
        if item_to_remove2 ~= nil then
            npc:RemoveItem(item_to_remove2)
        end

        if npc.RespawnPos ~= nil then --ТЕЛЕПОРТ ПО ЧЕКПОИНТУ
            local ent = Entities:FindByName( nil, "respawn_" .. npc.RespawnPos) --строка ищет как раз таки нашу точку pnt1
            local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты
            FindClearSpaceForUnit(npc, point, true)
            --PlayerResource:SetCameraTarget(npc:GetPlayerOwnerID(), npc)
            npc:Stop()
            --Timers:CreateTimer(0.2, function()
            --    PlayerResource:SetCameraTarget(npc:GetPlayerOwnerID(), nil)
            --    return nil
            --end)
        end


        npc:AddNewModifier(npc, nil, "modifier_custom_invulnerable_res", {duration = 5})


        if npc.isLeha == 1 and #get_team_heroes(DOTA_TEAM_GOODGUYS) > 1 then
            hero:RemoveAbility("donate_leha_genocid")
        end



        if npc:HasModifier("modifier_fountain_invulnerability") then
            modifier = npc:RemoveModifierByName("modifier_fountain_invulnerability")
        end

        local mode = KILL_VOTE_RESULT:upper()

        if mode == "EASY" then
            if not npc:HasModifier("modifier_damage_reduction_30") then
                modifier = npc:AddNewModifier(npc, nil, "modifier_damage_reduction_30", {})
            end
        elseif mode == "NORMAL" then
            --НУ НОРМАЛ ЭТО БАЗА
        elseif mode == "HARD" then
            if not npc:HasModifier("modifier_damage_increase_30") then
                 modifier = npc:AddNewModifier(npc, nil, "modifier_damage_increase_30", {})
            end
        elseif mode == "UNFAIR" then
            if not npc:HasModifier("modifier_damage_increase_50") then
                 modifier = npc:AddNewModifier(npc, nil, "modifier_damage_increase_50", {})
            end
        elseif mode == "IMPOSSIBLE" then
            if not npc:HasModifier("modifier_damage_increase_60") then
                 modifier = npc:AddNewModifier(npc, nil, "modifier_damage_increase_60", {})
            end
        elseif mode == "HELL" then
            if not npc:HasModifier("modifier_damage_increase_70") then
                 modifier = npc:AddNewModifier(npc, nil, "modifier_damage_increase_70", {})
            end
        elseif mode == "HARDCORE" then
            if not npc:HasModifier("modifier_damage_increase_80") then
                 modifier = npc:AddNewModifier(npc, nil, "modifier_damage_increase_80", {})
            end
        end
    end
end




-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys) 


    local new_state = GameRules:State_Get()
    if new_state > DOTA_GAMERULES_STATE_HERO_SELECTION then
        local playerID = keys.PlayerID or keys.player_id
        
        --if not playerID or not PlayerResource:IsValidPlayerID(playerID) then
        --    print("OnPlayerReconnect - Reconnected player ID isn't valid!")
        --end

        if PlayerResource:HasSelectedHero(playerID) or PlayerResource:HasRandomed(playerID) then
            -- This playerID already had a hero before disconnect
        else
            -- PlayerResource:IsConnected(playerID) is custom-made; can be found in 'player_resource.lua' library
            if PlayerResource:IsConnected(playerID) and not PlayerResource:IsBroadcaster(playerID) then
                PlayerResource:GetPlayer(playerID):MakeRandomHeroSelection()
                PlayerResource:SetHasRandomed(playerID)
                PlayerResource:SetCanRepick(playerID, false)
            end
        end
    end
end

-- A player leveled up
function GameMode:OnPlayerLevelUp(keys)

    --local playerId  = keys.PlayerID
    --local player = EntIndexToHScript(keys.player)
    local hero = EntIndexToHScript(keys.hero_entindex)
    --local level = keys.level


    --Timers:CreateTimer(0.5, function() 
        --Stats:OnLevelUp(hero)
        --Npcs:CheckQuests(hero)
    --end)



    hero:SetAbilityPoints(hero:GetAbilityPoints() + 1)
end

function GameMode:OnItemSpotted(event)
    PrintTable(event)
end

function GameMode:OnItemPicked(event)
--print("OnItemPicked:")
--PrintTable(event)
if not event.PlayerID then return end
if not event.ItemEntityIndex then return end
if not event.HeroEntityIndex then return end

    local playerId  = event.PlayerID
    local item      = EntIndexToHScript(event.ItemEntityIndex)
    local hero      = EntIndexToHScript(event.HeroEntityIndex)
    local itemName = item:GetName()
    local itemowner = item.owner or nil

    

    if hero ~= nil and item ~= nil then
        if not item:GetContainer() or not item:GetContainer():GetContainedItem() or not item then
            UTIL_Remove(item:GetContainer())
            UTIL_Remove(item)
            return
        end

        if itemName ~= "item_lia_health_elixir" and itemName ~= "item_lia_health_stone_potion" and itemName ~= "item_lia_health_stone_potion_two" and itemName ~= "item_candy" then

            if item.owner ~= hero and item.owner ~= nil then
                hero:DropItemAtPositionImmediate(item, hero:GetAbsOrigin())
                CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(), "create_error_message", {message = "YOU CAN'T TAKE ALLY ITEMS"})
            else
                hero:RemoveItem(item)
                hero:AddItemByName(itemName)
                local finded = hero:FindItemInInventory(itemName)
                if finded ~= nil then
                    finded.owner = itemowner or hero
                    Ascento:CheckItem(hero, finded)
                end
            end

        end
    end

end

function GameMode:OnItemAdded(event)


end



function GameMode:OnItemCombined(event)
    --print("OnItemCombined:")
    --PrintTable(event)
    if not event.PlayerID then return end
    if not event.itemname then return end

    local playerId  = event.PlayerID

    if not playerId then return end

    local player = PlayerResource:GetPlayer(playerId):GetAssignedHero()
    
    if not player then return end

    local itemName  = event.itemname

    local finded = player:FindItemInInventory(itemName)

    if not finded then return end

    if not finded.owner then
        finded.owner = player
    end
end




-- An entity died
function GameMode:OnEntityKilled(keys)

    local killer    = EntIndexToHScript(keys.entindex_attacker)
    local killed    = EntIndexToHScript(keys.entindex_killed)
    local killedUnit = EntIndexToHScript( keys.entindex_killed )

    if killedUnit.respoint ~= nil then
        caster_respoint = killedUnit.respoint
    elseif killedUnit.vInitialSpawnPos ~= nil then
        caster_respoint = killedUnit.vInitialSpawnPos
    end

    local killerAbility = nil

    if keys.entindex_inflictor ~= nil then
        killerAbility = EntIndexToHScript(keys.entindex_inflictor)
    end

    local killerEntity = nil

    if keys.entindex_attacker ~= nil then
      killerEntity = EntIndexToHScript( keys.entindex_attacker )
    end

    if killedUnit.trigger ~= nil and killerEntity:IsRealHero() then
        --GameMode:RollDrops(killedUnit.trigger, killedUnit, killerEntity)
    end




end

function GameMode:RollDrops(unit, killer)

    local mode = KILL_VOTE_RESULT:upper()
    local playerID = killer:GetPlayerOwnerID()

    local DropInfo = GameRules.DropTable[unit:GetUnitName()]
    --local DropInfo = GameRules.DropTable[droplocation]
    if DropInfo then
        for item_name, chance in pairs(DropInfo) do
            local DropChance = chance
            local ArtifactDropChance = 1

            if mode == "EASY" and DropChance < 100 then

                DropChance = DropChance * 0.8
                ArtifactDropChance = ArtifactDropChance * 0.8

            elseif mode == "NORMAL" and DropChance < 100 then

                DropChance = DropChance * 0.9
                ArtifactDropChance = ArtifactDropChance * 0.9

            elseif mode == "HARD" and DropChance < 100 then

                DropChance = DropChance * 1
                ArtifactDropChance = ArtifactDropChance * 1

            elseif mode == "HARDEVENT" and DropChance < 100 then

                DropChance = DropChance * 1
                ArtifactDropChance = ArtifactDropChance * 1

            elseif mode == "UNFAIR" and DropChance < 100 then

                DropChance = DropChance * 1.5
                ArtifactDropChance = ArtifactDropChance * 1.5

            elseif mode == "IMPOSSIBLE" and DropChance < 100 then

                DropChance = DropChance * 2.25
                ArtifactDropChance = ArtifactDropChance * 2.25

            elseif mode == "HELL" and DropChance < 100 then

                DropChance = DropChance * 3.5
                ArtifactDropChance = ArtifactDropChance * 3.5

            elseif mode == "HARDCORE" and DropChance < 100 then

                DropChance = DropChance * 5
                ArtifactDropChance = ArtifactDropChance * 5

            end


    
    
             if killer:HasModifier("modifier_pet_special_hardcore_buff") then
                DropChance = DropChance * 1.3
                ArtifactDropChance = ArtifactDropChance * 1.3
            end

            if killer:HasModifier("modifier_incarnation") then
                local modifier = killer:FindModifierByName("modifier_incarnation")
    
                if modifier:GetStackCount() ~= nil and modifier:GetStackCount() > 0 then
                    if modifier:GetStackCount() > 349 and modifier:GetStackCount() < 3000 then -- 350: 25% шанса выпадения
                        DropChance = DropChance * 1.25
                        ArtifactDropChance = ArtifactDropChance * 1.25
                    elseif modifier:GetStackCount() > 2999 then -- 3000: 50% шанса выпадения
                        DropChance = DropChance * 1.75
                        ArtifactDropChance = ArtifactDropChance * 1.75
                    end
                end
            end

            local playerID = killer:GetPlayerID()

            local steamID = PlayerResource:GetSteamAccountID(playerID)
            
    
            --DropChance = math.floor(DropChance)
            --ArtifactDropChance = math.floor(DropChance)
    
            if DropChance > 100 then
                DropChance = 100
            end

            if ArtifactDropChance > 5 then
                ArtifactDropChance = 5
            end
            --print(ArtifactDropChance)

            if RollPercentage(DropChance) and _G.lootDrop[playerID] == true then
                -- Create the item
                if item_name == "item_hallowen_legendary_pet_datadriven" and killer:HasModifier("modifier_hallowen_legendary_pet") then
                    break
                end
                local item = CreateItem(item_name, nil, nil)
                local pos = unit:GetAbsOrigin()
                local drop = CreateItemOnPositionSync(pos, item)
                local pos_launch = pos + RandomVector(RandomFloat(150, 200))
                if item ~= nil then
                    item:LaunchLoot(false, 200, 0.75, pos_launch)
                end
            end

            if IsBossASCENTO(unit) then

                if RollPercentage(ArtifactDropChance) then
                    --print("Основной шанс прокнул")
                    local random_int = 0
    
                    local item_type = 1--RandomInt(1, 1)
                    if item_type == 1 then
                        if RollPercentage(90) then
                            random_int = RandomInt(1, 10)
                        elseif RollPercentage(80) then
                            random_int = RandomInt(10, 20)
                        elseif RollPercentage(70) then
                            random_int = RandomInt(20, 30)
                        elseif RollPercentage(60) then
                            random_int = RandomInt(30, 40)
                        elseif RollPercentage(50) then
                            random_int = RandomInt(40, 50)
                        elseif RollPercentage(40) then
                            random_int = RandomInt(50, 60)
                        elseif RollPercentage(30) then
                            random_int = RandomInt(60, 70)
                        elseif RollPercentage(20) then
                            random_int = RandomInt(70, 80)
                        elseif RollPercentage(10) then
                            random_int = RandomInt(80, 90)
                        elseif RollPercentage(1) then
                            random_int = RandomInt(90, 100)
                        end
                    end
    
                    --print("random_int = " .. random_int)
                    if random_int > 100 then
                        random_int = 100 --ВРЕМЕННАЯ ЗАГЛУШКА
                    end
    
                    if random_int > 0 then
                        local item = CreateItem("item_holy_" .. random_int, nil, nil)
                        local pos = unit:GetAbsOrigin()
                        local drop = CreateItemOnPositionSync(pos, item)
                        local pos_launch = pos + RandomVector(RandomFloat(50, 100))
                        if item ~= nil then
                            item:LaunchLoot(false, 200, 0.75, pos_launch)
                        end
                    end
                end

            end

        end
    end
end

-- This function is called 1 to 2 times as the player connects initially but before they 
-- have completely connected
--function GameMode:PlayerConnect(keys)
--    DebugPrint('[BAREBONES] PlayerConnect')
--    --DebugPrintTable(keys)
--end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:OnConnectFull(keys)
    self:CaptureGameMode()
    PlayerResource:OnPlayerConnect(keys)
end

function GameMode:OnPlayerChat(keys)
    --if not IsServer() then return end
    local teamonly = keys.teamonly
    local userID = keys.userid
    local text = keys.text
    local steamid = tostring(PlayerResource:GetSteamID(keys.playerid))
    local player = PlayerResource:GetPlayer(keys.playerid):GetAssignedHero()
    local comslash = text

    if not player then return end

    local StartPoint = Vector (-23, -738, 133)

    if text ~= "00" and comslash:sub(1, 1) ~= "-" then
        ToDiscordMessage(steamid, text)
    end

    for str in string.gmatch(text, "%S+") do
        if str == "00" then
          player:ForceKill(true)
        end

        if str == "-spawn" then
            local ent = Entities:FindByName( nil, "respawn_0") --строка ищет как раз таки нашу точку pnt1
            local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты
            FindClearSpaceForUnit(player, point, true)
            PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), player)
            player:Stop()
            Timers:CreateTimer(0.2, function()
                PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)
                return nil
            end)
        end

        if str == "-uncheck" then
            player.RespawnPos = 0

            local ent = Entities:FindByName( nil, "respawn_0") --строка ищет как раз таки нашу точку pnt1
            local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты
            FindClearSpaceForUnit(player, point, true)
            PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), player)
            player:Stop()
            Timers:CreateTimer(0.2, function()
                PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)
                return nil
            end)
        end


    end

  if steamid == "76561198290873082" or steamid == "76561198083843808" or steamid == "76561198376130254" or steamid == "76561198204633313" then
    for str in string.gmatch(text, "%S+") do

        if str == "-dev_win" then
            GameMode:FastWin(player:GetPlayerID())
            GameRules:SetGameWinner(PlayerResource:GetPlayer(keys.playerid):GetTeamNumber())
        end

        if str == "-dev_lose" then
          GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
        end
    
        if str == "-dev_lvlmax" then
          HeroMaxLevel(player)
        end
        
        if str == "-donate" then
            GameMode:DonateLoad(player)
        end

        if str == "-top" then
            GameMode:TopLoad(player)
        end

        if str == "-dev_top" then
            player:AddItemByName("item_weapon_31")
            player:AddItemByName("item_strength_31")
            player:AddItemByName("item_ring_31")
            player:AddItemByName("item_agility_31")
            player:AddItemByName("item_health_31")
            player:AddItemByName("item_artifact_31")
            player:AddItemByName("item_armor_31")
            player:AddItemByName("item_mage_31")
        end
    
        if str == "-dev_god" then
            if not player:HasModifier("modifier_invulnerable") then
                player:AddNewModifier(player, nil, "modifier_invulnerable", {})
            end
        end
    
        if str == "-dev_ungod" then
            if player:HasModifier("modifier_invulnerable") then
                player:RemoveModifierByName("modifier_invulnerable")
            end
        end

    end
  end
  
end



