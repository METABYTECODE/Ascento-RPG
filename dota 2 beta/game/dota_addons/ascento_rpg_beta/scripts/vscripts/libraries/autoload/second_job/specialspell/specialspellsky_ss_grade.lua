FirstJobHeroesList = 
{
    "npc_dota_hero_juggernaut",
    "npc_dota_hero_legion_commander",
    "npc_dota_hero_mars",
    "npc_dota_hero_monkey_king",
    "npc_dota_hero_phantom_assassin",
    "npc_dota_hero_phantom_lancer",
    "npc_dota_hero_dragon_knight",
    "npc_dota_hero_antimage",
    "npc_dota_hero_kunkka",
    "npc_dota_hero_terrorblade"

}

SecondJobHeroesList = 
{   
    "npc_dota_hero_sven", 
    "npc_dota_hero_drow_ranger", 
    "npc_dota_hero_skywrath_mage", 
    "npc_dota_hero_nevermore", 
    "npc_dota_hero_abaddon", 
    "npc_dota_hero_zuus", 
    "npc_dota_hero_rubick",
    "npc_dota_hero_custom_antimage",
    "npc_dota_hero_lone_druid",
    "npc_dota_lone_druid_bear_special",
    "npc_dota_hero_void_spirit",
    "npc_dota_hero_wisp",
    "npc_dota_hero_doom_bringer",
}

function SpecialSpellSky( keys )
    local caster = keys.caster


        if caster:GetUnitName() == "npc_dota_hero_skywrath_mage" then
            if  caster:FindAbilityByName("empty1_skymage_datadriven") ~= nil then
                caster:RemoveAbility("empty1_skymage_datadriven")
                caster:AddAbility("queenofpain_scream_of_pain_ss_grade_datadriven")
                caster:FindAbilityByName("queenofpain_scream_of_pain_ss_grade_datadriven"):UpgradeAbility(true)
            end
        end

end

function SpecialSpellSkyDestroy( keys )
    local caster = keys.caster

        if caster:GetUnitName() == "npc_dota_hero_skywrath_mage" then
            if  caster:FindAbilityByName("queenofpain_scream_of_pain_ss_grade_datadriven") ~= nil then
                caster:RemoveAbility("queenofpain_scream_of_pain_ss_grade_datadriven") 
                caster:AddAbility("empty1_skymage_datadriven")
            end
        end

end