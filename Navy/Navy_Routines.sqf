#include "Navy_Macros.h"

Navy_Routine_HeliInsert =
{
	FUN_ARGS_5(_vehicleID,_cargo_group,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	DECLARE(_pilot) = driver _vehicleID;
	DECLARE(_WP1_pos) = getPosATL _first_waypoint_object;
	DECLARE(_WP2_pos) = getposATL _end_waypoint_object;
	DECLARE(_WP3_pos) = getposATL _cargo_waypoint_object;
	PVT_3(_WP1,_WP2,_WP3);
	// First: point at which the cargo units will land
	// Second: Clean up
	// Third: Cargo Units Waypoint
	
	/*
	_WP1 = [_pilot,[_WP1_pos,0],"MOVE","AWARE","BLUE"] call adm_common_fnc_createWaypoint;
	// Statement Array: [condition,script]. Waypoint is not considered done until the condition is reached, script will run when waypoint is done.
	_WP1 setWaypointStatements 
	[
		"sleep 0.5;[_vehicleID,_first_waypoint_object] call Navy_General_DistanceBelowLimit;",
		"_vehicleID land 'GET OUT';"
	];
	_pilot setCurrentWaypoint _WP1;
	*/
	// Add altitude check
	// Order units to get out (unassign their vehicle)
	// Delay a bit
	// Give cargo units waypoints
	// Give helicopter pilot waypoint to clean up
	// Do cleanup after second waypoint
	
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
		"FULL",
		"RED",
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
		"RED",
		["",""]
	] call Navy_Waypoint_AddFullWaypoint;
	[_vehicleID,"Door_L"] call Navy_Vehicle_Animation_Door_Open;
	[_vehicleID,"Door_R"] call Navy_Vehicle_Animation_Door_Open;
	WAIT_DELAY(0.5,(currentWaypoint (group _pilot)) == 2);
	[_cargo_group,0.6] call Navy_Vehicle_EjectCargo;
	DECLARE(_WP3) = [
		(leader _cargo_group),
		(getposATL _cargo_waypoint_object),
		NAVY_DEFAULT_CARGO_UNIT_RADIUS,
		4
	] call Navy_Waypoint_AddPatrolWaypoints;
	[_vehicleID,"Door_L"] call Navy_Vehicle_Animation_Door_Close;
	[_vehicleID,"Door_R"] call Navy_Vehicle_Animation_Door_Close;
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