custom_shmot_attr = custom_shmot_attr or class({})
LinkLuaModifier("modifier_custom_shmot_attr", "inventory/custom_shmot_attr", LUA_MODIFIER_MOTION_NONE)

function custom_shmot_attr:GetIntrinsicModifierName() return "modifier_custom_shmot_attr" end

modifier_custom_shmot_attr = class({})

function modifier_custom_shmot_attr:IsHidden() return false end
function modifier_custom_shmot_attr:IsDebuff() return false end
function modifier_custom_shmot_attr:IsPurgable() return false end
function modifier_custom_shmot_attr:RemoveOnDeath() return false end

function modifier_custom_shmot_attr:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_BONUS
    }
    return funcs
end

function modifier_custom_shmot_attr:OnCreated()

    local caster = self:GetCaster() or nil
    local playerId = ""

    if not IsServer() then
        local playerId = caster:GetPlayerOwnerID() or nil
        playerId = playerId or caster:GetPlayerID() or caster:GetPlayerOwnerID() or nil
        if playerId ~= nil then
            playerId = tostring(playerId)
            print("Player ID в клиенте = " .. playerId)
            local shmotload = CustomNetTables:GetTableValue( "custom_shmot", "shmot" ) or nil

            if shmotload ~= nil then

                shmotload = shmotload[playerId]
                shmotload = shmotload.shmot
                shmotload = shmotload[playerId]

                if shmotload ~= nil then

                    print("Shmotload client:")
                    DeepPrintTable (shmotload);

                    print( "Сервер Steam Community ID от shmotload: " .. shmotload.steamid)

                    if shmotload.steamid ~= nil then

                        self.bonus_damage = tonumber(shmotload.damage or 0)
                        self.bonus_attack_speed = tonumber(shmotload.attack_speed or 0)
                        self.bonus_hit_hp = tonumber(shmotload.hit_hp or 0)
                        self.bonus_hit_mp = tonumber(shmotload.hit_mp or 0)
                        self.bonus_creep_damage = tonumber(shmotload.creep_damage or 0)
                        self.bonus_all_stats = tonumber(shmotload.all_stats or 0)
                        self.bonus_status_resistance = tonumber(shmotload.status_resistance or 0)
                        self.bonus_health_percent = tonumber(shmotload.health_percent or 0)
                        self.bonus_spell_range = tonumber(shmotload.spell_range or 0)
                        self.bonus_movement_speed = tonumber(shmotload.movement_speed or 0)
                        self.bonus_armor = tonumber(shmotload.armor or 0)
                        self.bonus_hp = tonumber(shmotload.hp or 0)
                        self.bonus_mp = tonumber(shmotload.mp or 0)
                        self.bonus_cooldown_reduction = tonumber(shmotload.cooldown_reduction or 0)
                        self.bonus_spell_amplify = tonumber(shmotload.spell_amplify or 0)
                        self.bonus_spell_lifesteal = tonumber(shmotload.spell_lifesteal or 0)
                        self.bonus_strength = tonumber((shmotload.strength or 0) + (shmotload.all_stats or 0))
                        self.bonus_intellect = tonumber((shmotload.intellect or 0) + (shmotload.all_stats or 0))
                        self.bonus_agility = tonumber((shmotload.agility or 0) + (shmotload.all_stats or 0))

                        local hero = self:GetCaster()
                        if hero ~= nil and hero:IsNull() == false and hero.CalculateStatBonus then
                            hero:CalculateStatBonus(false)
                        end
                    end
                end
            end
        end
    else
        local playerId = caster:GetPlayerID() or nil
        playerId = playerId or caster:GetPlayerID() or caster:GetPlayerOwnerID() or nil

        if playerId ~= nil then
            playerId = tostring(playerId)
            print("Player ID на сервере = " .. playerId)
            
            local shmotload = CustomNetTables:GetTableValue( "custom_shmot", "shmot" ) or nil

            if shmotload ~= nil then

                shmotload = shmotload[playerId]
                shmotload = shmotload.shmot
                shmotload = shmotload[playerId]


                if shmotload ~= nil then


                    print("Shmotload server:")
                    DeepPrintTable (shmotload);

                    print( "Сервер Steam Community ID от shmotload: " .. shmotload.steamid)

                    if shmotload.steamid ~= nil then

                        self.bonus_damage = tonumber(shmotload.damage or 0)
                        self.bonus_attack_speed = tonumber(shmotload.attack_speed or 0)
                        self.bonus_hit_hp = tonumber(shmotload.hit_hp or 0)
                        self.bonus_hit_mp = tonumber(shmotload.hit_mp or 0)
                        self.bonus_creep_damage = tonumber(shmotload.creep_damage or 0)
                        self.bonus_all_stats = tonumber(shmotload.all_stats or 0)
                        self.bonus_status_resistance = tonumber(shmotload.status_resistance or 0)
                        self.bonus_health_percent = tonumber(shmotload.health_percent or 0)
                        self.bonus_spell_range = tonumber(shmotload.spell_range or 0)
                        self.bonus_movement_speed = tonumber(shmotload.movement_speed or 0)
                        self.bonus_armor = tonumber(shmotload.armor or 0)
                        self.bonus_hp = tonumber(shmotload.hp or 0)
                        self.bonus_mp = tonumber(shmotload.mp or 0)
                        self.bonus_cooldown_reduction = tonumber(shmotload.cooldown_reduction or 0)
                        self.bonus_spell_amplify = tonumber(shmotload.spell_amplify or 0)
                        self.bonus_spell_lifesteal = tonumber(shmotload.spell_lifesteal or 0)
                        self.bonus_strength = tonumber((shmotload.strength or 0) + (shmotload.all_stats or 0))
                        self.bonus_intellect = tonumber((shmotload.intellect or 0) + (shmotload.all_stats or 0))
                        self.bonus_agility = tonumber((shmotload.agility or 0) + (shmotload.all_stats or 0))

                        local hero = self:GetCaster()
                        if hero ~= nil and hero:IsNull() == false and hero.CalculateStatBonus then
                            hero:CalculateStatBonus(false)
                        end
                    end
                end
            end
        end
    end
