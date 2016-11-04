--------------------------------------------------------------------------------
-- Integer constants
--------------------------------------------------------------------------------
_G.nNEUTRAL_TEAM = 4
_G.nCREATURE_RESPAWN_TIME = 5
_G.nCREATURE_RESPAWNBOSS_TIME = 5


MAX_LEVEL = 80  

XP_PER_LEVEL_TABLE = {0,100}
for i=3,MAX_LEVEL do 
XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1] + 100 * i
end

LinkLuaModifier( "modifier_winner_duel_lua", LUA_MODIFIER_MOTION_NONE )


require( 'DuelTimer')


require( 'DuelTeleport' )


require( 'Events' )


require('Timers')


require('Spawner')

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

function OnEntityKilled (event)
	Events:KillEntity(event)
 end
 
 function SpawnUnit (sCreatureName, vSpawnLoc, vSpawnVector)
	local hUnit = CreateUnitByName(sCreatureName, vSpawnLoc, true, nil, nil, nNEUTRAL_TEAM ) 
	hUnit:SetForwardVector(vSpawnVector)
	hUnit.vSpawnLoc = vSpawnLoc
	hUnit.vSpawnVector = vSpawnVector
 end

function SpawnCreeps()

	Spawner:StartSpawn();
end



function OnStartGame(event)
		print("Detected Event");
		--Timers:CreateTimer(2, function() DuelTimer:StartTimerDuel() return nil end);
end

function Onplayer_death(event)
	print("player_death");
	Events:Onplayer_death(event);
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = CAddonTemplateGameMode()
	GameRules.AddonTemplate:InitGameMode()
	print("allo");
	SpawnCreeps();

	
	ListenToGameEvent("npc_spawned", OnStartGame, nil)
	ListenToGameEvent("player_death", Onplayer_death, nil)
	ListenToGameEvent("entity_killed", OnEntityKilled, nil)

	local allUnits = FindUnitsInRadius(nNEUTRAL_TEAM,
                              Vector(0, 0, 0),
                              nil,
                              FIND_UNITS_EVERYWHERE,
                              DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)	
	print (allUnits)
	for k, hUnit in pairs( allUnits ) do
		hUnit.vSpawnLoc = hUnit:GetOrigin()
		hUnit.vSpawnVector = hUnit:GetForwardVector()
		print (hUnit.vSpawnVector)
	end
end

function CAddonTemplateGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels( true )
    GameRules:GetGameModeEntity():SetCustomHeroMaxLevel( 80 )
    GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )
	GameRules:GetGameModeEntity():SetFountainPercentageHealthRegen( 10 )
	GameRules:GetGameModeEntity():SetFountainPercentageManaRegen( 10 )
	GameRules:GetGameModeEntity():SetFountainConstantManaRegen( 20 )
end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end
