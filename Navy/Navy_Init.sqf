#include "Navy_Macros.h"

// Add the following to your init.sqf:
// call compile preprocessFileLineNumbers "Navy\Navy_Init.sqf";
// [] call Navy_PreInit;

Navy_PreInit =
{
	PRECOMPILE("Navy\Navy_Settings.sqf");
	if (Navy_WaitForHull3) then
	{
		WAIT(hull3_isInitialized);
	};
	// Wait for Admiral AI Suite to finish initialising
	WAIT_DELAY(0.5,adm_isInitialized);
	// Make sure the admiral API command for running on HC is available
	WAIT_DELAY(0.5,!isNil "adm_api_fnc_executeIfAdmiralMachine");
	if (Navy_RunOnHC) then
	{
		[[],Navy_Init] spawn adm_api_fnc_executeIfAdmiralMachine;
	}
	else
	{
		RUN_ON_SERVER
		{
			[] spawn Navy_Init;
		};
	};
};

Navy_Init_Variables =
{
	Navy_Units = [];
	Navy_Unit_Counter = 0;
	Navy_Vehicles = [];
	Navy_Vehicle_Counter = 0;
	Navy_GroundUnit_Groups = [];
};

Navy_Init_CreateSpawnLocation =
{
	Navy_SpawnLocation = "HeliHEmpty" createVehicleLocal NAVY_SPAWN_LOCATION_POS;
};

Navy_Precompile =
{
	// Compile Debug functions only if debug is enabled
	DEBUG
	{
		PRECOMPILE("Navy\Navy_Debug.sqf");
		[] call Navy_Debug_Init;
	};
	PRECOMPILE("Navy\Navy_General.sqf");
	PRECOMPILE("Navy\Navy_Waypoints.sqf");
	PRECOMPILE("Navy\Navy_Units.sqf");
	PRECOMPILE("Navy\Navy_Vehicles.sqf");
	PRECOMPILE("Navy\Navy_Mission.sqf");
	PRECOMPILE("Navy\Navy_Routines.sqf");
};

Navy_Init =
{
	Navy_Initialised = false;
	[] call Navy_Init_Variables;
	[] call Navy_Init_CreateSpawnLocation;
	// Turn Debug off in multiplayer settings
	if (isMultiplayer && !DEBUG_MULTIPLAYER) then
	{
		Navy_Debug = false;
	};
	[] call Navy_Precompile;
	Navy_Initialised = true;
	publicVariable "Navy_Initialised";
	[["Navy Version %1 has successfully initliased.",NAVY_VERSION]] call Navy_General_Log;
	[] spawn Navy_Timeline;
};