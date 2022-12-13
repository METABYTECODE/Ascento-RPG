function IsBossASCENTO(unit)
  if not unit or unit:IsNull() then return false end

  local unitNames = {
    "npc_dota_neutral_kobold_tunneler",
    "npc_dota_neutral_satyr_hellcaller",
    "npc_dota_neutral_ogre_magi",
    "npc_dota_creep_goodguys_melee_upgraded_mega",
    "npc_dota_neutral_granite_golem",
    "npc_dota_necronomicon_archer_2",
    "npc_dota_neutral_kobold_taskmaster",
    "npc_dota_neutral_polar_furbolg_ursa_warrior",
    "npc_dota_broodmother_spiderite",
    "npc_dota_furion_treant_large",
    "npc_dota_warlock_golem_2",
    "npc_dota_neutral_mud_golem_split",
    "npc_dota_neutral_mud_golem",
    "npc_dota_neutral_mud_golem_split_doom",
    "npc_dota_neutral_centaur_khan",
    "npc_dota_brewmaster_storm_1",
    "npc_dota_brewmaster_fire_1",
    "npc_dota_unit_undying_zombie_torso",
    "npc_dota_lone_druid_bear1",
    "npc_dota_goodguys_tower4",
    "npc_dota_courier",
    "npc_dota_creep_goodguys_ranged_upgraded_mega",
    "npc_boss_volk1",
    "npc_boss_volk2",
    "npc_dota_neutral_big_thunder_lizard",
    "npc_dota_creature_last_boss" ,
    "npc_dota_creature_tiny_boss",
    "npc_dota_creature_tide_boss",
    "npc_dota_creature_timbersaw_boss",
    "npc_dota_creature_tinker_boss",
    "npc_dota_creature_arc_warden_boss",
    "npc_dota_creature_tusk_boss",
    "npc_dota_creature_wywern_boss",
    "npc_dota_creature_cm_boss",
    "npc_dota_creature_qop_boss",
    "npc_dota_creature_templar_boss",
    "npc_dota_creature_luna_boss",
    "npc_dota_creature_lina_boss",
    "npc_dota_creature_meepo_boss",
    "npc_dota_creature_weekly_boss_halloween",
    "npc_dota_creature_weekly_boss_odin",
    "npc_dota_creature_weekly_boss_dva",
    "npc_dota_creature_weekly_boss_tri",
    "npc_dota_creature_weekly_boss_new_year",
    "npc_dota_creature_final_tron"
  }

  for _,theUnit in ipairs(unitNames) do
    if unit:GetUnitName() == theUnit then return true end
  end

  return false
end