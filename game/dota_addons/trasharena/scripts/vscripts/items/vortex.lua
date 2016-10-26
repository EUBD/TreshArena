local projectiles = require("heroes/projectiles")

function GetDamagePercent(caster, ability)
	local summ_pct = ability:GetSpecialValueFor("damage_percent")
	local damage_decreased = 1
	--local damageL_decreased = 2
	--if caster:GetUnitName() == "npc_dota_hero_storm_spirit" then
	--	damageL_decreased = 3
	--end
	local n = 1
	for i = 0, 5 do
		local item = caster:GetItemInSlot(i)
		if item and item ~= ability  and item:GetName() == ability:GetName() then
			n = n + 1;
		end
	end
	summ_pct = (ability:GetSpecialValueFor("damage_percent")/n);

	return summ_pct
end

function HolyBook_attack( keys )
	local caster = keys.caster
	print(caster:GetTeamNumber());
	local damageBlade = keys.DamageBlade;
	if caster and not caster:IsRealHero() then return end
	local target = keys.target
	local ability = keys.ability
	local position = keys.target:GetAbsOrigin()
	local team = keys.target:GetOpposingTeamNumber()  
	local radius = keys.Radius
	local damage_percent = GetDamagePercent(caster, ability)--keys.ability:GetLevelSpecialValueFor( "damageL_percent", keys.ability:GetLevel() - 1 )
	
	local damageL = keys.Damage*(damage_percent/100)
	local fly_time
	local projectile_temp = projectiles[caster:GetUnitName()]
	local projectile_model, projectile_speed
	
	if projectile_temp then
		projectile_model = projectile_temp.model
		projectile_speed = projectile_temp.speed
	else
		projectile_model = ""
		projectile_speed = 2000
	end

	local damageL_int_pct_add = 1

	if caster:IsRealHero() then
		damageL_int_pct_add = caster:GetIntellect()
		damageL_int_pct_add = damageL_int_pct_add / 16 / 100 + 1
	end 

	damageL = damageL / damageL_int_pct_add


	local units = FindUnitsInRadius(team, position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false) 
	local caster_attack_speed = caster:GetAttacksPerSecond()

	for _, x in pairs(units) do
		if x ~= keys.target then
			if x and caster and x:GetTeamNumber() ~= caster:GetTeamNumber() and IsValidEntity(x) and x:IsAlive() then
				
				if projectile_model and caster_attack_speed < 8 then
					local info = {
	      				Target = x,
        				Source = keys.target,
        				EffectName = projectile_model,
	        			bDodgeable = false,
        				bProvidesVision = true,
        				iMoveSpeed = projectile_speed,
        				iVisionRadius = 0,
        				iVisionTeamNumber = caster:GetTeamNumber(),
	    			}
    				ProjectileManager:CreateTrackingProjectile( info )
    				fly_time = FindDistance(x:GetAbsOrigin(), position) / projectile_speed
    			else
	    			fly_time = 0.1
   				end

			
   				local damageTable = {
					victim = x,
					attacker = caster,
					damage = damageL,
					damage_type = DAMAGE_TYPE_PURE,
				}
		
   				ApplyDamage(damageTable);
   			
			end
			
		end
	end
end

function FindDistance(vec1, vec2)
	return math.sqrt(math.abs(vec1.x - vec2.x)^2 + math.abs(vec1.y - vec2.y)^2 + math.abs(vec1.z - vec2.z)^2 )
end