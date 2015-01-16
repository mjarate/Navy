#include "Navy_Macros.h"

Navy_Timeline =
{
	[] spawn Navy_Debug_HintCurrentNavyUnits;
	["NATO_WOODLAND","B_Heli_Light_01_F",getposATL spawn_item,6,true] call Navy_Vehicle_SpawnFilledAirVehicle;
	DEBUG
	{
		[["Timeline finished running."]] call Navy_Debug_HintRPT;
	};
};