function mana_regen( keys )
	local mana = (keys.target:GetMaxMana() / 100) * keys.ability:GetSpecialValueFor("mana_per_second_x")
	keys.target:GiveMana(mana)
end