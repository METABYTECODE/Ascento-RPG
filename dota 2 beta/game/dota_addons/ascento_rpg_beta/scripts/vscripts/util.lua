    --OVERHEAD_ALERT_GOLD = 0
    --OVERHEAD_ALERT_DENY = 1
    --OVERHEAD_ALERT_CRITICAL = 2
    --OVERHEAD_ALERT_XP = 3
    --OVERHEAD_ALERT_BONUS_SPELL_DAMAGE = 4
    --OVERHEAD_ALERT_MISS = 5
    --OVERHEAD_ALERT_DAMAGE = 6
    --OVERHEAD_ALERT_EVADE = 7
    --OVERHEAD_ALERT_BLOCK = 8
    --OVERHEAD_ALERT_BONUS_POISON_DAMAGE = 9
    --OVERHEAD_ALERT_HEAL = 10
    --OVERHEAD_ALERT_MANA_ADD = 11
    --OVERHEAD_ALERT_MANA_LOSS = 12
    --OVERHEAD_ALERT_LAST_HIT_EARLY = 13
    --OVERHEAD_ALERT_LAST_HIT_CLOSE = 14
    --OVERHEAD_ALERT_LAST_HIT_MISS = 15
    --OVERHEAD_ALERT_MAGICAL_BLOCK = 16
    --OVERHEAD_ALERT_INCOMING_DAMAGE = 17
    --OVERHEAD_ALERT_OUTGOING_DAMAGE = 18
    --OVERHEAD_ALERT_DISABLE_RESIST = 19
    --OVERHEAD_ALERT_DEATH = 20
    --OVERHEAD_ALERT_BLOCKED = 21
    --OVERHEAD_ALERT_ITEM_RECEIVED = 22
    --OVERHEAD_ALERT_SHARD = 23
    --OVERHEAD_ALERT_DEADLY_BLOW = 24




function BroadcastMessage( sMessage, fDuration )
    print("Got in BroadcastMessage")
    local centerMessage = {
        message = sMessage,
        duration = fDuration
    }
    FireGameEvent( "show_center_message", centerMessage )
end

function get_team_heroes(team)
  local out = {}

  for playerID = 0, DOTA_MAX_PLAYERS do
    local hero = PlayerResource:GetSelectedHeroEntity(playerID)
    if hero and PlayerResource:GetTeam(playerID) == team then
      table.insert(out, hero)
    end
  end

  return out
end

function floor(number)
  return math.floor(number)
end

function disp_time(time)
  local days = floor(time/86400)
  local remaining = time % 86400
  local hours = floor(remaining/3600)
  remaining = remaining % 3600
  local minutes = floor(remaining/60)
  remaining = remaining % 60
  local seconds = remaining
  if (hours < 10) then
    hours = "0" .. tostring(hours)
  end
  if (minutes < 10) then
    minutes = "0" .. tostring(minutes)
  end
  if (seconds < 10) then
    seconds = "0" .. tostring(seconds)
  end
  answer = tostring(days)..'d '..hours..'h '..minutes..'m '..seconds..'s'
  return answer
end

function increase_modifier(caster, target, ability, modifier)
  if target:HasModifier(modifier) then
    local newCount = target:GetModifierStackCount(modifier, caster) + 1
        target:SetModifierStackCount(modifier, caster, newCount)
  else
    ability:ApplyDataDrivenModifier(caster, target, modifier, nil)
    target:SetModifierStackCount(modifier, caster, 1)
    end
end

function decrease_modifier(caster, target, modifier)
  if target:HasModifier(modifier) then
    local count = target:GetModifierStackCount(modifier, caster)

    if count > 1 then
      target:SetModifierStackCount(modifier, caster, count - 1)
    else 
      target:RemoveModifierByName(modifier)
    end
  end
end

function find_item(caster, item_name)
    for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
        local item = caster:GetItemInSlot(i)
        if item:GetName() == item_name then
            return item
        end
    end
    return nil
end

