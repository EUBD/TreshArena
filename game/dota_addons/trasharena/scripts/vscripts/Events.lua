if Events == nil then
	_G.Events = class({})
end

function Events:Onplayer_death(event)
	print("player_death");
	if(isDuel) then 

		if(DuelTeleport:IskilledAllTeam(RadiantTeam)) then
			DuelTeleport:WinTeam(RadiantTeam)
			print("Winner Radiant")
		end

 		if(DuelTeleport:IskilledAllTeam(DireTeam)) then
 			DuelTeleport:WinTeam(DireTeam)
 			print("Winner Dier")
 		end

	end
end


function GoOutFromZoneArena(event)
	DeepPrintTable(event);
	local hero = event.activator;
	if(isDuel) then
		if(event.activator:GetTeamNumber() == RadiantTeam) then
			local DuelTpEntRadiant = Entities:FindByName(nil,RadiantTpPoint);
			local DuelTpPointRadiant = DuelTpEntRadiant:GetAbsOrigin();
			Teleport(hero,DuelTpPointRadiant);
		else
			local DuelTpEntDire = Entities:FindByName(nil,DireTpPoint);
			local DuelTpPointDire = DuelTpEntDire:GetAbsOrigin();
			Teleport(hero,DuelTpPointDire);
		end
	end
end



function Teleport(hero,point)
	hero:SetAbsOrigin(point);
    FindClearSpaceForUnit(hero, point, false);
    hero:Stop();
    PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),hero);
   Timers:CreateTimer(0.1, function() PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),nil) return nil end);

end