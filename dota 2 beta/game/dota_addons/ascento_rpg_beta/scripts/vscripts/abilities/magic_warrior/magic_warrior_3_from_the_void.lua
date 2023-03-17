LinkLuaModifier("modifier_magic_warrior_3_from_the_void", "abilities/magic_warrior/magic_warrior_3_from_the_void.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_magic_warrior_3_from_the_void_buff", "abilities/magic_warrior/magic_warrior_3_from_the_void.lua", LUA_MODIFIER_MOTION_NONE)


magic_warrior_3_from_the_void = class({})

function magic_warrior_3_from_the_void:GetIntrinsicModifierName()
    return "modifier_magic_warrior_3_from_the_void"
end

modifier_magic_warrior_3_from_the_void = class({})

function modifier_magic_warrior_3_from_the_void:IsHidden() return true end
function modifier_magic_warrior_3_from_the_void:IsDebuff() return false end
function modifier_magic_warrior_3_from_the_void:IsPurgable() return false end
function modifier_magic_warrior_3_from_the_void:RemoveOnDeath() return false end

function modifier_magic_warrior_3_from_the_void:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACKED
    }

    return funcs
end

function modifier_magic_warrior_3_from_the_void:OnCreated()
    self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
    self.armor_per_stack = self:GetAbility():GetSpecialValueFor("armor_per_stack")
    self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
    self.attack_speed_per_stack = self:GetAbility():GetSpecialValueFor("attack_speed_per_stack")
    self.stack_duration = self:GetAbility():GetSpecialValueFor("stack_duration")

    self:SetStackCount(0)
end


function modifier_magic_warrior_3_from_the_void:OnRefresh( kv )
    self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
    self.armor_per_stack = self:GetAbility():GetSpecialValueFor("armor_per_stack")
    self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
    self.attack_speed_per_stack = self:GetAbility():GetSpecialValueFor("attack_speed_per_stack")
    self.stack_duration = self:GetAbility():GetSpecialValueFor("stack_duration")
end

function modifier_magic_warrior_3_from_the_void:OnAttacked(keys)
    if not IsServer() then return end

    if keys.target ~= self:GetParent() then return end

    if self:GetParent():HasModifier("modifier_magic_warrior_3_from_the_void_buff") then

        local stackMod = self:GetParent():FindModifierByName("modifier_magic_warrior_3_from_the_void_buff")

        local stacks = stackMod:GetStackCount() + 1
        if stacks > self.max_stacks then
            stacks = self.max_stacks
        end

        stackMod:SetStackCount(stacks)
        stackMod:SetDuration(self.stack_duration, true)

    else
        local stackMod = self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_magic_warrior_3_from_the_void_buff", {armor_per_stack = self.armor_per_stack, damage_per_stack = self.damage_per_stack, attack_speed_per_stack = self.attack_speed_per_stack})

        local stacks = stackMod:GetStackCount() + 1
        if stacks > self.max_stacks then
            stacks = self.max_stacks
        end

        stackMod:SetStackCount(stacks)
        stackMod:SetDuration(self.stack_duration, true)
    end
end



modifier_magic_warrior_3_from_the_void_buff = class({})

function modifier_magic_warrior_3_from_the_void_buff:IsHidden() return false end
function modifier_magic_warrior_3_from_the_void_buff:IsDebuff() return false end
function modifier_magic_warrior_3_from_the_void_buff:IsPurgable() return false end
function modifier_magic_warrior_3_from_the_void_buff:RemoveOnDeath() return false end

function modifier_magic_warrior_3_from_the_void_buff:GetTexture() return "magic_warrior_3_from_the_void" end

function modifier_magic_warrior_3_from_the_void_buff:OnCreated(kv)
    self:SetHasCustomTransmitterData( true )

    self.armor_per_stack = kv.armor_per_stack or 0
    self.damage_per_stack = kv.damage_per_stack or 0
    self.attack_speed_per_stack = kv.attack_speed_per_stack or 0
end

function modifier_magic_warrior_3_from_the_void_buff:AddCustomTransmitterData()
    -- on server
    local data = {
        armor_per_stack = self.armor_per_stack,
        damage_per_stack = self.damage_per_stack,
        attack_speed_per_stack = self.attack_speed_per_stack,
    }

    return data
end

function modifier_magic_warrior_3_from_the_void_buff:HandleCustomTransmitterData( data )
    self.armor_per_stack = data.armor_per_stack
    self.damage_per_stack = data.damage_per_stack
    self.attack_speed_per_stack = data.attack_speed_per_stack
end

function modifier_magic_warrior_3_from_the_void_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }

    return funcs
end

function modifier_magic_warrior_3_from_the_void_buff:GetModifierPhysicalArmorBonus()
    return self.armor_per_stack * self:GetStackCount()
end

function modifier_magic_warrior_3_from_the_void_buff:GetModifierBaseDamageOutgoing_Percentage()
    return self.damage_per_stack * self:GetStackCount()
end

function modifier_magic_warrior_3_from_the_void_buff:GetModifierAttackSpeedBonus_Constant()
    return self.attack_speed_per_stack * self:GetStackCount()
end