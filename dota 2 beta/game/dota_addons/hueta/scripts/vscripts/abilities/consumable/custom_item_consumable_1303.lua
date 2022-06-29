require 'client'
custom_item_consumable_1303 = CustomItemSpellSystem:GetBaseClass()

local public = custom_item_consumable_1303

function public:OnCustomSpellStart(item)
    local caster = self:GetCaster()
    if IsNull(item) or IsNull(caster) then
        return
    end
    local attack_speed = item:GetSpecialValueFor("attack_speed")
    caster:ModifyCustomAttribute("attack_speed", "item_consumable_1303", attack_speed)
    caster:AddConsumableUseCount("item_consumable_1303")
end