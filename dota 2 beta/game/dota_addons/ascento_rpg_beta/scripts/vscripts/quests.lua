Quests = Quests or class({})



function Quests:Init() 																	-- Events:OnGameRulesStateChange()'den buraya geliyor.

	CustomGameEventManager:RegisterListener("quest_accepted", Dynamic_Wrap(Quests, 'OnAccept'))
	CustomGameEventManager:RegisterListener("quest_completed", Dynamic_Wrap(Quests, 'OnComplete'))

	self.data = LoadKeyValues('scripts/vscripts/data/quests.kv')

	for qId,qTable in pairs(self.data) do
		self.data[qId].qId = qId
	end
	
	print("[QUESTS] creating Quests")
end

function Quests:constructor(hero)

	local playerId 	= hero:GetPlayerOwnerID()
	local player 	= PlayerResource:GetPlayer(playerId)

	self.quests 	= 'player_'..playerId..'_quests'
	self.taken 		= 'player_'..playerId..'_taken'
	self.completed 	= 'player_'..playerId..'_completed'

	PlayerTables:CreateTable(self.quests, {}, {playerId})
	PlayerTables:CreateTable(self.taken, {}, {playerId})
	PlayerTables:CreateTable(self.completed, {}, {playerId})

	for qId,qTable in pairs(self.data) do
		PlayerTables:SetTableValue(self.quests, qId, qTable)
	end

	DebugPrint('[Quests]', 'Quest, Player: '..playerId..' icin baslatiliyor.')
end
---------------------------------------------------------------------- INTERACTION ------------------------------------------------------------
function Quests:StartInteraction(hero, npc)

	local quests 	= PlayerTables:GetAllTableValues(hero.Quests.quests) 				-- Burasını hero.self.quests gibi düşün. Ama her hero için farklı 
	local playerId 	= hero:GetPlayerOwnerID()
	local player 	= PlayerResource:GetPlayer(playerId)

	for qId,qTable in pairs(quests) do
		if qTable.end_entity == npc:GetUnitName() and Quests:IsCompleted(qId, hero) then  				-- Quest bitti mi ?
			CustomGameEventManager:Send_ServerToPlayer(player, 'quest_interacted', PlayerTables:GetTableValue(hero.Quests.taken, qId))
			return
		end
		if qTable.start_entity == npc:GetUnitName() and Quests:CheckRequirements(qId, hero) then 		-- Quest alabiliyor mu ?
			CustomGameEventManager:Send_ServerToPlayer(player, 'quest_interacted', qTable)
			return
		end
	end
end
---------------------------------------------------------------------- INTERACTION ------------------------------------------------------------
---------------------------------------------------------------------- ON ACCEPT ------------------------------------------------------------
function Quests:OnAccept(data)

	local playerId 	= data.PlayerID
	local quest 	= data.quest
	local qId 	 	= quest.qId

	PlayerTables:SetTableValue('player_'..playerId..'_taken', qId, quest)

	Npcs:CheckQuests(PlayerResource:GetPlayer(playerId):GetAssignedHero() )

	DebugPrint('[Quests]', qId, 'Player: '..playerId..' tarafından alındı.')
end
---------------------------------------------------------------------- ON ACCEPT ------------------------------------------------------------
---------------------------------------------------------------------- IS COMPLETED ------------------------------------------------------------
function Quests:IsCompleted(qId, hero) 																	-- end_entity ile etkileşince buraya bakıyor.

	local quest 	= PlayerTables:GetTableValue(hero.Quests.taken, qId) 
	if not quest then return false end
	local action 	= quest.objectives.action
	local current 	= quest.objectives.current
	local required 	= quest.objectives.required

	if action == 'kill' and current < required then 
		return false
	end
	if action == 'collect' and current < required then 
		return false
	end
	if action == 'talk' and not PlayerTables:GetTableValue(hero.Quests.completed, qId) then
		PlayerTables:SetTableValue(hero.Quests.taken, qId, Quests:UpdateQuest(qId, hero)) 				-- Quest "talk" ise quest tamamlanıyor.
		return true
	end
	return true
end
---------------------------------------------------------------------- IS COMPLETED ------------------------------------------------------------
---------------------------------------------------------------------- ONCOMPLETE ------------------------------------------------------------
function Quests:OnComplete(data)
	local playerId 	= data.PlayerID
	local player 	= PlayerResource:GetPlayer(playerId)
	local hero 		= player:GetAssignedHero() 
	local quest 	= data.quest
	local qId 	 	= quest.qId

	if quest.rewards.experience then
		local giveXP = quest.rewards.experience
		if hero:HasModifier("modifier_profession") then
        	local modProf = hero:FindModifierByName("modifier_profession")
        	local modProfLvl = modProf:GetStackCount()
        	if modProfLvl == 1 and hero:GetLevel() > 29 then
        	    giveXP = 0
	
        	elseif modProfLvl == 2 and hero:GetLevel() > 119 then
        	    giveXP = 0
        	end
    	end
		hero:AddExperience(giveXP, DOTA_ModifyXP_Unspecified, false, true)
	end
	if quest.rewards.gold then
		--hero:ModifyGold(quest.rewards.gold, true, DOTA_ModifyGold_Unspecified)
		--SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, hero, quest.rewards.gold, player)
	end
	if quest.rewards.item then
		hero:AddItemByName(quest.rewards.item)
	end
	PlayerTables:DeleteTableKey('player_'..playerId..'_taken', qId)
	PlayerTables:SetTableValue('player_'..playerId..'_completed', qId, qId)

	Npcs:CheckQuests(hero)

	DebugPrint('[Quests]', qId, 'Player: '..playerId..' tarafından bitirildi.')
