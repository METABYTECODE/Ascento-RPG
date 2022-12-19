

BOSS_TEAM_KILLS = 0
CREEP_TEAM_KILLS = 0

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
TREE_REGROW_TIME = 10                 -- How long should it take individual trees to respawn after being cut down/destroyed?

ENABLE_BANNING_PHASE = false            -- Should we enable banning phase? Set to true if "EnablePickRules" is "1" in 'addoninfo.txt'
BANNING_PHASE_TIME = 20.0               -- How long should the banning phase last? This will work only if "EnablePickRules" is "1" in 'addoninfo.txt'

GOLD_PER_TICK = 1                     -- How much gold should players get per tick?
GOLD_TICK_TIME = 0.5                      -- How long should we wait in seconds between gold ticks?

RECOMMENDED_BUILDS_DISABLED = true     -- Should we disable the recommened builds for heroes
CAMERA_DISTANCE_OVERRIDE = 1250           -- How far out should we allow the camera to go?  Use -1 for the default (1134) while still allowing for panorama camera distance changes

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
DISABLE_GOLD_SOUNDS = false             -- Should we disable the gold sound when players get gold?

END_GAME_ON_KILLS = false               -- Should the game end after a certain number of kills?
KILLS_TO_END_GAME_FOR_TEAM = 50         -- How many kills for a team should signify an end of game?

USE_CUSTOM_HERO_LEVELS = true           -- Should we allow heroes to have custom levels?
MAX_LEVEL = 100                        -- What level should we let heroes get to?
USE_CUSTOM_XP_VALUES = true            -- Should we use custom XP values to level up heroes, or the default Dota numbers?


-- Fill this table up with the required XP per level if you want to change it

