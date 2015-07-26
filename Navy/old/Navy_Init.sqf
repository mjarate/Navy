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
	WAIT_DELAY(0.5,adm_isInitialized); // Wait for Admiral AI Suite to finish initialising
	//WAIT_DELAY(0.5,!isNil "adm_api_fnc_executeIfAdmiralMachine"); // Make sure the admiral API command for running on HC is available // Command is only available in Admiral 0.8
	if (Navy_RunOnHC) then
	{
		//[[],Navy_Init] spawn adm_api_fnc_executeIfAdmiralMachine; // Command is only available in Admiral 0.8
	}
	else
	{
		if (isServer) then
		{
			[] spawn Navy_Init;
		};
	};
};

Navy_Init_Variables =
{
	Navy_Spawn_Position = NAVY_DEFAULT_SPAWN_POSITION;
	DEBUG
	{
		Navy_Units = [];
		Navy_Unit_Counter = 0;
		Navy_Vehicles = [];
		Navy_Vehicle_Counter = 0;
		Navy_Spawn_Counter = 1;
		Navy_Spawn_Markers = [];
		Navy_Cargo_Unit_Groups = [];
	};
};

Navy_Precompile_Functions =
{
	// Compile Debug functions only if debug is enabled
	DEBUG
	{
		PRECOMPILE("Navy\Navy_Debug.sqf");
		[] call Navy_Debug_Init;
	};
	PRECOMPILE("Navy\Navy_General.sqf");
	PRECOMPILE("Navy\Navy_Config.sqf");
	PRECOMPILE("Navy\Navy_Units.sqf");
	PRECOMPILE("Navy\Navy_Vehicles.sqf");
	PRECOMPILE("Navy\Navy_Waypoints.sqf");
	PRECOMPILE("Navy\Navy_Routines.sqf");
	PRECOMPILE("Navy\Navy_Procedures.sqf");
	PRECOMPILE("Navy\Navy_Mission.sqf");
};

Navy_Init =
{
	Navy_Initialised = false;
	publicVariable "Navy_Initialised";
	[] call Navy_Init_Variables;
	// Turn Debug off in multiplayer settings
	if (isMultiplayer && !DEBUG_MULTIPLAYER) then
	{
		Navy_Debug = false;
		Navy_Vehicle_StartingForm = NAVY_DEFAULT_SPAWN_FORM;
	};
	[] call Navy_Precompile_Functions;
	Navy_Initialised = true;
	publicVariable "Navy_Initialised";
	[["Navy Version %1 has successfully initliased.",NAVY_VERSION_STR]] call Navy_Log;
	[] spawn Navy_Timeline;
};