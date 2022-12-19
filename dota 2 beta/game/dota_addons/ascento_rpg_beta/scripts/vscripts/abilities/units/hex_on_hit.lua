hex_on_hit = class({
    GetIntrinsicModifierName = function()
		return "modifier_hex_on_hit"
	end
})

modifier_hex_on_hit = class({
    IsHidden = function()
        return true
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
	IsDebuff = function()
		return false
	end,
    DeclareFunctions = function()
        return {
		    MODIFIER_EVENT_ON_ATTACK_LANDED,
        }
    end
})

function modifier_hex_on_hit:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self:OnRefresh()
end

function modifier_hex_on_hit:OnRefresh()
    self.duration = self.ability:GetSpecialValueFor("duration")
end

function modifier_hex_on_hit:OnAttackLanded(kv)
    if self.parent ~= kv.attacker then
        return
    end
    
    local target = kv.target
    if self.ability:IsCooldownReady() then
        target:AddNewModifier(target, self,"modifier_hex_on_hit_debuff",{duration = self.duration})
        EmitSoundOn("MountainItem.ScytheOfVyse.Cast", target)
        self.ability:StartCooldown(self.ability:GetEffectiveCooldown(self.ability:GetLevel()-1))
    end
end

modifier_hex_on_hit_debuff = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
        return false
    end,
	IsDebuff = function()
		return false
	end,
	CheckState = function()
		return {
			[MODIFIER_STATE_MUTED] = true,
            [MODIFIER_STATE_SILENCED] = true,
            [MODIFIER_STATE_DISARMED] = true
		}
	end,
    DeclareFunctions = function()
        return {
		    MODIFIER_PROPERTY_MODEL_CHANGE,
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
        }
    end,
    GetModifierModelChange = function()
       return "models/props_gameplay/pig.vmdl" 
    end,
    GetModifierMoveSpeedBonus_Percentage = function()
        return -100
     end
})

function modifier_hex_on_hit_debuff:OnCreated()
end

function modifier_hex_on_hit_debuff:CheckState()
    return {    
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_DISARMED] = true
    }
end

LinkLuaModifier("modifier_hex_on_hit", "abilities/units/hex_on_hit", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_hex_on_hit_debuff", "abilities/units/hex_on_hit", LUA_MODIFIER_MOTION_NONE)