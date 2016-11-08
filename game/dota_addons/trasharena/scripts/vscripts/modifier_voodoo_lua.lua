modifier_voodoo_lua = class({})

--[[Author: Noya, Pizzalol
	Date: 27.09.2015.
	Changes the model, reduces the movement speed and disables the target]]
function modifier_voodoo_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_STATE_ATTACK_IMMUNE
	}

	return funcs
end

function modifier_voodoo_lua:GetModifierModelChange()
	return "models/props_gameplay/frog.vmdl"
end

function modifier_voodoo_lua:GetModifierMoveSpeedOverride()
	return 200;
end

function modifier_voodoo_lua:CheckState()
	local state = {
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_HEXED] = true,
	[MODIFIER_STATE_MUTED] = true,
	[MODIFIER_STATE_EVADE_DISABLED] = true,
	[MODIFIER_STATE_BLOCK_DISABLED] = true,
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_ATTACK_IMMUNE] = true
	}

	return state
end

function modifier_voodoo_lua:IsHidden() 
	return false
end