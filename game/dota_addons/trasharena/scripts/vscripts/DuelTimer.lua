if DuelTimer == nil then
	_G.DuelTimer = class({})
end

function DuelTimer:StartTimerDuel()

	Timers:CreateTimer(2, function()CustomGameEventManager:Send_ServerToAllClients("display_timer", {msg="Duel", duration=IntervalDuel-2, mode=0, endfade=false, position=1, warning=10, paused=false, sound=true} ) return nil end);

	Timers:CreateTimer(IntervalDuel, function() DuelTeleport:Start(); return nil end);

end

function KillBoss()
	if(not IsKillBoss) then
		IsKillBoss = true;
		DuelTimer:StartTimerDuel();

	end
end


