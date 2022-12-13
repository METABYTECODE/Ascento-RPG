function tp2(event)
     --print("meme2")
     local unit = event.activator
     --local  wws= "meme2" -- вот та сама точка, куда мы будем телепортировать героя, мы её указали в скрипте

     --local ent = Entities:FindByName( nil, wws) --строка ищет как раз таки нашу точку pnt1
     --local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты -8985.442383 -11731.358398 3965.000000
     --event.activator:SetAbsOrigin( point ) -- получили координаты, теперь меняем место героя на pnt1

     local point = Vector(-2315, -13861, 3069)

     --print(unit:GetRootMoveParent())

     if unit:GetLevel() >= 75 then
	     FindClearSpaceForUnit(event.activator, point, true) --нужно чтобы герой не застрял
	     event.activator:Stop() --приказываем ему остановиться, иначе он побежит назад к предыдущей точке
	 else
          CustomGameEventManager:Send_ServerToPlayer(unit:GetPlayerOwner(), "create_error_message", {message = "Only players 75+ lvl can enter this portal"})
      end
end