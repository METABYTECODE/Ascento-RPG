local AdvancedTableMT = {__index = {
    HasValue = function(self, value)
        for _, v in pairs(self) do
            if v == value then
                return true
            end
        end
        return false
    end
}}

function CDOTA_BaseNPC.GetItemsCount(self, itemsName, firstSlot, lastSlot)
    if type(itemsName) ~= "table" then
        itemsName = {itemsName}
    end
    setmetatable(itemsName, AdvancedTableMT)
    firstSlot = firstSlot or 0
    lastSlot = lastSlot or 8
    local ans = 0
        for slot = firstSlot, lastSlot do
            local item = self:GetItemInSlot(slot)
            if item and itemsName:HasValue(item:GetName()) then
                ans = ans + 1
            end
        end
    return ans
end

function weapon (event)
    local items =
    {
        "item_quarterstaff_datadriven",
        "item_quarterstaff_datadriven_one",
        "item_claymore_datadriven_one",
        "item_claymore_datadriven_eith",
        "item_claymore_datadriven_seven",
        "item_claymore_datadriven_six",
        "item_claymore_datadriven_five",
        "item_claymore_datadriven_four",
        "item_claymore_datadriven_three",
        "item_claymore_datadriven_two",
        "item_claymore_datadriven_nine",
        "item_claymore_datadriven_ten",
        "item_claymore_datadriven_ten_d_grade",
        "item_claymore_datadriven_ten_c_grade",
        "item_claymore_datadriven_ten_b_grade",
        "item_claymore_datadriven_ten_a_grade",
        "item_claymore_datadriven_ten_s_grade",
        "item_claymore_datadriven_ten_ss_grade",
        "item_claymore_datadriven_ten_sss_grade",
        "item_claymore_datadriven_ten_sss_grade_heroic",
    }
   --for k, v in pairs(items) do
   --    for i = 0, 5 do 
   --        local CurrentItem = event.caster:GetItemInSlot(i)
   --        if CurrentItem ~= nil then
   --            if CurrentItem:GetName() == v then
   --                event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
   --                CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
   --            end
   --        end
   --    end 
   --end
    if event.caster:GetItemsCount(items) ~= 0 then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
    end
end

function armor (event)
    local items =
    {
        "item_platemail_datadriven",
        "item_platemail_datadriven_one",
        "item_claymore_datadriven_one",
        "item_claymore_datadriven_eith",
        "item_claymore_datadriven_seven",
        "item_claymore_datadriven_six",
        "item_claymore_datadriven_five",
        "item_claymore_datadriven_four",
        "item_claymore_datadriven_three",
        "item_claymore_datadriven_two",
        "item_claymore_datadriven_nine",
        "item_claymore_datadriven_ten",
        "item_claymore_datadriven_ten_d_grade",
        "item_claymore_datadriven_ten_c_grade",
        "item_claymore_datadriven_ten_b_grade",
        "item_claymore_datadriven_ten_a_grade",
        "item_claymore_datadriven_ten_s_grade",
        "item_claymore_datadriven_ten_ss_grade",
        "item_claymore_datadriven_ten_sss_grade",
        "item_claymore_datadriven_ten_sss_grade_heroic",
    }
    if event.caster:GetItemsCount(items) ~= 0 then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
    end
end

function main_weapon(event)
    local items =
    {
        "item_platemail_datadriven",
        "item_platemail_datadriven_one",
        "item_claymore_datadriven_one",
        "item_claymore_datadriven_eith",
        "item_claymore_datadriven_seven",
        "item_claymore_datadriven_six",
        "item_claymore_datadriven_five",
        "item_claymore_datadriven_four",
        "item_claymore_datadriven_three",
        "item_claymore_datadriven_two",
        "item_chainmail_datadriven_one",
        "item_broadsword_datadriven_one",
        "item_claymore_datadriven_nine",
        "item_claymore_datadriven_ten",
        "item_claymore_datadriven_ten_d_grade",
        "item_claymore_datadriven_ten_c_grade",
        "item_claymore_datadriven_ten_b_grade",
        "item_claymore_datadriven_ten_a_grade",
        "item_claymore_datadriven_ten_s_grade",
        "item_claymore_datadriven_ten_ss_grade",
        "item_claymore_datadriven_ten_sss_grade",
        "item_claymore_datadriven_ten_sss_grade_heroic",

    }
    
    if event.caster:GetItemsCount(items) ~= 0 then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
    end
