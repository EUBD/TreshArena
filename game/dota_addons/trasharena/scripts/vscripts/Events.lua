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