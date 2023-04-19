modifier_profession = class({})

--------------------------------------------------------------------------------

function modifier_profession:IsHidden()
    return true
end

function modifier_profession:IsDebuff()
    return false
end

function modifier_profession:IsPurgable()
    return false
end

function modifier_profession:RemoveOnDeath()
    return false
end

function modifier_profession:GetTexture()
    return "profession"
end

--------------------------------------------------------------------------------

function modifier_profession:OnCreated( kv )
    self.status_resist = 0
    self.move_speed_pct = 10

    self.great_cleave_damage = 15
    if self:GetCaster():GetLevel() < 30 then
        self.great_cleave_damage = 15
        self.move_speed_pct = 10
    elseif self:GetCaster():GetLevel() > 29 and self:GetCaster():GetLevel() < 120 then
        self.great_cleave_damage = 20
        self.move_speed_pct = 25
    elseif self:GetCaster():GetLevel() > 119 then
        self.great_cleave_damage = 30
        self.move_speed_pct = 50
    end
    self.great_cleave_radius = 350

    if IsServer() then
        self:SetStackCount(1)
    end

    self:StartIntervalThink( 0.1 )
    self:OnIntervalThink()
end

function modifier_profession:OnIntervalThink(kv)
    if not IsServer() then return end
    local caster = self:GetParent()
    if not caster then return end
    local itemName = nil

    for slot = 0, 8 do
        if caster:GetItemInSlot(slot) ~= nil then
            local itemIN = caster:GetItemInSlot(slot)
            if itemIN ~= nil then
                Ascento:CheckItem(caster, itemIN)
            end
        end
    end

    if caster:HasModifier("modifier_item_armor") then
        local ability = caster:FindModifierByName("modifier_item_armor"):GetAbility()
        if ability:GetSpecialValueFor("status_resistance") ~= nil then
            self.status_resist = ability:GetSpecialValueFor("status_resistance")
        else
            self.status_resist = 0
        end
    else
        self.status_resist = 0
    end

    if caster:HasModifier("modifier_custom_attribute_status_resistance") then
        local statusModifier = caster:FindModifierByName("modifier_custom_attribute_status_resistance")
        statusModifier:SetStackCount(self.status_resist)
    end



    
    

    self:GetCaster():CalculateStatBonus(true) 
    self:OnRefresh()

end

--------------------------------------------------------------------------------

function modifier_profession:OnRefresh( kv )
    self.great_cleave_damage = 15
    self.move_speed_pct = 10
    if self:GetCaster():GetLevel() < 30 then
        self.great_cleave_damage = 15
        self.move_speed_pct = 10
    elseif self:GetCaster():GetLevel() > 29 and self:GetCaster():GetLevel() < 120 then
        self.great_cleave_damage = 20
        self.move_speed_pct = 25
    elseif self:GetCaster():GetLevel() > 119 then
        self.great_cleave_damage = 30
        self.move_speed_pct = 50
    end
    self.great_cleave_radius = 350
end

-------------------------------------------------------------------------------- MODIFIER_STATE_ATTACK_ALLIES  

function modifier_profession:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_PROPERTY_TOOLTIP2,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }

    return funcs
end

function modifier_profession:OnTooltip( params )
    return self:GetStackCount()
end



function modifier_profession:OnTooltip2( params )
    return self.great_cleave_damage
end

function modifier_profession:GetModifierMoveSpeedBonus_Percentage( params )
    return self.move_speed_pct
end



--------------------------------------------------------------------------------

function modifier_profession:OnAttackLanded( params )
    if not IsServer() then return end
    if not self:GetParent() then return end
    if not self:GetCaster() then return end
    if self:GetCaster() ~= self:GetParent() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.attacker ~= self:GetCaster() then return end
    if self:GetCaster():IsIllusion() then return end
    if self:GetCaster():PassivesDisabled() then return end
    if not self:GetCaster():IsRealHero() then return end


    local target = params.target
    local caster = self:GetCaster()
    if target ~= nil and target:GetTeamNumber() ~= caster:GetTeamNumber() then
        local cleaveDamage = ( (self.great_cleave_damage / 100.0) * params.damage ) 

        local team = target:GetOpposingTeamNumber() 
        local position = target:GetAbsOrigin()
        local radius = self.great_cleave_radius
        local units = FindUnitsInRadius(team, position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false) 

        for _, x in pairs(units) do
            if x ~= target then
                if x and caster and x:GetTeamNumber() ~= caster:GetTeamNumber() and IsValidEntity(x) and x:IsAlive() then
                    if x and IsValidEntity(x) and x:IsAlive() and caster and IsValidEntity(caster) then
                        ApplyDamage({ ability = self:GetAbility(), victim = x, attacker = caster, damage = cleaveDamage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self})
                    end
                end
            end
        end
    end
end

