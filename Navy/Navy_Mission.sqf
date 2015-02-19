#include "Navy_Macros.h"

#define UNIT_TEMPLATE "NATO_WOODLAND" // This should match the admiral template name

Navy_Timeline =
{
	
	//[navy_spawn_trigger_1,Navy_Wave_1] call Navy_RunMission;
	//sleep 6;
	[navy_spawn_trigger_1,Navy_Wave_2] call Navy_RunMission;
	
	DEBUG
	{
		[["Timeline finished spawning"]] call Navy_Debug_HintRPT;
	};
};

Navy_Wave_1 =
{
	FUN_ARGS_1(_spawn_trigger);
	[UNIT_TEMPLATE,"O_Heli_Transport_04_covered_F",8,_spawn_trigger,heli_insert_item,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
};

Navy_Wave_2 =
{
	FUN_ARGS_1(_spawn_trigger);
	[UNIT_TEMPLATE,"B_Heli_Attack_01_F",_spawn_trigger,heli_insert_item,cleanup_item,attack_item] spawn Navy_RunCASPatrol;
};

Navy_RunMission =
{
	FUN_ARGS_2(_spawn_trigger,_mission_name);
	WAIT_DELAY(1,triggerActivated _spawn_trigger);
	//[_spawn_trigger] call Navy_InitTrigger; // Uncomment for debugging
	[_spawn_trigger] call _mission_name;
};