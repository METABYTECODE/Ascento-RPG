modifier_incarnation = class({})

--------------------------------------------------------------------------------

function modifier_incarnation:IsHidden()
    if self:GetStackCount() > 0 then
        return true
    else
        return true
    end
end

function modifier_incarnation:IsDebuff()
    return false
end

function modifier_incarnation:IsPurgable()
    return false
end

function modifier_incarnation:RemoveOnDeath()
    return false
end

function modifier_incarnation:GetTexture()
    return "incarnation"
end

--------------------------------------------------------------------------------

function modifier_incarnation:OnCreated( kv )
    


    --self:StartIntervalThink( 0.1 )
    --self:OnIntervalThink()

end

--function modifier_incarnation:OnIntervalThink(kv)
--    if not IsServer() then return end
--    local caster = self:GetCaster()
--    if not caster then return end
--
--end

--------------------------------------------------------------------------------

function modifier_incarnation:OnRefresh( kv )

end

--------------------------------------------------------------------------------

function modifier_incarnation:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_PROPERTY_TOOLTIP2,
        MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
        MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
    }

    return funcs
end

function modifier_incarnation:OnTooltip( params )
    if self:GetStackCount() == 0 then return 0 end

    return self:GetStackCount()
end

function modifier_incarnation:OnTooltip2( params ) -- Снижение урона
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 39 and self:GetStackCount() < 175 then -- 40: -5% получаемого урона
        return -5
    elseif self:GetStackCount() > 174 and self:GetStackCount() < 450 then -- 175: -7.5% получаемого урона
        return -12.5
    elseif self:GetStackCount() > 449 and self:GetStackCount() < 1000 then -- 450: -10% получаемого урона
        return -22.5
    elseif self:GetStackCount() > 999 and self:GetStackCount() < 12500 then -- 1000: -12.5% получаемого урона
        return -35
    elseif self:GetStackCount() > 12499 and self:GetStackCount() < 35000 then -- 12500: -15% получаемого урона
        return -50
    elseif self:GetStackCount() > 34999 and self:GetStackCount() < 80000 then -- 35000: -17.5% получаемого урона
        return -67.5
    elseif self:GetStackCount() > 79999 then -- 80000: -20% получаемого урона
        return -87.5
    end

    return 0
end

function modifier_incarnation:GetModifierExtraHealthPercentage( params )
    if self:GetStackCount() == 0 then return 0 end

    return self:GetStackCount() * 0.3 -- +0,3% хп за ренку
end

