KILL_VOTE_RESULT = {}
KILL_VOTE_DEFAULT = "EASY"

BOSS_KILLS_DEFAULT = 50
CREEP_KILLS_DEFAULT = 250

-- In this file you can set up all the properties and settings for your game mode.


ENABLE_HERO_RESPAWN = true              -- Should the heroes automatically respawn on a timer or stay dead until manually respawned
UNIVERSAL_SHOP_MODE = true             -- Should the main shop contain Secret Shop items as well as regular items
ALLOW_SAME_HERO_SELECTION = false        -- Should we let people select the same hero as each other

CUSTOM_GAME_SETUP_TIME = 20.0           -- How long should custom game setup last - the screen where players pick a team?
HERO_SELECTION_TIME = 30.0              -- How long should we let people select their hero?
HERO_SELECTION_PENALTY_TIME = 30.0      -- How long should the penalty time for not picking a hero last? During this time player loses gold.
STRATEGY_TIME = 0.0                    -- How long should strategy time last? Bug: You can buy items during strategy time and it will not be spent!
SHOWCASE_TIME = 0.0                    -- How long should show case time be?
PRE_GAME_TIME = 0.0                    -- How long after showcase time should the horn blow and the game start?
POST_GAME_TIME = 15.0                   -- How long should we let people stay around before closing the server automatically?
TREE_REGROW_TIME = 2                 -- How long should it take individual trees to respawn after being cut down/destroyed?

ENABLE_BANNING_PHASE = false            -- Should we enable banning phase? Set to true if "EnablePickRules" is "1" in 'addoninfo.txt'
BANNING_PHASE_TIME = 20.0               -- How long should the banning phase last? This will work only if "EnablePickRules" is "1" in 'addoninfo.txt'

GOLD_PER_TICK = 0                     -- How much gold should players get per tick?
GOLD_TICK_TIME = 0                      -- How long should we wait in seconds between gold ticks?

RECOMMENDED_BUILDS_DISABLED = true     -- Should we disable the recommened builds for heroes
CAMERA_DISTANCE_OVERRIDE = 1200           -- How far out should we allow the camera to go?  Use -1 for the default (1134) while still allowing for panorama camera distance changes

MINIMAP_ICON_SIZE = 1                   -- What icon size should we use for our heroes?
MINIMAP_CREEP_ICON_SIZE = 1             -- What icon size should we use for creeps?
MINIMAP_RUNE_ICON_SIZE = 1              -- What icon size should we use for runes?

RUNE_SPAWN_TIME = 120                   -- How long in seconds should we wait between rune spawns?
CUSTOM_BUYBACK_COST_ENABLED = true      -- Should we use a custom buyback cost setting?
CUSTOM_BUYBACK_COOLDOWN_ENABLED = true  -- Should we use a custom buyback time?
BUYBACK_ENABLED = false                 -- Should we allow people to buyback when they die?

DISABLE_FOG_OF_WAR_ENTIRELY = false      -- Should we disable fog of war entirely for both teams?
FOG_VISION = false    

USE_STANDARD_DOTA_BOT_THINKING = false  -- Should we have bots act like they would in Dota? (This requires 3 lanes, normal items, etc)
USE_STANDARD_HERO_GOLD_BOUNTY = true    -- Should we give gold for hero kills the same as in Dota, or allow those values to be changed?

USE_CUSTOM_TOP_BAR_VALUES = true        -- Should we do customized top bar values or use the default kill count per team?
TOP_BAR_VISIBLE = false                  -- Should we display the top bar score/count at all?
SHOW_KILLS_ON_TOPBAR = false             -- Should we display kills only on the top bar? (No denies, suicides, kills by neutrals)  Requires USE_CUSTOM_TOP_BAR_VALUES

ENABLE_TOWER_BACKDOOR_PROTECTION = false-- Should we enable backdoor protection for our towers?
REMOVE_ILLUSIONS_ON_DEATH = true       -- Should we remove all illusions if the main hero dies?
DISABLE_GOLD_SOUNDS = true             -- Should we disable the gold sound when players get gold?

END_GAME_ON_KILLS = false               -- Should the game end after a certain number of kills?
KILLS_TO_END_GAME_FOR_TEAM = 50         -- How many kills for a team should signify an end of game?

USE_CUSTOM_HERO_LEVELS = true           -- Should we allow heroes to have custom levels?
MAX_LEVEL = 3500                        -- What level should we let heroes get to?
USE_CUSTOM_XP_VALUES = true            -- Should we use custom XP values to level up heroes, or the default Dota numbers?

