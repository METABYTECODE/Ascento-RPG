
gold_extra_storage= class({})

LinkLuaModifier( "modifier_gold_extra_storage", "modules/gold_extra_storage", LUA_MODIFIER_MOTION_NONE )

function gold_extra_storage:GetIntrinsicModifierName()
    return "modifier_gold_extra_storage"
end

modifier_gold_extra_storage = class({})

function modifier_gold_extra_storage:OnCreated (table)
	self:StartIntervalThink (0.3)
end

function modifier_gold_extra_storage:OnIntervalThink()

	if  self:GetCaster():IsRealHero()  then 
		local playerID = self:GetCaster():GetPlayerOwnerID()
		
		local hero = PlayerResource:GetSelectedHeroEntity(playerID)
		
		local currentGold = PlayerResource:GetGold(playerID)
		
		
		
		local max_gold = 80000
		
		local give_gold = math.min(max_gold - currentGold, gold_wallet[playerID+1])
			

		gold_wallet[playerID+1] = gold_wallet[playerID+1] - give_gold
		hero:ModifyGold(give_gold, false, 0) 

		
		local extra_gold = (gold_wallet[playerID + 1] or 0)
		
		self:SetStackCount(extra_gold)
		
	end

end

function modifier_gold_extra_storage:DeclareFunctions()
    local funcs = {
	
    }
    return funcs
end

--return modifier's texture name returns the Buff icon resource name (here with Abaddon first skill icon)
function modifier_gold_extra_storage:GetTexture()
    return "alchemist_goblins_greed"
end

function modifier_gold_extra_storage:RemoveOnDeath()
    return false
end
