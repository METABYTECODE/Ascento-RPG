--[[
//////////////////
Types of Wearables:
//////////////////
"bundle"    "21317"
"hero"  "npc_dota_hero_rubick"
"index" "12451"
"model" "models/items/rubick/rubick_arcana/rubick_arcana_back.vmdl"
"name"  "The Magus Cypher"
"slot"  "back"
"styles"    "26"
"type"  "wearable"/"bundle"/"default_item"
"visuals" {}

//////////////////
Types of Visuals:
//////////////////
.alternate_icons (for styles)
.alternate_icons_2 (1 occurence)
asset_modifier
.hide_on_portrait (tiny trees)
.hide_styles_from_ui (ability-based style)
only_display_on_hero_model_change (1 occurence)
skin (gold/crimson)
skip_model_combine
styles
    "0"
    {
        "alternate_icon"    "0"
        ."auto_style_rule"   "modifier_sven_gods_strength == 0"

        "name"  "#DOTA_Style_FV_The_hollow_Shoulder_0"
        "skin"  "0"
    }
    "1"
    {
        "alternate_icon"    "1"
        "name"  "#DOTA_Style_FV_The_hollow_Shoulder_1"
        "skin"  "1"
        "unlock"
        {
            "item_def"  "22522"
            "price" "1"
        }
    }

styles_2 (jugg, sven)


///////////////////
Types of Asset Modifiers:
////////////////////
Hero modifiers:
    activity
        "asset" "ALL"
        "modifier"  "spear"
        "style" "0"
        "type"  "activity"

    entity_model
        "asset" "npc_dota_lone_druid_bear"
        "modifier"  "models/items/lone_druid/bear/spirit_of_anger/spirit_of_anger.vmdl"
        "type"  "entity_model"

    entity_scale
        "apply_when_equipped_in_ability_effects_slot"   "4"
        "asset" "npc_dota_visage_familiar"
        "scale_size"    "0.7"
        "type"  "entity_scale"

    entity_healthbar_offset
        "asset" "npc_dota_unit_tombstone"
        "offset"    "335"
        "type"  "entity_healthbar_offset"

    hero_scale
        "LoadoutScale"  "0.9388"
        "ModelScale"    "1"
        "VersusScale"   "0.9184"
        "asset" "npc_dota_hero_pudge"
        "type"  "hero_scale"

    persona
        "persona"   "1"
        "type"  "persona"

Wearable modifiers:
    healthbar_offset
        "offset"    "140"
        "style" "0"
        "type"  "healthbar_offset"

    model_skin
        "skin"  "1"
        "style" "1"
        "type"  "model_skin"

    particle_control_point
        "asset" "particles/econ/items/sven/sven_endless_fury/sven_endless_fury_belt.vpcf"
        "control_point_number"  "2"
        "cp_position"   "1 0 0"
        "style" "1"
        "type"  "particle_control_point"

    particle_create
        "modifier"  "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_loadout_pedestal.vpcf"
        "spawn_in_loadout_only" "1"
        "style" "0"
        "type"  "particle_create"
        "attachments"
        {
            "attach_entity" "parent"
            "attach_type"   "customorigin"
            "control_points"
            {
                "0"
                {
                    "attach_type"   "point_follow"
                    "attachment"    "attach_attack1"
                    "control_point_index"   "0"
                }
            }
        }

    particle_combined
        "apply_when_equipped_in_ability_effects_slot"   "2"
        "asset" "particles/econ/items/faceless_void/faceless_void_arcana/faceless_void_arcana_time_dialate_v2.vpcf"
        "modifier"  "particles/econ/items/faceless_void/faceless_void_arcana/faceless_void_arcana_time_dialate_combined_v2_crimson.vpcf"
        "type"  "particle_combined"
        "style" "1"

    particle_snapshot
        "asset" "particles/particle_snapshots/bounty_hunter/bounty_hunter_weapon_r.vsnap"
        "modifier"  "particles/models/items/bounty_hunter/desperado_in_the_shade_weapon/desperado_in_the_shade_weapon_fx.vsnap"
        "type"  "particle_snapshot"


Replacements:
    ability_icon
        "apply_when_equipped_in_ability_effects_slot"   "3"
        "asset" "rattletrap_rocket_flare"
        "modifier"  "clockwerk/paraflare_cannon/clockwerk_rocket_flare"
        "type"  "ability_icon"
        "style" "0"

    icon_replacement_hero
        "asset" "npc_dota_hero_pudge"
        "force_display" "1"
        "modifier"  "npc_dota_hero_pudge_alt1"
        "style" "0"
        "type"  "icon_replacement_hero"

    icon_replacement_hero_minimap
        "asset" "npc_dota_hero_drow_ranger"
        "force_display" "1"
        "modifier"  "npc_dota_hero_drow_ranger_alt2"
        "style" "1"
        "type"  "icon_replacement_hero_minimap"

    inventory_icon
        "asset" "blade_mail"
        "modifier"  "blade_mail_spectre_arcana_alt2"
        "style" "1"
        "type"  "inventory_icon"

    model
        "asset" "models/items/huskar/frostivus2018_huskar_ice_age_hunter_arms/frostivus2018_huskar_ice_age_hunter_arms.vmdl"
        "modifier"  "models/items/huskar/frostivus2018_huskar_ice_age_hunter_arms/frostivus2018_huskar_ice_age_hunter_arms_2021_refit.vmdl"
        "type"  "model"

    particle
        "asset" "particles/units/heroes/hero_windrunner/windrunner_bowstring.vpcf"
        "modifier"  "particles/econ/items/windrunner/windrunner_battleranger/windrunner_battleranger_bowstring_ambient.vpcf"
        "style" "1"
        "type"  "particle"


Additions:
    additional_wearable
        "asset" "models/heroes/phoenix/phoenix_wings_fx.vmdl"
        "type"  "additional_wearable"

Abilities & Modifiers:
    buff_modifier
        "modifier"  "modifier_spectre_arcana"
        "type"  "buff_modifier"

    custom_kill_effect
        "asset" "kill"
        "modifier"  "modifier_terrorblade_arcana_kill_effect"
        "type"  "custom_kill_effect"

    hero_model_change
        "asset" "models/heroes/dragon_knight/dragon_knight_dragon.vmdl"
        "modifier"  "models/items/dragon_knight/ti8_dk_third_awakening_dragon/ti8_dk_third_awakening_dragon.vmdl"
        "skin"  "3"
        "style" "3"
        "type"  "hero_model_change"

    hex_model
        "apply_when_equipped_in_ability_effects_slot"   "2"
        "asset" "hex"
        "modifier"  "models/items/hex/sheep_hex/sheep_hex.vmdl"
        "type"  "hex_model"


Unused:
    .announcer_preview
    arcana_level
        "level" "2"
        "style" "1"
        "type"  "arcana_level"

    attack_projectile_attachment
        "asset" "close"
        "modifier"  "attach_attack2"
        "type"  "attack_projectile_attachment"

    chatwheel
        "asset" "queenofpain_pain_taunt_01"
        "label" "#dota_chatwheel_label_queenofpain_arcana_4"
        "message"   "#dota_chatwheel_message_queenofpain_arcana_4"
        "modifier"  "queenofpain_qop_arc_wheel_all_10"
        "type"  "chatwheel"

    .default_idle_expression
    .pet
    .portrait_background_model
    .portrait_game
    .response_criteria
    .rubick_arcana
    .rubick_arcana_follower
    .sound
    .tiny_voice

////////////////////////////////////
3 types of wearable:
- Hero
- Summon
- Wearable
]]