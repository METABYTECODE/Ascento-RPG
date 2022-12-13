loaded_players_saveload = {}
first_loaded_players_saveload = {}


fast_save_req_tbl = {}

function GameMode:FastSave(event)
    local playerID = event.playerID
    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local caster = PlayerResource:GetSelectedHeroEntity(playerID)
    local player = PlayerResource:GetPlayer(playerID)
    local creep_kills = caster.creep_kills or 0
    local boss_kills = caster.boss_kills or 0
    local deaths = caster.deaths or 0

    if fast_save_req_tbl[steamID] ~= true then


            local item0 = caster:GetItemInSlot(0)
            if item0 then
                if item0:IsMuted() then
                    item0 = nil
                else
                    item0 = item0:GetAbilityName()
                end
            else
                item0 = nil
            end

            local item1 = caster:GetItemInSlot(1)
            if item1 then
                if item1:IsMuted() then
                    item1 = nil
                else
                    item1 = item1:GetAbilityName()
                end
            else
                item1 = nil
            end

            local item2 = caster:GetItemInSlot(2)
            if item2 then
                if item2:IsMuted() then
                    item2 = nil
                else
                    item2 = item2:GetAbilityName()
                end
            else
                item2 = nil
            end

            local item3 = caster:GetItemInSlot(3)
            if item3 then
                if item3:IsMuted() then
                    item3 = nil
                else
                    item3 = item3:GetAbilityName()
                end
            else
                item3 = nil
            end

            local item4 = caster:GetItemInSlot(4)
            if item4 then
                if item4:IsMuted() then
                    item4 = nil
                else
                    item4 = item4:GetAbilityName()
                end
            else
                item4 = nil
            end

            local item5 = caster:GetItemInSlot(5)
            if item5 then
                if item5:IsMuted() then
                    item5 = nil
                else
                    item5 = item5:GetAbilityName()
                end
            else
                item5 = nil
            end

            local item6 = caster:GetItemInSlot(6)
            if item6 then
                if item6:IsMuted() then
                    item6 = nil
                else
                    item6 = item6:GetAbilityName()
                end
            else
                item6 = nil
            end

            local item7 = caster:GetItemInSlot(7)
            if item7 then
                if item7:IsMuted() then
                    item7 = nil
                else
                    item7 = item7:GetAbilityName()
                end
            else
                item7 = nil
            end

            local item8 = caster:GetItemInSlot(8)
            if item8 then
                if item8:IsMuted() then
                    item8 = nil
                else
                    item8 = item8:GetAbilityName()
                end
            else
                item8 = nil
            end

            local slot_neutral = caster:GetItemInSlot(16)
            if slot_neutral then
                if slot_neutral:IsMuted() then
                    slot_neutral = nil
                else
                    slot_neutral = slot_neutral:GetAbilityName()
                end
            else
                slot_neutral = nil
            end

            --local halloween_pet = 0
            --if caster:HasModifier("modifier_hallowen_legendary_pet") then
            --    halloween_pet = 1
            --end

            local prof_id = 0
            if caster:HasModifier("modifier_profession") then
                local CurrentProf = caster:FindModifierByName("modifier_profession")
                if CurrentProf ~= nil then
                    local CurrentProfId = CurrentProf:GetStackCount()
                    if CurrentProfId ~= nil and CurrentProfId > 0 then
                        prof_id = CurrentProfId
                    end
                end
            end

            local checkpointNUM = 0
            if caster.RespawnPos ~= nil then
                checkpointNUM = caster.RespawnPos
                --checkpoint = caster.RespawnPos
                --checkpointNUM = (tonumber(checkpoint:sub(9, 11)))
            end

            local hero_lvl = caster:GetLevel()
            local heroName = caster:GetUnitName()

            local SavingData = {}
            SavingData = { AsteamID = steamID, hero_name = heroName, slot_0 = item0, slot_1 = item1, slot_2 = item2, slot_3 = item3, slot_4 = item4, slot_5 = item5, slot_6 = item6, slot_7 = item7, slot_8 = item8, slot_neutral = slot_neutral, prof_id = prof_id, hero_lvl = hero_lvl, checkpoint = checkpointNUM, boss_kills = boss_kills, creep_kills = creep_kills, deaths = deaths }
            SaveDataWeb(SavingData, function(a,b) print(a) 
                if a == '{"status":"ok"}' then 
                    Say(player, "Game is Saved", false)
                elseif a == 'NO SERVER' then
                    Say(player, "You cannot save without Server.", false)
                else
                    Say(player, "FAIL! Save error, try later and contact with Developer.", false)
                end
            end)
            table.insert(fast_save_req_tbl, steamID, true)
            local waiting_time = 30
            if steamID == 330607354 or steamID == 244367585 then
                waiting_time = 5
            end
            Timers:CreateTimer({
                useGameTime = false,
                endTime = waiting_time,
                callback = function()
                  table.insert(fast_save_req_tbl, steamID, false)
                end
              })

    else
        Say(player, "Too many requests, please wait.", false)
    end
end

