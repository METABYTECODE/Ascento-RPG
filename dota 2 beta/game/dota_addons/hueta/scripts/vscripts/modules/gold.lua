
local max_gold = 80000

_G.gold_wallet = {0,0,0,0,0}

function add_gold_to_player(index,gold)
			
			local hero = PlayerResource:GetSelectedHeroEntity(index)
			
			local currentGold = PlayerResource:GetGold(index)
			
			local newGold = currentGold + gold + gold_wallet[index+1]
			
			if (newGold > max_gold) then
				gold_wallet[index+1] = newGold-max_gold 
				hero:ModifyGold(max_gold - currentGold, false, 0) -- set to 80k
				
			else
				gold_wallet[index+1] = 0 
				hero:ModifyGold(newGold - currentGold, false, 0) 
			end

end