end

function artifact (event)
    local items =
    {
        "item_ultimate_orb_datadriven",
        "item_ultimate_orb_datadriven_one",
        "item_ultimate_orb_datadriven_two",
        "item_ultimate_orb_datadriven_three",
        "item_ultimate_orb_datadriven_four",
        "item_ultimate_orb_datadriven_five",
        "item_ultimate_orb_datadriven_six",
        "item_ultimate_orb_datadriven_seven",
        "item_ultimate_orb_datadriven_eith",
        "item_final_artifact_datadriven",
        "item_ultimate_orb_datadriven_nine",
        "item_final_artifact_sharpened_datadriven",
        "item_final_artifact_sharpened_datadriven_d_grade",
        "item_final_artifact_sharpened_datadriven_c_grade",
        "item_final_artifact_sharpened_datadriven_b_grade",
        "item_final_artifact_sharpened_datadriven_a_grade",
        "item_final_artifact_sharpened_datadriven_s_grade",
        "item_final_artifact_sharpened_datadriven_ss_grade",
        "item_final_artifact_sharpened_datadriven_sss_grade",
        "item_final_artifact_sharpened_datadriven_sss_grade_heroic",
    }
    
    if event.caster:GetItemsCount(items) ~= 0 then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
    end
end

function gloves (event)
	if event.caster:GetItemsCount("item_gloves_datadriven_four") ~= 0 then
		Timers:CreateTimer(0.01,function()
			event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
		end)
		CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
	end
end

function desolator (event)
    local items =
    {
        "item_desolator_datadriven",
        "item_desolator_datadriven_one",
        "item_desolator_and_battelfury",
        "item_desolator_and_battelfury_s_grade",
        "item_desolator_and_battelfury_ss_grade",
        "item_desolator_and_battelfury_sss_grade",
        "item_desolator_and_battelfury_sss_grade_heroic",
    }
    
    if event.caster:GetItemsCount(items) ~= 0 then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
    end
end

function fly (event)
    local items =
    {
        "item_butterfly_datadriven",
        "item_butterfly_datadriven_one",
        "item_desolator_and_battelfury",
        "item_desolator_and_battelfury_s_grade",
        "item_desolator_and_battelfury_ss_grade",
        "item_desolator_and_battelfury_sss_grade",
        "item_desolator_and_battelfury_sss_grade_heroic",
    }
    
    if event.caster:GetItemsCount(items) ~= 0 then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
    end
end

function rose (event)
	local items =
    {
        "item_basher_datadriven",
        "item_basher_datadriven_s_grade",
        "item_basher_datadriven_ss_grade",
        "item_basher_datadriven_sss_grade",
        "item_basher_datadriven_sss_grade_heroic",
    }
    
    if event.caster:GetItemsCount(items) ~= 0 then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
    end
end

function vladmir (event)
    local items =
    {
        "item_vladmir_datadriven",
        "item_vladmir_s_datadriven_final",
        "item_vladmir_ss_datadriven_final",
        "item_vladmir_sss_datadriven_final",
        "item_vladmir_sss_datadriven_final_heroic",
    }
    
    if event.caster:GetItemsCount(items) ~= 0 then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
    end
end

function mutecheck (event)
    if event.ability:IsMuted() then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end) 
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "YOU CAN'T TAKE ALLY ITEMS"})
    end
end

function levelcheck (event)
    if event.caster:GetLevel() < 50 then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "YOU NEED 50 LVL"})
    end
end

