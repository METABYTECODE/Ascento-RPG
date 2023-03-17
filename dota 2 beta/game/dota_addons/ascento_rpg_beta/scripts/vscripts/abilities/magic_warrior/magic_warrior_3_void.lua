LinkLuaModifier("modifier_magic_warrior_3_void", "abilities/magic_warrior/magic_warrior_3_void.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_magic_warrior_3_void_buff", "abilities/magic_warrior/magic_warrior_3_void.lua", LUA_MODIFIER_MOTION_NONE)

magic_warrior_3_void = class({})

function magic_warrior_3_void:GetIntrinsicModifierName()
    return "modifier_magic_warrior_3_void"
end

modifier_magic_warrior_3_void = class({})

function modifier_magic_warrior_3_void:IsHidden() return true end
function modifier_magic_warrior_3_void:IsDebuff() return false end
function modifier_magic_warrior_3_void:IsPurgable() return false end
function modifier_magic_warrior_3_void:RemoveOnDeath() return false end

function modifier_magic_warrior_3_void:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACKED
    }

    return funcs
end

function modifier_magic_warrior_3_void:OnCreated()
    self.store_damage = self:GetAbility():GetSpecialValueFor("store_damage")
    self.duration_buff = self:GetAbility():GetSpecialValueFor("duration_buff")
end


function modifier_magic_warrior_3_void:OnRefresh( kv )
    self.store_damage = self:GetAbility():GetSpecialValueFor("store_damage")
    self.duration_buff = self:GetAbility():GetSpecialValueFor("duration_buff")
end


function modifier_magic_warrior_3_void:OnAttacked(keys)

    if keys.target == self:GetParent() then -- Check if the attacked unit is the modifier's parent
        local damageTaken = keys.damage -- Get the amount of damage taken
        local duration = self.duration_buff -- The duration of the bonus damage in seconds
        local bonusDamage = damageTaken * self.store_damage -- The amount of bonus damage is 50% of the damage taken

        if self:GetParent():HasModifier("modifier_magic_warrior_3_void_buff") then

            local stackMod = self:GetParent():FindModifierByName("modifier_magic_warrior_3_void_buff")

            stackMod:SetStackCount(bonusDamage)
            stackMod:SetDuration(duration, true)

        else
            local stackMod = self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_magic_warrior_3_void_buff", {})
            
            stackMod:SetStackCount(bonusDamage)
            stackMod:SetDuration(duration, true)
        end
    end
end




modifier_magic_warrior_3_void_buff = class({})

function modifier_magic_warrior_3_void_buff:IsHidden() return false end
function modifier_magic_warrior_3_void_buff:IsDebuff() return false end
function modifier_magic_warrior_3_void_buff:IsPurgable() return false end
function modifier_magic_warrior_3_void_buff:RemoveOnDeath() return false end

function modifier_magic_warrior_3_void_buff:GetTexture() return "magic_warrior_3_void" end

function modifier_magic_warrior_3_void_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }

    return funcs
end

function modifier_magic_warrior_3_void_buff:GetModifierPreAttack_BonusDamage()
    if self:GetStackCount() > 0 then
        return self:GetStackCount() -- Return the bonus damage value set by the OnAttacked function
    else
        return 0
    end
end