XP_PER_LEVEL_TABLE = {}
XP_PER_LEVEL_TABLE[1] = 0
XP_PER_LEVEL_TABLE[2] = 240
XP_PER_LEVEL_TABLE[3] = 640
XP_PER_LEVEL_TABLE[4] = 1160
XP_PER_LEVEL_TABLE[5] = 1760
XP_PER_LEVEL_TABLE[6] = 2440
XP_PER_LEVEL_TABLE[7] = 3200
XP_PER_LEVEL_TABLE[8] = 4000
XP_PER_LEVEL_TABLE[9] = 4900
XP_PER_LEVEL_TABLE[10] = 5900
XP_PER_LEVEL_TABLE[11] = 7000
XP_PER_LEVEL_TABLE[12] = 8200
XP_PER_LEVEL_TABLE[13] = 9500
XP_PER_LEVEL_TABLE[14] = 10900
XP_PER_LEVEL_TABLE[15] = 12400
XP_PER_LEVEL_TABLE[16] = 14000
XP_PER_LEVEL_TABLE[17] = 15700
XP_PER_LEVEL_TABLE[18] = 17500
XP_PER_LEVEL_TABLE[19] = 19400
XP_PER_LEVEL_TABLE[20] = 21400
XP_PER_LEVEL_TABLE[21] = 23600
XP_PER_LEVEL_TABLE[22] = 26000
XP_PER_LEVEL_TABLE[23] = 28600
XP_PER_LEVEL_TABLE[24] = 31400
XP_PER_LEVEL_TABLE[25] = 34400
XP_PER_LEVEL_TABLE[26] = 38400
XP_PER_LEVEL_TABLE[27] = 43400
XP_PER_LEVEL_TABLE[28] = 49400
XP_PER_LEVEL_TABLE[29] = 56400
XP_PER_LEVEL_TABLE[30] = 63900
XP_PER_LEVEL_TABLE[31] = 68900
XP_PER_LEVEL_TABLE[32] = 73900
XP_PER_LEVEL_TABLE[33] = 78900
XP_PER_LEVEL_TABLE[34] = 83900
XP_PER_LEVEL_TABLE[35] = 88900
XP_PER_LEVEL_TABLE[36] = 93900
XP_PER_LEVEL_TABLE[37] = 98900
XP_PER_LEVEL_TABLE[38] = 103900
XP_PER_LEVEL_TABLE[39] = 108900
XP_PER_LEVEL_TABLE[40] = 113900
XP_PER_LEVEL_TABLE[41] = 118900
XP_PER_LEVEL_TABLE[42] = 123900
XP_PER_LEVEL_TABLE[43] = 128900
XP_PER_LEVEL_TABLE[44] = 133900
XP_PER_LEVEL_TABLE[45] = 138900
XP_PER_LEVEL_TABLE[46] = 143900
XP_PER_LEVEL_TABLE[47] = 148900
XP_PER_LEVEL_TABLE[48] = 153900
XP_PER_LEVEL_TABLE[49] = 158900
XP_PER_LEVEL_TABLE[50] = 163900
XP_PER_LEVEL_TABLE[51] = 168900
XP_PER_LEVEL_TABLE[52] = 173900
XP_PER_LEVEL_TABLE[53] = 178900
XP_PER_LEVEL_TABLE[54] = 183900
XP_PER_LEVEL_TABLE[55] = 188900
XP_PER_LEVEL_TABLE[56] = 193900
XP_PER_LEVEL_TABLE[57] = 198900
XP_PER_LEVEL_TABLE[58] = 203900
XP_PER_LEVEL_TABLE[59] = 208900
XP_PER_LEVEL_TABLE[60] = 213900
XP_PER_LEVEL_TABLE[61] = 218900
XP_PER_LEVEL_TABLE[62] = 223900
XP_PER_LEVEL_TABLE[63] = 228900
XP_PER_LEVEL_TABLE[64] = 233900
XP_PER_LEVEL_TABLE[65] = 238900
XP_PER_LEVEL_TABLE[66] = 243900
XP_PER_LEVEL_TABLE[67] = 248900
XP_PER_LEVEL_TABLE[68] = 253900
XP_PER_LEVEL_TABLE[69] = 258900
XP_PER_LEVEL_TABLE[70] = 263900
XP_PER_LEVEL_TABLE[71] = 268900
XP_PER_LEVEL_TABLE[72] = 273900
XP_PER_LEVEL_TABLE[73] = 278900
XP_PER_LEVEL_TABLE[74] = 283900
XP_PER_LEVEL_TABLE[75] = 288900
XP_PER_LEVEL_TABLE[76] = 293900
XP_PER_LEVEL_TABLE[77] = 298900
XP_PER_LEVEL_TABLE[78] = 303900
XP_PER_LEVEL_TABLE[79] = 308900
XP_PER_LEVEL_TABLE[80] = 313900
XP_PER_LEVEL_TABLE[81] = 318900
XP_PER_LEVEL_TABLE[82] = 323900
XP_PER_LEVEL_TABLE[83] = 328900
XP_PER_LEVEL_TABLE[84] = 333900
XP_PER_LEVEL_TABLE[85] = 338900
XP_PER_LEVEL_TABLE[86] = 343900
XP_PER_LEVEL_TABLE[87] = 348900
XP_PER_LEVEL_TABLE[88] = 353900
XP_PER_LEVEL_TABLE[89] = 358900
XP_PER_LEVEL_TABLE[90] = 363900
XP_PER_LEVEL_TABLE[91] = 368900
XP_PER_LEVEL_TABLE[92] = 373900
XP_PER_LEVEL_TABLE[93] = 378900
XP_PER_LEVEL_TABLE[94] = 383900
XP_PER_LEVEL_TABLE[95] = 388900
XP_PER_LEVEL_TABLE[96] = 393900
XP_PER_LEVEL_TABLE[97] = 398900
XP_PER_LEVEL_TABLE[98] = 403900
XP_PER_LEVEL_TABLE[99] = 408900
XP_PER_LEVEL_TABLE[100] = 413900