XP_PER_LEVEL_TABLE = {}
XP_PER_LEVEL_TABLE[1] = 0
for i=2,MAX_LEVEL do
  XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1] + (i ^ 1.25) * 40
  --print(XP_PER_LEVEL_TABLE[i])
end
-- Fill this table up with the required XP per level if you want to change it


--XP_PER_LEVEL_TABLE[1] = 100
--for i=2,MAX_LEVEL do
--  XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1] + i*100  
--end

ENABLE_FIRST_BLOOD = false              -- Should we enable first blood for the first kill in this game?
HIDE_KILL_BANNERS = true               -- Should we hide the kill banners that show when a player is killed?
LOSE_GOLD_ON_DEATH = false               -- Should we have players lose the normal amount of dota gold on death?
SHOW_ONLY_PLAYER_INVENTORY = false      -- Should we only allow players to see their own inventory even when selecting other units?
DISABLE_STASH_PURCHASING = true       -- Should we prevent players from being able to buy items into their stash when not at a shop?
DISABLE_ANNOUNCER = true               -- Should we disable the announcer from working in the game?
FORCE_PICKED_HERO = nil                -- What hero should we force all players to spawn as? (e.g. "npc_dota_hero_axe").  Use nil to allow players to pick their own hero.

FIXED_RESPAWN_TIME = 5
RESPAWN_TIME = 0                -- What time should we use for a fixed respawn timer?  Use -1 to keep the default dota behavior.
FOUNTAIN_CONSTANT_MANA_REGEN = -1       -- What should we use for the constant fountain mana regen?  Use -1 to keep the default dota behavior.
FOUNTAIN_PERCENTAGE_MANA_REGEN = -1     -- What should we use for the percentage fountain mana regen?  Use -1 to keep the default dota behavior.
FOUNTAIN_PERCENTAGE_HEALTH_REGEN = -1   -- What should we use for the percentage fountain health regen?  Use -1 to keep the default dota behavior.
MAXIMUM_ATTACK_SPEED = 4000             -- What should we use for the maximum attack speed?
MINIMUM_ATTACK_SPEED = 20               -- What should we use for the minimum attack speed?

GAME_END_DELAY = -1                     -- How long should we wait after the game winner is set to display the victory banner and End Screen?  Use -1 to keep the default (about 10 seconds)
VICTORY_MESSAGE_DURATION = 3            -- How long should we wait after the victory message displays to show the End Screen?  Use 
STARTING_GOLD = 0                     -- How much starting gold should we give to each player?
DISABLE_DAY_NIGHT_CYCLE = false         -- Should we disable the day night cycle from naturally occurring? (Manual adjustment still possible)
DISABLE_KILLING_SPREE_ANNOUNCER = true -- Shuold we disable the killing spree announcer?
DISABLE_STICKY_ITEM = true             -- Should we disable the sticky item button in the quick buy area?
SKIP_TEAM_SETUP = false                 -- Should we skip the team setup entirely?
ENABLE_AUTO_LAUNCH = true               -- Should we automatically have the game complete team setup after AUTO_LAUNCH_DELAY seconds?
AUTO_LAUNCH_DELAY = 0                  -- How long should the default team selection launch timer be?  The default for custom games is 30.  Setting to 0 will skip team selection.
LOCK_TEAM_SETUP = true                 -- Should we lock the teams initially?  Note that the host can still unlock the teams 


-- NOTE: You always need at least 2 non-bounty type runes to be able to spawn or your game will crash!
ENABLED_RUNES = {}                      -- Which runes should be enabled to spawn in our game mode?
ENABLED_RUNES[DOTA_RUNE_DOUBLEDAMAGE] = true
ENABLED_RUNES[DOTA_RUNE_HASTE] = true
ENABLED_RUNES[DOTA_RUNE_ILLUSION] = true
ENABLED_RUNES[DOTA_RUNE_INVISIBILITY] = true
ENABLED_RUNES[DOTA_RUNE_REGENERATION] = true
ENABLED_RUNES[DOTA_RUNE_BOUNTY] = true
ENABLED_RUNES[DOTA_RUNE_ARCANE] = true


MAX_NUMBER_OF_TEAMS = 1               -- How many potential teams can be in this game mode?
USE_CUSTOM_TEAM_COLORS = true           -- Should we use custom team colors?
USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS = true          -- Should we use custom team colors to color the players/minimap?

