modifier_special_hardcore = class ({})

function modifier_special_hardcore:IsHidden()
    return true
end

function modifier_special_hardcore:IsDebuff()
    return false
end

function modifier_special_hardcore:RemoveOnDeath() return false end
function modifier_special_hardcore:IsPurgable() return false end
function modifier_special_hardcore:IsPurgeException() return false end

function modifier_special_hardcore:GetTexture() return "special_hardcore" end

function modifier_special_hardcore:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
 
    return funcs
end

function modifier_special_hardcore:GetModifierSpellAmplify_Percentage( params )
    return math.floor(self:GetParent():GetLevel() / 10)
end

function modifier_special_hardcore:GetModifierPhysicalArmorBonus( params )
    local heroArmor = self:GetParent():GetPhysicalArmorBaseValue()
    if heroArmor > 0 then
        return heroArmor * 0.2
    else
        return 0
    end
    
end

