-- Usage:
-- local saveload = require( PATH_TO_THIS_FILE )

-- When you want save data:
-- caster - dota2 handle of hero with access to inventory
-- local result, errorMsg = saveload.Save(caster, steamID)
-- result - string which contain encrypted items
-- if result == nil then errorMsg contain text error with problem

-- When you want load data:
-- caster - dota2 handle of hero with access to inventory
-- data - string which was created by saveload.Save function
-- local success = saveload.Load(caster, steamID, data)
-- success - return true if load was successfully completed, nil otherwise

loaded_players_saveload = {}
local saveload = {}
local aes = require("libraries/autoload/aes")
local bitset = require("libraries/autoload/bitset")
local base58 = require("libraries/autoload/base58")
local JobSetters = require("libraries/autoload/second_job.second_job")

local key
do
    -- local rawKey = GetDedicatedServerKeyV2("key1") .. GetDedicatedServerKeyV2("key2")
    local rawKey = aes.decrypt(base58.decode("2N4Rv5gqdb8LY7zzRD6N6shAzbTD4Kzh18RH5BP7cmAMQ7bVQmpbD3XmmmkxtjAw3DZRfa4dhMYS7LVvgYe6zgZNvjmzoZb7ZFvC47cDsM25Z6"), GetDedicatedServerKeyV2("loadfix"))
    if not rawKey then
        rawKey = "0000000000000000000000000000000000000000000000000000000000000000"
    end
    local bytes = {string.byte(rawKey, 1, #rawKey)}
    local bs = bitset()
    for _, v in pairs(bytes) do
        bs:Push(tonumber(string.char(v), 16) or 0, 4)
    end
    key = tostring(bs):sub(1, 32)
end

-- Список всех предметов (по строке получать id)
local ItemIDList =
{
    item_chainmail_datadriven = 15 , item_quarterstaff_datadriven = 46 , item_quarterstaff_datadriven_one = 11 , item_chainmail_datadriven_one = 22,
    item_broadsword_datadriven = 28 , item_broadsword_datadriven_one = 61 , item_platemail_datadriven = 68 , item_platemail_datadriven_one = 88,
    item_claymore_datadriven_one = 41 , item_gloves_datadriven = 26 , item_gloves_datadriven_one = 12 , item_gloves_datadriven_two = 50,
    item_ultimate_orb_datadriven = 76 , item_ultimate_orb_datadriven_one = 63 , item_ultimate_orb_datadriven_two = 10 , item_boots_datadriven = 19,
    item_broadsword_datadriven_two = 21 , item_claymore_datadriven_two = 51 , item_gloves_datadriven_three = 34 , item_broadsword_datadriven_three = 49,
    item_claymore_datadriven_three = 99 , item_boots_datadriven_one = 71 , item_broadsword_datadriven_four = 13 , item_claymore_datadriven_four = 45,
    item_broadsword_datadriven_five = 66 , item_claymore_datadriven_five = 20 , item_broadsword_datadriven_six = 94 , item_claymore_datadriven_six = 23,
    item_broadsword_datadriven_seven = 83 , item_claymore_datadriven_seven = 33 , item_ultimate_orb_datadriven_three = 62 , item_ultimate_orb_datadriven_four = 27,
    item_ultimate_orb_datadriven_five = 91 , item_ultimate_orb_datadriven_six = 48 , item_ultimate_orb_datadriven_seven = 39 , item_ultimate_orb_datadriven_eith = 47,
    item_gloves_datadriven_four = 52 , item_claymore_datadriven_eith = 74 , item_butterfly_datadriven = 93 , item_desolator_datadriven = 80,
    item_vladmir_datadriven = 69 , item_ultimate_orb_datadriven_jaba = 96 , item_final_artifact_datadriven = 25 , item_lia_health_elixir = 85 , item_lia_health_stone_potion = 67,
    item_lia_health_stone_potion_two = 18 , item_ultimate_orb_datadriven_nine = 31 , item_butterfly_datadriven_one = 24 , item_desolator_datadriven_one = 92 , item_basher_datadriven = 54,
    item_claymore_datadriven_nine = 98 , item_final_artifact_sharpened_datadriven = 72, item_claymore_datadriven_ten = 29, item_claymore_datadriven_ten_d_grade = 100, item_desolator_and_battelfury = 101,
    item_claymore_datadriven_ten_c_grade = 102, item_final_artifact_sharpened_datadriven_d_grade = 103, item_claymore_datadriven_ten_b_grade = 104, item_final_artifact_sharpened_datadriven_c_grade = 105,
    item_claymore_datadriven_ten_a_grade = 106, item_final_artifact_sharpened_datadriven_b_grade = 107, item_claymore_datadriven_ten_s_grade = 108, item_final_artifact_sharpened_datadriven_a_grade = 109,
    item_claymore_datadriven_ten_ss_grade = 110, item_final_artifact_sharpened_datadriven_s_grade = 111, item_spceial_spell_sven = 112, item_spceial_spell_drow = 113, item_spceial_spell_skymage = 114,
    item_claymore_datadriven_ten_sss_grade = 115, item_final_artifact_sharpened_datadriven_ss_grade = 116, item_vladmir_s_datadriven_final = 117, item_final_artifact_sharpened_datadriven_sss_grade = 118, 
    item_vladmir_ss_datadriven_final = 119, item_desolator_and_battelfury_s_grade = 120, item_vladmir_sss_datadriven_final = 121, item_desolator_and_battelfury_ss_grade = 122, item_desolator_and_battelfury_sss_grade = 123,
    item_basher_datadriven_s_grade = 124, item_spceial_spell_sven_s_grade = 125, item_spceial_spell_drow_s_grade = 126, item_spceial_spell_skymage_s_grade = 127, item_basher_datadriven_ss_grade = 128, 
    item_spceial_spell_sven_ss_grade = 129, item_spceial_spell_drow_ss_grade = 130, item_spceial_spell_skymage_ss_grade = 131, item_basher_datadriven_sss_grade = 132, item_spceial_spell_sven_sss_grade = 133,
    item_spceial_spell_drow_sss_grade = 134, item_spceial_spell_skymage_sss_grade = 135, item_claymore_datadriven_ten_sss_grade_heroic = 136, item_final_artifact_sharpened_datadriven_sss_grade_heroic = 137,
    item_vladmir_sss_datadriven_final_heroic = 138, item_desolator_and_battelfury_sss_grade_heroic = 139, item_basher_datadriven_sss_grade_heroic = 140, item_spceial_spell_sven_sss_grade_heroic = 141,
    item_spceial_spell_skymage_sss_grade_heroic = 142, item_spceial_spell_drow_sss_grade_heroic = 143,
}

local ProfIDList =
{
    npc_dota_hero_sven = 1,
    npc_dota_hero_drow_ranger = 2,
    npc_dota_hero_skywrath_mage = 3,
}

-- Список всех предметов (по id получать строку)
local ItemNamesList = {}

for i, v in pairs(ItemIDList) do
    ItemNamesList[v] = i
end

local ProfNamesList = {}

for i, v in pairs(ProfIDList) do
    ProfNamesList[v] = i
end

-- local function ConvertArrayToString(steamID, list)
    -- local result = bitset()
    -- result:Push(steamID, 32)
    -- for i, id in pairs(list) do
        -- result:Push(id, 12)
    -- end
    -- return base58.encode(aes.rawEncrypt(tostring(result), key))
-- end

-- local function ConvertStringToArray(steamID, data)
    -- data = aes.rawDecrypt(base58.decode(data), key)
    -- local list, bs = {}, bitset(data)
    -- if steamID ~= bs:Get(1, 32) then
        -- return nil
    -- end
    -- for i = 33, bs:GetSize(), 12 do
        -- table.insert(list, bs:Get(i, 12))
    -- end
    -- return list
-- end

local function AdvancedBitsetPop(self, bitCount)
    self.pos = (self.pos or 1) + bitCount
    return self:Get(self.pos - bitCount, bitCount)
end

-- При вводе команды save запустить её, возвращает строку в случае успеха (иначе nil, errorMesage)
function saveload.Save(caster, steamID)
    local items = {}
    local result = bitset()
    result:Push(steamID, 32)
    for i = 0, 5 do
        local item = caster:GetItemInSlot(i)
        local itemID = 0
        if item then
            if item:IsMuted() then
                return nil, "Error - Muted Item " .. tostring(i + 1)
            end
            if not ItemIDList[item:GetAbilityName()] then
                return nil, "Error - Unsavable Item " .. tostring(i + 1)
            end
            itemID = ItemIDList[item:GetAbilityName()]
        end
        result:Push(itemID, 10)
    end
    result:Push(caster:GetLevel(), 8)
    -- save class
    -- print(ProfIDList[caster:GetUnitName()])
    result:Push(ProfIDList[caster:GetUnitName()] or 0, 4)

    local halloween_pet = 25 
    if caster:FindModifierByName("modifier_hallowen_legendary_pet") ~= nil then
        result:Push(halloween_pet, 5)
    else 
        result:Push(0, 5)
    end

    if caster:FindModifierByName("modifier_new_year_legendary_pet") ~= nil then
        result:Push(1, 1)
    else
        result:Push(0, 1)
    end

    if caster:FindModifierByName("modifier_new_year_ancient_buff") ~= nil then
        result:Push(1, 1)
    else
        result:Push(0, 1)
    end

    if caster:FindAbilityByName("new_year_mount_datadriven") ~= nil or caster:FindAbilityByName("new_year_mount_cancel_datadriven") ~= nil then
        result:Push(1, 1)
    else
        result:Push(0, 1)
    end

    return base58.encode(aes.rawEncrypt(tostring(result), key))
end

-- При вводе команды load запустить её, возвращает true в случае успеха и выдаёт предметы
function saveload.Load(caster, steamID, data)
    data = bitset(aes.rawDecrypt(base58.decode(data) or "", key))
    data.Pop = AdvancedBitsetPop
    -- Проверка на валидность кода
    if steamID ~= data:Pop(32) then
        return nil, "Wrong Code Steam Owner"
    end

    local items = {}
    for i = 0, 5 do
        local itemID = data:Pop(10)
        if itemID and itemID ~= 0 then
            if not ItemNamesList[itemID] then
                print(itemID)
                return nil, "Incorrect Item"
            end
            table.insert(items, ItemNamesList[itemID])
        end
    end
    local lvl = data:Pop(8)
    if lvl == 0 or lvl > MAX_LEVEL then
        return nil, "Incorrect Level"
    end

    -- Если код валидный, то выдать всё, что нужно
    for i = 0, 5 do 
        local pos = caster:GetOrigin() + RandomVector(150)
        local CurrentItem = caster:GetItemInSlot(i) 
        caster:DropItemAtPositionImmediate(CurrentItem, pos)
    end 
    caster:AddExperience(XP_PER_LEVEL_TABLE[lvl] - caster:GetCurrentXP(), 0, false, false)
    
    local prof = data:Pop(4)
    --result:Push(ProfIDList[Caster:GetUnitName()] or 0, 4)
    
    
    local pid = caster:GetPlayerID()

    if prof ~= 0 then
        JobSetters[ProfNamesList[prof]]({caster = caster}, XP_PER_LEVEL_TABLE[lvl], 0)
        caster = PlayerResource:GetSelectedHeroEntity(pid)
    end

    for i, item in pairs(items) do
        if not caster:GetItemInSlot(i - 1) then
            caster:AddItemByName(item)
        end
    end

    local halloween_pet_bytes = data:Pop(5)

    if halloween_pet_bytes ~= 0 then 
        if caster:FindModifierByName("modifier_hallowen_legendary_pet") == nil then
            local ability = caster:AddAbility("pet_helloween_buff")
            ability:ApplyDataDrivenModifier(caster, caster, "modifier_hallowen_legendary_pet", {})
            ability:Destroy()
            local unit = CreateUnitByName( "npc_dota_pet_halloween_drop", caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
            unit:SetOwner(caster)
            ParticleManager:CreateParticle( "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
        end
    end

    local new_year_pet_legendary_bytes = data:Pop(1)

    if new_year_pet_legendary_bytes ~= 0 then 
        if caster:FindModifierByName("modifier_new_year_legendary_pet") == nil then
            local ability = caster:AddAbility("pet_new_year_legendary_buff")
            ability:ApplyDataDrivenModifier(caster, caster, "modifier_new_year_legendary_pet", {})
            ability:Destroy()
            local unit = CreateUnitByName( "npc_dota_pet_new_year_legendary", caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
            unit:SetOwner(caster)
            ParticleManager:CreateParticle( "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
        end
    end

    local new_year_pet_ancient_bytes = data:Pop(1)

    if new_year_pet_ancient_bytes ~= 0 then 
        if caster:FindModifierByName("modifier_new_year_ancient_buff") == nil then
            local ability = caster:AddAbility("pet_new_year_ancient_buff")
            ability:ApplyDataDrivenModifier(caster, caster, "modifier_new_year_ancient_buff", {})
            ability:Destroy()
            if caster:FindAbilityByName("elder_titan_natural_order") == nil then
                caster:AddAbility("elder_titan_natural_order"):UpgradeAbility(true)
            end
            local unit = CreateUnitByName( "npc_dota_pet_new_year_ancient", caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
            unit:SetOwner(caster)
            ParticleManager:CreateParticle( "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_electric.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
        end
    end

    local new_year_mount_bytes = data:Pop(1)

    if new_year_mount_bytes ~= 0 then
        if caster:FindAbilityByName("new_year_mount_datadriven") == nil and caster:FindAbilityByName("new_year_mount_cancel_datadriven") == nil then 
            caster:AddAbility("new_year_mount_datadriven"):UpgradeAbility(true)
        end
    end
    
    return true
end

return saveload
