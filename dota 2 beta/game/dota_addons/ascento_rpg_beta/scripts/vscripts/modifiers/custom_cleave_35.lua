modifier_custom_cleave_35 = class({})

--------------------------------------------------------------------------------

function modifier_custom_cleave_35:IsHidden()
    return false
end

function modifier_custom_cleave_25:GetTexture()
    return "cleave_one"
end

--------------------------------------------------------------------------------

function modifier_custom_cleave_35:OnCreated( kv )
    self.great_cleave_damage = 35
    self.great_cleave_radius = 350
end

--------------------------------------------------------------------------------

function modifier_custom_cleave_35:OnRefresh( kv )
    self.great_cleave_damage = 35
    self.great_cleave_radius = 350
end

--------------------------------------------------------------------------------

function modifier_custom_cleave_35:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }

    return funcs
end

--------------------------------------------------------------------------------

function modifier_custom_cleave_35:OnAttackLanded( params )
    if IsServer() then
        if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then
            if self:GetParent():PassivesDisabled() then
                return 0
            end

            local target = params.target
            if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
                local cleaveDamage = ( self.great_cleave_damage * params.damage ) / 100.0
                DoCleaveAttack(
                    self:GetParent(),
                    target,
                    self:GetAbility(),
                    cleaveDamage,
                    150,
                    360,
                    self.great_cleave_radius,
                    "particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf"
                )
            end
        end
    end
    
    return 0
end