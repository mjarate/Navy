#include "Navy_Macros.h"

Navy_Timeline =
{
	//[] spawn Navy_Debug_HintCurrentNavyUnits;
	//["NATO_WOODLAND","B_Heli_Light_01_F",getposATL spawn_item,6,true] call Navy_Vehicle_SpawnFilledAirVehicle;
	["NATO_WOODLAND","B_Heli_Light_01_F",6,spawn_item,drop_item,cleanup_item,attack_item] spawn Navy_RunParadrop;
	/*
	DEBUG
	{
		[["Timeline finished running."]] call Navy_Debug_HintRPT;
	};
	*/
};