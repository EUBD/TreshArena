local forbidden_modifiers_list = {
	"modifier_sniper_machine_gun",
}

function HasForbiddenModifier(unit)
	for _, modifier_name in pairs(forbidden_modifiers_list) do
		if unit:HasModifier(modifier_name) then 
			return true 
		end
	end

	return false
end

function Bash(keys)
	local caster 			= keys.caster
	local target 			= keys.target
	local ability 			= keys.ability
	local modifier_name 	= keys.ModifierName
	local cooldown			= keys.Cooldown or 0
	local cooldown_modifier = keys.CooldownModifier
	ability:ApplyDataDrivenModifier(caster, target, modifier_name, {})

end