ENABLE_FIRST_BLOOD = false              -- Should we enable first blood for the first kill in this game?
HIDE_KILL_BANNERS = true               -- Should we hide the kill banners that show when a player is killed?
LOSE_GOLD_ON_DEATH = true               -- Should we have players lose the normal amount of dota gold on death?
SHOW_ONLY_PLAYER_INVENTORY = false      -- Should we only allow players to see their own inventory even when selecting other units?
DISABLE_STASH_PURCHASING = false       -- Should we prevent players from being able to buy items into their stash when not at a shop?
DISABLE_ANNOUNCER = true               -- Should we disable the announcer from working in the game?
FORCE_PICKED_HERO = nil                -- What hero should we force all players to spawn as? (e.g. "npc_dota_hero_axe").  Use nil to allow players to pick their own hero.

FIXED_RESPAWN_TIME = 10                 -- What time should we use for a fixed respawn timer?  Use -1 to keep the default dota behavior.
FOUNTAIN_CONSTANT_MANA_REGEN = -1       -- What should we use for the constant fountain mana regen?  Use -1 to keep the default dota behavior.
FOUNTAIN_PERCENTAGE_MANA_REGEN = -1     -- What should we use for the percentage fountain mana regen?  Use -1 to keep the default dota behavior.
FOUNTAIN_PERCENTAGE_HEALTH_REGEN = -1   -- What should we use for the percentage fountain health regen?  Use -1 to keep the default dota behavior.
MAXIMUM_ATTACK_SPEED = 2000             -- What should we use for the maximum attack speed?
MINIMUM_ATTACK_SPEED = 20               -- What should we use for the minimum attack speed?

GAME_END_DELAY = -1                     -- How long should we wait after the game winner is set to display the victory banner and End Screen?  Use -1 to keep the default (about 10 seconds)
VICTORY_MESSAGE_DURATION = 3            -- How long should we wait after the victory message displays to show the End Screen?  Use 
STARTING_GOLD = 500                     -- How much starting gold should we give to each player?
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
  

  GameRules:SetUseCustomHeroXPValues ( USE_CUSTOM_XP_VALUES )
  GameRules:SetGoldPerTick(GOLD_PER_TICK)
  GameRules:SetUseBaseGoldBountyOnHeroes(USE_STANDARD_HERO_GOLD_BOUNTY)
  GameRules:SetHeroMinimapIconScale( MINIMAP_ICON_SIZE )
  GameRules:SetCreepMinimapIconScale( MINIMAP_CREEP_ICON_SIZE )
  GameRules:SetRuneMinimapIconScale( MINIMAP_RUNE_ICON_SIZE )

  GameRules.DropTable = LoadKeyValues("scripts/kv/item_drops_ny.kv")
  GameRules.UnitsXPTable = LoadKeyValues("scripts/kv/xp_table_ny.kv")

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


  -- Setting the Damage filter
  gameMode1:SetDamageFilter(Dynamic_Wrap( GameMode, "DamageFilter" ), self)

  
  ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(GameMode, 'OnPlayerLevelUp'), self)
  ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, 'OnConnectFull'), self)
  ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, 'OnGameRulesStateChange'), self)
  ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(GameMode, 'OnHeroPick'), self)
  ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, 'OnNPCSpawned'), self)
  ListenToGameEvent("player_reconnected", Dynamic_Wrap(GameMode, 'OnPlayerReconnect'), self)
  ListenToGameEvent("player_chat", Dynamic_Wrap(GameMode, 'OnPlayerChat'), self)



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
    Gmode:SetCustomBackpackSwapCooldown(1)
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

    Gmode:SetMaximumAttackSpeed( MAXIMUM_ATTACK_SPEED ) 
    Gmode:SetMinimumAttackSpeed( MINIMUM_ATTACK_SPEED )

    self:OnFirstPlayerLoaded()
  end 
end