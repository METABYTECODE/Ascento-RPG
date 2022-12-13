LinkLuaModifier("modifier_generic_base_attack_time", "abilities/generic/modifier_generic_base_attack_time.lua", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
modifier_generic_base_attack_time = class({})
--[[
KV (default):
    isPurgable (1)
    interval (1)
    duration (0)
    as_slow (0), flat, positive means slower
    ms_slow (0), percentage, positive means slower
    dps (0), damage per second, not per interval
]]

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_base_attack_time:IsHidden()
    return true
end

function modifier_generic_base_attack_time:IsDebuff()
    return false
end

function modifier_generic_base_attack_time:IsPurgable()
    return false
end

-- Optional Classifications
function modifier_generic_base_attack_time:IsStunDebuff()
    return false
end

function modifier_generic_base_attack_time:RemoveOnDeath()
    return false
end

function modifier_generic_base_attack_time:DestroyOnExpire()
    return false
end

function modifier_generic_base_attack_time:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_generic_base_attack_time:OnCreated( kv )

    if not IsServer() then return end
    -- send init data from server to client
    self:SetHasCustomTransmitterData( true )

    -- get data
    self.bsa = kv.bsa or 0

    -- Start interval
    self:StartIntervalThink( 1 )
    self:OnIntervalThink()
end

function modifier_generic_base_attack_time:OnRefresh( kv )
    
end

function modifier_generic_base_attack_time:OnRemoved()
end

function modifier_generic_base_attack_time:OnDestroy()
end

function modifier_generic_base_attack_time:AddCustomTransmitterData()
    -- on server
    local data = {
        bsa = self.bsa,
    }

    return data
end

function modifier_generic_slowed_lua:HandleCustomTransmitterData( data )
    -- on client
    self.bsa = data.bsa
end

function modifier_generic_slowed_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
    }

    return funcs
end

function modifier_ranger_1_heavy_bolts:GetModifierBaseAttackTimeConstant()
    return self.bsa
end

