

function Precache( context )
    PrecacheEveryThingFromKV(context)
    PrecacheUnitByNameSync("npc_dota_hero_dragon_knight", context)
    PrecacheUnitByNameSync("npc_dota_hero_legion_commander", context)
    PrecacheUnitByNameSync("npc_dota_hero_phantom_assassin", context)
    PrecacheUnitByNameSync("npc_dota_hero_drow_ranger", context)
    PrecacheUnitByNameSync("npc_dota_hero_oracle", context)
    PrecacheUnitByNameSync("npc_dota_hero_invoker", context)
    PrecacheUnitByNameSync("npc_dota_hero_void_spirit", context)
    PrecacheUnitByNameSync("npc_dota_hero_dazzle", context)
    PrecacheUnitByNameSync("npc_dota_hero_nevermore", context)
    PrecacheUnitByNameSync("npc_dota_hero_juggernaut", context)


    --PrecacheResource( "particle",  "", context)
    PrecacheResource( "particle",  "particles/units/heroes/hero_terrorblade/terrorblade_weapon_blur.vpcf", context)
    PrecacheResource( "particle",  "particles/units/heroes/hero_terrorblade/terrorblade_weapon_blur_reverse.vpcf", context)
    PrecacheResource( "particle",  "particles/units/heroes/hero_terrorblade/terrorblade_weapon_blur_both.vpcf", context)
    PrecacheResource( "particle",  "particles/units/heroes/hero_undying/undying_tnt_wlk_golem.vpcf", context)
    PrecacheResource( "particle",  "particles/units/heroes/hero_shadow_demon/sd_w.vpcf", context)

    --PrecacheResource( "model",  "", context)
    PrecacheResource( "model",  "models/heroes/doom/doom.vmdl", context)
    PrecacheResource( "model",  "models/creeps/item_creeps/i_creep_necro_warrior/necro_warrior.vmdl", context)
    PrecacheResource( "model",  "models/heroes/furion/treant.vmdl", context)
    PrecacheResource( "model",  "models/heroes/broodmother/spiderling.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl", context)
    PrecacheResource( "model",  "models/creeps/roshan/roshan.vmdl", context)
    PrecacheResource( "model",  "models/creeps/roshan_halloween/roshan_halloween.vmdl", context)
    PrecacheResource( "model",  "models/creeps/baby_rosh_halloween/baby_rosh_dire/baby_rosh_dire.vmdl", context)
    PrecacheResource( "model",  "models/heroes/warlock/warlock_demon.vmdl", context)
    PrecacheResource( "model",  "models/heroes/brewmaster/brewmaster_earthspirit.vmdl", context)
    PrecacheResource( "model",  "models/heroes/brewmaster/brewmaster_firespirit.vmdl", context)
    PrecacheResource( "model",  "models/heroes/undying/undying_minion.vmdl", context)
    PrecacheResource( "model",  "models/heroes/undying/undying_minion_torso.vmdl", context)
    PrecacheResource( "model",  "models/heroes/lycan/summon_wolves.vmdl", context)
    PrecacheResource( "model",  "models/heroes/lone_druid/spirit_bear.vmdl", context)
    PrecacheResource( "model",  "models/creeps/baby_rosh_halloween/baby_rosh_radiant/baby_rosh_radiant.vmdl", context)
    PrecacheResource( "model",  "models/items/furion/treant_stump.vmdl", context)
    PrecacheResource( "model",  "models/courier/greevil/greevil.vmdl", context)
    PrecacheResource( "model",  "models/creeps/nian/nian_creep.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_bad_ranged/lane_dire_ranged.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_bad_ranged/lane_dire_ranged_mega.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_thunder_lizard/n_creep_thunder_lizard_big.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_thunder_lizard/n_creep_thunder_lizard_small.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_gnoll/n_creep_gnoll.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_ghost_a/n_creep_ghost_a.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_troll_dark_a/n_creep_troll_dark_a.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_troll_dark_b/n_creep_troll_dark_b.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_satyr_b/n_creep_satyr_b.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_forest_trolls/n_creep_forest_troll_high_priest.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_harpy_a/n_creep_harpy_a.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_harpy_b/n_creep_harpy_b.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_black_drake/n_creep_black_drake.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_black_dragon/n_creep_black_dragon.vmdl", context)
    PrecacheResource( "model",  "models/creeps/item_creeps/i_creep_necro_archer/necro_archer.vmdl", context)
    PrecacheResource( "model",  "models/heroes/venomancer/venomancer_ward.vmdl", context)
    PrecacheResource( "model",  "models/heroes/enigma/eidelon.vmdl", context)
    PrecacheResource( "model",  "models/heroes/invoker/forge_spirit.vmdl", context)
    PrecacheResource( "model",  "models/heroes/clinkz/clinkz_archer.vmdl", context)
    PrecacheResource( "model",  "models/heroes/beastmaster/beastmaster_beast.vmdl", context)
    PrecacheResource( "model",  "models/heroes/brewmaster/brewmaster_windspirit.vmdl", context)
    PrecacheResource( "model",  "models/heroes/visage/visage_familiar.vmdl", context)
    PrecacheResource( "model",  "models/heroes/death_prophet/death_prophet_ghost.vmdl", context)
    PrecacheResource( "model",  "models/heroes/dark_willow/dark_willow_wisp.vmdl", context)
    PrecacheResource( "model",  "models/courier/baby_rosh/babyroshan_ti9_flying.vmdl", context)
    PrecacheResource( "model",  "models/heroes/elder_titan/ancestral_spirit.vmdl", context)
    PrecacheResource( "model",  "models/heroes/shadowshaman/shadowshaman_totem.vmdl", context)
    PrecacheResource( "model",  "maps/journey_assets/characters/journey_crane/crane.vmdl", context)
    PrecacheResource( "model",  "models/courier/beetlejaws/mesh/beetlejaws.vmdl", context)
    PrecacheResource( "model",  "models/courier/card_courier/imp/card_courier_imp_prop.vmdl", context)
    PrecacheResource( "model",  "models/courier/card_courier/imp/card_courier_imp_prop_red.vmdl", context)
    PrecacheResource( "model",  "models/courier/courier_mech/courier_mech.vmdl", context)
    PrecacheResource( "model",  "models/courier/flopjaw/flopjaw.vmdl", context)
    PrecacheResource( "model",  "models/courier/seekling/seekling.vmdl", context)
    PrecacheResource( "model",  "models/courier/smeevil_crab/smeevil_crab.vmdl", context)
    PrecacheResource( "model",  "models/creeps/ice_biome/frostbitten/n_creep_frostbitten_01.vmdl", context)
    PrecacheResource( "model",  "models/creeps/ice_biome/frostbitten/n_creep_frostbitten_shaman01.vmdl", context)
    PrecacheResource( "model",  "models/creeps/ice_biome/frostbitten/n_creep_frostbitten_swollen01.vmdl", context)
    PrecacheResource( "model",  "models/creeps/ice_biome/giant/ice_giant01.vmdl", context)
    PrecacheResource( "model",  "models/creeps/ice_biome/undeadtusk/undead_tuskskeleton01.vmdl", context)
    PrecacheResource( "model",  "models/creeps/ice_biome/undeadtusk/undead_tuskskeleton02.vmdl", context)
    PrecacheResource( "model",  "models/creeps/ice_biome/undeadtusk/undead_tuskskeleton_armor01.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_2021_dire/creep_2021_dire_ranged.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_2021_dire/creep_2021_dire_melee_flagbearer_mega.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_2021_dire/creep_2021_dire_siege.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_2021_radiant/creep_2021_radiant_melee_mega.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_2021_radiant/creep_2021_radiant_flagbearer_melee.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_2021_radiant/creep_2021_radiant_ranged_mega.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_2021_radiant/creep_2021_radiant_siege.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee_flagbearer_crystal.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee_mega_crystal.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_bad_melee_diretide/creep_bad_melee_diretide.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_bad_ranged/creep_bad_ranged_crystal.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_bad_ranged/creep_bad_ranged_mega_crystal.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_dire_hulk/creep_dire_ancient_hulk.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_dire_hulk/creep_dire_winter_ancient_hulk.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_radiant_hulk/creep_radiant_diretide_ancient_hulk.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_radiant_hulk/creep_radiant_winter_ancient_hulk.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_radiant_melee/crystal_radiant_flagbearer.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_radiant_ranged/crystal_radiant_ranged.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_radiant_ranged/radiant_ranged_crystal.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/creep_radiant_ranged/radiant_ranged_mega_crystal.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/ti9_crocodilian_dire/ti9_crocodilian_dire_flagbearer_melee.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/ti9_crocodilian_dire/ti9_crocodilian_dire_ranged.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/ti9_chameleon_radiant/ti9_chameleon_radiant_flagbearer_melee.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/ti9_chameleon_radiant/ti9_chameleon_radiant_flagbearer_melee_mega.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/ti9_chameleon_radiant/ti9_chameleon_radiant_ranged.vmdl", context)
    PrecacheResource( "model",  "models/creeps/lane_creeps/ti9_chameleon_radiant/ti9_chameleon_radiant_ranged_mega.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_centaur_lrg/neutral_stash_centaur.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_dragonspawn_a/n_creep_dragonspawn_a.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_eimermole/n_creep_eimermole_lamp.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_eimermole/n_creep_eimermole.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_forest_trolls/n_creep_forest_troll_berserker.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_forest_trolls/neutral_stash_troll.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_ghost_b/n_creep_ghost_red.vmdl", context)
    PrecacheResource( "model",  "models/creeps/neutral_creeps/n_creep_ghost_b/n_creep_ghost_frost.vmdl", context)
    PrecacheResource( "model",  "models/creeps/roshan_aghanim/roshan_aghanim.vmdl", context)
    PrecacheResource( "model",  "models/creeps/pine_cone/pine_cone.vmdl", context)
    PrecacheResource( "model",  "models/events/frostivus/penguin/penguin.vmdl", context)
    PrecacheResource( "model",  "models/gameplay/orb_passage.vmdl", context)
    PrecacheResource( "model",  "models/heroes/antimage_female/antimage_female.vmdl", context)
    PrecacheResource( "model",  "models/heroes/beastmaster/beastmaster.vmdl", context)
    PrecacheResource( "model",  "models/heroes/dark_seer/darkseer_sfm.vmdl", context)
    PrecacheResource( "model",  "models/heroes/doom/doom.vmdl", context)
    PrecacheResource( "model",  "models/heroes/dragon_knight_persona/debut/dk_persona_debut_dragon.vmdl", context)
    PrecacheResource( "model",  "models/heroes/earthshaker/earthshaker.vmdl", context)
    PrecacheResource( "model",  "models/heroes/elder_titan/elder_titan.vmdl", context)
    PrecacheResource( "model",  "models/heroes/ember_spirit/ember_spirit_sfm.vmdl", context)
    PrecacheResource( "model",  "models/heroes/hoodwink/hoodwink.vmdl", context)
    PrecacheResource( "model",  "models/heroes/huskar/huskar.vmdl", context)
    PrecacheResource( "model",  "models/heroes/invoker_kid/invoker_kid.vmdl", context)
    PrecacheResource( "model",  "models/heroes/jakiro/jakiro.vmdl", context)
    PrecacheResource( "model",  "models/heroes/life_stealer/life_stealer.vmdl", context)
    PrecacheResource( "model",  "models/heroes/lone_druid/true_form.vmdl", context)
    PrecacheResource( "model",  "models/heroes/magnataur/magnataur.vmdl", context)
    PrecacheResource( "model",  "models/heroes/marci/marci_base.vmdl", context)
    PrecacheResource( "model",  "models/heroes/mars/mars.vmdl", context)
    PrecacheResource( "model",  "models/heroes/meepo/meepo.vmdl", context)
    PrecacheResource( "model",  "models/heroes/nightstalker/nightstalker.vmdl", context)
    PrecacheResource( "model",  "models/heroes/nightstalker/nightstalker_night.vmdl", context)
    PrecacheResource( "model",  "models/heroes/pangolier/pangolier_round.vmdl", context)
    PrecacheResource( "model",  "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl", context)
    PrecacheResource( "model",  "models/heroes/puck/puck.vmdl", context)
    PrecacheResource( "model",  "models/heroes/pudge_cute/pudge_cute.vmdl", context)
    PrecacheResource( "model",  "models/heroes/shadow_demon/shadow_demon.vmdl", context)
    PrecacheResource( "model",  "models/heroes/snapfire/snapfire_customgame.vmdl", context)
    PrecacheResource( "model",  "models/heroes/storm_spirit/storm_spirit.vmdl", context)
    PrecacheResource( "model",  "models/heroes/terrorblade/demon.vmdl", context)
    PrecacheResource( "model",  "models/heroes/terrorblade/terrorblade_arcana.vmdl", context)
    PrecacheResource( "model",  "models/heroes/tidehunter/tidehunter.vmdl", context)
    PrecacheResource( "model",  "models/heroes/tiny/tiny_04/tiny_04.vmdl", context)
    PrecacheResource( "model",  "models/heroes/undying/undying_flesh_golem.vmdl", context)
    PrecacheResource( "model",  "models/heroes/ursa/ursa.vmdl", context)
    PrecacheResource( "model",  "models/heroes/wraith_king/wraith_frost.vmdl", context)
    PrecacheResource( "model",  "models/heroes/zeus/zeus_arcana.vmdl", context)
    PrecacheResource( "model",  "models/items/bane/slumbering_terror/slumbering_terror_nightmare_model.vmdl", context)
    PrecacheResource( "model",  "models/items/axe/ti9_jungle_axe/axe_bare.vmdl", context)
    PrecacheResource( "model",  "models/items/batrider/manta_rayder_ti7_mount/manta_rayder_ti7_mount.vmdl", context)
    PrecacheResource( "model",  "models/items/beastmaster/bm_2021_immortal/bm_2021_bird.vmdl", context)
    PrecacheResource( "model",  "models/items/beastmaster/boar/beast_deming/beast_deming.vmdl", context)
    PrecacheResource( "model",  "models/items/beastmaster/boar/shrieking_razorback/shrieking_razorback.vmdl", context)
    PrecacheResource( "model",  "models/items/beastmaster/boar/ti9_cache_beast_master_dinosaurs_telepathy_beast/ti9_cache_beast_master_dinosaurs_telepathy_beast.vmdl", context)
    PrecacheResource( "model",  "models/items/beastmaster/boar/ti9_cache_beastmaster_king_of_beasts_boar/ti9_cache_beastmaster_king_of_beasts_boar.vmdl", context)
    PrecacheResource( "model",  "models/items/beastmaster/boar/ti9_cache_bm_chieftain_of_the_primal_tribes_beast/ti9_cache_bm_chieftain_of_the_primal_tribes_beast.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/dplus_malevolent_mother_malevoling/dplus_malevolent_mother_malevoling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/elder_blood_heir_of_elder_blood/elder_blood_heir_of_elder_blood.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/firemother_firemother_spiderling_ti8_3_styles/firemother_firemother_spiderling_ti8_3_styles.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/lycosidae_spiderling/lycosidae_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/aranea_cucurbita_spiderling/aranea_cucurbita_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/araknarok_broodmother_araknarok_spiderling/araknarok_broodmother_araknarok_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/amber_queen_spiderling_2/amber_queen_spiderling_2.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/broodmother_nightmare_spiderling/broodmother_nightmare_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/perceptive_spiderling/perceptive_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/pale_cyclopean_spiderling/pale_cyclopean_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/spiderling_dlotus_red/spiderling_dlotus_red.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/strangling_gloom_spiderling/strangling_gloom_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/the_glacial_creeper_creepling/the_glacial_creeper_creepling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/the_glacial_creeper_creepling/the_glacial_creeper_creepling_dpc.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/thistle_crawler/thistle_crawler.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/ti8_brood_the_great_arachne_spiderling/ti8_brood_the_great_arachne_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/ti9_cache_brood_carnivorous_mimicry_spiderling/ti9_cache_brood_carnivorous_mimicry_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/ti9_cache_brood_mother_of_thousands_spiderling/ti9_cache_brood_mother_of_thousands_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/venomous_caressin_spiderling/venomous_caressin_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/virulent_matriarchs_spiderling/virulent_matriarchs_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/broodmother/spiderling/witchs_grasp_spiderling/witchs_grasp_spiderling.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/amaterasu/amaterasu.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/amphibian_kid/amphibian_kid.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/alphid_of_lecaciida/alphid_of_lecaciida.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/arneyb_rabbit/arneyb_rabbit.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/atrophic_skitterwing/atrophic_skitterwing.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/azuremircourierfinal/azuremircourierfinal.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/baekho/baekho.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/bearzky/bearzky.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/beaverknight_s2/beaverknight_s2.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/deathbringer/deathbringer.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/deathripper/deathripper.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/devourling/devourling.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/faceless_rex/faceless_rex.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/faceless_rex/faceless_rex_flying.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/grim_wolf/grim_wolf_flying.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/grim_wolf_radiant/grim_wolf_radiant.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/hand_courier/hand_courier_dire_lv2.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/jin_yin_white_fox/jin_yin_white_fox.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/kupu_courier/kupu_courier.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/krobeling_gold/krobeling_gold.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/krobeling/krobeling.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/little_fraid_the_courier_of_simons_retribution/little_fraid_the_courier_of_simons_retribution.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/mango_the_courier/mango_the_courier.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/mlg_courier_wraith/mlg_courier_wraith.vmdl", context)
    PrecacheResource( "model",  "models/items/courier/supernova_rave_courier/supernova_rave_courier.vmdl", context)
