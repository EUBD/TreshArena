modifier_winner_duel_lua = class({})

--------------------------------------------------------------------------------

function modifier_winner_duel_lua:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
	return funcs
end

function modifier_winner_duel_lua:GetIntrinsicModifierName( ) 
	return "duel"
end

function modifier_winner_duel_lua:GetTexture()
	return "my_icon"
end

--------------------------------------------------------------------------------

function modifier_winner_duel_lua:GetModifierMoveSpeedBonus_Percentage( params )
	return 25
end

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------

