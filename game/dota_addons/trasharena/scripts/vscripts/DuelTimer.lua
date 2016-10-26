

function DuelTimer:StartTimerDuel()

	CustomGameEventManager:Send_ServerToAllClients("display_timer", {msg="Duel", duration=IntervalDuel, mode=0, endfade=false, position=1, warning=1, paused=false, sound=true} )
	Timers:CreateTimer(IntervalDuel, function() DuelTeleport:Start(); return nil end);

end

function KillBoss()
	DuelTimer:StartTimerDuel();
end