end

function PrecacheEveryThingFromKV( context )
    local kv_files = {      "scripts/npc/npc_units_custom.txt",
                            "scripts/npc/npc_abilities_custom.txt",
                            "scripts/npc/abilities/donate_abilities.txt",
                            "scripts/npc/abilities/heroes_abilities.txt",
                            "scripts/npc/abilities/enemy_abilities.txt",
                            "scripts/npc/abilities/assasin.txt",
                            "scripts/npc/abilities/cultist.txt",
                            "scripts/npc/abilities/fighter.txt",
                            "scripts/npc/abilities/mage.txt",
                            "scripts/npc/abilities/magic_warrior.txt",
                            "scripts/npc/abilities/ranger.txt",
                            "scripts/npc/abilities/support.txt",
                            "scripts/npc/abilities/tank.txt",
                            "scripts/npc/npc_heroes_custom.txt",
                            "scripts/npc/npc_items_custom.txt"
                          }
    for _, kv in pairs(kv_files) do
        local kvs = LoadKeyValues(kv)
        if kvs then
            --print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
            PrecacheEverythingFromTable( context, kvs)
        end
    end
end

function PrecacheEverythingFromTable( context, kvtable)
    for key, value in pairs(kvtable) do
        if type(value) == "table" then
            PrecacheEverythingFromTable( context, value )
        else
            if string.find(value, "vpcf") then
                PrecacheResource( "particle",  value, context)


                --print("PRECACHE PARTICLE RESOURCE", value)
                
            end
            if string.find(value, "vmdl") then  

                PrecacheResource( "model",  value, context)
                
                --print("PRECACHE MODEL RESOURCE", value)
                
            end
            if string.find(value, "vsndevts") then
                PrecacheResource( "soundfile",  value, context)
                --print("PRECACHE SOUND RESOURCE", value)
            end
        end
    end
end

require('util')

if GetMapName() == "ascento_rpg" then
    require('spawn')
    require('spawn_endless')
    require('libraries/autoload')
    require('gamemode')
end

if GetMapName() == "newyear" then
    require('spawn_ny')
    require('libraries/autoload')
    require('gamemode_ny')
    
end



function Activate()
    GameRules.GameMode = GameMode()
    GameRules.GameMode:InitGameMode()

    _G.lootDrop               = {}

    Timers:CreateTimer(15.0, function()
        ClearItems(true)
        return 15.0
    end)
end