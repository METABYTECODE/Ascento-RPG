
function GameMode:FastWin(playerID)
  
    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local caster = PlayerResource:GetSelectedHeroEntity(playerID)
    local player = PlayerResource:GetPlayer(playerID)

    --print("Win game")

    local heroName = caster:GetUnitName()
    if heroName then
        local SavingData = {}

        SavingData = { AsteamID = steamID, hero_name = heroName }

        WinEventDataWeb(SavingData, function(a,b) result = json.decode(a) --print(a) 
            if result ~= nil then
                if result["status"] == 'ok' then 
                    --GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='green'>Win data successfull sended to the server!</font>", 0, 0)
                else
                    --GameRules:SendCustomMessage("<font color='#00EA43'>".. caster:GetUnitName() ..": </font><font color='red'>Win data send failed. Try later, or contact with Developer.</font>", 0, 0)
                end
            end
        end)
    else
        Say(player, err, false)
    end
end

function GameMode:SaveOnline(event)
    local playerID = event
    local steamID = PlayerResource:GetSteamAccountID(playerID)
    local caster = PlayerResource:GetSelectedHeroEntity(playerID)
    local player = PlayerResource:GetPlayer(playerID)

    if not caster then return end


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
