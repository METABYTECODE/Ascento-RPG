support_1_sustain = class({})
LinkLuaModifier( "modifier_support_1_sustain", "abilities/support/support_1_sustain", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_support_1_sustain_effect", "abilities/support/support_1_sustain", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier

function support_1_sustain:OnToggle(  )
    -- unit identifier
    local caster = self:GetCaster()

    -- load data
    local toggle = self:GetToggleState()

    if toggle then
        -- add modifier
        self.modifier = caster:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_support_1_sustain", -- modifier name
            {  } -- kv
        )
    else
        if self.modifier and not self.modifier:IsNull() then
            self.modifier:Destroy()
        end
        self.modifier = nil
    end
end

modifier_support_1_sustain = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_support_1_sustain:IsHidden()
	return true
end

function modifier_support_1_sustain:IsDebuff()
	return false
end

function modifier_support_1_sustain:IsPurgable()
	return false
end

function modifier_support_1_sustain:IsPurgeException()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_support_1_sustain:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_support_1_sustain:GetModifierAura()
	return "modifier_support_1_sustain_effect"
end

function modifier_support_1_sustain:GetAuraRadius()
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	if self:GetCaster():HasModifier("modifier_donate_aura_damage") then
		self.radius = self.radius * 2
	end
	return self.radius
end

function modifier_support_1_sustain:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_support_1_sustain:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_support_1_sustain_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_support_1_sustain_effect:IsHidden()
	return false
end

function modifier_support_1_sustain_effect:IsDebuff()
	return false
end

function modifier_support_1_sustain_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_support_1_sustain_effect:OnCreated( kv )
	-- references
	self.hp_regen = self:GetAbility():GetSpecialValueFor( "hp_regen_pct" ) -- special value
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen_pct" )  / 100 -- special value
	
	if self:GetParent():HasModifier("modifier_donate_aura_damage") then
		self.hp_regen = self.hp_regen * 2
		self.mana_regen = self.mana_regen * 2
	end
end

function modifier_support_1_sustain_effect:OnRefresh( kv )
	-- references
	self.hp_regen = self:GetAbility():GetSpecialValueFor( "hp_regen_pct" ) -- special value
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen_pct" )  / 100 -- special value

	if self:GetParent():HasModifier("modifier_donate_aura_damage") then
		self.hp_regen = self.hp_regen * 2
		self.mana_regen = self.mana_regen * 2
	end
end

function modifier_support_1_sustain_effect:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects

function modifier_support_1_sustain_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}

	return funcs
end
function modifier_support_1_sustain_effect:GetModifierConstantManaRegen()
	return self:GetCaster():GetMaxMana() * self.mana_regen
end

function modifier_support_1_sustain_effect:GetModifierHealthRegenPercentage()
	return self.hp_regen
end


--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_support_1_sustain_effect:GetTexture() return "support_1_sustain" end

 function modifier_support_1_sustain_effect:GetEffectName()
 	return "particles/units/heroes/hero_mars/mars_arena_of_blood_heal_flame.vpcf"
 end

 function modifier_support_1_sustain_effect:GetEffectAttachType()
 	return PATTACH_ABSORIGIN_FOLLOW
 end