TEAM_COLORS = {}                        -- If USE_CUSTOM_TEAM_COLORS is set, use these colors.
TEAM_COLORS[DOTA_TEAM_GOODGUYS] = { 101, 212, 19 }  --    Green
TEAM_COLORS[DOTA_TEAM_BADGUYS]  = { 255, 108, 0 }   --    Orange
TEAM_COLORS[DOTA_TEAM_CUSTOM_1] = { 61, 210, 150 }  --    Teal
TEAM_COLORS[DOTA_TEAM_CUSTOM_2] = { 243, 201, 9 }   --    Yellow
TEAM_COLORS[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 }   --    Blue
TEAM_COLORS[DOTA_TEAM_CUSTOM_4] = { 197, 77, 168 }  --    Pink
TEAM_COLORS[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }   --    Brown
TEAM_COLORS[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 }  --    Cyan
TEAM_COLORS[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 }  --    Olive
TEAM_COLORS[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }  --    Purple


USE_AUTOMATIC_PLAYERS_PER_TEAM = false   -- Should we set the number of players to 10 / MAX_NUMBER_OF_TEAMS?

CUSTOM_TEAM_PLAYER_COUNT = {}           -- If we're not automatically setting the number of players per team, use this table
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 8
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_1] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_2] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_3] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_4] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_5] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_6] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_7] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_8] = 0

INT_MAX_LIMIT = 2000000000 -- For max hp etc.

CREATURE_RESPAWN_TIME = 5




