Achievments = Achievments or class({})



function Achievments:Init()                                  -- Events:OnGameRulesStateChange()'den buraya geliyor.

  --CustomGameEventManager:RegisterListener("quest_accepted", Dynamic_Wrap(Quests, 'OnAccept'))
  CustomGameEventManager:RegisterListener("achievments_completed", Dynamic_Wrap(Achievments, 'OnComplete'))

  self.data = LoadKeyValues('scripts/vscripts/data/achievments.kv')

  for qId,qTable in pairs(self.data) do
    self.data[qId].qId = qId
  end
  
  print("[Achievments] creating Achievments")

  --PrintTable(self.data)
end

function Achievments:constructor(hero)

  local playerId  = hero:GetPlayerOwnerID()
  local player  = PlayerResource:GetPlayer(playerId)

  self.achieves   = 'player_'..playerId..'_achieves'
  self.completed  = 'player_'..playerId..'_achieves_completed'

  PlayerTables:CreateTable(self.achieves, {}, {playerId})
  PlayerTables:CreateTable(self.completed, {}, {playerId})

  for qId,qTable in pairs(self.data) do
    PlayerTables:SetTableValue(self.achieves, qId, qTable)
  end
  print("Constructor achieves")

  --PrintTable(PlayerTables:GetAllTableValues(self.achieves))
  
  --print("Constructor completed")

  --PrintTable(PlayerTables:GetAllTableValues(self.completed))

  --DebugPrint('[Quests]', 'Quest, Player: '..playerId..' icin baslatiliyor.')
end

---------------------------------------------------------------------- ON ACCEPT ------------------------------------------------------------
---------------------------------------------------------------------- IS COMPLETED ------------------------------------------------------------
function Achievments:IsCompleted(qId, hero)                                  -- end_entity ile etkileşince buraya bakıyor.

  local achieves   = PlayerTables:GetTableValue(hero.Achieves.achieves, qId) 
  if not achieves then return false end
  local action  = achieves.objectives.action
  local current   = achieves.objectives.current
  local required  = achieves.objectives.required

  if action == 'kill' and current < required then 
    return false
  end
  if action == 'collect' and current < required then 
    return false
  end
  if action == 'death' and current < required then 
    return false
  end
  if action == 'lvlup' and current < required then 
    return false
  end
  if action == 'win' and current < required then 
    return false
  end
  if action == 'play' and current < required then 
    return false
  end

  return true
end
---------------------------------------------------------------------- IS COMPLETED ------------------------------------------------------------
---------------------------------------------------------------------- ONCOMPLETE ------------------------------------------------------------
function Achievments:OnComplete(data)
  local playerId  = data.PlayerID
  local player  = PlayerResource:GetPlayer(playerId)
  local hero    = player:GetAssignedHero() 
  local achieve   = data.achievments
  local qId     = achieve.qId
  local reward  = achieve.rewards

  if reward.all_stats then
      reward = all_stats
  end
  if reward.all_stats_pct then
      reward = all_stats_pct
  end
  if reward.armor then
      reward = armor
  end
  if reward.exp_boost then
      reward = exp_boost
  end
  if reward.bonus_damage_pct then
      reward = bonus_damage_pct
  end
  if reward.damage_reduction_pct then
      reward = damage_reduction_pct
  end
  if reward.bonus_spell_damage_pct then
      reward = bonus_spell_damage_pct
  end
  if reward.drop_rate then
      reward = drop_rate
  end
  if reward.primary_attribute then
      reward = primary_attribute
  end

  PlayerTables:DeleteTableKey('player_'..playerId..'_achieves', qId)
  PlayerTables:SetTableValue('player_'..playerId..'_achieves_completed', qId, qId)

  --Npcs:CheckQuests(hero)

  DebugPrint('[Achievments]', qId, 'Player: '..playerId..' tarafından bitirildi.')