function GameMode:FastSaveNoReq(event)
    local playerID = event
    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local caster = PlayerResource:GetSelectedHeroEntity(playerID)
    local player = PlayerResource:GetPlayer(playerID)
    local creep_kills = caster.creep_kills or 0
    local boss_kills = caster.boss_kills or 0
    local deaths = caster.deaths or 0



            local item0 = caster:GetItemInSlot(0)
            if item0 then
                if item0:IsMuted() then
                    item0 = nil
                else
                    item0 = item0:GetAbilityName()
                end
            else
                item0 = nil
            end

            local item1 = caster:GetItemInSlot(1)
            if item1 then
                if item1:IsMuted() then
                    item1 = nil
                else
                    item1 = item1:GetAbilityName()
                end
            else
                item1 = nil
            end

            local item2 = caster:GetItemInSlot(2)
            if item2 then
                if item2:IsMuted() then
                    item2 = nil
                else
                    item2 = item2:GetAbilityName()
                end
            else
                item2 = nil
            end

            local item3 = caster:GetItemInSlot(3)
            if item3 then
                if item3:IsMuted() then
                    item3 = nil
                else
                    item3 = item3:GetAbilityName()
                end
            else
                item3 = nil
            end

            local item4 = caster:GetItemInSlot(4)
            if item4 then
                if item4:IsMuted() then
                    item4 = nil
                else
                    item4 = item4:GetAbilityName()
                end
            else
                item4 = nil
            end

            local item5 = caster:GetItemInSlot(5)
            if item5 then
                if item5:IsMuted() then
                    item5 = nil
                else
                    item5 = item5:GetAbilityName()
                end
            else
                item5 = nil
            end

            local item6 = caster:GetItemInSlot(6)
            if item6 then
                if item6:IsMuted() then
                    item6 = nil
                else
                    item6 = item6:GetAbilityName()
                end
            else
                item6 = nil
            end

            local item7 = caster:GetItemInSlot(7)
            if item7 then
                if item7:IsMuted() then
                    item7 = nil
                else
                    item7 = item7:GetAbilityName()
                end
            else
                item7 = nil
            end

            local item8 = caster:GetItemInSlot(8)
            if item8 then
                if item8:IsMuted() then
                    item8 = nil
                else
                    item8 = item8:GetAbilityName()
                end
            else
                item8 = nil
            end

            local slot_neutral = caster:GetItemInSlot(16)
            if slot_neutral then
                if slot_neutral:IsMuted() then
                    slot_neutral = nil
                else
                    slot_neutral = slot_neutral:GetAbilityName()
                end
            else
                slot_neutral = nil
            end

            --local halloween_pet = 0
            --if caster:HasModifier("modifier_hallowen_legendary_pet") then
            --    halloween_pet = 1
            --end

            local prof_id = 0
            if caster:HasModifier("modifier_profession") then
                local CurrentProf = caster:FindModifierByName("modifier_profession")
                if CurrentProf ~= nil then
                    local CurrentProfId = CurrentProf:GetStackCount()
                    if CurrentProfId ~= nil and CurrentProfId > 0 then
                        prof_id = CurrentProfId
                    end
                end
            end

            local checkpointNUM = 0
            if caster.RespawnPos ~= nil then
                checkpointNUM = caster.RespawnPos
                --checkpoint = caster.RespawnPos
                --checkpointNUM = (tonumber(checkpoint:sub(9, 11)))
            end

            local hero_lvl = caster:GetLevel()
            local heroName = caster:GetUnitName()

            local SavingData = {}
            SavingData = { AsteamID = steamID, hero_name = heroName, slot_0 = item0, slot_1 = item1, slot_2 = item2, slot_3 = item3, slot_4 = item4, slot_5 = item5, slot_6 = item6, slot_7 = item7, slot_8 = item8, slot_neutral = slot_neutral, prof_id = prof_id, hero_lvl = hero_lvl, checkpoint = checkpointNUM, boss_kills = boss_kills, creep_kills = creep_kills, deaths = deaths }
            SaveDataWeb(SavingData, function(a,b) print(a) 
                if a == '{"status":"ok"}' then 
                    Say(player, "Game is Saved", false)
                elseif a == 'NO SERVER' then
                    Say(player, "You cannot save without Server.", false)
                else
                    Say(player, "FAIL! Save error, try later and contact with Developer.", false)
                end
            end)
            

end

fast_load_req_tbl = {}

