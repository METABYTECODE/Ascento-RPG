item_tp_scroll_custom = class({})

function item_tp_scroll_custom:Precache(context)
    PrecacheResource("particle", "particles/items2_fx/teleport_start.vpcf", context)
    PrecacheResource("particle", "particles/items2_fx/teleport_end.vpcf", context)
end

function item_tp_scroll_custom:OnSpellStart()
    local caster = self:GetCaster()
    Teleports:OpenTeleportsWindowForPlayer(caster:GetPlayerOwnerID(), true)
end

function item_tp_scroll_custom:OnLocationSelected(location)
    local caster = self:GetCaster()
    caster:BeginChannel(
        self:GetChannelTime(), 
        location, 
        GetAbilityTextureNameForAbility(self:GetAbilityName()), 
        0, 
        function()
            self:PlayTeleportEffects(caster, location)
        end,
        function() end, 
        function(isInterrupt)
            self:DestroyTeleportEffects(caster, location)
            if(isInterrupt) then
                return
            end
            EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "TeleportScroll.Hero_Disappear", caster)
            FindClearSpaceForUnit(caster, location, true)
            caster:AddNewModifier(caster, nil, "modifier_phased", {duration = 0.01})
            caster:Interrupt()
            CenterCameraOnUnit(caster:GetPlayerOwnerID(), caster)
            EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "TeleportScroll.Hero_Appear", caster)
        end
    )
end

function item_tp_scroll_custom:PlayTeleportEffects(caster, location)
    local channelTime = self:GetChannelTime()
    local casterTeam = caster:GetTeamNumber()
    MinimapEvent(casterTeam, caster, location.x, location.y, DOTA_MINIMAP_EVENT_TEAMMATE_TELEPORTING, channelTime)
    StartSoundEvent("TeleportScroll.Loop_Disappear", caster)
    self._thinker = CreateModifierThinker(
        caster, 
        self, 
        "modifier_phased", 
        {
            duration = -1
        }, 
        location, 
        casterTeam, 
        false
    )
    StartSoundEvent("TeleportScroll.Loop_Appear", self._thinker)
    local playerColor = PlayerResource:GetPlayerColor(caster:GetPlayerOwnerID())
    self._startParticle = ParticleManager:CreateParticle(
        "particles/items2_fx/teleport_start.vpcf", 
        PATTACH_WORLDORIGIN, 
        caster
    )
	ParticleManager:SetParticleControl(self._startParticle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self._startParticle, 2, playerColor)
	ParticleManager:SetParticleControl(self._startParticle, 3, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self._startParticle, 4, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self._startParticle, 5, Vector(3,0,0))
	ParticleManager:SetParticleControl(self._startParticle, 6, caster:GetAbsOrigin())
    self._endParticle = ParticleManager:CreateParticle(
        "particles/items2_fx/teleport_end.vpcf", 
        PATTACH_WORLDORIGIN, 
        caster
    )
	ParticleManager:SetParticleControl(self._endParticle, 0, location)
	ParticleManager:SetParticleControl(self._endParticle, 1, location)
    ParticleManager:SetParticleControl(self._endParticle, 2, playerColor)
    ParticleManager:SetParticleControlEnt(self._endParticle, 3, caster, PATTACH_CUSTOMORIGIN, "attach_hitloc", location, false)
	ParticleManager:SetParticleControl(self._endParticle, 5, location)
	ParticleManager:SetParticleControl(self._endParticle, 4, Vector(1,0,0))
    self._fowViewer = AddFOWViewer(casterTeam, location, caster:GetModelRadius(), channelTime, false)
end

function item_tp_scroll_custom:DestroyTeleportEffects(caster, location)
    MinimapEvent(caster:GetTeamNumber(), caster, location.x, location.y, DOTA_MINIMAP_EVENT_TEAMMATE_TELEPORTING, -1)
    StopSoundEvent("TeleportScroll.Loop_Disappear", caster)
    StopSoundOn("TeleportScroll.Loop_Appear", self._thinker)
    UTIL_Remove(self._thinker)
    ParticleManager:DestroyParticle(self._startParticle, false)
    ParticleManager:ReleaseParticleIndex(self._startParticle)
    ParticleManager:DestroyParticle(self._endParticle, false)
    ParticleManager:ReleaseParticleIndex(self._endParticle)
    RemoveFOWViewer(caster:GetTeamNumber(), self._fowViewer)
end