function tp2(event)
     print("meme3")
     local unit = event.activator
     --local  wws= "meme3" -- вот та сама точка, куда мы будем телепортировать героя, мы её указали в скрипте

     --local ent = Entities:FindByName( nil, wws) --строка ищет как раз таки нашу точку pnt1
     --local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты
     --event.activator:SetAbsOrigin( point ) -- получили координаты, теперь меняем место героя на pnt1

     local point = Vector(-8985, -11731, 3965)

     --print(unit:GetRootMoveParent())

     if unit:GetLevel() == 135 then
          FindClearSpaceForUnit(event.activator, point, true) --нужно чтобы герой не застрял
          event.activator:Stop() --приказываем ему остановиться, иначе он побежит назад к предыдущей точке
      else
          CustomGameEventManager:Send_ServerToPlayer(unit:GetPlayerOwner(), "create_error_message", {message = "Only players 135 lvl can enter this portal"})
      end
end