function modifier_incarnation:GetModifierMoveSpeedBonus_Percentage( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 24 then -- 25: 25% скорости передвижения
        return 25
    end

    return 0
end

function modifier_incarnation:GetModifierMoveSpeedBonus_Constant( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 59 then -- 60: 100 мувспида
        return 100
    end

    return 0
end

function modifier_incarnation:GetModifierAttackSpeedBonus_Constant( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 4 and self:GetStackCount() < 50 then -- бонус при 5: +50 скорости атаки
        return 50
    end

    if self:GetStackCount() > 49 and self:GetStackCount() < 150 then -- 50: 100 скорости атаки
        return 150
    end

    if self:GetStackCount() > 149 and self:GetStackCount() < 900 then -- 150: 200 скорости атаки
        return 350
    end

    if self:GetStackCount() > 899 then -- 900: 400 скорости атаки
        return 750
    end

    return 0
end

function modifier_incarnation:GetModifierBaseDamageOutgoing_Percentage( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 699 then -- 700: 7.5% урона
        return 7.5 + self:GetStackCount() * 0.2
    end

    return self:GetStackCount() * 0.2 -- +0,2% урона за ренку
end


function modifier_incarnation:GetModifierTotalDamageOutgoing_Percentage( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 199 and self:GetStackCount() < 500 then -- 200: 7.5% наносимого урона
        return 7.5
    end

    if self:GetStackCount() > 499 and self:GetStackCount() < 1500 then -- 500: 10% наносимого урона
        return 17.5
    end

    if self:GetStackCount() > 1499 and self:GetStackCount() < 15000 then -- 1500: 12.5% урона
        return 30
    end

    if self:GetStackCount() > 14999 and self:GetStackCount() < 40000 then -- 15000: 15% урона
        return 45
    end

    if self:GetStackCount() > 39999 and self:GetStackCount() < 90000 then -- 39999: 17.5% урона
        return 62.5
    end

    if self:GetStackCount() > 89999 then -- 90000: 20% урона
        return 82.5
    end

    return 0
end

function modifier_incarnation:GetModifierSpellAmplify_Percentage( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 9 and self:GetStackCount() < 70 then -- при 10: +10% силы заклинаний
        return 10
    end

    if self:GetStackCount() > 69 and self:GetStackCount() < 8000 then -- 70: 25% силы заклинаний 
        return 35
    end

    if self:GetStackCount() > 7999 and self:GetStackCount() < 100000 then -- 8000: 50% силы заклинаний 
        return 85
    end

    if self:GetStackCount() > 99999 then -- 100000: 100% силы заклинаний 
        return 185
    end

    return 0
end

function modifier_incarnation:GetModifierPhysicalArmorBonus( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 0 and self:GetStackCount() < 20 then -- бонус при 1: +10 брони
        return 10
    end

    if self:GetStackCount() > 19 and self:GetStackCount() < 125 then -- 20: 50 брони
        return 60
    end

    if self:GetStackCount() > 124 and self:GetStackCount() < 4500 then -- 125: 100 брони
        return 160
    end

    if self:GetStackCount() > 4499 and self:GetStackCount() < 9000 then -- 4500: 200 брони
        return 360
    end

    if self:GetStackCount() > 8999 and self:GetStackCount() < 25000 then -- 9000: 400 брони
        return 760
    end

    if self:GetStackCount() > 24999 then -- 25000: 800 брони
        return 1560
    end

    return 0
end

function modifier_incarnation:GetModifierBaseAttack_BonusDamage( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 29 and self:GetStackCount() < 250 then -- 30: +100 базовой атаки
        return 100
    end

    if self:GetStackCount() > 249 and self:GetStackCount() < 4000 then -- 250: 500 базовой атаки
        return 600
    end

    if self:GetStackCount() > 3999 and self:GetStackCount() < 45000 then -- 4000: 1500 базовой атаки
        return 2100
    end

    if self:GetStackCount() > 44999 then -- 45000: 3000 базовой атаки
        return 5100
    end

    return 0
end

function modifier_incarnation:GetModifierMagicalResistanceBonus( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 14 and self:GetStackCount() < 2000 then -- при 15: +10% маг сопрота
        return 10
    end

    if self:GetStackCount() > 1999 and self:GetStackCount() < 17500 then -- при 1500: +15% маг сопрота
        return 25
    end

    if self:GetStackCount() > 17499 and self:GetStackCount() < 30000 then -- при 17500: +20% маг сопрота
        return 45
    end

    if self:GetStackCount() > 29999 then -- при 30000: +25% маг сопрота
        return 70
    end

    return 0
end

function modifier_incarnation:GetModifierBonusStats_Strength( params )
    if not self:GetCaster() then return end
    if not IsServer() then return end
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 79 and self:GetStackCount() < 90 then -- 80: 50 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 50
        end
    end

    if self:GetStackCount() > 89 and self:GetStackCount() < 400 then -- 90: 25 всех характеристик
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 75
        else
            return 25
        end
    end

    if self:GetStackCount() > 399 and self:GetStackCount() < 3500 then -- 400: 100 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 175
        else
            return 125
        end
    end

    if self:GetStackCount() > 3499 and self:GetStackCount() < 5000 then -- 3500: 300 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 475
        else
            return 425
        end
    end

    if self:GetStackCount() > 4999 and self:GetStackCount() < 7000 then -- 5000: 500 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 975
        else
            return 425
        end
    end

    if self:GetStackCount() > 6999 and self:GetStackCount() < 10000 then -- 7000: 500 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 1475
        else
            return 925
        end
    end

    if self:GetStackCount() > 9999 and self:GetStackCount() < 20000 then -- 10000: 1000 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 2475
        else
            return 925
        end
    end

    if self:GetStackCount() > 19999 and self:GetStackCount() < 60000 then -- 20000: 1500 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 3975
        else
            return 2425
        end
    end

    if self:GetStackCount() > 59999 and self:GetStackCount() < 70000 then -- 60000: 2500 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 6475
        else
            return 2425
        end
    end

    if self:GetStackCount() > 69999 then -- 70000: 3000 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 0 then
            return 9475
        else
            return 5425
        end
    end

    return 0
end

function modifier_incarnation:GetModifierBonusStats_Agility( params )
    if not self:GetCaster() then return end
    if not IsServer() then return end
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 79 and self:GetStackCount() < 90 then -- 80: 50 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 50
        end
    end

    if self:GetStackCount() > 89 and self:GetStackCount() < 400 then -- 90: 25 всех характеристик
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 75
        else
            return 25
        end
    end

    if self:GetStackCount() > 399 and self:GetStackCount() < 3500 then -- 400: 100 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 175
        else
            return 125
        end
    end

    if self:GetStackCount() > 3499 and self:GetStackCount() < 5000 then -- 3500: 300 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 475
        else
            return 425
        end
    end

    if self:GetStackCount() > 4999 and self:GetStackCount() < 7000 then -- 5000: 500 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 975
        else
            return 425
        end
    end

    if self:GetStackCount() > 6999 and self:GetStackCount() < 10000 then -- 7000: 500 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 1475
        else
            return 925
        end
    end

    if self:GetStackCount() > 9999 and self:GetStackCount() < 20000 then -- 10000: 1000 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 2475
        else
            return 925
        end
    end

    if self:GetStackCount() > 19999 and self:GetStackCount() < 60000 then -- 20000: 1500 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 3975
        else
            return 2425
        end
    end

    if self:GetStackCount() > 59999 and self:GetStackCount() < 70000 then -- 60000: 2500 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 6475
        else
            return 2425
        end
    end

    if self:GetStackCount() > 69999 then -- 70000: 3000 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 1 then
            return 9475
        else
            return 5425
        end
    end

    return 0
end

function modifier_incarnation:GetModifierBonusStats_Intellect( params )
    if not self:GetCaster() then return end
    if not IsServer() then return end
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 79 and self:GetStackCount() < 90 then -- 80: 50 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 50
        end
    end

    if self:GetStackCount() > 89 and self:GetStackCount() < 400 then -- 90: 25 всех характеристик
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 75
        else
            return 25
        end
    end

    if self:GetStackCount() > 399 and self:GetStackCount() < 3500 then -- 400: 100 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 175
        else
            return 125
        end
    end

    if self:GetStackCount() > 3499 and self:GetStackCount() < 5000 then -- 3500: 300 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 475
        else
            return 425
        end
    end

    if self:GetStackCount() > 4999 and self:GetStackCount() < 7000 then -- 5000: 500 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 975
        else
            return 425
        end
    end

    if self:GetStackCount() > 6999 and self:GetStackCount() < 10000 then -- 7000: 500 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 1475
        else
            return 925
        end
    end

    if self:GetStackCount() > 9999 and self:GetStackCount() < 20000 then -- 10000: 1000 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 2475
        else
            return 925
        end
    end

    if self:GetStackCount() > 19999 and self:GetStackCount() < 60000 then -- 20000: 1500 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 3975
        else
            return 2425
        end
    end

    if self:GetStackCount() > 59999 and self:GetStackCount() < 70000 then -- 60000: 2500 основной характеристики
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 6475
        else
            return 2425
        end
    end

    if self:GetStackCount() > 69999 then -- 70000: 3000 ко всем атрибутам
        if self:GetCaster():GetPrimaryAttribute() == 2 then
            return 9475
        else
            return 5425
        end
    end

    return 0
end

function modifier_incarnation:GetModifierHealthBonus( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 99 and self:GetStackCount() < 800 then -- 100: 1000хп и 750 маны
        return 1000
    end

    if self:GetStackCount() > 799 then -- 800: 5000хп и 4000 маны
        return 6000
    end

    return 0
end

function modifier_incarnation:GetModifierManaBonus( params )
    if self:GetStackCount() == 0 then return 0 end

    if self:GetStackCount() > 99 and self:GetStackCount() < 800 then -- 100: 1000хп и 750 маны
        return 750
    end

    if self:GetStackCount() > 799 then -- 800: 5000хп и 4000 маны
        return 4750
    end

    return 0
end

function modifier_incarnation:GetModifierPercentageCooldown( params )
    if self:GetStackCount() == 0 or self:GetStackCount() < 50000 then return 0 end

    if self:GetStackCount() > 49999 then -- 50000: 25% снижение перезарядки
        return 25
    end

    return 0
end

function modifier_incarnation:GetModifierPercentageCasttime( params )
    if self:GetStackCount() == 0 or self:GetStackCount() < 2500 then return 0 end

    if self:GetStackCount() > 2499 then -- 2500: 50% снижение каста
        return 50
    end

    return 0
end


--------------------------------------------------------------------------------