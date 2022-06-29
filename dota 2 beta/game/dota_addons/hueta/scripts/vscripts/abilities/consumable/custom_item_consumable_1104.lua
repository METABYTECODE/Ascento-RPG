require 'client'
custom_item_consumable_1104 = CustomItemSpellSystem:GetBaseClass()

local public = custom_item_consumable_1104

function public:OnCustomSpellStart(item)
    local caster = self:GetCaster()
    if IsNull(item) or IsNull(caster) then
        return
    end
    local spell_amp = item:GetSpecialValueFor("spell_amp")
    caster:ModifyCustomAttribute("spell_amp", "item_consumable_1104", spell_amp)
    caster:AddConsumableUseCount("item_consumable_1104")
end