end



function modifier_custom_shmot_attr:GetModifierHealthBonus()
    return self.bonus_hp
end

function modifier_custom_shmot_attr:GetModifierManaBonus()
    return self.bonus_mp
end

function modifier_custom_shmot_attr:GetModifierPreAttack_BonusDamage()
    return self.bonus_damage
end

function modifier_custom_shmot_attr:GetModifierAttackSpeedBonus_Constant()
    return self.bonus_attack_speed
end

function modifier_custom_shmot_attr:GetModifierSpellAmplify_Percentage()
    return self.bonus_spell_amplify
end

function modifier_custom_shmot_attr:GetModifierPercentageCooldown()
    return self.bonus_cooldown_reduction
end

function modifier_custom_shmot_attr:GetModifierSpellLifesteal()
    return self.bonus_spell_lifesteal
end

function modifier_custom_shmot_attr:GetModifierAttackSpeedBonus_Constant()
    return self.bonus_attack_speed
end

function modifier_custom_shmot_attr:GetModifierBonusStats_Strength()
        return self.bonus_strength
end

function modifier_custom_shmot_attr:GetModifierBonusStats_Agility()
        return self.bonus_agility
end

function modifier_custom_shmot_attr:GetModifierBonusStats_Intellect()
        return self.bonus_intellect
end

function modifier_custom_shmot_attr:GetModifierMoveSpeedBonus_Constant()
    return self.bonus_movement_speed
end

function modifier_custom_shmot_attr:GetModifierPhysicalArmorBonus()
    return self.bonus_armor
end

function modifier_custom_shmot_attr:GetModifierCastRangeBonusStacking()
    return self.bonus_spell_range
end

function modifier_custom_shmot_attr:GetModifierStatusResistanceStacking()
    return self.bonus_status_resistance
end

function modifier_custom_shmot_attr:GetModifierExtraHealthPercentage()
    return self.bonus_health_percent
end

function modifier_custom_shmot_attr:OnAttackLanded(keys)
    if not IsServer() then return end

    local parent = self:GetParent()
    local attacker = keys.attacker
    local target = keys.target

     if parent == nil or attacker == nil or target == nil then return end

    if attacker == parent then
        if self.bonus_hit_hp > 0 then
            parent:Heal(self.bonus_hit_hp, nil)
        end

        if self.bonus_hit_mp > 0 then
            parent:GiveMana(self.bonus_hit_mp)
        end
    end
end

function modifier_custom_shmot_attr:GetModifierTotalDamageOutgoing_Percentage(keys)
    local damagePercentage = 100
    local parent = self:GetParent()
    local attacker = keys.attacker or nil
    local target = keys.target or nil
    if parent == nil or attacker == nil or target == nil then
        return damagePercentage
    end

    if attacker ~= parent then 
        return damagePercentage
    end

    if target.IsCreep ~= nil and target:IsCreep() then
        return damagePercentage + self.bonus_creep_damage
    end
    
    return damagePercentage
end