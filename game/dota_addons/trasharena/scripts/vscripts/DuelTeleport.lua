if DuelTeleport == nil then
	_G.DuelTeleport = class({})
end

_G.DireTpPoint = "TpDuelDier"
_G.RadiantTpPoint = "TpDuelRadiant"
_G.DireTeam = 3
_G.RadiantTeam = 2
_G.IntervalDuel = 22
_G.TimeDuel = 12
_G.isDuel = false
_G.IsKillBoss = false;



function DuelTeleport:Start()
	TeleporTeams();
end

function TeleporTeams()
		
	print("Teleport");
	local amtDire, amtRadiant;
	local amtMin;

	
	amtRadiant = getAmtTeam(RadiantTeam);
	amtDire    =  getAmtTeam(DireTeam);

	print("Dire amt "..amtDire.." |||  Radiant amt "..amtRadiant);

	if(amtRadiant == 0 or amtDire == 0) then
		print("Duel not start")
		DuelTimer:StartTimerDuel();
	else

		if(amtDire <= amtRadiant) then
			amtMin = amtDire;
		else
			amtMin = amtRadiant;
		end
		print("Duel start")
		isDuel = true;
		Timers:CreateTimer(2, function()CustomGameEventManager:Send_ServerToAllClients("display_timer", {msg="End", duration=TimeDuel-2, mode=0, endfade=false, position=1, warning=5, paused=false, sound=true}) return nil end);
		Timers:CreateTimer(TimeDuel, function() TeleportToEnd(0) return nil end);
		TeleportDire(amtMin,amtDire);
		TeleportRadiant(amtMin,amtRadiant);
		
	end
end


function TeleportToEnd(TeamNumber)
	if(isDuel) then
		local isWinDire = false;
		local isWinRadiant = false;
		if(TeamNumber == RadiantTeam) then
			isWinRadiant = true;
		end

		if(TeamNumber == DireTeam) then
			isWinDire = true;
		end

		TeleportRadiantToEnd(isWinRadiant);
		TeleportDireToEnd(isWinDire);
		isDuel = false;
		DuelTimer:StartTimerDuel();
	end
	return nil
end

function TeleportRadiantToEnd(isWin)
	local RadiantTeam = GetTableplayers(RadiantTeam);
	if(RadiantTeam == nill) then return nil; end
	for _,player in pairs(RadiantTeam) do
		if(isWin) then
			player:AddNewModifier(player, nil, "modifier_winner_duel_lua", { duration = - 1 })
		else
			player:RemoveModifierByName("modifier_winner_duel_lua");
		end
		if(player:IsAlive()) then	
			if(player.saved) then
				DeleteFrog(player);
				RestoreHero(player);
        	end
     	end

     end

	print("TeleportEnd");
end

function SetFrog(player)
	player:AddNewModifier(player, nil, "modifier_voodoo_lua", { duration = - 1 }) 
	player.isfrog = true;
end

function DeleteFrog(player)
	player:RemoveModifierByName("modifier_voodoo_lua");
	player.isfrog = false;
end

function TeleportDireToEnd(isWin)
	local DireTeam = GetTableplayers(DireTeam);
	if(DireTeam == nill) then return nil; end
	for _,player in pairs(DireTeam) do
		if(isWin) then
			player:AddNewModifier(player, nil, "modifier_winner_duel_lua", { duration = - 1 })
		else
			player:RemoveModifierByName("modifier_winner_duel_lua");
		end
		if(player:IsAlive()) then
			if(player.saved) then
				DeleteFrog(player);
				RestoreHero(player);
     			
     		end
		end
     end

	print("TeleportEnd");
end



function TeleportRadiant(amtMin,amtRadiant)
	local DuelTpEntRadiant = Entities:FindByName(nil,RadiantTpPoint);
	local DuelTpPointRadiant = DuelTpEntRadiant:GetAbsOrigin();
	local RadiantTeam = GetTableplayers(RadiantTeam);
	local counter=1;
	if(amtRadiant == amtMin) then   
		for _,player in pairs(RadiantTeam) do

			if(player:IsAlive() and not player:IsIllusion()) then	
				counter = counter + 1;	
				SaveAbout(player);
				maxMod(player);
				Teleport(player,DuelTpPointRadiant);
     		end

     	end
     else
     	local DuelTeam = {};
     	for i = 1,amtMin do
     		local num = math.random(1,amtRadiant);
     		while(IsInByValue(num,DuelTeam)) do
     			num = math.random(1,amtRadiant);
     		end
     		DuelTeam[i]=num;
     		print("---------------NUM   "..num);
     	end

		for _,player in pairs(RadiantTeam) do
			if(IsInByValue(counter,DuelTeam)) then
				if(player:IsAlive() and not player:IsIllusion()) then
					SaveAbout(player);
					maxMod(player);
					Teleport(player,DuelTpPointRadiant);
     			end
     		else
     			if(player:IsAlive() and not player:IsIllusion()) then
					SaveAbout(player);
					maxMod(player);
					Teleport(player,DuelTpPointRadiant);
     				SetFrog(player);
     			end
     		end
     		counter = counter + 1;
     		
     	end
	end

end

function IsInByValue(key,table)

if(table==nil) then
	return false;
end

	for _,value in pairs(table) do
		if(key==value) then
			return true;
		end
	end

	print("---------------------------IsInByValue -- false")
	return false;
	
end