-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()

  -- Setup rules
  GameRules:SetHeroRespawnEnabled( ENABLE_HERO_RESPAWN )
  GameRules:SetUseUniversalShopMode( UNIVERSAL_SHOP_MODE )
  GameRules:SetSameHeroSelectionEnabled( ALLOW_SAME_HERO_SELECTION )

  GameRules:SetHeroSelectionTime(HERO_SELECTION_TIME) -- THIS IS IGNORED when "EnablePickRules" is "1" in 'addoninfo.txt' !
  GameRules:SetHeroSelectPenaltyTime(HERO_SELECTION_PENALTY_TIME)

  GameRules:SetPreGameTime(PRE_GAME_TIME)
  GameRules:SetPostGameTime(POST_GAME_TIME)
  GameRules:SetShowcaseTime(SHOWCASE_TIME)
  GameRules:SetStrategyTime(STRATEGY_TIME)

  GameRules:SetTreeRegrowTime( TREE_REGROW_TIME )

  GameRules:SetGoldTickTime(GOLD_TICK_TIME)
  GameRules:SetRuneSpawnTime(RUNE_SPAWN_TIME)
  
  GameRules:GetGameModeEntity():SetFixedRespawnTime( FIXED_RESPAWN_TIME )

  GameRules:SetUseCustomHeroXPValues ( USE_CUSTOM_XP_VALUES )
  GameRules:SetGoldPerTick(GOLD_PER_TICK)
  GameRules:SetUseBaseGoldBountyOnHeroes(USE_STANDARD_HERO_GOLD_BOUNTY)
  GameRules:SetHeroMinimapIconScale( MINIMAP_ICON_SIZE )
  GameRules:SetCreepMinimapIconScale( MINIMAP_CREEP_ICON_SIZE )
  GameRules:SetRuneMinimapIconScale( MINIMAP_RUNE_ICON_SIZE )
  GameRules:SetSameHeroSelectionEnabled(true)

  GameRules.DropTable = LoadKeyValues("scripts/kv/item_drops.kv")
  GameRules.UnitsXPTable = LoadKeyValues("scripts/kv/units_xp.kv")
  GameRules.SpawnsTable = LoadKeyValues("scripts/kv/spawnpoints.kv")

  GameRules:SetFirstBloodActive( ENABLE_FIRST_BLOOD )
  GameRules:SetHideKillMessageHeaders( HIDE_KILL_BANNERS )

  GameRules:SetCustomGameEndDelay( GAME_END_DELAY )
  GameRules:SetCustomVictoryMessageDuration( VICTORY_MESSAGE_DURATION )
  GameRules:SetStartingGold( STARTING_GOLD )

  if SKIP_TEAM_SETUP then
    GameRules:SetCustomGameSetupAutoLaunchDelay( 0 )
    GameRules:LockCustomGameSetupTeamAssignment( true )
    GameRules:EnableCustomGameSetupAutoLaunch( true )
  else
    GameRules:SetCustomGameSetupAutoLaunchDelay( AUTO_LAUNCH_DELAY )
    GameRules:LockCustomGameSetupTeamAssignment( LOCK_TEAM_SETUP )
    GameRules:EnableCustomGameSetupAutoLaunch( ENABLE_AUTO_LAUNCH )
  end


  -- This is multiteam configuration stuff
  if USE_AUTOMATIC_PLAYERS_PER_TEAM then
    local num = math.floor(10 / MAX_NUMBER_OF_TEAMS)
    local count = 0
    for team,number in pairs(TEAM_COLORS) do
      if count >= MAX_NUMBER_OF_TEAMS then
        GameRules:SetCustomGameTeamMaxPlayers(team, 0)
      else
        GameRules:SetCustomGameTeamMaxPlayers(team, num)
      end
      count = count + 1
    end
  else
    local count = 0
    for team,number in pairs(CUSTOM_TEAM_PLAYER_COUNT) do
      if count >= MAX_NUMBER_OF_TEAMS then
        GameRules:SetCustomGameTeamMaxPlayers(team, 0)
      else
        GameRules:SetCustomGameTeamMaxPlayers(team, number)
      end
      count = count + 1
    end
  end

  if USE_CUSTOM_TEAM_COLORS then
    for team,color in pairs(TEAM_COLORS) do
      SetTeamCustomHealthbarColor(team, color[1], color[2], color[3])
    end
  end
  DebugPrint('[BAREBONES] GameRules set')

  --InitLogFile( "log/barebones.txt","")

  -- Event Hooks
  local gameMode1 = GameRules:GetGameModeEntity()

  -- Setting the Order filter
  gameMode1:SetExecuteOrderFilter(Dynamic_Wrap(GameMode, 'OnOrder'), self)

  -- Setting the Damage filter
  gameMode1:SetDamageFilter(Dynamic_Wrap( GameMode, "DamageFilter" ), self)

  -- Setting the Experience filter
  gameMode1:SetModifyExperienceFilter(Dynamic_Wrap( GameMode, "ExperienceFilter" ), self)

  gameMode1:SetItemAddedToInventoryFilter(Dynamic_Wrap(GameMode, "InventoryFilter"), self)
  
  ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(GameMode, 'OnPlayerLevelUp'), self)
  ListenToGameEvent('entity_killed', Dynamic_Wrap(GameMode, 'OnEntityKilled'), self)
  ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, 'OnConnectFull'), self)
  ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, 'OnGameRulesStateChange'), self)
  ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(GameMode, 'OnHeroPick'), self)
  ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, 'OnNPCSpawned'), self)
  ListenToGameEvent("player_reconnected", Dynamic_Wrap(GameMode, 'OnPlayerReconnect'), self)
  ListenToGameEvent("player_chat", Dynamic_Wrap(GameMode, 'OnPlayerChat'), self)
  ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(GameMode, 'OnItemPicked'), self)
  ListenToGameEvent("dota_item_combined", Dynamic_Wrap(GameMode, 'OnItemCombined'), self)
  ListenToGameEvent("dota_inventory_item_added", Dynamic_Wrap(GameMode, 'OnItemAdded'), self)



  --[[This block is only used for testing events handling in the event that Valve adds more in the future
  Convars:RegisterCommand('events_test', function()
      GameMode:StartEventTest()
    end, "events test", 0)]]

  local spew = 0
  if BAREBONES_DEBUG_SPEW then
    spew = 1
  end
  Convars:RegisterConvar('barebones_spew', tostring(spew), 'Set to 1 to start spewing barebones debug info.  Set to 0 to disable.', 0)

  -- Change random seed
  local timeTxt = string.gsub(string.gsub(GetSystemTime(), ':', ''), '^0+','')
  math.randomseed(tonumber(timeTxt))

  -- Initialized tables for tracking state
  self.bSeenWaitForPlayers = false
  self.vUserIds = {}

  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')

end

Gmode = nil

