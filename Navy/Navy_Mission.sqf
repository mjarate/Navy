#include "Navy_Macros.h"

Navy_Timeline =
{
	["NATO_WOODLAND","B_Heli_Light_01_F",getposATL spawn_item,false] call Navy_Vehicle_SpawnFilledAirVehicle;
	DEBUG
	{
		[["Timeline finished running."]] call Navy_Debug_HintRPT;
	};
};