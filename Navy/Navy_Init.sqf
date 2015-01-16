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
	//WAIT(sleep 0.5; adm_isInitialized);
	WAIT_DELAY(0.5,adm_isInitialized);
	// Make sure the admiral API command for running on HC is available
	//WAIT(sleep 0.5; !isNil "adm_api_fnc_executeIfAdmiralMachine");
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
};

Navy_Init_CreateSpawnLocation =
{
	Navy_SpawnLocation = "HeliHEmpty" createVehicleLocal NAVY_SPAWN_LOCATION_POS;
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
	// Compile Debug functions only if debug is enabled
	DEBUG
	{
		PRECOMPILE("Navy\Navy_Debug.sqf");
		[] call Navy_Debug_Init;
	};
	PRECOMPILE("Navy\Navy_General.sqf");
	PRECOMPILE("Navy\Navy_Units.sqf");
	PRECOMPILE("Navy\Navy_Vehicles.sqf");
	PRECOMPILE("Navy\Navy_Routines.sqf");
	PRECOMPILE("Navy\Navy_Mission.sqf");
	Navy_Initialised = true;
	publicVariable "Navy_Initialised";
	[["Navy Version %1 has successfully initliased.",Navy_Version]] call Navy_General_Log;
	[] spawn Navy_Timeline;
};