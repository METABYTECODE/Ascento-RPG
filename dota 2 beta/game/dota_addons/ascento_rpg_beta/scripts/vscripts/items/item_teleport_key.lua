item_teleport_key = class({})

function item_teleport_key:OnSpellStart()
    if(not IsServer()) then
        return
    end

    local teleportID = self:GetSpecialValueFor("teleport_id")

    Teleports:SetIsTeleportLocked(teleportID, false)
    Notifications:BottomToAll({item=self:GetAbilityName(), duration = 5.0})
    Notifications:BottomToAll({text="ui_teleports_unlock_item_used", continue = true})
    EmitGlobalSound("TeleportKey.Cast")
    self:Destroy()
end

item_teleport_key_1 = class(item_teleport_key)
item_teleport_key_2 = class(item_teleport_key)
item_teleport_key_3 = class(item_teleport_key)
item_teleport_key_4 = class(item_teleport_key)