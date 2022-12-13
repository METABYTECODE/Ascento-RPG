triggerRadius = 2000 / 2



function spawn_creeps_for_trigger(triggerABS, triggerName)

   local theUnits = LoadKeyValues("scripts/npc/test_spawn.kv")
   local theUnitTable = {}

   for k, v in pairs(theUnits) do
      if k ~= nil then
         table.insert(theUnitTable, k)
      end
   end


   local theUnit = GetRandomTableElement(theUnitTable)


   local pointName = Entities:FindAllByNameWithin("spawner_creep", triggerABS, triggerRadius)
   
   if pointName ~= nil then
      for _,thePoint in ipairs(pointName) do
         
         local spawnPosition = thePoint:GetAbsOrigin()
         local unit = CreateUnitByName(theUnit, spawnPosition + RandomVector( RandomFloat( 50, 50)), true, nil, nil, DOTA_TEAM_BADGUYS)
         unit.trigger = triggerName
         unit:SetModelScale(1)

         local enemystats = LoadKeyValues("scripts/npc/enemy_stats.txt")
         local unit_stats = enemystats[triggerName]
         for param, value in pairs(unit_stats) do
            if param == "damage" then
                local damage_unit = tonumber(value)
                unit:SetBaseDamageMin(damage_unit)
                unit:SetBaseDamageMax(damage_unit)
            end
            if param == "armor" then
                local armor_unit = tonumber(value)
                unit:SetPhysicalArmorBaseValue(armor_unit)
            end
            if param == "health" then
                local health_unit = tonumber(value)
                unit:SetMaxHealth(health_unit)
                unit:SetBaseMaxHealth(health_unit)
                unit:SetHealth(health_unit)
            end
            if param == "health_regen" then
                local health_regen_unit = tonumber(value)
                unit:SetBaseHealthRegen(health_regen_unit)
            end
            if param == "mana" then
                local mana_unit = tonumber(value)
                unit:SetMana(mana_unit)
            end
            if param == "mana_regen" then
                local mana_regen_unit = tonumber(value)
                unit:SetBaseManaRegen(mana_regen_unit)
            end
         end
      end
   end

   

end

function spawn_creeps(event)
  
   local unit = event.activator
   local trigger = event.caller
   local triggerName = trigger:GetName()

   local triggerABS = trigger:GetAbsOrigin()
   if unit then
      if unit:GetName() == "npc_dota_hero" then

         --print("Герой есть")

         if unit:IsRealHero() then

         --print("Реальный герой есть")

            local finded = Entities:FindAllInSphere(triggerABS, triggerRadius)
         
            local findedCount = 0
            
            for k, v in pairs(finded) do
               if v ~= nil then
                  if v:GetName() == "npc_dota_creature" then
                     if v.trigger ~= nil and v.trigger == triggerName then
                        findedCount = findedCount + 1
                     end
                  end
               end
            end

            --print(findedCount)
         
            if findedCount < 1 then
         
               spawn_creeps_for_trigger(triggerABS, triggerName)

               --print("Timer " .. triggerName)
               Timers:CreateTimer(triggerName, {
               useGameTime = false,
               endTime = -1,
               callback = function()
                  --

                  local finded = Entities:FindAllInSphere(triggerABS, triggerRadius * 20)
         
                  local findedCount_timer = 0
                  
                  for k, v in pairs(finded) do
                     if v ~= nil then
                        if v:GetName() == "npc_dota_creature" then
                           if v.trigger ~= nil and v.trigger == triggerName then
                              findedCount_timer = findedCount_timer + 1
                           end
                        end
                     end
                  end

                  --print(findedCount_timer)

                  if findedCount_timer < 1 then
                     spawn_creeps_for_trigger(triggerABS, triggerName)
                  end
                  return 1
               end
            })
               
            end
         end
      end
   end


end




function despawn_creeps(event)

   local unit = event.activator
   if unit then
      if unit:GetName() == "npc_dota_creature" then
         unit:Destroy()
      end
   end

   if unit then

      local trigger = event.caller
      local triggerName = trigger:GetName()
   
      local triggerABS = trigger:GetAbsOrigin()
   
      local findedhero = Entities:FindAllInSphere(triggerABS, triggerRadius - 200)
      
      local findedCount = 0
   
      for k, v in pairs(findedhero) do
         if v ~= nil then
            if v:GetName() == "npc_dota_hero" then
            --print("npc_dota_hero finded")
               if v:IsRealHero() then
            --print("IsRealHero finded")
                  findedCount = findedCount + 1
               end
            end
         end
      end
         --print("findedCount " .. findedCount)
      
      
      if findedCount < 1 then
         --print("findedCount < 1")
         if unit ~= nil then
            if unit:GetName() ~= nil then
               if unit:GetName() == "npc_dota_hero" then
                  Timers:RemoveTimer(triggerName)
                  --print("Таймер остановлен " .. triggerName)
               end
            end
         end
   
         local finded = Entities:FindAllInSphere(triggerABS, triggerRadius * 20)
   
         for k, v in pairs(finded) do
            if v ~= nil then
               if v:GetName() == "npc_dota_creature" then
                  if v.trigger == triggerName then
                     v:Destroy()
                  end
               end
            end
         end
      end
   end


end
