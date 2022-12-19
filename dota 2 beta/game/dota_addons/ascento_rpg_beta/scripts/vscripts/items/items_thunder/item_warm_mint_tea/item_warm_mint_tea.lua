LinkLuaModifier("modifier_item_warm_mint_tea", "items/items_thunder/item_warm_mint_tea/item_warm_mint_tea.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_warm_mint_tea_buff", "items/items_thunder/item_warm_mint_tea/item_warm_mint_tea.lua", LUA_MODIFIER_MOTION_NONE)

local ItemBaseClass = {
    IsPurgable = function(self) return false end,
    RemoveOnDeath = function(self) return false end,
    IsHidden = function(self) return true end,
    IsStackable = function(self) return false end,
}

local ItemBaseClassBuff = {
    IsPurgable = function(self) return true end,
    RemoveOnDeath = function(self) return true end,
    IsHidden = function(self) return false end,
    IsStackable = function(self) return false end,
}

item_warm_mint_tea = class(ItemBaseClass)
modifier_item_warm_mint_tea = class(item_warm_mint_tea)
modifier_item_warm_mint_tea_buff = class(ItemBaseClassBuff)
-------------
function item_warm_mint_tea:GetIntrinsicModifierName()
    return "modifier_item_warm_mint_tea"
end

function item_warm_mint_tea:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()

    caster:AddNewModifier(caster, self, "modifier_item_warm_mint_tea_buff", {
        duration = 300
    })

    caster:RemoveItem(self)
end

function modifier_item_warm_mint_tea_buff:GetTexture()
    return "warm_mint_tea"
end