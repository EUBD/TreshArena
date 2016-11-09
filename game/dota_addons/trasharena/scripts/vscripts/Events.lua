if Events == nil then
	_G.Events = class({})
end

_G.DropItems = {"item_piece_old_gods"}
_G.probabilityDrop = 0.1;


function Events:Onplayer_death(event)
	print("player_death");
	if(isDuel) then 
		local mntDire 	 = DuelTeleport:amtKilleTeamNumber(DireTeam)
		local mntRadiant = DuelTeleport:amtKilleTeamNumber(RadiantTeam)

		print("----------------- mntDire - "..mntDire);
		print("----------------- mntRAdiant - "..mntRadiant);

		if(mntDire==0) then
			DuelTeleport:WinTeam(RadiantTeam)
		end

 		if(mntRadiant==0) then
 			DuelTeleport:WinTeam(DireTeam)
 		end

	end
end


function GoOutFromZoneArena(event)
	local hero = event.activator;
	
	if(isDuel) then
		if(event.activator:GetTeamNumber() == RadiantTeam) then
			local Table = Entities:FindAllInSphere(event.activator:GetAbsOrigin(),0.1);
			if(IsInByValue(event.caller,Table)) then
				return;
			end

			local DuelTpEntRadiant = Entities:FindByName(nil,RadiantTpPoint);
			local DuelTpPointRadiant = DuelTpEntRadiant:GetAbsOrigin();
			TeleportE(hero,DuelTpPointRadiant);
		else
			local Table = Entities:FindAllInSphere(event.activator:GetAbsOrigin(),0.1);
			if(IsInByValue(event.caller,Table)) then
				return;
			end
			local DuelTpEntDire = Entities:FindByName(nil,DireTpPoint);
			local DuelTpPointDire = DuelTpEntDire:GetAbsOrigin();
			TeleportE(hero,DuelTpPointDire);
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

function Events:KillEntity(event)
	    local killedEntity = EntIndexToHScript(event.entindex_killed)
		local sCreatureName = killedEntity:GetUnitName()
		local vSpawnLoc = killedEntity.vSpawnLoc
		local vSpawnVector = killedEntity.vSpawnVector
		local Number = killedEntity.targetname; 
		local intNumber = tonumber(Number);
		print(Number);
		Events:Onplayer_death(event);
		if(intNumber ~= nil) then
			if(quantity[intNumber] > 0) then
				quantity[intNumber] = quantity[intNumber] - 1;
			end
		end
	 
	if (IsInByValue(sCreatureName,CreepsLow)) then
		if(probabilityItem(probabilityDrop)) then
		local newItem = CreateItem(DropItems[1], nil, nil)
			newItem:SetPurchaseTime(0)
			CreateItemOnPositionSync(killedEntity:GetOrigin(), newItem)
			newItem:LaunchLoot(false, 300, 0.75, killedEntity:GetOrigin() + RandomVector(RandomFloat(50, 70)))
		end

	end
end

function probabilityItem(persent)
	local border = persent*100;
	local key  = math.random(1,100);

	if(key <= border) then
		return true;
	end

	return false;
		

	

	
end


function KillBossRadiant()
	if(not IsKillBoss) then
		IsKillBoss = true;
		DuelTimer:StartTimerDuel();
	end

	SetItemplayers(RadiantTeam);

end

function KillBossDire()
	if(not IsKillBoss) then
		IsKillBoss = true;
		DuelTimer:StartTimerDuel();
	end

	SetItemplayers(DireTeam);

end


function SetItemplayers(TeamNumber)

	local i = 1;
	local item = "item_blink";
	local Tableusers = HeroList:GetAllHeroes();
	if(TeamNumber == DireTeam ) then

		for _, hero in pairs(Tableusers) do
			if(hero:GetTeamNumber() == DireTeam and not hero:Isillusion()) then
				hero:AddItem(CreateItem(item, hero,hero));
			end 
		end


	else

		for _, hero in pairs(Tableusers) do
			if(hero:GetTeamNumber() == DireTeam and not hero:Isillusion()) then
				hero:AddItem(CreateItem(item, hero,hero));
			end 
		end 


	end
end


function TeleportE(hero,point)
	hero:SetAbsOrigin(point);
    FindClearSpaceForUnit(hero, point, false);
    hero:Stop();
    PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),hero);
   Timers:CreateTimer(0.1, function() PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),nil) return nil end);

end