function GameMode:FastLoad(event)
    local playerID = event.playerID

    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local caster = PlayerResource:GetSelectedHeroEntity(playerID)
    local player = PlayerResource:GetPlayer(playerID)

    if fast_load_req_tbl[steamID] ~= true then
        local result
        local heroName = caster:GetUnitName()
        LoadDataWeb({steam_id = steamID, hero_name = heroName}, function(a,b) result = json.decode(a)
            if result["steam_id"] ~= nil then
                if loaded_players_saveload[steamID] ~= true or steamID == 330607354 or steamID == 244367585  then

                    


                    --modifier_profession
                    if result["prof_id"] ~= nil then
                        local ProfId = math.floor(result["prof_id"])
                        if ProfId > 0 then
                            if caster:HasModifier("modifier_profession") then
                                local CurrentProf = caster:FindModifierByName("modifier_profession")
                                local CurrentProfId = CurrentProf:GetStackCount()
                                if ProfId > CurrentProfId then
                                    if ProfId == 2 then
                                        Ascento:UpgradeJobTo2(caster)
                                        --caster:AddItemByName("item_grade_profession")
                                    end
                                    if ProfId == 3 then
                                        Ascento:UpgradeJobTo2(caster)
                                        Ascento:UpgradeJobTo3(caster)
                                    end
                                end
                            end
                        end
                    end


                    if result["hero_lvl"] ~= nil then
                        local lvl = math.floor(result["hero_lvl"])
                        if lvl == 0 or lvl > MAX_LEVEL then
                            Say(player, "Level is missing", false)
                        elseif caster:HasModifier("modifier_profession") then
                            local CurrentProf = caster:FindModifierByName("modifier_profession")
                            local CurrentProfId = CurrentProf:GetStackCount()

                            if CurrentProfId == 1 and lvl > 30 then
                                lvl = 30
                            elseif CurrentProfId == 2 and lvl > 120 then
                                lvl = 120
                            end

                            caster:AddExperience(XP_PER_LEVEL_TABLE[lvl] - caster:GetCurrentXP(), 0, false, false)
                        end
                    end

                    for i = 0, 8 do 
                        local CurrentItem = caster:GetItemInSlot(i)
                        if result["slot" .. i] ~= nil then
                            if CurrentItem ~= nil then
                                if CurrentItem:GetName() ~= result["slot" .. i] then
                                    caster:RemoveItem(CurrentItem)
                                    caster:AddItemByName(result["slot" .. i])
                                end
                            else
                                caster:AddItemByName(result["slot" .. i])
                            end
                        end
                    end

                    if result["slot_neutral"] ~= nil then
                        local CurrentItem = caster:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
                        if CurrentItem ~= nil then
                            if CurrentItem:GetName() ~= result["slot_neutral"] then
                                caster:RemoveItem(CurrentItem)
                                caster:AddItemByName(result["slot_neutral"])
                            end
                        else
                            caster:AddItemByName(result["slot_neutral"])
                        end
                    end

                    if result["checkpoint"] ~= nil then
                        local checkpoint = math.floor(result["checkpoint"])

                        caster.RespawnPos = checkpoint

                        local ent = Entities:FindByName( nil, "respawn_" .. caster.RespawnPos) --строка ищет как раз таки нашу точку pnt1
                        local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты
        
                        FindClearSpaceForUnit(caster, point, true)
                        PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), caster)
                        caster:Stop()

                        Timers:CreateTimer(0.2, function()
                            PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), nil)
                            return nil
                        end)

                    end

                    if result["boss_kills"] ~= nil then
                        local boss_kills_load = math.floor(result["boss_kills"])
                        if boss_kills_load > 0 then
                            caster.boss_kills = boss_kills_load
                            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_boss", {playerKilledBoss = tonumber(caster.boss_kills)})
                        end
                    end

                    if result["creep_kills"] ~= nil then
                        local creep_kills_load = math.floor(result["creep_kills"])
                        if creep_kills_load > 0 then
                            caster.creep_kills = creep_kills_load
                            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_creeps", {playerKilledCreeps = tonumber(caster.creep_kills)})
                        end
                    end

                    if result["deaths"] ~= nil then
                        local deaths_load = math.floor(result["deaths"])
                        if deaths_load > 0 then
                            caster.deaths = deaths_load
                            --CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_creeps", {playerKilledCreeps = tonumber(caster.creep_kills)})
                        end
                    end

                    GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='green'>Your progress successfully loaded.</font>", 0, 0)

                    table.insert(loaded_players_saveload, steamID, true)

                else
                    GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='red'>You already load game.</font>", 0, 0)
                end
            elseif result == 'NO DATA IN DATABASE' then
                GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='red'>You don`t have a save.</font>", 0, 0)
            elseif result == 'NO SERVER' then
                GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='red'>You cannot load without Server.</font>", 0, 0)
            else
                GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='red'>FAIL! Load error, try later and contact with Developer.</font>", 0, 0)
            end
        end)
        table.insert(fast_load_req_tbl, steamID, true)
        local waiting_time = 30
        if steamID == 330607354 or steamID == 244367585 then
            waiting_time = 1
        end
        Timers:CreateTimer({
            useGameTime = false,
            endTime = waiting_time,
            callback = function()
              table.insert(fast_load_req_tbl, steamID, false)
            end
          })
    else
        Say(player, "Too many requests, please wait.", false)
    end
end

function GameMode:TopLoad(event)
    local caster = event
    local playerID = caster:GetPlayerID()

    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local player = PlayerResource:GetPlayer(playerID)

    local result
    local heroName = caster:GetUnitName()

    TopLoadDataWeb({steam_id = steamID, hero_name = heroName}, function(a,b) result = json.decode(a)
    if result == nil then return end

        if result["creep_top"] ~= nil then
            CreepTopList = {}
            for k, v in pairs(result["creep_top"]) do

                local kv =
                    {
                        id = v["steam_id_full"],
                        col = v["creep_kills"]
                    }
                table.insert(CreepTopList,kv)
            end
            CustomGameEventManager:Send_ServerToAllClients( "UpdateTopCreeps", CreepTopList)       
        end

        if result["boss_top"] ~= nil then
            BossTopList = {}
            for k, v in pairs(result["boss_top"]) do

                local kv =
                    {
                        id = v["steam_id_full"],
                        col = v["boss_kills"]
                    }
                table.insert(BossTopList,kv)
            end
            CustomGameEventManager:Send_ServerToAllClients( "UpdateTopBoss", BossTopList)       
        end

        if result["reinc_top"] ~= nil then
            ReincTopList = {}
            for k, v in pairs(result["reinc_top"]) do

                local kv =
                    {
                        id = v["steam_id_full"],
                        col = v["reincarnation"]
                    }
                table.insert(ReincTopList,kv)
            end
            CustomGameEventManager:Send_ServerToAllClients( "UpdateTopReinc", ReincTopList)       
        end

        if result["all_players"] ~= nil then
            local allplayerscount = result["all_players"]
            CustomGameEventManager:Send_ServerToAllClients( "UpdatePlayersCount", {PlayersCount = tonumber(allplayerscount)})       
        end
    end)

end

function GameMode:FirstLoad(event)
    local caster = event
    local playerID = caster:GetPlayerID()

    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local player = PlayerResource:GetPlayer(playerID)

    local result
    local heroName = caster:GetUnitName()

    FirstLoadDataWeb({steam_id = steamID, hero_name = heroName}, function(a,b) result = json.decode(a)

        if result == nil then return end

        if result["steamid"] ~= nil then
            if first_loaded_players_saveload[steamID] ~= true then

                if result["boss_kills"] ~= nil then
                    local boss_kills_load = math.floor(result["boss_kills"])
                    if boss_kills_load ~= nil and boss_kills_load > 0 then
                        caster.all_boss_kills = boss_kills_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_boss", {playerKilledBoss = tonumber(caster.all_boss_kills)})
                    else
                        caster.all_boss_kills = 0
                    end
                end

                if result["creep_kills"] ~= nil then
                    local creep_kills_load = math.floor(result["creep_kills"])
                    if creep_kills_load ~= nil and creep_kills_load > 0 then
                        caster.all_creep_kills = creep_kills_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(caster.all_creep_kills)})
                    else
                        caster.all_creep_kills = 0
                    end
                end

                if result["deaths"] ~= nil then
                    local deaths_load = math.floor(result["deaths"])
                    if deaths_load ~= nil and deaths_load > 0 then
                        caster.all_deaths = deaths_load
                        --CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(caster.all_creep_kills)})
                    else
                        caster.all_deaths = 0
                    end
                end

                    if result["endless_1"] ~= nil or result["endless_2"] ~= nil or result["endless_3"] ~= nil or result["endless_4"] ~= nil or result["endless_5"] ~= nil or result["endless_6"] ~= nil or result["endless_7"] ~= nil or result["endless_8"] ~= nil or result["endless_9"] ~= nil or result["endless_10"] ~= nil or result["endless_11"] ~= nil or result["endless_12"] ~= nil or result["endless_13"] ~= nil or result["endless_14"] ~= nil or result["endless_15"] ~= nil then
                        local endless_load = result

                        local modifiers = LoadKeyValues('scripts/kv/endless_modifiers.kv')

                        caster.endless_1 = math.floor(endless_load["endless_1"]) or 0
                        

                        if caster.endless_1 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 1 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_1)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_1)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_2 = math.floor(endless_load["endless_2"]) or 0

                        if caster.endless_2 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 2 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_2)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_2)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_3 = math.floor(endless_load["endless_3"]) or 0

                        if caster.endless_3 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 3 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_3)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_3)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_4 = math.floor(endless_load["endless_4"]) or 0

                        if caster.endless_4 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 4 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_4)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_4)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_5 = math.floor(endless_load["endless_5"]) or 0

                        if caster.endless_5 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 5 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_5)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_5)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_6 = math.floor(endless_load["endless_6"]) or 0

                        if caster.endless_6 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 6 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_6)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_6)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_7 = math.floor(endless_load["endless_7"]) or 0

                        if caster.endless_7 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 7 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_7)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_7)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_8 = math.floor(endless_load["endless_8"]) or 0

                        if caster.endless_8 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 8 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_8)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_8)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_9 = math.floor(endless_load["endless_9"]) or 0

                        if caster.endless_9 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 9 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_9)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_9)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_10 = math.floor(endless_load["endless_10"]) or 0

                        if caster.endless_10 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 10 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_10)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_10)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_11 = math.floor(endless_load["endless_11"]) or 0

                        if caster.endless_11 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 11 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_11)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_11)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_12 = math.floor(endless_load["endless_12"]) or 0

                        if caster.endless_12 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 12 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_12)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_12)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_13 = math.floor(endless_load["endless_13"]) or 0

                        if caster.endless_13 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 13 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_13)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_13)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_14 = math.floor(endless_load["endless_14"]) or 0

                        if caster.endless_14 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 14 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_14)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_14)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_15 = math.floor(endless_load["endless_15"]) or 0

                        if caster.endless_15 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 15 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_15)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_15)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 1, modifierValue = caster.endless_1})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 2, modifierValue = caster.endless_2})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 3, modifierValue = caster.endless_3})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 4, modifierValue = caster.endless_4})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 5, modifierValue = caster.endless_5})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 6, modifierValue = caster.endless_6})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 7, modifierValue = caster.endless_7})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 8, modifierValue = caster.endless_8})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 9, modifierValue = caster.endless_9})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 10, modifierValue = caster.endless_10})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 11, modifierValue = caster.endless_11})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 12, modifierValue = caster.endless_12})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 13, modifierValue = caster.endless_13})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 14, modifierValue = caster.endless_14})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_get_endless", {modifierNumber = 15, modifierValue = caster.endless_15})

                    end


                if result["reincarnation"] ~= nil then
                    local IncLVL = math.floor(result["reincarnation"])
                    if IncLVL ~= nil and IncLVL > 0 then

                        if caster:HasModifier("modifier_incarnation") then

                            local CurrentIncMod = caster:FindModifierByName("modifier_incarnation")
                            local CurrentIncLvl = CurrentIncMod:GetStackCount()
                            if IncLVL > CurrentIncLvl then
                                CurrentIncMod:SetStackCount(IncLVL)
                            end

                        else

                            caster:AddNewModifier (caster, nil, "modifier_incarnation", {duration = -1})
                            local CurrentIncMod = caster:FindModifierByName("modifier_incarnation")
                            CurrentIncMod:SetStackCount(IncLVL)

                        end

                        --CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_reincarnation", {player_reincarnation = tonumber(IncLVL)})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_reinc_update", {player_reincarnation = tonumber(IncLVL)})

                    end
                end


                if result["gametime"] ~= nil then
                    local gametime_load = math.floor(result["gametime"])
                    if gametime_load ~= nil and gametime_load > 0 then
                        caster.all_gametime = gametime_load
                        local textTime = disp_time(caster.all_gametime)
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_gametime", {player_gametime = textTime})
                    else
                        caster.all_gametime = 0
                        local textTime = disp_time(caster.all_gametime)
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_gametime", {player_gametime = textTime})
                    end

                    Timers:CreateTimer("hero_gametime_" .. caster:GetPlayerID(), {
                        useGameTime = false,
                        endTime = 1,
                        callback = function()
                            caster.all_gametime = caster.all_gametime + 1
                            local textTime = disp_time(caster.all_gametime)
                            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_gametime", {player_gametime = textTime})
                            return 1
                        end
                    })

                end

                if result["easy_win"] ~= nil then
                    local easy_win_load = math.floor(result["easy_win"])
                    if easy_win_load ~= nil and easy_win_load > 0 then
                        caster.easy_win = easy_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_easy_win", {player_easy_win = tonumber(caster.easy_win)})
                    else
                        caster.easy_win = 0
                    end
                end

                if result["normal_win"] ~= nil then
                    local normal_win_load = math.floor(result["normal_win"])
                    if normal_win_load ~= nil and normal_win_load > 0 then
                        caster.normal_win = normal_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_normal_win", {player_normal_win = tonumber(caster.normal_win)})
                    else
                        caster.normal_win = 0
                    end
                end

                if result["hard_win"] ~= nil then
                    local hard_win_load = math.floor(result["hard_win"])
                    if hard_win_load ~= nil and hard_win_load > 0 then
                        caster.hard_win = hard_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_hard_win", {player_hard_win = tonumber(caster.hard_win)})
                    else
                        caster.hard_win = 0
                    end
                end

                if result["unfair_win"] ~= nil then
                    local unfair_win_load = math.floor(result["unfair_win"])
                    if unfair_win_load ~= nil and unfair_win_load > 0 then
                        caster.unfair_win = unfair_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_unfair_win", {player_unfair_win = tonumber(caster.unfair_win)})
                    else
                        caster.unfair_win = 0
                    end
                end

                if result["impossible_win"] ~= nil then
                    local impossible_win_load = math.floor(result["impossible_win"])
                    if impossible_win_load ~= nil and impossible_win_load > 0 then
                        caster.impossible_win = impossible_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_impossible_win", {player_impossible_win = tonumber(caster.impossible_win)})
                    else
                        caster.impossible_win = 0
                    end
                end

                if result["hell_win"] ~= nil then
                    local hell_win_load = math.floor(result["hell_win"])
                    if hell_win_load ~= nil and hell_win_load > 0 then
                        caster.hell_win = hell_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_hell_win", {player_hell_win = tonumber(caster.hell_win)})
                    else
                        caster.hell_win = 0
                    end
                end

                if result["hardcore_win"] ~= nil then
                    local hardcore_win_load = math.floor(result["hardcore_win"])
                    if hardcore_win_load ~= nil and hardcore_win_load > 0 then
                        caster.hardcore_win = hardcore_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_hardcore_win", {player_hardcore_win = tonumber(caster.hardcore_win)})
                    else
                        caster.hardcore_win = 0
                    end
                end


                Timers:CreateTimer("hero_online_" .. caster:GetPlayerID(), {
                    useGameTime = false,
                    endTime = 1,
                    callback = function()
                        GameMode:SaveOnline(playerID)
                        return 30
                    end
                })

                GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='green'>Player data synchronized.</font>", 0, 0)

                --print("Player data synchronized")
                table.insert(first_loaded_players_saveload, steamID, true)
            else
                --Say(player, "You already load game.", false)
            end
        elseif result == 'NO DATA IN DATABASE' then
            --FIRST PLAYER GAME
            caster.all_creep_kills = 0
            caster.all_boss_kills = 0
            caster.all_deaths = 0
            caster.easy_win = 0
            caster.normal_win = 0
            caster.unfair_win = 0
            caster.impossible_win = 0
            caster.hard_win = 0
            caster.hell_win = 0
            caster.hardcore_win = 0

        elseif result == 'NO SERVER' then
            Say(player, "You cannot load without Server.", false)
        else
            Say(player, "FAIL! Player data was not loaded, try restarting the game or contact the developer.", false)
        end
    end)

end


function GameMode:FirstLoadNoReq(event)
    local caster = event
    local playerID = caster:GetPlayerID()

    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local player = PlayerResource:GetPlayer(playerID)

    local result
    local heroName = caster:GetUnitName()

    FirstLoadDataWeb({steam_id = steamID, hero_name = heroName}, function(a,b) result = json.decode(a)

        if result == nil then return end

        if result["steamid"] ~= nil then

                if result["boss_kills"] ~= nil then
                    local boss_kills_load = math.floor(result["boss_kills"])
                    if boss_kills_load ~= nil and boss_kills_load > 0 then
                        caster.all_boss_kills = boss_kills_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_boss", {playerKilledBoss = tonumber(caster.all_boss_kills)})
                    else
                        caster.all_boss_kills = 0
                    end
                end

                if result["creep_kills"] ~= nil then
                    local creep_kills_load = math.floor(result["creep_kills"])
                    if creep_kills_load ~= nil and creep_kills_load > 0 then
                        caster.all_creep_kills = creep_kills_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(caster.all_creep_kills)})
                    else
                        caster.all_creep_kills = 0
                    end
                end

                if result["deaths"] ~= nil then
                    local deaths_load = math.floor(result["deaths"])
                    if deaths_load ~= nil and deaths_load > 0 then
                        caster.all_deaths = deaths_load
                        --CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_creeps", {playerKilledCreeps = tonumber(caster.all_creep_kills)})
                    else
                        caster.all_deaths = 0
                    end
                end

                if result["endless_1"] ~= nil or result["endless_2"] ~= nil or result["endless_3"] ~= nil or result["endless_4"] ~= nil or result["endless_5"] ~= nil or result["endless_6"] ~= nil or result["endless_7"] ~= nil or result["endless_8"] ~= nil or result["endless_9"] ~= nil or result["endless_10"] ~= nil or result["endless_11"] ~= nil or result["endless_12"] ~= nil or result["endless_13"] ~= nil or result["endless_14"] ~= nil or result["endless_15"] ~= nil then
                        local endless_load = result

                        local modifiers = LoadKeyValues('scripts/kv/endless_modifiers.kv')

                        caster.endless_1 = math.floor(endless_load["endless_1"]) or 0

                        if caster.endless_1 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 1 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_1)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_1)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_2 = math.floor(endless_load["endless_2"]) or 0

                        if caster.endless_2 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 2 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_2)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_2)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_3 = math.floor(endless_load["endless_3"]) or 0

                        if caster.endless_3 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 3 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_3)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_3)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_4 = math.floor(endless_load["endless_4"]) or 0

                        if caster.endless_4 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 4 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_4)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_4)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_5 = math.floor(endless_load["endless_5"]) or 0

                        if caster.endless_5 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 5 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_5)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_5)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_6 = math.floor(endless_load["endless_6"]) or 0

                        if caster.endless_6 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 6 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_6)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_6)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_7 = math.floor(endless_load["endless_7"]) or 0

                        if caster.endless_7 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 7 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_7)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_7)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_8 = math.floor(endless_load["endless_8"]) or 0

                        if caster.endless_8 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 8 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_8)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_8)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_9 = math.floor(endless_load["endless_9"]) or 0

                        if caster.endless_9 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 9 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_9)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_9)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_10 = math.floor(endless_load["endless_10"]) or 0

                        if caster.endless_10 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 10 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_10)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_10)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_11 = math.floor(endless_load["endless_11"]) or 0

                        if caster.endless_11 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 11 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_11)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_11)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_12 = math.floor(endless_load["endless_12"]) or 0

                        if caster.endless_12 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 12 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_12)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_12)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_13 = math.floor(endless_load["endless_13"]) or 0

                        if caster.endless_13 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 13 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_13)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_13)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_14 = math.floor(endless_load["endless_14"]) or 0

                        if caster.endless_14 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 14 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_14)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_14)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        caster.endless_15 = math.floor(endless_load["endless_15"]) or 0

                        if caster.endless_15 > 0 then
                            for k, v in pairs(modifiers) do
                                if k ~= nil and v ~= nil then
                                    local givemodifier = k
                                    if v == 15 then
                                        if not caster:HasModifier(givemodifier) then
                                            local modifier = caster:AddNewModifier (caster, nil, givemodifier, {duration = -1})
                                            if modifier then
                                                modifier:SetStackCount(caster.endless_15)
                                            end
                                        else
                                            local modifier = caster:FindModifierByName(givemodifier)
                                            if modifier then
                                              modifier:SetStackCount(caster.endless_15)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                    end


                if result["reincarnation"] ~= nil then
                    local IncLVL = math.floor(result["reincarnation"])
                    if IncLVL ~= nil and IncLVL > 0 then

                        if caster:HasModifier("modifier_incarnation") then

                            local CurrentIncMod = caster:FindModifierByName("modifier_incarnation")
                            local CurrentIncLvl = CurrentIncMod:GetStackCount()
                            if IncLVL > CurrentIncLvl then
                                CurrentIncMod:SetStackCount(IncLVL)
                            end

                        else

                            caster:AddNewModifier (caster, nil, "modifier_incarnation", {duration = -1})
                            local CurrentIncMod = caster:FindModifierByName("modifier_incarnation")
                            CurrentIncMod:SetStackCount(IncLVL)

                        end

                        --CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_reincarnation", {player_reincarnation = tonumber(IncLVL)})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_reinc_update", {player_reincarnation = tonumber(IncLVL)})

                    end
                end


                if result["gametime"] ~= nil then
                    local gametime_load = math.floor(result["gametime"])
                    if gametime_load ~= nil and gametime_load > 0 then
                        caster.all_gametime = gametime_load
                        local textTime = disp_time(caster.all_gametime)
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_gametime", {player_gametime = textTime})
                    else
                        caster.all_gametime = 0
                        local textTime = disp_time(caster.all_gametime)
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_gametime", {player_gametime = textTime})
                    end

                    Timers:RemoveTimer("hero_gametime_" .. caster:GetPlayerID())

                    Timers:CreateTimer("hero_gametime_" .. caster:GetPlayerID(), {
                        useGameTime = false,
                        endTime = 1,
                        callback = function()
                            caster.all_gametime = caster.all_gametime + 1
                            local textTime = disp_time(caster.all_gametime)
                            CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_gametime", {player_gametime = textTime})
                            return 1
                        end
                    })

                end

                if result["easy_win"] ~= nil then
                    local easy_win_load = math.floor(result["easy_win"])
                    if easy_win_load ~= nil and easy_win_load > 0 then
                        caster.easy_win = easy_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_easy_win", {player_easy_win = tonumber(caster.easy_win)})
                    else
                        caster.easy_win = 0
                    end
                end

                if result["normal_win"] ~= nil then
                    local normal_win_load = math.floor(result["normal_win"])
                    if normal_win_load ~= nil and normal_win_load > 0 then
                        caster.normal_win = normal_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_normal_win", {player_normal_win = tonumber(caster.normal_win)})
                    else
                        caster.normal_win = 0
                    end
                end

                if result["hard_win"] ~= nil then
                    local hard_win_load = math.floor(result["hard_win"])
                    if hard_win_load ~= nil and hard_win_load > 0 then
                        caster.hard_win = hard_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_hard_win", {player_hard_win = tonumber(caster.hard_win)})
                    else
                        caster.hard_win = 0
                    end
                end

                if result["unfair_win"] ~= nil then
                    local unfair_win_load = math.floor(result["unfair_win"])
                    if unfair_win_load ~= nil and unfair_win_load > 0 then
                        caster.unfair_win = unfair_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_unfair_win", {player_unfair_win = tonumber(caster.unfair_win)})
                    else
                        caster.unfair_win = 0
                    end
                end

                if result["impossible_win"] ~= nil then
                    local impossible_win_load = math.floor(result["impossible_win"])
                    if impossible_win_load ~= nil and impossible_win_load > 0 then
                        caster.impossible_win = impossible_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_impossible_win", {player_impossible_win = tonumber(caster.impossible_win)})
                    else
                        caster.impossible_win = 0
                    end
                end

                if result["hell_win"] ~= nil then
                    local hell_win_load = math.floor(result["hell_win"])
                    if hell_win_load ~= nil and hell_win_load > 0 then
                        caster.hell_win = hell_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_hell_win", {player_hell_win = tonumber(caster.hell_win)})
                    else
                        caster.hell_win = 0
                    end
                end

                if result["hardcore_win"] ~= nil then
                    local hardcore_win_load = math.floor(result["hardcore_win"])
                    if hardcore_win_load ~= nil and hardcore_win_load > 0 then
                        caster.hardcore_win = hardcore_win_load
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_stats_update_hardcore_win", {player_hardcore_win = tonumber(caster.hardcore_win)})
                    else
                        caster.hardcore_win = 0
                    end
                end

                for i = 0, 5 do
                    ability = caster:GetAbilityByIndex(i):SetLevel(0)
                end

                local donate1 = caster:FindAbilityByName("terrorblade_metamorphosis_datadriven")
                if donate1 ~= nil then
                    donate1:SetLevel(1)
                end

                local donate2 = caster:FindAbilityByName("special_pure_damage_spell_datadriven")
                if donate2 ~= nil then
                    donate2:SetLevel(1)
                end

                local donate3 = caster:FindAbilityByName("spectre_dispersion_datadriven")
                if donate3 ~= nil then
                    donate3:SetLevel(1)
                end

                local ent = Entities:FindByName( nil, "respawn_0") --строка ищет как раз таки нашу точку pnt1
                local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты
        
                FindClearSpaceForUnit(caster, point, true)
                PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), caster)
                caster:Stop()

                Timers:RemoveTimer("hero_online_" .. caster:GetPlayerID())

                Timers:CreateTimer("hero_online_" .. caster:GetPlayerID(), {
                    useGameTime = false,
                    endTime = 1,
                    callback = function()
                        GameMode:SaveOnline(playerID)
                        return 30
                    end
                })

                Timers:CreateTimer(0.2, function()
                    PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), nil)
                    return nil
                end)

                Say(player, "Player data synchronized.", false)
                print("Player data synchronized")

        elseif result == 'NO DATA IN DATABASE' then
            --FIRST PLAYER GAME
            caster.all_creep_kills = 0
            caster.all_boss_kills = 0
            caster.all_deaths = 0
            caster.easy_win = 0
            caster.normal_win = 0
            caster.unfair_win = 0
            caster.impossible_win = 0
            caster.hard_win = 0
            caster.hell_win = 0
            caster.hardcore_win = 0

        elseif result == 'NO SERVER' then
            Say(player, "You cannot load without Server.", false)
        else
            Say(player, "FAIL! Player data was not loaded, try restarting the game or contact the developer.", false)
        end
    end)

end




function GameMode:FastWin(event)
    local playerID = event
    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local caster = PlayerResource:GetSelectedHeroEntity(playerID)
    local player = PlayerResource:GetPlayer(playerID)
    local creep_kills = CREEP_KILLS_DEFAULT or 0
    local boss_kills = BOSS_KILLS_DEFAULT or 0
    local deaths = caster.deaths or 0
    --print("Win game")

        local heroName = caster:GetUnitName()
        if heroName then
            --CustomGameEventManager:Send_ServerToPlayer(player, "on_player_save_game", {data = "-load " .. data})
            local SavingData = {}

            SavingData = { AsteamID = steamID, hero_name = heroName, creep_kills = creep_kills, boss_kills = boss_kills, deaths = deaths, endless_1 = math.floor(caster.endless_1), endless_2 = math.floor(caster.endless_2), endless_3 = math.floor(caster.endless_3), endless_4 = math.floor(caster.endless_4), endless_5 = math.floor(caster.endless_5), endless_6 = math.floor(caster.endless_6), endless_7 = math.floor(caster.endless_7), endless_8 = math.floor(caster.endless_8), endless_9 = math.floor(caster.endless_9), endless_10 = math.floor(caster.endless_10), endless_11 = math.floor(caster.endless_11), endless_12 = math.floor(caster.endless_12), endless_13 = math.floor(caster.endless_13), endless_14 = math.floor(caster.endless_14), endless_15 = math.floor(caster.endless_15) }

            
            WinGameDataWeb(SavingData, function(a,b) result = json.decode(a) --print(a) 
                if result ~= nil then
                    if result["status"] == 'ok' then 
                        --print("Reincarnate successfull for " .. steamID)
                        GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='green'>Your hero Reincarnate successfull!</font>", 0, 0)
                        caster.creep_kills = 0
                        caster.boss_kills = 0
                        caster.deaths = 0
                        caster.RespawnPos = 0
                        caster.canreinc = 0
                    else
                        --print("FAIL WIN")
                        GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='red'>Reincarnate failed. Try later, or contact with Developer.</font>", 0, 0)
                    end
                end
            end)
        else
            --print("FAIL WIN " .. err)
            Say(player, err, false)
        end
end

function GameMode:SaveOnline(event)
    local playerID = event
    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local caster = PlayerResource:GetSelectedHeroEntity(playerID)
    local player = PlayerResource:GetPlayer(playerID)

    if not caster then return end

        local item_to_remove = caster:FindItemInInventory("item_tpscroll")
        local item_to_remove2 = caster:FindItemInInventory("item_tpscroll_fake")
        if item_to_remove ~= nil then
            caster:RemoveItem(item_to_remove)
        end
        if item_to_remove2 ~= nil then
            caster:RemoveItem(item_to_remove2)
        end

        local data = caster:GetUnitName()
        if data then

            
            local SavingData = {}
            --if caster.endless_1 > 0 then
                SavingData = {steam_id = steamID}
            --end

            OnlineDataWeb(SavingData, function(a,b) result = json.decode(a) 
                if result ~= nil then
                    if result == 'NO SERVER' then
                        --Say(player, "You cannot be online without Server.", false)
                    elseif result["online"] ~= nil then
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_online_save", {playersOnlineNow = tonumber(result["online"]), playersOnlineNowEasy = tonumber(result["easy"]), playersOnlineNowNormal = tonumber(result["normal"]), playersOnlineNowHard = tonumber(result["hard"]), playersOnlineNowUnfair = tonumber(result["unfair"]), playersOnlineNowImpossible = tonumber(result["impossible"]), playersOnlineNowHell = tonumber(result["hell"]), playersOnlineNowHardcore = tonumber(result["hardcore"])})
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_online_coins", {playerCoins = tonumber(result["coins"])})
                        
                        --Say(player, "WIN Data Sended", false)
                    else
                        CustomGameEventManager:Send_ServerToPlayer(player, "on_player_online_save", {playersOnlineNow = 0, playersOnlineNowEasy = 0, playersOnlineNowNormal = 0, playersOnlineNowHard = 0, playersOnlineNowUnfair = 0, playersOnlineNowImpossible = 0, playersOnlineNowHell = 0, playersOnlineNowHardcore = 0})
                    end
                end
            end)
        else
            --Say(player, err, false)
        end
end


function GameMode:ConsoleTest(event)

        local data = event

        if data then
            
            local SavingData = {}
            SavingData = {match_id = data}
            ConsoleTestWeb(SavingData, function(a,b) result = json.decode(a) 
                if result ~= nil then
                    if result == 'NO SERVER' then
                        --print("Нет сервера")
                    elseif result == 'NO DATA IN DATABASE' then
                        --print("Новых комманд нет")
                    elseif result["command"] ~= nil then
                        SendToConsole(result["command"])
                        --print("В консоль отправлена команда: " .. result["command"])
                    else
                        --print("Нет данных")
                    end
                end
            end)
        else 
            --Say(player, err, false)
        end
end



function GameMode:DonateLoad(event)
    local caster = event
    local hero = caster
    local playerID = caster:GetPlayerID()

    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local player = PlayerResource:GetPlayer(playerID)

    local result
    local heroName = caster:GetUnitName()

    hero.isLeha = 0

    DonatesLoadDataWeb({steam_id = steamID}, function(a,b) result = json.decode(a)

        if result == nil then return end

        if result["steam_id"] ~= nil then
            if result["donates"] ~= nil then
                for str in string.gmatch(result["donates"], "%S+") do
                    local finderDonate = str



--SPECIAL HARDCORE PET |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

                
                    if finderDonate:find("SpecialHardcorePet") == 1 and steamID == result["steam_id"] then
                        print("SpecialHardcorePet")
                        if hero:FindAbilityByName("pet_special_hardcore_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_special_hardcore", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.SPpet = unit
                            --ParticleManager:CreateParticle("particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_electric.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
                            local buffSP = hero:AddAbility("pet_special_hardcore_buff")
                            buffSP:UpgradeAbility(true)
                            if not hero:HasModifier("modifier_special_hardcore") then
                                modifier = hero:AddNewModifier(hero, nil, "modifier_special_hardcore", {})
                            end
                        end
                    end


--HALLOWEEN PET |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


                    if finderDonate:find("HalloweenBonus") == 1 and steamID == result["steam_id"] then
                        print("HalloweenBonus")
                        if hero:FindAbilityByName("pet_helloween_buff") == nil then

                            local ability = hero:AddAbility("pet_helloween_buff")
                            ability:UpgradeAbility(true)
                    
                            local unit = CreateUnitByName( "npc_dota_pet_halloween_drop", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.HWpet = unit
                            ParticleManager:CreateParticle( "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
                            ParticleManager:CreateParticle( "particles/ui/ui_halloween_bats_diretide_ability_draft.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero )
                        end
                    end

                   

            --ALL PETS ISSUES PET DONATIONS |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||       
                
                
                    if finderDonate:find("AllPets") == 1 and steamID == result["steam_id"] then
                        print("AllPets")
                        --COMMON PET
                        if hero:FindAbilityByName("pet_common_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_common", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.COpet = unit
                            ParticleManager:CreateParticle("particles/econ/courier/courier_jadehoof_ambient/jadehoof_special_blossoms.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
                            local buff1 = hero:AddAbility("pet_common_buff")
                            buff1:UpgradeAbility(true)
                        end
    
                        --UNCOMMON PET
                        if hero:FindAbilityByName("pet_uncommon_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_uncommon", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.UNpet = unit
                            local buff2 = hero:AddAbility("pet_uncommon_buff")
                            buff2:UpgradeAbility(true)
                        end
    
                        --RARE PET
                        if hero:FindAbilityByName("pet_rare_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_rare", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.RApet = unit
                            local buff3 = hero:AddAbility("pet_rare_buff")
                            buff3:UpgradeAbility(true)
                        end
    
                        --EPIC PET
                        if hero:FindAbilityByName("pet_epic_buff") == nil then 
                            local unit = CreateUnitByName("npc_dota_pet_epic", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.EPpet = unit
                            local buff4 = hero:AddAbility("pet_epic_buff")
                            buff4:UpgradeAbility(true)
                        end
    
                        --LEGENDARY PET
                        if hero:FindAbilityByName("pet_legendary_buff") == nil then 
                            local unit = CreateUnitByName("npc_dota_pet_legendary", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.LEpet = unit
                            ParticleManager:CreateParticle( "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
                            local buff5 = hero:AddAbility("pet_legendary_buff")
                            buff5:UpgradeAbility(true)
                        end
    
                        --ANCIENT PET
                        if hero:FindAbilityByName("pet_ancient_buff") == nil then 
                            local unit = CreateUnitByName("npc_dota_pet_ancient", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.ANpet = unit
                            local buff6 = hero:AddAbility("pet_ancient_buff")
                            buff6:UpgradeAbility(true)
                        end
    
                    end








--COMMON PET ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


                
                    if finderDonate:find("CommonPet") == 1 and steamID == result["steam_id"] then
                        print("CommonPet")
                        if hero:FindAbilityByName("pet_common_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_common", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.COpet = unit
                            ParticleManager:CreateParticle("particles/econ/courier/courier_jadehoof_ambient/jadehoof_special_blossoms.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
                            local buff1 = hero:AddAbility("pet_common_buff")
                            buff1:UpgradeAbility(true)
                        end
                    end

--UNCOMMON PET ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

 
                
                    if finderDonate:find("UncommonPet") == 1 and steamID == result["steam_id"] then
                        print("UncommonPet")
                        if hero:FindAbilityByName("pet_uncommon_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_uncommon", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.UNpet = unit
                            local buff2 = hero:AddAbility("pet_uncommon_buff")
                            buff2:UpgradeAbility(true)
                        end
                    end


--RARE PET ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


                
                    if finderDonate:find("RarePet") == 1 and steamID == result["steam_id"] then
                        print("RarePet")
                        if hero:FindAbilityByName("pet_rare_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_rare", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.RApet = unit
                            local buff3 = hero:AddAbility("pet_rare_buff")
                            buff3:UpgradeAbility(true)
                        end
                    end


--EPIC PET ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


                
                    if finderDonate:find("EpicPet") == 1 and steamID == result["steam_id"] then
                        print("EpicPet")
                        if hero:FindAbilityByName("pet_epic_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_epic", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.EPpet = unit
                            local buff4 = hero:AddAbility("pet_epic_buff")
                            buff4:UpgradeAbility(true)
                        end
                    end


--LEGENDARY PET ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


                
                    if finderDonate:find("LegendPet") == 1 and steamID == result["steam_id"] then
                        print("LegendPet")
                        if hero:FindAbilityByName("pet_legendary_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_legendary", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.LEpet = unit
                            ParticleManager:CreateParticle( "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
                            local buff5 = hero:AddAbility("pet_legendary_buff")
                            buff5:UpgradeAbility(true)
                        end
                    end


--ANCIENT PET |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


                
                    if finderDonate:find("AncientPet") == 1 and steamID == result["steam_id"] then
                        print("AncientPet")
                        if hero:FindAbilityByName("pet_ancient_buff") == nil then
                            local unit = CreateUnitByName("npc_dota_pet_ancient", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
                            unit:SetOwner(hero)
                            hero.ANpet = unit
                            ParticleManager:CreateParticle("particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_electric.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
                            local buff6 = hero:AddAbility("pet_ancient_buff")
                            buff6:UpgradeAbility(true)
                        end
                    end


--ROSE ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


                
                    if finderDonate:find("RoseDonators") == 1 and steamID == result["steam_id"] then
                        print("RoseDonators")
                        if hero:FindItemInInventory("item_holy_50") == nil then
                            local added = hero:AddItemByName("item_holy_50")
                        end
                    end


--DEMON AND PARTICLES |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


                
                    if finderDonate:find("DemonDonators") == 1 and steamID == result["steam_id"] then
                        print("DemonDonators")
                        if hero:FindAbilityByName("terrorblade_metamorphosis_datadriven") == nil then
                            hero:AddAbility("terrorblade_metamorphosis_datadriven"):SetLevel(1)
                            ParticleManager:CreateParticle("particles/dev/curlnoise_test.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
                        end
                    end
                end
            end
        end
    end) 
--КОНЕЦ ОБЩЕЙ ЗАГРУЗКИ

        if steamID == 845162754 then
            --Вова Крищук Бусти герой
            if caster:GetUnitName() ~= "npc_dota_hero_juggernaut" then
                local added = hero:AddItemByName("item_hero_change_to_juggernaut")
            end
        end

        if steamID == 330607354 then
            --Я
            --donate_leha_doom_aura
            hero:AddAbility("donate_leha_doom_aura"):SetLevel(1)
            --hero:AddAbility("donate_steal_kills"):SetLevel(1)
            --hero:AddAbility("elder_titan_natural_order_custom"):SetLevel(1)
            --hero:AddAbility("donate_bruiser"):SetLevel(1)
            --hero:AddAbility("zaglotus_donate_bue"):SetLevel(1)
--
            --hero:AddAbility("slark_essence_shift_lua"):SetLevel(1)
            --hero:AddAbility("donate_aura_damage"):SetLevel(1)

            --hero:AddAbility("life_stealer_feast_donate"):SetLevel(1)

            --hero:AddAbility("slark_essence_shift_lua"):SetLevel(1)
--
            --if caster:GetUnitName() ~= "npc_dota_hero_juggernaut" then
            --    local added = hero:AddItemByName("item_hero_change_to_juggernaut")
            --end 
            --
            --if caster:GetUnitName() ~= "npc_dota_hero_crystal_maiden" then
            --    local added = hero:AddItemByName("item_hero_change_to_crystal_maiden")
            --end
--
            --if caster:GetUnitName() ~= "npc_dota_hero_terrorblade" then
            --    local added = hero:AddItemByName("item_hero_change_to_tb")
            --end
--
            --if caster:GetUnitName() ~= "npc_dota_hero_nevermore" then
            --    local added = hero:AddItemByName("item_hero_change_to_nevermore")
            --end

            hero.isLeha = 1

        end

        if steamID == 147536644 then
            --Steam64: 76561198107802372
            --Имя игрока: Holy Wet Virgin
            hero:AddAbility("donate_aura_damage"):SetLevel(1)

        end

        if steamID == 67155475 then
            --Scriptolog#6645
            hero:AddAbility("elder_titan_natural_order_custom"):SetLevel(1)
            hero:AddAbility("donate_bruiser"):SetLevel(1)
            hero:AddAbility("mars_bulwark"):SetLevel(1)
            hero:AddAbility("life_stealer_feast_donate"):SetLevel(1)


        end



        if steamID == 908758431 then
            --Night Wolf#3239
--
            hero:AddAbility("donate_steal_kills"):SetLevel(1)
            
        end

        if steamID == 134882011 then
            --Dobdim#1012 
--
            hero:AddAbility("slark_essence_shift_lua"):SetLevel(1)
            
        end

        if steamID == 1151872034 then
            --poombang
--
            hero:AddAbility("ricko_mount"):SetLevel(1)
            hero:AddAbility("ricko_unmount"):SetLevel(1)
            
        end

        

        if steamID == 297185758 then
            --Назар
            hero:AddAbility("medusa_split_shot_lua"):SetLevel(1)
            hero:AddAbility("donate_bonus_damage_sf"):SetLevel(1)
            
        end

        

        if steamID == 1464977114 then
            --Nalis Discord
            hero:AddAbility("life_stealer_feast_donate"):SetLevel(1)

            if caster:GetUnitName() ~= "npc_dota_hero_terrorblade" then
                local added = hero:AddItemByName("item_hero_change_to_tb")
            end
            
        end



        if steamID == 362582001 then
            --xcz9v7czx9vc#2426
            hero:AddAbility("donate_disarmor"):SetLevel(1)
            
        end

        if steamID == 142880691 then
            --Flux Discord
            hero:AddAbility("donate_disarmor"):SetLevel(1)
            
        end

        if steamID == 415864526 then
            --Витя цмка
            if caster:GetUnitName() ~= "npc_dota_hero_crystal_maiden" then
                local added = hero:AddItemByName("item_hero_change_to_crystal_maiden")
            end

        end

        if steamID == 130569575 or steamID == 158686274 then
            if caster:GetUnitName() ~= "npc_dota_hero_nevermore" then
                local added = hero:AddItemByName("item_hero_change_to_nevermore")
            end

            --Леха скил рубика и 75% чистого урона и обратка
            hero:AddAbility("terrorblade_metamorphosis_datadriven_sf"):SetLevel(1)
            hero:AddAbility("special_pure_damage_spell_datadriven"):SetLevel(1)
            hero:AddAbility("spectre_dispersion_datadriven"):SetLevel(1)
            hero:AddAbility("zaglotus_donate"):SetLevel(1)
            hero:AddAbility("zaglotus_donate_bue"):SetLevel(1)
            
            hero:AddAbility("donate_leha_doom_aura"):SetLevel(1)

            hero.isLeha = 1

        end

        if steamID == 190914471 then
            -- https://vk.com/gorokhov1992 400 rub from VK to Sber
            hero:AddAbility("special_pure_damage_spell_datadriven"):SetLevel(1)
            
        end

        if steamID == 1051977818 then
            -- Никита Кротов бусти с 23.10.2022
            hero:AddAbility("rubick_bonus_damage"):SetLevel(1)
            
            hero:AddAbility("ricko_mount"):SetLevel(1)
            hero:AddAbility("ricko_unmount"):SetLevel(1)
        end




end

CustomGameEventManager:RegisterListener("FastSaveEvent", Dynamic_Wrap(GameMode, "FastSave"))
CustomGameEventManager:RegisterListener("FastLoadEvent", Dynamic_Wrap(GameMode, "FastLoad"))