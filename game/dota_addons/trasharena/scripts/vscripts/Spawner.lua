if Spawner == nil then
	_G.Spawner = class({})
end
_G.nMaxCreeps = 10
_G.quantity = {}
_G.CreepsLow = {"Creep_base","Creep_base_2","Creep_base_3"}

_G.CreepsMiddle = {"Creep_swamp_1","Creep_swamp_2","Creep_swamp_3"}

_G.CreepsHighDesrt = {"Creep_desert_1","Creep_desert_2","Creep_desert_3","Creep_desert_4"}

_G.CreepsHighWinter = {"Creep_winter_1","Creep_winter_2","Creep_winter_3","Creep_winter_4"}

_G.TriggerType = {"lowSpawn","middleSpawn","highSpawnDesrt","highSpawnWinter"}

_G.NcripsInStack = 4

	function Spawner:StartSpawn()
		GameRules:GetGameModeEntity():SetThink(Spawn)
		
	end

function Spawn()
	print("SPAWN");
	local Ncreeps = NcripsInStack;
	local CreespTable = {CreepsLow,CreepsMiddle,CreepsHighDesrt,CreepsHighWinter};
	local  NumberSpawn = 0;
	for k = 1,#TriggerType do
		local Table = Entities:FindAllByName(TriggerType[k]);
		for j = 1,#Table do
			NumberSpawn = NumberSpawn + 1;
	 		local npc = Table[j];
	 		local point = npc:GetAbsOrigin()
	 		local CreepsName = GetCreepsname(CreespTable[k]);
	 		print(CreepsName);
	 		for i=1,Ncreeps do

	 			if(quantity[NumberSpawn] == nil) then quantity[NumberSpawn] = 0; end

	 			if(quantity[NumberSpawn] <= nMaxCreeps) then
	 				quantity[NumberSpawn] = quantity[NumberSpawn] + 1;
	 	 			local current = CreateUnitByName(CreepsName, point, true, nil, nil, DOTA_TEAM_NEUTRALS)
	 				current.targetname = NumberSpawn;
	 			else
	 				break;
	 			end
	 		end
		end
	end
 print("Spawn");
return nCREATURE_RESPAWNBOSS_TIME;
end


function GetCreepsname(Table)
	local size = #Table;
	local i = math.random(1,size);
	return Table[i];
end