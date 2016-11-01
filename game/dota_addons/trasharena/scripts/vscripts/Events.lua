if Events == nil then
	_G.Events = class({})
end

function Events:Onplayer_death(event)
	print("player_death");
	if(isDuel) then 

		if(DuelTeleport:amtKilleTeamNumber(DireTeam)==0) then
			DuelTeleport:WinTeam(RadiantTeam)
		end

 		if(DuelTeleport:amtKilleTeamNumber(RadiantTeam)==0) then
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
			Teleport(hero,DuelTpPointRadiant);
		else
			local Table = Entities:FindAllInSphere(event.activator:GetAbsOrigin(),0.1);
			if(IsInByValue(event.caller,Table)) then
				return;
			end
			local DuelTpEntDire = Entities:FindByName(nil,DireTpPoint);
			local DuelTpPointDire = DuelTpEntDire:GetAbsOrigin();
			Teleport(hero,DuelTpPointDire);
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

function Teleport(hero,point)
	hero:SetAbsOrigin(point);
    FindClearSpaceForUnit(hero, point, false);
    hero:Stop();
    PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),hero);
   Timers:CreateTimer(0.1, function() PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),nil) return nil end);

end