function SecondJobAbility (event)
    local items =
    {
        "item_spceial_spell_sven",
        "item_spceial_spell_drow",
        "item_spceial_spell_skymage",
        "item_spceial_spell_sven_s_grade",
        "item_spceial_spell_drow_s_grade",
        "item_spceial_spell_skymage_s_grade",
        "item_spceial_spell_sven_ss_grade",
        "item_spceial_spell_drow_ss_grade",
        "item_spceial_spell_skymage_ss_grade",
        "item_spceial_spell_sven_sss_grade",
        "item_spceial_spell_drow_sss_grade",
        "item_spceial_spell_skymage_sss_grade",
        "item_spceial_spell_sven_sss_grade_heroic",
        "item_spceial_spell_drow_sss_grade_heroic",
        "item_spceial_spell_skymage_sss_grade_heroic",
    }
    
    if event.caster:GetItemsCount(items) ~= 0 then
        Timers:CreateTimer(0.10,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "DOUBLE ITEM"})
    end
end

function SecondJobAbilityCheckSven (event)
    if event.caster:GetUnitName() ~= "npc_dota_hero_sven" and event.caster:GetUnitName() ~= "npc_dota_lone_druid_bear_creep_1"
    and event.caster:GetUnitName() ~= "npc_dota_hero_abaddon" and event.caster:GetUnitName() ~= "npc_dota_hero_nevermore" and event.caster:GetUnitName() ~= "npc_dota_hero_zuus" 
    and event.caster:GetUnitName() ~= "npc_dota_hero_rubick" and event.caster:GetUnitName() ~= "npc_dota_hero_custom_antimage" and event.caster:GetUnitName() ~= "npc_dota_hero_lone_druid" 
    and event.caster:GetUnitName() ~= "npc_dota_lone_druid_bear_special" and event.caster:GetUnitName() ~= "npc_dota_hero_void_spirit" and event.caster:GetUnitName() ~= "npc_dota_hero_wisp" then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "WRONG HERO"})
    end
end

function SecondJobAbilityCheckDrow (event)
    if event.caster:GetUnitName() ~= "npc_dota_hero_drow_ranger" and event.caster:GetUnitName() ~= "npc_dota_lone_druid_bear_creep_1"
    and event.caster:GetUnitName() ~= "npc_dota_hero_abaddon" and event.caster:GetUnitName() ~= "npc_dota_hero_nevermore" and event.caster:GetUnitName() ~= "npc_dota_hero_zuus" 
    and event.caster:GetUnitName() ~= "npc_dota_hero_rubick" and event.caster:GetUnitName() ~= "npc_dota_hero_custom_antimage" and event.caster:GetUnitName() ~= "npc_dota_hero_lone_druid" 
    and event.caster:GetUnitName() ~= "npc_dota_lone_druid_bear_special" and event.caster:GetUnitName() ~= "npc_dota_hero_void_spirit" and event.caster:GetUnitName() ~= "npc_dota_hero_wisp" then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "WRONG HERO"})
    end
end

function SecondJobAbilityCheckSky (event)
    if event.caster:GetUnitName() ~= "npc_dota_hero_skywrath_mage" and event.caster:GetUnitName() ~= "npc_dota_lone_druid_bear_creep_1"
    and event.caster:GetUnitName() ~= "npc_dota_hero_abaddon" and event.caster:GetUnitName() ~= "npc_dota_hero_nevermore" and event.caster:GetUnitName() ~= "npc_dota_hero_zuus" 
    and event.caster:GetUnitName() ~= "npc_dota_hero_rubick" and event.caster:GetUnitName() ~= "npc_dota_hero_custom_antimage" and event.caster:GetUnitName() ~= "npc_dota_hero_lone_druid" 
    and event.caster:GetUnitName() ~= "npc_dota_lone_druid_bear_special" and event.caster:GetUnitName() ~= "npc_dota_hero_void_spirit" and event.caster:GetUnitName() ~= "npc_dota_hero_wisp" then
        Timers:CreateTimer(0.01,function()
            event.caster:DropItemAtPositionImmediate(event.ability, event.caster:GetAbsOrigin())
        end)
        CustomGameEventManager:Send_ServerToPlayer(event.caster:GetPlayerOwner(), "create_error_message", {message = "WRONG HERO"})
    end
end