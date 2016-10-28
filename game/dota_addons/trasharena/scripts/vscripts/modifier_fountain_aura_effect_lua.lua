modifier_fountain_aura_effect_lua = class({})

--------------------------------------------------------------------------------

function modifier_fountain_aura_effect_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
	return funcs
end

function modifier_fountain_aura_effect_lua:GetTexture()
	return "rune_regen"
end

--------------------------------------------------------------------------------

function modifier_fountain_aura_effect_lua:GetModifierMoveSpeedBonus_Percentage( params )
	return 10;
end
--------------------------------------------------------------------------------

