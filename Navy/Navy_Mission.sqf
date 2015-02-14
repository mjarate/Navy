#include "Navy_Macros.h"

#define REINFORCEMENT_AMOUNT 0

Navy_Timeline =
{
	//[] call Navy_StressTest_Paradrop;
	//[] call Navy_StressTest_HeliInsert;
	//[] call Navy_StressTest_HeliInsert_Paradrop;
	//["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	["NATO_WOODLAND","B_Heli_Attack_01_F",spawn_item,cas_patrol_1,cas_patrol_2,cas_patrol_3] spawn Navy_RunCASPatrol;
	DEBUG
	{
		[["Timeline finished spawning"]] call Navy_Debug_HintRPT;
	};
};

Navy_Reinforcement_1 =
{

};