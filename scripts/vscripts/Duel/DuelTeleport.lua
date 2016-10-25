

_G.DireTpPoint = "TpDuelDier"
_G.RadiantTpPoint = "TpDuelRadiant"
_G.DireTeam = 3
_G.RadiantTeam = 2;
_G.IntervalDuel = 350

function DuelTeleport:TeleporTeams()
	TeleportDire();
	TeleportRadiant();
	return IntervalDuel;
end

function TeleportDire()
	local DuelTpPointRadiant = (Entities:FindByName(nil,RadiantTpPoint)):GetAbsOrigin();
	local RadiantTeam = GetTableplayers(RadiantTeam);

	for player,#RadiantTeam do

		if(player.IsAlive()) then
			SaveAbout(player);
			player:SetAbsOrigin(DuelTpPointRadiant);
     		FindClearSpaceForUnit(player, point, false);
     		player:Stop();
     	end

     end

end

function TeleportRadiant()
	local DuelTpPointDire = (Entities:FindByName(nil,DireTpPoint)):GetAbsOrigin();
	local DireTeam = GetTableplayers(DireTeam);

	for player,#DireTeam do

		if(player.IsAlive()) then
			SaveAbout(player);
			player:SetAbsOrigin(DuelTpPointDire);
     		FindClearSpaceForUnit(player, point, false);
     		player:Stop();
     	end

     end


end

function GetTableplayers(TeamNumber)

	local TableDire,TableRadiant;
	local i = 1;
	local Tableysers = GetAllHeroes();
	if(TeamNumber == "Dire") then

		for hero ,#Tableysers do
			if(hero:GetTeamNumber() == DireTeam) then
				TableDire[i] = hero;
				i = i+1;
			end 
		return TableDire;

	else

		i = 1;
		for hero ,#Tableysers do
			if(hero:GetTeamNumber() == DireTeam) then
				TableRadiant[i] = hero;
				i= i+1;
			end 
		return TableRadiant;

	end
end

function SaveAbout(hero) 

hero.position = hero:GetAbsOrigin()
hero.mana = hero:GetMana()
hero.hp = hero:GetHealth()
hero.saved = true

local count = hero:GetAbilityCount()
--GetCooldownTimeRemaining()
		for i = 0, count do
		 local ability = hero:GetAbilityByIndex(i)
		 if ability:GetLevel() == 0 then hero.ability[i] = nil 
			else
				if ability and not ability:IsCooldownReady() then
					hero.ability[i] = ability:GetCooldownTimeRemaining()
		 end
		end
	end
DeepPrintTable(hero)
print("saved")
end

function RestorePos(hero) --восстановить кдшки, хп, ману и позиция героя после дуэли
	if hero.saved then
		local position = hero.position
		local hp = hero.hp
		local mana = hero.mana
		hero.saved = false
		hero:SetHealth(hp)
		local count = hero:GetAbilityCount()
		FindClearSpaceForUnit(hero, position, false)
			for i = 0, count do
				 if hero.ability[i] ~= nil then 
					hero:GetAbilityByIndex(i):StartCooldown(hero.ability[i])
				 end
			end
			
		hero.position = nil
		hero.hp = nil
		hero.mana = nil
			for i = 0,5 do
				hero.ability[i] = nil
			end
	end
end