end
---------------------------------------------------------------------- ONCOMPLETE ------------------------------------------------------------
---------------------------------------------------------------------- ON ENTITY KILLED ------------------------------------------------------------
function Achievments:OnEntityKilled(event)

  local killer  = EntIndexToHScript(event.entindex_attacker)
  local killed  = EntIndexToHScript(event.entindex_killed)
  if not killer:IsHero() then killer = killer:GetOwnerEntity() end
  if not killer or not killer:IsHero() then return end
  local hero    = killer
  local playerId  = hero:GetPlayerOwnerID()
  local targets   = DOTA_UNIT_TARGET_HERO
  local heroes  = FindUnitsInRadius(hero:GetTeamNumber(), hero:GetOrigin(), nil, 1500, DOTA_UNIT_TARGET_TEAM_FRIENDLY, targets, 0, 0, false)
  for i=1,#heroes do
    local qTaken  = PlayerTables:GetAllTableValues(heroes[i].Achievments.achieves)              -- Alinan questler
    local playerId  = heroes[i]:GetPlayerOwnerID()
    for qId,qTable in pairs(qTaken) do
      if qTable.objectives["object"] == "boss" then
        if IsBossASCENTO(killed) then
          PlayerTables:SetTableValue('player_'..playerId..'_achieves', qId, Achievments:UpdateQuest(qId, heroes[i]))
        end
      elseif qTable.objectives["object"] == "enemy" then
        if IsCreepASCENTO(killed) then
          PlayerTables:SetTableValue('player_'..playerId..'_achieves', qId, Achievments:UpdateQuest(qId, heroes[i]))
        end
      end
    end
  end

  --Npcs:CheckQuests(hero)
end
---------------------------------------------------------------------- ON ENTITY KILLED ------------------------------------------------------------
---------------------------------------------------------------------- ON ITEM PICKED ------------------------------------------------------------
function Achievments:OnItemPicked(hero, item)

  local playerId  = hero:GetPlayerOwnerID()
  local qTaken  = PlayerTables:GetAllTableValues(hero.Achievments.achieves)                 -- Alinan questler
  local player  = PlayerResource:GetPlayer(playerId)

  for qId,qTable in pairs(qTaken) do
    if qTable.objectives["object"] == item:GetName() then
      PlayerTables:SetTableValue('player_'..playerId..'_achieves', qId, Achievments:UpdateQuest(qId, hero))
    end
  end

  --Npcs:CheckQuests(hero) 
end
---------------------------------------------------------------------- ON ITEM PICKED ------------------------------------------------------------
---------------------------------------------------------------------- OPDATE QUEST ------------------------------------------------------------
function Achievments:UpdateQuest(qId, hero)                                  -- Quest objectives'e +1 katıyor.
  local achieve     = PlayerTables:GetTableValue(hero.Achievments.achieves, qId)              -- Eşleşen quest

  local objectives  = {object = achieve.objectives.object, 
               required = achieve.objectives.required, 
               action = achieve.objectives.action, 
               current = achieve.objectives.current + 1}

  local data      = {qId = achieve.qId, 
               rewards = achieve.rewards, 
               requirements = achieve.requirements,
               title = achieve.title,
               objectives = objectives,
               start_entity = achieve.start_entity,
               end_entity = achieve.end_entity,
               description = achieve.description}
  return data
end 
---------------------------------------------------------------------- OPDATE QUEST ------------------------------------------------------------
---------------------------------------------------------------------- CHECK REQ ------------------------------------------------------------
function Achievments:CheckRequirements(qId, hero)

  local achieve   = PlayerTables:GetTableValue(hero.Achievments.achieves, qId)
  local playerId  = hero:GetPlayerOwnerID() 

  if PlayerTables:GetTableValue(hero.Achievments.completed, qId) then return false end
  if PlayerTables:GetTableValue(hero.Achievments.achieves, qId) then return false end
  if not achieve.requirements then return true end


  return true
end
---------------------------------------------------------------------- CHECK REQ ------------------------------------------------------------
---------------------------------------------------------------------- SAVE DATA ------------------------------------------------------------
function Achievments:GetQuestsToSave(hero)

  local achieve    = hero.Achievments.completed
  local achieveTable  = {}

  for _,qId in pairs(PlayerTables:GetAllTableValues(achieve)) do
    table.insert(achieveTable, qId)
  end

  return achieveTable
end 
---------------------------------------------------------------------- SAVE DATA ------------------------------------------------------------
