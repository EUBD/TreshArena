function Base( keys )
	ability = keys.ability
	caster = keys.caster
	if IsServer() and ability:IsCooldownReady() then
		caster:Heal(caster:GetMaxHealth() * (ability:GetSpecialValueFor("health_regen_prc") / 100 * 0.05),caster)
		caster:GiveMana(caster:GetMaxMana() * (ability:GetSpecialValueFor("mana_regen_prc") / 100 * 0.05))
	end
end

function Cooldown( keys )
	ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))
end