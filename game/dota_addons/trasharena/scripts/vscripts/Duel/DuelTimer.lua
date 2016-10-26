if DuelTeleport == nil then
	_G.DuelTeleport = class({})
end

require( "DuelTeleport" )


function DuelTimer:StartTimerDuel()

  
	GameRules:GetGameModeEntity():SetThink(DuelTeleport:TeleporTeams)

end