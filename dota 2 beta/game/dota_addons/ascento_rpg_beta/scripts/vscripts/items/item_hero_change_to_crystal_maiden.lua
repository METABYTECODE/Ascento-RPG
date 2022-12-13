function ChangeHero ( keys )
	local caster = keys.caster
	local item_to_remove = caster:FindItemInInventory("item_hero_change_to_crystal_maiden")

	caster:RemoveItem(item_to_remove)

    

    if not caster then return end
    if not caster:GetUnitName() then return end

    local playerID = caster:GetPlayerOwnerID()
    local player = PlayerResource:GetPlayer(playerID)
    local heroname = caster:GetUnitName()


	for i = 0, 8 do 
        local pos = caster:GetOrigin() + RandomVector(150)
        local CurrentItem = caster:GetItemInSlot(i) 
        caster:DropItemAtPositionImmediate(CurrentItem, pos)
    end

    local neutral_item = caster:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)

    if neutral_item ~= nil then
        neutral_item_name = neutral_item:GetName()
    end

    CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_boss", {playerKilledBoss = 0})
    CustomGameEventManager:Send_ServerToPlayer(player, "on_player_kill_creeps", {playerKilledCreeps = 0})

    ClearPlayerItems(caster)

    UTIL_Remove(caster.SPpet)
    UTIL_Remove(caster.HWpet)
    UTIL_Remove(caster.COpet)
    UTIL_Remove(caster.UNpet)
    UTIL_Remove(caster.RApet)
    UTIL_Remove(caster.EPpet)
    UTIL_Remove(caster.LEpet)
    UTIL_Remove(caster.ANpet)

	if caster:GetUnitName() ~= "npc_dota_hero_crystal_maiden" then
        new_hero = PlayerResource:ReplaceHeroWith(caster:GetPlayerOwnerID(), "npc_dota_hero_crystal_maiden", PlayerResource:GetGold(caster:GetPlayerOwnerID()), 0)
    end

    if neutral_item_name ~= nil then
      new_hero:AddItemByName(neutral_item_name)
    end

    if new_hero:HasModifier("modifier_profession") then
      local CurrentProf = new_hero:FindModifierByName("modifier_profession")
      CurrentProf:SetStackCount(3)
    else
      local CurrentProf = new_hero:AddNewModifier (new_hero, nil, "modifier_profession", {duration = -1})
      CurrentProf:SetStackCount(3)
    end
      

    Timers:CreateTimer(3,function()
      GameMode:FirstLoadNoReq(new_hero)

        return nil
    end)
    

    --ParticleManager:CreateParticle("particles/units/heroes/hero_void_spirit/void_spirit_ethereal_form.vpcf", PATTACH_ABSORIGIN_FOLLOW, new_hero)

end