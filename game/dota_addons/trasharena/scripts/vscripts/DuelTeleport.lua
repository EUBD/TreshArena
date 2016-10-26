if DuelTeleport == nil then
	_G.DuelTeleport = class({})
end

_G.DireTpPoint = "TpDuelDier"
_G.RadiantTpPoint = "TpDuelRadiant"
_G.DireTeam = 3
_G.RadiantTeam = 2
_G.IntervalDuel = 50
_G.TimeDuel = 30
_G.isDuel = false



function DuelTeleport:Start()
	TeleporTeams();
end

function TeleporTeams()
		
	print("Teleport");
	isDuel = true;

	Timers:CreateTimer(2, function() CustomGameEventManager:Send_ServerToAllClients("display_timer", {msg="Finish", duration=TimeDuel-2, mode=0, endfade=false, position=0, warning=5, paused=false, sound=true} ) return nil end);

	TeleportDire();
	TeleportRadiant();

Timers:CreateTimer(TimeDuel, function() TeleportToEnd() return nil end);

end


function TeleportToEnd()
	if(isDuel) then
		TeleportRadiantToEnd();
		TeleportDireToEnd();
		isDuel = false;
		DuelTimer:StartTimerDuel();
	end
	return nil
end

function TeleportRadiantToEnd()
	local RadiantTeam = GetTableplayers(RadiantTeam);
	if(RadiantTeam == nill) then return nil; end
	for _,player in pairs(RadiantTeam) do

		if(player:IsAlive()) then
			
			if(player.saved) then
				RestoreHero(player);
        	end
     	end

     end

	print("TeleportEnd");
end

function TeleportDireToEnd()
	local DireTeam = GetTableplayers(DireTeam);
	if(DireTeam == nill) then return nil; end
	for _,player in pairs(DireTeam) do

		if(player:IsAlive()) then
			if(player.saved) then
				RestoreHero(player);
     			
     		end
		end
     end

	print("TeleportEnd");
end

function TeleportRadiant()
	local DuelTpEntRadiant = Entities:FindByName(nil,RadiantTpPoint);
	local DuelTpPointRadiant = DuelTpEntRadiant:GetAbsOrigin();
	local RadiantTeam = GetTableplayers(RadiantTeam);
	local counter=0;
	if(RadiantTeam == nill) then   
	  DuelTeleport:WinTeam(DireTeam);
	  return nil; 
	end
	for _,player in pairs(RadiantTeam) do

		if(player:IsAlive()) then	
			counter = counter + 1;	
			SaveAbout(player);
			maxMod(player);
			Teleport(player,DuelTpPointRadiant);
     	end

     end

     if(counter == 0) then
     	--DuelTeleport:WinTeam(DireTeam);
     end

end

function TeleportDire()
	local DuelTpEntDire = Entities:FindByName(nil,DireTpPoint);
	local DuelTpPointDire = DuelTpEntDire:GetAbsOrigin();
	local DireTeam = GetTableplayers(DireTeam);
	local counter=0;
	if(DireTeam == nill) then  
		
		return nil; 
	end

	for _,player in pairs(DireTeam) do

		if(player:IsAlive()) then
			counter = counter + 1;
			SaveAbout(player);
			maxMod(player);
			Teleport(player,DuelTpPointDire);
     	end

     end

     if(counter == 0) then
     	--DuelTeleport:WinTeam(RadiantTeam);
     end

end


function DuelTeleport:WinTeam(TeamNumber)

	if(TeamNumber == DireTeam) then
		print("Winner Dier")
		TeleportToEnd();
	else
		print("Winner Radiant")
		TeleportToEnd();
	end

end

function DuelTeleport:IskilledAllTeam(TeamNumber)
	print(" ---------------------------- Begin IsKelled ------------------------------")
	local TableDire = {};
	local TableRadiant = {};
	local i = 0;
	local j =0;
	local Tableusers = HeroList:GetAllHeroes();
	if(TeamNumber == DireTeam ) then

		for _, hero in pairs(Tableusers) do
			if(hero:GetTeamNumber() == DireTeam) then
				if(hero:IsAlive() and hero.saved == true) then
					i = i+1;
				end
			end 
		end
							print(" ---------------------------- DIre ------------------------------ "..i);
				if(i>0) then

			return false;
		else
			return true;
		end

	else

		for _, hero in pairs(Tableusers) do
			print(i.." - heroType = "..hero:GetTeamNumber())
			if(hero:GetTeamNumber() == RadiantTeam) then
				if(hero:IsAlive() and hero.saved == true) then
					j = j+1;
				end
			end 
		end 
							print(" ---------------------------- Radiant ------------------------------ "..j);
		if(j>0) then
			return false;
		else
			return true;
		end

	end
end


function GetTableplayers(TeamNumber)

	local TableDire = {};
	local TableRadiant = {};
	local i = 1;
	local Tableusers = HeroList:GetAllHeroes();
	if(TeamNumber == DireTeam ) then

		for _, hero in pairs(Tableusers) do
			if(hero:GetTeamNumber() == DireTeam) then
				TableDire[i] = hero;
				i = i+1;
			end 
		end
		print("hero from Dire - "..(i-1));
		return TableDire;

	else

		i = 1;
		for _, hero in pairs(Tableusers) do
			print(i.." - heroType = "..hero:GetTeamNumber())
			if(hero:GetTeamNumber() == RadiantTeam) then
				TableRadiant[i] = hero;
				i = i+1;
			end 
		end 
		print("hero from Radiant - "..(i-1));
		return TableRadiant;


	end
end


function Teleport(hero,point)

	hero:SetAbsOrigin(point);
    FindClearSpaceForUnit(hero, point, false);
    hero:Stop();
    PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),hero);
   Timers:CreateTimer(0.1, function() PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),nil) return nil end);

end


function maxMod(hero)
	
	hero:SetHealth(hero:GetMaxHealth());
	hero:SetMana(hero:GetMaxHealth());
end

function SaveAbout(hero) 

hero.position = hero:GetAbsOrigin()
hero.mana = hero:GetMana()
hero.hp = hero:GetHealth()
hero.saved = true

--[[local count = hero:GetAbilityCount()
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
]]
DeepPrintTable(hero)
print("saved")
end

function RestoreHero(hero) --восстановить кдшки, хп, ману и позиция героя после дуэли
	if hero.saved then
		local position = hero.position
		local hp = hero.hp
		local mana = hero.mana
		hero.saved = false
		hero:SetHealth(hp)
		Teleport(hero,position);
		--[[local count = hero:GetAbilityCount()
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
			end]]
	end
end