modifier_creep_duration = class({
    IsHidden = function()
        return true
    end
})

function modifier_creep_duration :OnCreated()
    self.parent = self:GetParent()
    Timers:CreateTimer(60, function()
        self.parent:ForceKill(true)
    end)
end

LinkLuaModifier( "modifier_creep_duration", 'modifiers/modifier_creep_duration', LUA_MODIFIER_MOTION_NONE )