function TeleportDire(amtMin,amtDire)
	local DuelTpEntDire = Entities:FindByName(nil,DireTpPoint);
	local DuelTpPointDire = DuelTpEntDire:GetAbsOrigin();
	local DireTeam = GetTableplayers(DireTeam);
	local counter=1;
	if(amtDire == amtMin) then   
		for _,player in pairs(DireTeam ) do

			if(player:IsAlive() and not player:IsIllusion()) then	
				counter = counter + 1;	
				SaveAbout(player);
				maxMod(player);
				Teleport(player,DuelTpPointDire);
     		end

     	end
     else
     	local DuelTeam = {};
     	for i = 1,amtMin do
     		local num;
     		num = math.random(1,amtDire);
     		while(IsInByValue(num,DuelTeam)) do
     			num = math.random(1,amtDire);
     		end
     		DuelTeam[i] = num;
     		print("---------------NUM   "..num);
     	end
		
		for _,player in pairs(DireTeam) do
			if(IsInByValue(counter,DuelTeam)) then	
				if(player:IsAlive() and not player:IsIllusion()) then		
					SaveAbout(player);
					maxMod(player);
					Teleport(player,DuelTpPointDire);
     			end
     		else
     			if(player:IsAlive() and not player:IsIllusion()) then
					SaveAbout(player);
					maxMod(player);
					Teleport(player,DuelTpPointDire);
     				SetFrog(player);
     			end
     		end

     		counter = counter + 1;
     	end
	end

end


function DuelTeleport:WinTeam(TeamNumber)

	if(TeamNumber == DireTeam) then
		print("Winner Dire")
			Timers:CreateTimer(1, function()CustomGameEventManager:Send_ServerToAllClients("Show_Winner", {TeamName ="Dire victory"} ) return nil end);
		TeleportToEnd(DireTeam);
	else
		print("Winner Radiant")
			Timers:CreateTimer(1, function()CustomGameEventManager:Send_ServerToAllClients("Show_Winner", {TeamName ="Radiant victory"} ) return nil end);
		TeleportToEnd(RadiantTeam);
	end
end



function getAmtTeam(TeamNumber)
 	local TableDire = {};
	local TableRadiant = {};
	local i = 0;
	local j =0;
	local Tableusers = HeroList:GetAllHeroes();
	if(TeamNumber == DireTeam ) then

		for _, hero in pairs(Tableusers) do
			if(hero:GetTeamNumber() == DireTeam) then
				if(hero:IsAlive() and not hero:IsIllusion()) then
					i = i+1;
				end
			end 
		end

			return i;

	else

		for _, hero in pairs(Tableusers) do
			print(i.." - heroType = "..hero:GetTeamNumber())
			if(hero:GetTeamNumber() == RadiantTeam) then
				if(hero:IsAlive() and not hero:IsIllusion()) then
					j = j+1;
				end
			end 
		end 
		return j;

	end
 end

function DuelTeleport:amtKilleTeamNumber(TeamNumber)
	local TableDire = {};
	local TableRadiant = {};
	local i = 0;
	local j =0;
	local Tableusers = HeroList:GetAllHeroes();
	if(TeamNumber == DireTeam ) then

		for _, hero in pairs(Tableusers) do
			if(hero:GetTeamNumber() == DireTeam) then
				if(hero:IsAlive() and not hero:IsIllusion() and hero.saved == true and not hero.isfrog) then
					i = i+1;
				end
			end 
		end

			return i;

	else

		for _, hero in pairs(Tableusers) do
			print(i.." - heroType = "..hero:GetTeamNumber())
			if(hero:GetTeamNumber() == RadiantTeam) then
				if(hero:IsAlive() and not hero:IsIllusion() and hero.saved == true and not hero.isfrog) then
					j = j+1;
				end
			end 
		end 
		return j;

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
	hero.mana = hero:GetMana();
	hero.hp = hero:GetHealth();
	hero.KdTable = SaveAbilitiesCooldowns(hero);
	hero.saved = true;


	DeepPrintTable(hero);
	print("saved");
end

function RestoreHero(hero) --восстановить кдшки, хп, ману и позиция героя после дуэли
	if hero.saved then
		local position = hero.position;
		local hp = hero.hp;
		local mana = hero.mana;
		hero.saved = false;
		hero:SetHealth(hp);
		SetAbilitiesCooldowns(hero,hero.KdTable);
		Teleport(hero,position);
	end
end

function SaveAbilitiesCooldowns(unit)
    if not unit then return end
   
    local savetable = {}
    local abilities = unit:GetAbilityCount() - 1
    for i = 0, abilities do
        if unit:GetAbilityByIndex(i) then
            savetable[i] = unit:GetAbilityByIndex(i):GetCooldownTimeRemaining()
            unit:GetAbilityByIndex(i):EndCooldown() 
        end
    end

    savetable.items = {}

    for i = 0, 5 do
        if unit:GetItemInSlot(i) then
            savetable.items[unit:GetItemInSlot(i)] = unit:GetItemInSlot(i):GetCooldownTimeRemaining() 
            unit:GetItemInSlot(i):EndCooldown();
        end
    end

    return savetable
end

function SetAbilitiesCooldowns(unit, settable)
    local abilities = unit:GetAbilityCount() - 1
    if not settable or not unit then return end
    for i = 0, abilities do
        if unit:GetAbilityByIndex(i) then
            unit:GetAbilityByIndex(i):StartCooldown(settable[i])
            if settable[i] == 0 then 
                unit:GetAbilityByIndex(i):EndCooldown() 
            end
        end
    end

    if settable.items then
        for item, cooldown in pairs(settable.items) do
            if item and IsValidEntity(item) then
                item:EndCooldown() 
                item:StartCooldown(cooldown) 
            end
        end
    end
end