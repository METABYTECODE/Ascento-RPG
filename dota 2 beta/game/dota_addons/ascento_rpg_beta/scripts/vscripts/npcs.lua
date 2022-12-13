Npcs = Npcs or class({})

function Npcs:Init() 																	-- Events:OnGameRulesStateChange()'den buraya geliyor.

	self.data 		= LoadKeyValues('scripts/npc/npc_quest.txt')
	self.particles 	= {}



	for id,nTable in pairs(self.data) do
		if self.data[id].NpcType == "quest" and self.data[id].NpcType ~= nil then
			local entCreate = Entities:FindByName(nil, id)
			if entCreate ~= nil then
				local position 	= entCreate:GetAbsOrigin()
				if position ~= nil then
					local npc 		= CreateUnitByName(id, position, true, nil, nil, DOTA_TEAM_GOODGUYS)
					npc:GetAbilityByIndex(0):SetLevel(1)
					npc:SetAngles(0, nTable.NpcAngle, 0)
					if self.data[id].NpcType == "shop" then 
						local particle = ParticleManager:CreateParticle("particles/dev/library/base_overhead_follow.vpcf", PATTACH_CUSTOMORIGIN, nil)
						ParticleManager:SetParticleControl(particle, 0, npc:GetAbsOrigin() + Vector(0,0,256))
					end
				end
			end
		end
		--if self.data[id].NpcType == "creature" then
		--	for pointName,spawnInfo in pairs(self.data[id].SpawnInfo) do
		--		local spawnPoint	= Entities:FindByName(nil, pointName)
		--		local lim, del 		= spawnInfo:match'(%d+) (%d+)'
		--		local limit, delay 	= tonumber(lim), tonumber(del)
		--		Npcs:StartSpawn(pointName, spawnPoint, id, limit, delay)
		--	end
		--end
		--if self.data[id].NpcType == "boss" then
		--	Npcs:BossSpawner(id)
		--end
	end

	print("[NPCS] creating Npcs")
end

function Npcs:StartSpawn(pointName, spawnPoint, id, limit, delay)
	spawnPoint.spawned = {}
	Timers:CreateTimer(function()
		Npcs:SpawnUnit(pointName, spawnPoint, id, limit, delay)
		return delay
	end)
end

function Npcs:SpawnUnit(pointName, spawnPoint, id, limit, delay)
	if #spawnPoint.spawned < limit then
		local creature = CreateUnitByName(id, spawnPoint:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS)
		ai = require( "ai/ai_basic" )
		ai.Init(creature)
		local particle = ParticleManager:CreateParticle("mellon.vpcf", PATTACH_ABSORIGIN_FOLLOW, creature) 	 	-- error particle
		ParticleManager:ReleaseParticleIndex(particle)
		table.insert(spawnPoint.spawned, creature)
	end

	local t = {}

	for int, unit in pairs(spawnPoint.spawned) do
		if unit and IsValidEntity(unit) then
			table.insert(t, unit) 						-- Burada "creature"ı hScript olarak kaydettiği için ölünce oto siliniyor?
		end
	end

	spawnPoint.spawned = t
end

function Npcs:CheckQuests(hero) -- Characters:OnCharacterLoad(), OnCharacterPick() - Events:OnLevelUp() - Quests:OnComplete(), OnEntityKilled(), OnAccept(), OnItemPicked() kullanıyor.

	local playerId 	= hero:GetPlayerOwnerID()
	local player 	= PlayerResource:GetPlayer(playerId)
	local quests 	= PlayerTables:GetAllTableValues(hero.Quests.quests)

	for qId,quest in pairs(quests) do
		if PlayerTables:GetTableValue(hero.Quests.completed, qId) and self.particles[playerId..qId] then 
			ParticleManager:DestroyParticle(self.particles[playerId..qId], false)
			ParticleManager:ReleaseParticleIndex(self.particles[playerId..qId])
			self.particles[playerId..qId] = nil
			if quest.repeatable == "yes" and PlayerTables:GetTableValue(hero.Quests.completed, qId) then
				local particle 	= ParticleManager:CreateParticleForPlayer("particles/repeatable_quest.vpcf", PATTACH_CUSTOMORIGIN,	nil, player)
				ParticleManager:SetParticleControl(particle, 0, Entities:FindByName(nil, quest.start_entity):GetAbsOrigin())
				self.particles[playerId..qId] = particle
			end
		end

		if PlayerTables:GetTableValue(hero.Quests.taken, qId) and self.particles[playerId..qId] then 
			ParticleManager:DestroyParticle(self.particles[playerId..qId], false)
			ParticleManager:ReleaseParticleIndex(self.particles[playerId..qId])
			self.particles[playerId..qId] = nil
			local particle 	= ParticleManager:CreateParticleForPlayer("particles/taken_quest.vpcf", PATTACH_CUSTOMORIGIN,	nil, player)
			ParticleManager:SetParticleControl(particle, 0, Entities:FindByName(nil, quest.end_entity):GetAbsOrigin())
			self.particles[playerId..qId] = particle

			local quest = PlayerTables:GetTableValue('player_'..playerId..'_taken', qId)

			if quest.objectives.required <= quest.objectives.current or quest.objectives.action == "talk" then
				ParticleManager:DestroyParticle(self.particles[playerId..qId], false)
				ParticleManager:ReleaseParticleIndex(self.particles[playerId..qId])
				self.particles[playerId..qId] = nil
				local particle 	= ParticleManager:CreateParticleForPlayer("particles/completed_quest.vpcf", PATTACH_CUSTOMORIGIN,	nil, player)
				ParticleManager:SetParticleControl(particle, 0, Entities:FindByName(nil, quest.end_entity):GetAbsOrigin())
				self.particles[playerId..qId] = particle
			end
		end

		if Quests:CheckRequirements(qId, hero) then

			if not self.particles[playerId..qId] then
				if quest.repeatable == "yes" and PlayerTables:GetTableValue(hero.Quests.completed, qId) then
					local particle 	= ParticleManager:CreateParticleForPlayer("particles/repeatable_quest.vpcf", PATTACH_CUSTOMORIGIN,	nil, player)
					ParticleManager:SetParticleControl(particle, 0, Entities:FindByName(nil, quest.start_entity):GetAbsOrigin())
					self.particles[playerId..qId] = particle
				else
					local particle 	= ParticleManager:CreateParticleForPlayer("particles/has_quest.vpcf", PATTACH_CUSTOMORIGIN,	nil, player)
					ParticleManager:SetParticleControl(particle, 0, Entities:FindByName(nil, quest.start_entity):GetAbsOrigin())
					self.particles[playerId..qId] = particle
				end
			end
		end
	end

end

function Npcs:GetNpcType(npcName)
	if npcName ~= nil then
		if self.data[npcName] ~= nil then
			if self.data[npcName].NpcType ~= nil then
				return self.data[npcName].NpcType
			else
				return nil
			end
		else
			return nil
		end
	else
		return nil
	end
end
