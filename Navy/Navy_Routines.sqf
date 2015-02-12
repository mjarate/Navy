#include "Navy_Macros.h"

Navy_Routine_HeliInsert =
{
	FUN_ARGS_5(_vehicleID,_cargo_group,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	DECLARE(_pilot) = driver _vehicleID;
	PVT_4(_wait_handle,_WP1,_WP2,_WP3);
	// First: point at which the cargo units will land
	// Second: Clean up
	// Third: Cargo Units Waypoint
	
	// Give pilot waypoints
	// Add distance check
	// Order heli to land
	// Add altitude check
	// Order units to get out (unassign their vehicle. Ordering helicopter to land might not be needed)
	// Delay a bit
	// Give cargo units waypoints
	// Give helicopter pilot waypoint to clean up
	// Do cleanup after second waypoint

	DECLARE(_WP1) = [
		(driver _vehicleID),
		1,
		(getPosATL _first_waypoint_object),
		0,
		"MOVE",
		"AWARE",
		"NORMAL",
		"BLUE",
		["",""]
	] call Navy_Waypoint_AddFullWaypoint;
	DECLARE(_WP2) = [
		(driver _vehicleID),
		2,
		(getposATL _end_waypoint_object),
		0,
		"MOVE",
		"AWARE",
		"FULL",
		"BLUE",
		["",""]
	] call Navy_Waypoint_AddFullWaypoint;
	DECLARE(_WP3) = [
		(leader _cargo_group),
		(getposATL _cargo_waypoint_object),
		NAVY_DEFAULT_CARGO_UNIT_RADIUS,
		4
	] call Navy_Waypoint_AddPatrolWaypoints;
	waitUntil
	{
		sleep 0.5;
		[_vehicleID,_first_waypoint_object,600] call Navy_General_DistanceBelowLimit; // Adjust distance according to testing
	};
	_vehicleID land "GET OUT";
	//WAIT_DELAY(0.5, ([_vehicleID,10] call Navy_General_AltitudeBelowLimit););
	waitUntil
	{
		sleep 0.5;
		[_vehicleID,10] call Navy_General_AltitudeBelowLimit;
	};
	[_vehicleID,["Door_L","Door_R"]] call Navy_Vehicle_Animation_OpenDoorArray;
	waitUntil
	{
		sleep 0.5;
		[_vehicleID,0.5] call Navy_General_AltitudeBelowLimit;
	};
	//WAIT_DELAY(0.5, ([_vehicleID,0.1] call Navy_General_AltitudeBelowLimit););
	_pilot disableAI "MOVE";
	//_wait_handle = [_cargo_group,0.5] spawn Navy_Vehicle_CargoUnassign;
	[_cargo_group,0] call Navy_Vehicle_CargoUnassign;
	_wait_handle = [_cargo_group,"GetOut",0.8] spawn Navy_Vehicle_CargoAction;
	WAIT_DELAY(1,scriptDone _wait_handle);
	[_vehicleID,["Door_L","Door_R"]] call Navy_Vehicle_Animation_CloseDoorArray;
	_pilot enableAI "MOVE"; 
	waitUntil
	{
		sleep 2;
		[_vehicleID,_end_waypoint_object,NAVY_DEFAULT_CLEANUP_DISTANCE] call Navy_General_DistanceBelowLimit;
	};
	[_vehicleID] call Navy_Vehicle_CleanUp;
	DEBUG
	{
		[["Vehicle with ID: %1 has finished executing the heli insert routine",_vehicleID]] call Navy_Debug_HintRPT;
	};
};

Navy_Routine_Paradrop =
{
	FUN_ARGS_5(_vehicleID,_cargo_group,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	DECLARE(_pilot) = driver _vehicleID;
	// First: point at which the cargo units will jump out
	// Second: Clean up
	// Third: Cargo Units Waypoint
	DECLARE(_WP1) = [
		(driver _vehicleID),
		1,
		(getPosATL _first_waypoint_object),
		0,
		"MOVE",
		"AWARE",
		"NORMAL",
		"BLUE",
		["",""]
	] call Navy_Waypoint_AddFullWaypoint;
	DECLARE(_WP2) = [
		(driver _vehicleID),
		2,
		(getposATL _end_waypoint_object),
		0,
		"MOVE",
		"AWARE",
		"NORMAL",
		"BLUE",
		["",""]
	] call Navy_Waypoint_AddFullWaypoint;
	[_vehicleID,["Door_L","Door_R"]] call Navy_Vehicle_Animation_OpenDoorArray;
	WAIT_DELAY(0.5,(currentWaypoint (group _pilot)) == 2);
	[_cargo_group,0.7] call Navy_Vehicle_EjectCargo;
	DECLARE(_WP3) = [
		(leader _cargo_group),
		(getposATL _cargo_waypoint_object),
		NAVY_DEFAULT_CARGO_UNIT_RADIUS,
		4
	] call Navy_Waypoint_AddPatrolWaypoints;
	[_vehicleID,["Door_L","Door_R"]] call Navy_Vehicle_Animation_CloseDoorArray;
	waitUntil
	{
		sleep 2;
		[_vehicleID,_end_waypoint_object,NAVY_DEFAULT_CLEANUP_DISTANCE] call Navy_General_DistanceBelowLimit;
	};
	[_vehicleID] call Navy_Vehicle_CleanUp;
	DEBUG
	{
		[["Vehicle with ID: %1 has finished executing the paradrop routine",_vehicleID]] call Navy_Debug_HintRPT;
	};
};