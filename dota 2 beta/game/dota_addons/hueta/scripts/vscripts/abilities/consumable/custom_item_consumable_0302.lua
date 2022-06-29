require 'client'
custom_item_consumable_0302 = CustomItemSpellSystem:GetBaseClass()

local public = custom_item_consumable_0302

function public:OnCustomSpellStart(item)
    local caster = self:GetCaster()
    if IsNull(item) or IsNull(caster) then
        return
    end
    caster:ModifyCustomAttribute("agi", "item_consumable_0302", item:GetSpecialValueFor("agility"))
    caster:AddConsumableUseCount("item_consumable_0302")
end