
--------------------------------------------------------------------------------
support_3_beg_of_life = class({})
LinkLuaModifier( "modifier_support_3_beg_of_life", "abilities/support/support_3_beg_of_life", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function support_3_beg_of_life:GetAOERadius()
  return 600
end

--------------------------------------------------------------------------------
-- Ability Start
function support_3_beg_of_life:OnSpellStart()
  -- unit identifier
  local caster = self:GetCaster()
  local point = self:GetAbsOrigin()

  -- load data
  local duration = 5

  -- create thinker
  CreateModifierThinker(
    caster, -- player source
    self, -- ability source
    "modifier_support_3_beg_of_life", -- modifier name
    { duration = duration }, -- kv
    point,
    caster:GetTeamNumber(),
    false
  )

  -- create thinker
  CreateModifierThinker(
    caster, -- player source
    self, -- ability source
    "modifier_support_3_beg_of_life_dmg", -- modifier name
    { duration = duration }, -- kv
    point,
    caster:GetTeamNumber(),
    false
  )
end

--------------------------------------------------------------------------------
modifier_support_3_beg_of_life = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_support_3_beg_of_life:IsHidden()
  return true
end

function modifier_support_3_beg_of_life:IsDebuff()
  return false
end

function modifier_support_3_beg_of_life:IsStunDebuff()
  return false
end

function modifier_support_3_beg_of_life:IsPurgable()
  return false
end

function modifier_support_3_beg_of_life:IsPurgeException()
  return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_support_3_beg_of_life:OnCreated( kv )
  -- references
  self.heal = self:GetAbility():GetSpecialValueFor( "heal" )
  self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
  self.radius = 600

  self.thinker = kv.isProvidedByAura~=1

  if not IsServer() then return end
  if not self.thinker then return end

  self:StartIntervalThink( 0.5 )
  self:OnIntervalThink()

  -- Play effects
  self:PlayEffects()
end

function modifier_support_3_beg_of_life:OnRefresh( kv )
  self.heal = self:GetAbility():GetSpecialValueFor( "heal" )
  self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
  self.radius = 600
end

function modifier_support_3_beg_of_life:OnRemoved()
end

function modifier_support_3_beg_of_life:OnDestroy()
  if not IsServer() then return end
  if not self.thinker then return end

  UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_support_3_beg_of_life:IsAura()
  return self.thinker
end

function modifier_support_3_beg_of_life:GetModifierAura()
  return "modifier_support_3_beg_of_life"
end

function modifier_support_3_beg_of_life:GetAuraRadius()
  return self.radius
end

function modifier_support_3_beg_of_life:GetAuraDuration()
  return 0.01
end

function modifier_support_3_beg_of_life:GetAuraSearchTeam()
  return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_support_3_beg_of_life:GetAuraSearchType()
  return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_support_3_beg_of_life:GetAuraSearchFlags()
  return 0
end

function modifier_support_3_beg_of_life:OnIntervalThink()
  if not IsServer() then return end
  if self:GetParent() == self:GetCaster() then return end
  -- apply damage

  local caster = self:GetCaster()
  local parent = self:GetParent()

   local allies = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, parent:GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false) 
   local enemies = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, parent:GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

  self.healint = self:GetCaster():GetAverageTrueAttackDamage(self:GetCaster()) * (self.heal / 100)
  self.dps = self:GetCaster():GetAverageTrueAttackDamage(self:GetCaster()) * (self.damage / 100)

  ------------------ HEAL

   for i, ally in pairs(allies) do

      -- Heal ally for the percentage of attack damage set in the table above 
      ally:Heal(self.healint, caster) 

      SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, ally, self.healint, nil)

   end 

  ----------------- DAMAGE

  for i, enemy in pairs(enemies) do 

      -- Damage enemy for the percentage of attack damage set in the table above  
      self.damageTable = {
         victim = enemy,
         attacker = caster,
         damage = self.dps,
         damage_type = DAMAGE_TYPE_MAGICAL,
         ability = self:GetAbility(), --Optional.
      }
      
      ApplyDamage( self.damageTable )

  end
    
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_support_3_beg_of_life:GetEffectName()
  return "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healing_ward_fortunes_tout_ward_gold_flame_cat_ring.vpcf"
end

function modifier_support_3_beg_of_life:GetEffectAttachType()
  return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_support_3_beg_of_life:PlayEffects()
  -- Get Resources
  local particle_cast = "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healing_ward_fortunes_tout_gold.vpcf"
  local sound_cast = "Hero_Alchemist.AcidSpray"

  -- Create Particle
  local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
  ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
  ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )

  -- buff particle
  self:AddParticle(
    effect_cast,
    false, -- bDestroyImmediately
    false, -- bStatusEffect
    -1, -- iPriority
    false, -- bHeroEffect
    false -- bOverheadEffect
  )

  -- Create Sound
  --EmitSoundOn( sound_cast, self:GetParent() )
end