function PickRandomShuffle( reference_list, bucket )
    if ( #reference_list == 0 ) then
        return nil
    end
    
    if ( #bucket == 0 ) then
        -- ran out of options, refill the bucket from the reference
        for k, v in pairs(reference_list) do
            bucket[k] = v
        end
    end

    -- pick a value from the bucket and remove it
    local pick_index = RandomInt( 1, #bucket )
    local result = bucket[ pick_index ]
    table.remove( bucket, pick_index )
    return result
end

function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function ShuffledList( orig_list )
  local list = shallowcopy( orig_list )
  local result = {}
  local count = #list
  for i = 1, count do
    local pick = RandomInt( 1, #list )
    result[ #result + 1 ] = list[ pick ]
    table.remove( list, pick )
  end
  return result
end

function TableCount( t )
  local n = 0
  for _ in pairs( t ) do
    n = n + 1
  end
  return n
end

function TableFindKey( table, val )
  if table == nil then
    print( "nil" )
    return nil
  end

  for k, v in pairs( table ) do
    if v == val then
      return k
    end
  end
  return nil
end

function CountdownTimer(time_in_sec)
    --nCOUNTDOWNTIMER = nCOUNTDOWNTIMER - 1
    --local t = nCOUNTDOWNTIMER
    --print( t )
    --local minutes = math.floor(t / 60)
    --local seconds = t - (minutes * 60)
    --local m10 = math.floor(minutes / 10)
    --local m01 = minutes - (m10 * 10)
    --local s10 = math.floor(seconds / 10)
    local s10 = 0
    if(time_in_sec > 10) then
        s10 = 1
    end
    local s01 = time_in_sec--seconds - (s10 * 10)
    local broadcast_gametimer = 
        {
            timer_minute_10 = 0,--m10,
            timer_minute_01 = 0,--m01,
            timer_second_10 = s10,
            timer_second_01 = s01,
        }
    --CustomGameEventManager:Send_ServerToAllClients( "countdown", broadcast_gametimer )
    --if t <= 120 then
    CustomGameEventManager:Send_ServerToAllClients( "time_remaining", broadcast_gametimer )
    --end
end

function SetTimer( cmdName, time )
    print( "Set the timer to: " .. time )
    nCOUNTDOWNTIMER = time
end

function DebugPrint(...)
  if USE_DEBUG then
    print(...)
  end
end

function FormatLongNumber(n)
  if n >= 10^9 then
        return string.format("%.2fb", n / 10^9)
    elseif n >= 10^6 then
        return string.format("%.2fm", n / 10^6)

    elseif n >= 10^3 then
        return string.format("%.2fk", n / 10^3)
    else
        return tostring(n)
    end
end

function callIfCallable(f)
    return function(...)
        error, result = pcall(f, ...)
        if error then -- f exists and is callable
            print('ok')
            return result
        end
        -- nothing to do, as though not called, or print('error', result)
    end
end

function ToRadians(degrees)
  return degrees * math.pi / 180
end

function RotateVector2D(vector, theta)
    local xp = vector.x*math.cos(theta)-vector.y*math.sin(theta)
    local yp = vector.x*math.sin(theta)+vector.y*math.cos(theta)
    return Vector(xp,yp,vector.z):Normalized()
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function maxFreq(arr, n, fallback)
  table.sort(arr)
  -- we do this so it falls back to the default value
  table.insert(arr, fallback)
  n= n + 1
  --

  local max_count = 1
  local res = arr[1]

  local curr_count = 1

  for i = 1, n do 
    if arr[i] == arr[i - 1] then
        curr_count = curr_count + 1
    else
        if curr_count > max_count then
            max_count = curr_count
            res = arr[i - 1]
        end

        curr_count = 1
    end
  end

  if curr_count > max_count then
    max_count = curr_count
    res = arr[n - 1]
  end

  return res
end

function DebugPrintTable(...)
  local spew = Convars:GetInt('barebones_spew') or -1
  if spew == -1 and BAREBONES_DEBUG_SPEW then
    spew = 1
  end

  if spew == 1 then
    PrintTable(...)
  end
end

function DisplayError(playerID, message)
  local player = PlayerResource:GetPlayer(playerID)
  if player then
    CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message=message})
  end
end

function CreateParticleWithTargetAndDuration(particleName, target, duration)
  local particle = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN_FOLLOW, target)
  ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)

  Timers:CreateTimer(duration, function()
      ParticleManager:DestroyParticle(particle, true)
      ParticleManager:ReleaseParticleIndex(particle)
  end)

  return particle
end

function GetRealConnectedHeroCount()
  local heroes = HeroList:GetAllHeroes()
  local amount = 0
  for _,hero in ipairs(heroes) do
    local connectionState = PlayerResource:GetConnectionState(hero:GetPlayerID())
    if connectionState == DOTA_CONNECTION_STATE_CONNECTED and UnitIsNotMonkeyClone(hero) and not hero:IsIllusion() and hero:IsRealHero() and not hero:IsClone() and not hero:IsTempestDouble() and  hero:GetUnitName() ~= "outpost_placeholder_unit" then
      amount = amount + 1
    end
  end

  return amount
end

function GetRealHeroCount()
  local heroes = HeroList:GetAllHeroes()
  local amount = 0
  for _,hero in ipairs(heroes) do
    if UnitIsNotMonkeyClone(hero) and not hero:IsIllusion() and hero:IsRealHero() and not hero:IsClone() and not hero:IsTempestDouble() and  hero:GetUnitName() ~= "outpost_placeholder_unit" then
      amount = amount + 1
    end
  end

  return amount
end

function IsInTrigger(entity, trigger)
  if not entity:IsAlive() then return false end

  local triggerOrigin = trigger:GetAbsOrigin()
  local bounds = trigger:GetBounds()

  local origin = entity
  if entity.GetAbsOrigin then
    origin = entity:GetAbsOrigin()
  end

  if origin.x < bounds.Mins.x + triggerOrigin.x then
    return false
  end
  if origin.y < bounds.Mins.y + triggerOrigin.y then
    return false
  end
  if origin.x > bounds.Maxs.x + triggerOrigin.x then
    return false
  end
  if origin.y > bounds.Maxs.y + triggerOrigin.y then
    return false
  end

  return true
end

function IsEventASCENTO(unit)
  if not unit or unit:IsNull() then return false end

  local unitNames = {
    "npc_ny_creep_1",
    "npc_ny_boss_10",
    "npc_ny_boss_20",
    "npc_ny_boss_30",
    "npc_ny_boss_40",
    "npc_ny_boss_50"
  }

  for _,theUnit in ipairs(unitNames) do
    if unit:GetUnitName() == theUnit then return true end
  end

  return false
end

function IsCreepASCENTO(unit)
  if not unit or unit:IsNull() then return false end

  local unitNames = {
    "npc_dota_neutral_kobold",
    "npc_dota_neutral_ogre_mauler",
    "npc_dota_roshan_halloween_minion",
    "npc_dota_necronomicon_warrior_1",
    "npc_dota_neutral_polar_furbolg_champion",
    "npc_dota_broodmother_spiderling",
    "npc_dota_warlock_golem_1",
    "npc_special_event_halloween",
    "npc_dota_neutral_centaur_outrunner",
    "npc_dota_brewmaster_earth_1",
    "npc_dota_unit_undying_zombie",
    "npc_dota_badguys_tower1_bot",
    "npc_dota_creep_badguys_ranged",
    "npc_dota_creep_badguys_ranged_upgraded",
    "npc_dota_creep_badguys_ranged_upgraded_mega",
    "npc_dota_creep_goodguys_ranged",
    "npc_dota_creature_tiny_creep",
    "npc_dota_creature_slardar_creep",
    "npc_dota_creature_clock_creep",
    "npc_dota_creature_gyro_creep",
    "npc_dota_creature_enigma_creep",
    "npc_dota_creature_aa_creep" ,
    "npc_dota_creature_lich_creep",
    "npc_dota_creature_wisp_creep",
    "npc_dota_creature_grimstroke_creep",
    "npc_dota_creature_dazzle_creep",
    "npc_dota_boss_aghanim_crystal",
    "npc_dota_boss_aghanim_spear",
    "npc_dota_creature_aghanim_minion"
  }

  for _,theUnit in ipairs(unitNames) do
    if unit:GetUnitName() == theUnit then return true end
  end

  return false
end

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

function IsEndlessASCENTO(unit)
  if not unit or unit:IsNull() then return false end

  local unitNames = {
    "npc_creep_endless_1"
  }

  for _,theUnit in ipairs(unitNames) do
    if unit:GetUnitName() == theUnit then return true end
  end

  return false
end

function PrintTable(t, indent, done)
  --print ( string.format ('PrintTable type %s', type(keys)) )
  if type(t) ~= "table" then return end

  done = done or {}
  done[t] = true
  indent = indent or 0

  local l = {}
  for k, v in pairs(t) do
    table.insert(l, k)
  end

  table.sort(l)
  for k, v in ipairs(l) do
    -- Ignore FDesc
    if v ~= 'FDesc' then
      local value = t[v]

      if type(value) == "table" and not done[value] then
        done [value] = true
        print(string.rep ("\t", indent)..tostring(v)..":")
        PrintTable (value, indent + 2, done)
      elseif type(value) == "userdata" and not done[value] then
        done [value] = true
        print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
        PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
      else
        if t.FDesc and t.FDesc[v] then
          print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
        else
          print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
        end
      end
    end
  end
end

function GetRandomTableElement(t)
    -- iterate over whole table to get all keys
    local keyset = {}
    for k in pairs(t) do
        table.insert(keyset, k)
    end
    -- now you can reliably return a random key
    return t[keyset[RandomInt(1, #keyset)]]
end

-- Colors
COLOR_NONE = '\x06'
COLOR_GRAY = '\x06'
COLOR_GREY = '\x06'
COLOR_GREEN = '\x0C'
COLOR_DPURPLE = '\x0D'
COLOR_SPINK = '\x0E'
COLOR_DYELLOW = '\x10'
COLOR_PINK = '\x11'
COLOR_RED = '\x12'
COLOR_LGREEN = '\x15'
COLOR_BLUE = '\x16'
COLOR_DGREEN = '\x18'
COLOR_SBLUE = '\x19'
COLOR_PURPLE = '\x1A'
COLOR_ORANGE = '\x1B'
COLOR_LRED = '\x1C'
COLOR_GOLD = '\x1D'


function DebugAllCalls()
    if not GameRules.DebugCalls then
        print("Starting DebugCalls")
        GameRules.DebugCalls = true

        debug.sethook(function(...)
            local info = debug.getinfo(2)
            local src = tostring(info.short_src)
            local name = tostring(info.name)
            if name ~= "__index" then
                print("Call: ".. src .. " -- " .. name .. " -- " .. info.currentline)
            end
        end, "c")
    else
        print("Stopped DebugCalls")
        GameRules.DebugCalls = false
        debug.sethook(nil, "c")
    end
end

-- Requires an element and a table, returns true if element is in the table.
function TableContains(t, element)
    if t == nil then return false end
    for k,v in pairs(t) do
        if k == element then
            return true
        end
    end
    return false
end

-- Return length of the table even if the table is nil or empty
function TableLength(t)
    if t == nil or t == {} then
        return 0
    end
    local length = 0
    for k,v in pairs(t) do
        length = length + 1
    end
    return length
end




--[[Author: Noya
  Date: 09.08.2015.
  Hides all dem hats
]]
function HideWearables( unit )
  unit.hiddenWearables = {} -- Keep every wearable handle in a table to show them later
    local model = unit:FirstMoveChild()
    while model ~= nil do
        if model:GetClassname() == "dota_item_wearable" then
            model:AddEffects(EF_NODRAW) -- Set model hidden
            table.insert(unit.hiddenWearables, model)
        end
        model = model:NextMovePeer()
    end
end

-- Author: Noya
-- This function un-hides (shows) wearables that were hidden with HideWearables() function.
function ShowWearables(unit)
  for i,v in pairs(unit.hiddenWearables) do
    v:RemoveEffects(EF_NODRAW)
  end
end

-- Author: Noya
-- This function changes (swaps) dota item cosmetic models (hats/wearables)
-- Works only for wearables added with code
function SwapWearable(unit, target_model, new_model)
    local wearable = unit:FirstMoveChild()
    while wearable ~= nil do
        if wearable:GetClassname() == "dota_item_wearable" then
            if wearable:GetModelName() == target_model then
                wearable:SetModel(new_model)
                return
            end
        end
        wearable = wearable:NextMovePeer()
    end
end

-- This function checks if this entity is a fountain or not; returns boolean value;
function CBaseEntity:IsFountain()
  if self:GetName() == "ent_dota_fountain_bad" or self:GetName() == "ent_dota_fountain_good" then
    return true
  end
  
  return false
end


function ClearItems(mustHaveOwner)
  local items_on_the_ground = Entities:FindAllByClassname("dota_item_drop")
  
  for _,item in pairs(items_on_the_ground) do
    local containedItem = item:GetContainedItem()
    if containedItem then
      local owner = containedItem:GetOwnerEntity()

      local creationTime = math.floor(item:GetCreationTime())
      local gameTime = math.floor(GameRules:GetGameTime())

      local name = containedItem:GetAbilityName()

      --if string.find(name, "item_hallowen_legendary_pet_datadriven") then
      --  break
      --end

      if containedItem and (mustHaveOwner and owner == nil and ((gameTime - creationTime) > 40)) then

        local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, item )
        ParticleManager:SetParticleControl( nFXIndex, 0, item:GetOrigin() )
        ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
        ParticleManager:ReleaseParticleIndex( nFXIndex )
        EmitGlobalSound("Item.PickUpWorld")

        UTIL_Remove(containedItem)
        UTIL_Remove(item)
        
      end

      if containedItem and (mustHaveOwner and owner ~= nil and ((gameTime - creationTime) > 90)) then

        local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, item )
        ParticleManager:SetParticleControl( nFXIndex, 0, item:GetOrigin() )
        ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
        ParticleManager:ReleaseParticleIndex( nFXIndex )
        EmitGlobalSound("Item.PickUpWorld")

        UTIL_Remove(containedItem)
        UTIL_Remove(item)
        
      end
    end
  end
end

function ClearPlayerItems(hero)
  local items_on_the_ground = Entities:FindAllByClassname("dota_item_drop")
  for _,item in pairs(items_on_the_ground) do
    local containedItem = item:GetContainedItem()
    if containedItem then

      local owner = containedItem:GetOwnerEntity()

      local name = containedItem:GetAbilityName()

      if hero == owner then

        local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, item )
        ParticleManager:SetParticleControl( nFXIndex, 0, item:GetOrigin() )
        ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
        ParticleManager:ReleaseParticleIndex( nFXIndex )
        EmitGlobalSound("Item.PickUpWorld")

        UTIL_Remove(containedItem)
        UTIL_Remove(item)
        
      end
    end
  end
end


function CDOTA_BaseNPC:FindItemInAnyInventory(name)
  local pass = nil

  for i=0,14 do
      local item = self:GetItemInSlot(i)
      if item ~= nil then
          if item:GetAbilityName() == name then
              pass = item
              break
          end
      end
  end

  return pass
end

function CDOTABaseAbility:FireLinearProjectile(FX, velocity, distance, width, data, bDelete, bVision, vision)
  local internalData = data or {}
  local delete = false
  if bDelete then delete = bDelete end
  local provideVision = true
  if bVision then provideVision = bVision end
  if internalData.source and not internalData.origin then
    internalData.origin = internalData.source:GetAbsOrigin()
  end
  local info = {
    EffectName = FX,
    Ability = self,
    vSpawnOrigin = internalData.origin or self:GetCaster():GetAbsOrigin(), 
    fStartRadius = width,
    fEndRadius = internalData.width_end or width,
    vVelocity = velocity,
    fDistance = distance or 1000,
    Source = internalData.source or self:GetCaster(),
    iUnitTargetTeam = internalData.team or DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = internalData.type or DOTA_UNIT_TARGET_ALL,
    iUnitTargetFlags = internalData.type or DOTA_UNIT_TARGET_FLAG_NONE,
    iSourceAttachment = internalData.attach or DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
    bDeleteOnHit = delete,
    fExpireTime = GameRules:GetGameTime() + 10.0,
    bProvidesVision = provideVision,
    iVisionRadius = vision or 100,
    iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
    ExtraData = internalData.extraData
  }
  local projectile = ProjectileManager:CreateLinearProjectile( info )
  return projectile
end

function CDOTABaseAbility:FireTrackingProjectile(FX, target, speed, data, iAttach, bDodge, bVision, vision)
  local internalData = data or {}
  local dodgable = true
  if bDodge ~= nil then dodgable = bDodge end
  local provideVision = false
  if bVision ~= nil then provideVision = bVision end
  origin = self:GetCaster():GetAbsOrigin()
  if internalData.origin then
    origin = internalData.origin
  elseif internalData.source then
    origin = internalData.source:GetAbsOrigin()
  end
  local projectile = {
    Target = target,
    Source = internalData.source or self:GetCaster(),
    Ability = self, 
    EffectName = FX,
      iMoveSpeed = speed,
    vSourceLoc= origin or self:GetCaster():GetAbsOrigin(),
    bDrawsOnMinimap = false,
        bDodgeable = dodgable,
        bIsAttack = false,
        bVisibleToEnemies = true,
        bReplaceExisting = false,
        flExpireTime = internalData.duration,
    bProvidesVision = provideVision,
    iVisionRadius = vision or 100,
    iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
    iSourceAttachment = iAttach or 3,
    ExtraData = internalData.extraData
  }
  return ProjectileManager:CreateTrackingProjectile(projectile)
end

function CDOTA_BaseNPC:HasTalent(talentName)
  if self and not self:IsNull() and self:HasAbility(talentName) then
    if self:FindAbilityByName(talentName):GetLevel() > 0 then return true end
  end

  return false
end

function CDOTA_BaseNPC:IsRoshan()
  if self:IsAncient() and self:GetUnitName() == "npc_dota_roshan" then
    return true
  end
  
  return false
end

-- Author: Noya
-- This function is showing custom Error Messages using notifications library
function SendErrorMessage(pID, string)
  if Notifications then
    Notifications:ClearBottom(pID)
    Notifications:Bottom(pID, {text=string, style={color='#E62020'}, duration=2})
  end
  EmitSoundOnClient("General.Cancel", PlayerResource:GetPlayer(pID))
end
