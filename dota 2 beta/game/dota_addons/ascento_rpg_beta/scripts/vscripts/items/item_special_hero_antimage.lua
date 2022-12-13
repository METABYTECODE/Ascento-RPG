function ChangeHero ( keys )
	local caster = keys.caster
	local item_to_remove = caster:FindItemInInventory("item_hero_change_to_antimage")

	caster:RemoveItem(item_to_remove)

	for i = 0, 8 do 
        local pos = caster:GetOrigin() + RandomVector(150)
        local CurrentItem = caster:GetItemInSlot(i) 
        caster:DropItemAtPositionImmediate(CurrentItem, pos)
    end 

    local PetModifierNames = 
    {
        "modifier_hallowen_legendary_pet",
        "modifier_new_year_legendary_pet",
        "modifier_new_year_ancient_buff"
    }

    local PetModifiersForNewHero = {}

    local SpecialEventAbilities = {}

    for _, pet_name in pairs(PetModifierNames) do 
        if caster:FindModifierByName(pet_name) ~= nil then 
            table.insert(PetModifiersForNewHero, pet_name)
        end
    end

    if caster:FindAbilityByName("new_year_mount_datadriven") ~= nil then 
        table.insert(SpecialEventAbilities, "new_year_mount_datadriven")
    end

	if caster:GetUnitName() ~= "npc_dota_hero_custom_antimage" then
        new_hero = PlayerResource:ReplaceHeroWith(caster:GetPlayerOwnerID(), "npc_dota_hero_custom_antimage", PlayerResource:GetGold(caster:GetPlayerOwnerID()), 0)
    end

    if PetModifiersForNewHero ~= nil then    
        for _, pet_name in pairs(PetModifiersForNewHero) do 
            if pet_name == "modifier_hallowen_legendary_pet" then 
                local ability = new_hero:AddAbility("pet_helloween_buff")
                ability:ApplyDataDrivenModifier(new_hero, new_hero, "modifier_hallowen_legendary_pet", {})
                ability:Destroy()
                local unit = CreateUnitByName( "npc_dota_pet_halloween_drop", new_hero:GetAbsOrigin(), true, new_hero, new_hero, new_hero:GetTeamNumber())
                unit:SetOwner(new_hero)
                ParticleManager:CreateParticle( "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
            end
            if pet_name == "modifier_new_year_legendary_pet" then 
                local ability = new_hero:AddAbility("pet_new_year_legendary_buff")
                ability:ApplyDataDrivenModifier(new_hero, new_hero, "modifier_new_year_legendary_pet", {})
                ability:Destroy()
                local unit = CreateUnitByName( "npc_dota_pet_new_year_legendary", new_hero:GetAbsOrigin(), true, new_hero, new_hero, new_hero:GetTeamNumber())
                unit:SetOwner(new_hero)
                ParticleManager:CreateParticle( "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
            end
            if pet_name == "modifier_new_year_ancient_buff" then 
                local ability = new_hero:AddAbility("pet_new_year_ancient_buff")
                ability:ApplyDataDrivenModifier(new_hero, new_hero, "modifier_new_year_ancient_buff", {})
                ability:Destroy()
                if new_hero:FindAbilityByName("elder_titan_natural_order") == nil then
                    new_hero:AddAbility("elder_titan_natural_order"):UpgradeAbility(true)
                end
                local unit = CreateUnitByName( "npc_dota_pet_new_year_ancient", new_hero:GetAbsOrigin(), true, new_hero, new_hero, new_hero:GetTeamNumber())
                unit:SetOwner(new_hero)
                ParticleManager:CreateParticle( "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_electric.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
            end
        end
    end

    if SpecialEventAbilities ~= nil then
        for _, ability_name in pairs(SpecialEventAbilities) do 
            new_hero:AddAbility(ability_name)
        end
    end
 
    new_hero:AddExperience(30000000, false, false)
    ParticleManager:CreateParticle("particles/econ/items/necrolyte/necro_ti9_immortal/necro_ti9_immortal_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, new_hero)

    new_hero:AddAbility("ursa_fury_swipes_datadriven")
    new_hero:SwapAbilities("ursa_fury_swipes_datadriven", "phantom_assassin_phantom_strike_datadriven", true, true)
    new_hero:AddAbility("rubick_bonus_damage")
    new_hero:SwapAbilities("rubick_bonus_damage", "queenofpain_blink", true, true)
    new_hero:AddAbility("special_pure_damage_spell_datadriven")
    new_hero:FindAbilityByName("special_pure_damage_spell_datadriven"):UpgradeAbility(true)
    new_hero:SwapAbilities("special_pure_damage_spell_datadriven", "hero_great_cleave_datadriven_one", true, true)
    new_hero:SwapAbilities("phantom_assassin_phantom_strike_datadriven", "chaos_strike_datadriven_one", true, true)
    new_hero:SwapAbilities("queenofpain_blink", "lone_druid_spirit_bear_datadriven", true, true)
    new_hero:AddAbility("rubick_ulti_datadriven")
    new_hero:SwapAbilities("rubick_ulti_datadriven", "special_bonus_attack_speed_100", true, true) 

end