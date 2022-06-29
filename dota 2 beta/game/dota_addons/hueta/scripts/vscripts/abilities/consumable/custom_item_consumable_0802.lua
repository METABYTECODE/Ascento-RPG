require 'client'
custom_item_consumable_0802 = CustomItemSpellSystem:GetBaseClass()

local public = custom_item_consumable_0802

function public:OnCustomSpellStart(item)
    local caster = self:GetCaster()
    if IsNull(item) or IsNull(caster) then
        return
    end
    local health_regen_pct = item:GetSpecialValueFor("health_regen_pct")
    caster:ModifyCustomAttribute("health_regen_pct", "item_consumable_0802", health_regen_pct)
    caster:AddConsumableUseCount("item_consumable_0802")
end