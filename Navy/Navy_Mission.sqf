#include "Navy_Macros.h"

#define REINFORCEMENT_AMOUNT 0

Navy_Timeline =
{
	//[] call Navy_StressTest_Paradrop;
	[] call Navy_StressTest_HeliInsert;
	// [] call Navy_StressTest_Combined;
	//["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	DEBUG
	{
		[["Timeline finished spawning"]] call Navy_Debug_HintRPT;
	};
};

Navy_Reinforcement_1 =
{

};