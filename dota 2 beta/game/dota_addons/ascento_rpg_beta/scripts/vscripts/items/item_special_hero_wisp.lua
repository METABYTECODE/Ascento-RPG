function ChangeHero ( keys )
	local caster = keys.caster
	local item_to_remove = caster:FindItemInInventory("item_hero_change_to_wisp")

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

	if caster:GetUnitName() ~= "npc_dota_hero_wisp" then
        new_hero = PlayerResource:ReplaceHeroWith(caster:GetPlayerOwnerID(), "npc_dota_hero_wisp", PlayerResource:GetGold(caster:GetPlayerOwnerID()), 0)
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
    ParticleManager:CreateParticle("particles/units/heroes/hero_void_spirit/void_spirit_ethereal_form.vpcf", PATTACH_ABSORIGIN_FOLLOW, new_hero)

end