end
---------------------------------------------------------------------- ONCOMPLETE ------------------------------------------------------------
---------------------------------------------------------------------- ON ENTITY KILLED ------------------------------------------------------------
function Quests:OnEntityKilled(event)

	local killer 	= EntIndexToHScript(event.entindex_attacker)
	if not killer then return end
	if not killer:IsHero() then return end
	local killed 	= EntIndexToHScript(event.entindex_killed)
	if not killer:IsHero() then	killer = killer:GetOwnerEntity() end
	local hero 		= killer
	local playerId 	= hero:GetPlayerOwnerID()
	local targets 	= DOTA_UNIT_TARGET_HERO
	local heroes 	= FindUnitsInRadius(hero:GetTeamNumber(), hero:GetOrigin(), nil, 1500, DOTA_UNIT_TARGET_TEAM_FRIENDLY, targets, 0, 0, false)
	for i=1,#heroes do
		local qTaken 	= PlayerTables:GetAllTableValues(heroes[i].Quests.taken) 							-- Alinan questler
		local playerId 	= heroes[i]:GetPlayerOwnerID()
		for qId,qTable in pairs(qTaken) do
			if qTable.objectives["object"] == killed:GetUnitName() then
				PlayerTables:SetTableValue('player_'..playerId..'_taken', qId, Quests:UpdateQuest(qId, heroes[i]))
			end
		end
	end

	Npcs:CheckQuests(hero)
end
---------------------------------------------------------------------- ON ENTITY KILLED ------------------------------------------------------------
---------------------------------------------------------------------- ON ITEM PICKED ------------------------------------------------------------
function Quests:OnItemPicked(hero, item)

	local playerId 	= hero:GetPlayerOwnerID()
	local qTaken 	= PlayerTables:GetAllTableValues(hero.Quests.taken) 								-- Alinan questler
	local player 	= PlayerResource:GetPlayer(playerId)

	for qId,qTable in pairs(qTaken) do
		if qTable.objectives["object"] == item:GetName() then
			PlayerTables:SetTableValue('player_'..playerId..'_taken', qId, Quests:UpdateQuest(qId, hero))
		end
	end

	Npcs:CheckQuests(hero) 
end
---------------------------------------------------------------------- ON ITEM PICKED ------------------------------------------------------------
---------------------------------------------------------------------- OPDATE QUEST ------------------------------------------------------------
function Quests:UpdateQuest(qId, hero) 																	-- Quest objectives'e +1 katıyor.
	local quest 		= PlayerTables:GetTableValue(hero.Quests.taken, qId) 							-- Eşleşen quest

	local objectives 	= {object = quest.objectives.object, 
						   required = quest.objectives.required, 
						   action = quest.objectives.action, 
						   current = quest.objectives.current + 1}

	local data 			= {qId = quest.qId, 
						   rewards = quest.rewards, 
						   requirements = quest.requirements,
						   title = quest.title,
						   objectives = objectives,
						   start_entity = quest.start_entity,
						   end_entity = quest.end_entity,
						   description = quest.description}
	return data
end	
---------------------------------------------------------------------- OPDATE QUEST ------------------------------------------------------------
---------------------------------------------------------------------- CHECK REQ ------------------------------------------------------------
function Quests:CheckRequirements(qId, hero)

	local quest 	= PlayerTables:GetTableValue(hero.Quests.quests, qId)
	local playerId 	= hero:GetPlayerOwnerID() 

	if PlayerTables:GetTableValue(hero.Quests.completed, qId) and quest.repeatable == "no" then return false end
	if PlayerTables:GetTableValue(hero.Quests.taken, qId) then return false end
	if not quest.requirements then return true end

	local reqQuest = quest.requirements["quest"] 
	local reqLevel = quest.requirements["level"]

	if reqLevel and hero:GetLevel() < reqLevel then return false end
	if reqQuest and not PlayerTables:GetTableValue(hero.Quests.completed, reqQuest) then return false end

	return true
end
---------------------------------------------------------------------- CHECK REQ ------------------------------------------------------------
---------------------------------------------------------------------- SAVE DATA ------------------------------------------------------------
function Quests:GetQuestsToSave(hero)

	local quests 		= hero.Quests.completed
	local questTable 	= {}

	for _,qId in pairs(PlayerTables:GetAllTableValues(quests)) do
		table.insert(questTable, qId)
	end

	return questTable
end	
---------------------------------------------------------------------- SAVE DATA ------------------------------------------------------------