-- This function is called as the first player loads and sets up the GameMode parameters
function GameMode:CaptureGameMode()
  if Gmode == nil then
    -- Set GameMode parameters
    Gmode = GameRules:GetGameModeEntity()        

    Gmode:SetGiveFreeTPOnDeath(false)
    Gmode:SetTPScrollSlotItemOverride("item_phantom_assassin_phantom_strike_datadriven")
    Gmode:SetRecommendedItemsDisabled( RECOMMENDED_BUILDS_DISABLED )
    Gmode:SetCameraDistanceOverride( CAMERA_DISTANCE_OVERRIDE )
    Gmode:SetCustomBuybackCostEnabled( CUSTOM_BUYBACK_COST_ENABLED )
    Gmode:SetCustomBuybackCooldownEnabled( CUSTOM_BUYBACK_COOLDOWN_ENABLED )
    Gmode:SetBuybackEnabled( BUYBACK_ENABLED )
    Gmode:SetTopBarTeamValuesOverride ( USE_CUSTOM_TOP_BAR_VALUES )
    Gmode:SetTopBarTeamValuesVisible( TOP_BAR_VISIBLE )
    Gmode:SetUseCustomHeroLevels ( USE_CUSTOM_HERO_LEVELS )
    Gmode:SetCustomHeroMaxLevel ( MAX_LEVEL )
    Gmode:SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )

    Gmode:SetNeutralStashEnabled(false)
    Gmode:SetAllowNeutralItemDrops(false)
    Gmode:SetCustomBackpackSwapCooldown(0)
    Gmode:SetNeutralItemHideUndiscoveredEnabled(true)

    Gmode:SetBotThinkingEnabled( USE_STANDARD_DOTA_BOT_THINKING )
    Gmode:SetTowerBackdoorProtectionEnabled( ENABLE_TOWER_BACKDOOR_PROTECTION )

    Gmode:SetFogOfWarDisabled( DISABLE_FOG_OF_WAR_ENTIRELY )
    Gmode:SetUnseenFogOfWarEnabled( FOG_VISION )

    Gmode:SetGoldSoundDisabled( DISABLE_GOLD_SOUNDS )
    Gmode:SetRemoveIllusionsOnDeath( REMOVE_ILLUSIONS_ON_DEATH )

    Gmode:SetAlwaysShowPlayerInventory( SHOW_ONLY_PLAYER_INVENTORY )
    Gmode:SetAnnouncerDisabled( DISABLE_ANNOUNCER )
    if FORCE_PICKED_HERO ~= nil then
      Gmode:SetCustomGameForceHero( FORCE_PICKED_HERO )
    end
    Gmode:SetFixedRespawnTime( FIXED_RESPAWN_TIME ) 
    Gmode:SetFountainConstantManaRegen( FOUNTAIN_CONSTANT_MANA_REGEN )
    Gmode:SetFountainPercentageHealthRegen( FOUNTAIN_PERCENTAGE_HEALTH_REGEN )
    Gmode:SetFountainPercentageManaRegen( FOUNTAIN_PERCENTAGE_MANA_REGEN )
    Gmode:SetLoseGoldOnDeath( LOSE_GOLD_ON_DEATH )
    Gmode:SetMaximumAttackSpeed( MAXIMUM_ATTACK_SPEED )
    Gmode:SetMinimumAttackSpeed( MINIMUM_ATTACK_SPEED )
    Gmode:SetStashPurchasingDisabled ( DISABLE_STASH_PURCHASING )

    for rune, spawn in pairs(ENABLED_RUNES) do
      Gmode:SetRuneEnabled(rune, spawn)
    end


    Gmode:SetDaynightCycleDisabled( DISABLE_DAY_NIGHT_CYCLE )
    Gmode:SetKillingSpreeAnnouncerDisabled( DISABLE_KILLING_SPREE_ANNOUNCER )
    Gmode:SetStickyItemDisabled( DISABLE_STICKY_ITEM )

    Gmode:SetInnateMeleeDamageBlockAmount( 0 )
    Gmode:SetInnateMeleeDamageBlockPerLevelAmount( 0 )
    Gmode:SetInnateMeleeDamageBlockPercent( 0 )

    Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_DAMAGE,1)
    Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_DAMAGE,1)
    Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_DAMAGE,1)

    Gmode:SetMaximumAttackSpeed( 2000 ) 
    Gmode:SetMinimumAttackSpeed( 10 )
    --Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_STATUS_RESISTANCE_PERCENT,0)

    Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_HP,10.00)
    Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_HP_REGEN,0.04)
    --Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_STATUS_RESISTANCE_PERCENT,0)

    Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_ARMOR,0.04)
    Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_ATTACK_SPEED,0.08)
    --GameMode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_MOVE_SPEED_PERCENT,0)

    Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_MANA,7.00)
    Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_MANA_REGEN,0.03)
    --Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_SPELL_AMP_PERCENT,0)
    --Gmode:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_MAGIC_RESISTANCE_PERCENT,0)

    self:OnFirstPlayerLoaded()
  end 
end