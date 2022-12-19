modifier_bash = class({
	IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
    IsDebuff = function()
        return true
    end,
    IsStunDebuff = function()
        return true
    end,
    CheckState = function()
		return {
			[MODIFIER_STATE_STUNNED] = true
		}
	end
})



function modifier_bash:CheckState()
    local state = {
        [MODIFIER_STATE_STUNNED] = true,
        }
    
    return state
end

function modifier_bash:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_bash:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_bash:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

function modifier_bash:GetTexture()
	return "slardar_bash"
end

LinkLuaModifier("modifier_bash", "modifiers/modifier_bash", LUA_MODIFIER_MOTION_NONE)