dota_courier = class({})

LinkLuaModifier("dota_courier_god", "modifiers/courier/god_courier", LUA_MODIFIER_MOTION_NONE)

function dota_courier:GetIntrinsicModifierName()
	return "dota_courier_god"
end
dota_courier_god = class({})
function dota_courier_god:IsHidden() return false end
function dota_courier_god:IsDebuff() return false end
function dota_courier_god:IsPurgable() return false end

function dota_courier_god:StatusEffectPriority() return 10 end
function dota_courier_god:OnCreated(keys)
	if IsClient() then return end
end

function dota_courier_god:OnDestroy()
end

function dota_courier_god:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
end
function dota_courier_god:GetAbsoluteNoDamagePhysical() return 1 end
function dota_courier_god:GetAbsoluteNoDamageMagical() return 1 end
function dota_courier_god:GetAbsoluteNoDamagePure() return 1 end