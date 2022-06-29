if playersShmot == nil then
	_G.playersShmot = class({})

end

if not request then 
    request = class({})
    request.__http = 'https://ascento.ru/api'
    request.__authKey = "AuthKey12345"
end

local _util_ = require('modules/request/util')
function request:Init()
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(request, 'OnGameRulesStateChange'), self)    
end

function request:OnGameRulesStateChange()
	local newState = GameRules:State_Get()

    if newState == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP  then 

        local players = {}
        playersShmot.shmot = {}

        for index=0 ,23 do
            if (PlayerResource:IsValidPlayer(index) and not _util_.IsBot(index)) then 
                table.insert(players,{tostring(index), tostring(PlayerResource:GetSteamID(index))})
            end
        end

		_util_.RequestData('/loadshmot',players,function(data)


            			--playersShmot.shmot = {playerID = (tonumber(index)), steamID = players, shmot = data.shmot}
            			
            			CustomNetTables:SetTableValue( "custom_shmot", "shmot", data )

      	end)



        --_util_.RequestData('/beforeMatch',players,function(data)

        --    CustomNetTables:SetTableValue( "leaderboard", 'solo', data.solo )
        --    CustomNetTables:SetTableValue( "leaderboard", 'party', data.party )
        --    CustomNetTables:SetTableValue( "leaderboard", 'players', data.players )

        --end)
		
	--_util_.RequestData('/loadgame',players,function(data)

		--	CustomNetTables:SetTableValue( "sal", 'solo', data.solo )
		
      --end)
	  
	  --_util_.RequestData('/donate',players,function(data)

		--	CustomNetTables:SetTableValue( "donateweb", 'solo', data.solo )
		
      --end)
	  
	  --_util_.RequestData('/donate_items',players,function(data)

		--	CustomNetTables:SetTableValue( "donate_items", 'solo', data.solo )
		
      --end)
	  
	  -- _util_.RequestData('/wave_count',players,function(data)

		--	CustomNetTables:SetTableValue( "wave_count", 'solo', data.solo )
		
      --end)

    end 
 
end

function request:afterMatchSend() 
if GameRules:IsCheatMode()  then return end
    local players = {}
    for index=0 ,23 do
    	    table.insert(players,{
                heroName = PlayerResource:GetSelectedHeroEntity(index):GetUnitName(),
                steamID = tostring(PlayerResource:GetSteamID(index))
            })

        if (PlayerResource:IsValidPlayer(index) and not _util_.IsBot(index)) and PlayerResource:GetSelectedHeroEntity(index) then 
        	    _util_.RequestData('/afterMatch',{
		        gameTime =  wave,
        		matchID = tostring(GameRules:Script_GetMatchID()),
                heroName = PlayerResource:GetSelectedHeroEntity(index):GetUnitName(),
                steamID = tostring(PlayerResource:GetSteamID(index))
   		 })
        	    DeepPrintTable(players)

        end
    end

        _util_.RequestData('/afterMatch',{
        		gameTime =  wave,
        		matchID = tostring(GameRules:Script_GetMatchID()),
        		players = players
   		})

end 




function request:saveGame() 
if GameRules:IsCheatMode()  then return end
    local save = {}
	local maxindex = PlayerResource:GetNumConnectedHumanPlayers()
for index=0,(maxindex) do

local hero = PlayerResource:GetSelectedHeroEntity(index)
local heroName = PlayerResource:GetSelectedHeroName(index)
local esDop = 0 
local esAtk = 0 
				
			


             _util_.RequestData('/savegame',{
      gameTime =  GameRules:GetDOTATime(false, false),
       matchID = tostring(GameRules:Script_GetMatchID()),
				heroName = tostring(PlayerResource:GetSelectedHeroName(index)), -- npc_hero_name
				steamGID = tostring(PlayerResource:GetSteamID(index)), -- SteamID
				gold = tostring(PlayerResource:GetGold(index)), -- Голда
				lvl = tostring(hero:GetCurrentXP()),-- XP
				esAtk = tostring(esAtk), -- считаем стаки Essensse Attack (Стаки урона у всех)
				esDop = tostring(esDop), -- Добавляем пассивку если есть 
				agi = tostring(PlayerResource:GetSelectedHeroEntity(index):GetBaseAgility()), -- базовая ловк
				dmg = tostring(hero:GetAverageTrueAttackDamage(hero)), -- дамаг
				str = tostring(PlayerResource:GetSelectedHeroEntity(index):GetBaseStrength()),-- сила
				int = tostring(PlayerResource:GetSelectedHeroEntity(index):GetBaseIntellect()), -- интелект
				slot0 = tostring(slot0), -- слот1
				slot1 = tostring(slot1), -- слот2
				slot2 = tostring(slot2), -- слот3
				slot3 = tostring(slot3), -- слот4
				slot4 = tostring(slot4), -- слот5
				slot5 = tostring(slot5), -- слот6
				slot_netral = tostring(slot_netral), -- нейтральный слот
				wave = wave
   })
				
   end
   

   
   --DeepPrintTable (save);
   --DeepPrintTable (gameTime);
   


  
   
end 

  





request:Init()

