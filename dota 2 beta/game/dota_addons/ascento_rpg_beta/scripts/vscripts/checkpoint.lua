function checkpoint(event)

     local unit = event.activator

     local caller = event.caller
     local callerName = caller:GetName()

     --print(callerName)

     local wws = callerName:sub(12, 14)


     if unit.RespawnPos ~= nil then
          if tonumber(unit.RespawnPos) < tonumber(wws) then
               unit.RespawnPos = wws
               CustomGameEventManager:Send_ServerToPlayer(unit:GetPlayerOwner(), "create_error_message", {message = "Respawn point successfully set"})
          end
     else
          unit.RespawnPos = wws
          CustomGameEventManager:Send_ServerToPlayer(unit:GetPlayerOwner(), "create_error_message", {message = "Respawn point successfully set"})
     end

     
end

function check_reinc(event)

     local unit = event.activator

     --local caller = event.caller
     --local callerName = caller:GetName()

     local playerID = unit:GetPlayerID()
     local steamID = PlayerResource:GetSteamAccountID(playerID)

     local wws = "teleport_endless_" .. unit:GetPlayerOwnerID() + 1

     if unit.isLeha == 1 then
          wws = "teleport_endless_leha"
     end

     local ent = Entities:FindByName( nil, wws) --строка ищет как раз таки нашу точку pnt1
     local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты

     if unit.boss_kills >= BOSS_KILLS_DEFAULT and unit.creep_kills >= CREEP_KILLS_DEFAULT and unit.canreinc == 1 then

          if unit:GetLevel() >= 100 then
               FindClearSpaceForUnit(unit, point, true) --нужно чтобы герой не застрял

               PlayerResource:SetCameraTarget(unit:GetPlayerOwnerID(), unit)
               unit:Stop()
               Timers:CreateTimer(0.2, function()
                   PlayerResource:SetCameraTarget(unit:GetPlayerOwnerID(), nil)
                   return nil
               end)
               
          else
               CustomGameEventManager:Send_ServerToPlayer(unit:GetPlayerOwner(), "create_error_message", {message = "Only players 100+ lvl can enter this portal"})
          end

          --local gate_endless = Entities:FindByName(nil, "gate_endless")
          --if gate_endless ~= nil then
          --     gate_endless:SetModel("models/props_generic/gate_wooden_destruction_03.vmdl")
          --end
     --
          --local endless_obst = Entities:FindByName(nil, "gate_endless_obst")
          --if endless_obst ~= nil then
          --     UTIL_Remove(endless_obst)
          --end
     else
          CustomGameEventManager:Send_ServerToPlayer(unit:GetPlayerOwner(), "create_error_message", {message = "To open this gate, you must kill at least ".. BOSS_KILLS_DEFAULT .." and at least ".. CREEP_KILLS_DEFAULT .." creeps."})
     end
     
end


