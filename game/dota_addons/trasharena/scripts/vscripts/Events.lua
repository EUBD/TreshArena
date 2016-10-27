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