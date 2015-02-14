#include "Navy_Macros.h"

// First: point at which the cargo units will land
// Second: Clean up
// Third: Cargo Units Waypoint
Navy_Routine_HeliInsert =
{
	FUN_ARGS_5(_vehicleID,_cargo_group,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	DECLARE(_pilot) = driver _vehicleID;
	PVT_4(_wait_handle,_WP1,_WP2,_WP3);
	_vehicleID flyInHeight NAVY_FLIGHT_HEIGHT_INSERT;
	DECLARE(_WP1) = [
		_pilot,
		1,
		(getPosATL _first_waypoint_object),
		0,
		"MOVE",
		"CARELESS",
		"NORMAL",
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
		[_vehicleID,_first_waypoint_object,350] call Navy_General_DistanceBelowLimit; // Adjust distance according to testing
	};
	_vehicleID land "GET OUT";
	//WAIT_DELAY(0.5, ([_vehicleID,10] call Navy_General_AltitudeBelowLimit););
	waitUntil
	{
		sleep 0.5;
		[_vehicleID,10] call Navy_General_AltitudeBelowLimit;
	};
	[_vehicleID,["Door_L","Door_R"]] call Navy_Vehicle_Animation_OpenDoorArray;
	WAIT_DELAY(1,(isTouchingGround _vehicleID););
	_pilot disableAI "MOVE"; // Stops him from flying away
	[_cargo_group,0.7] call Navy_Vehicle_CargoGetOut;
	WAIT_DELAY(1,(count (assignedCargo _vehicleID) == 0));
	sleep 2;
	_vehicleID land "NONE";
	DECLARE(_WP2) = [
		_pilot,
		2,
		(getposATL _end_waypoint_object),
		0,
		"MOVE",
		"AWARE",
		"FULL",
		"BLUE",
		["",""]
	] call Navy_Waypoint_AddFullWaypoint;
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
		[["Vehicle: %1 has finished executing the heli insert routine",_vehicleID]] call Navy_Debug_HintRPT;
	};
};

Navy_Routine_Paradrop =
{
	FUN_ARGS_5(_vehicleID,_cargo_group,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	DECLARE(_pilot) = driver _vehicleID;
	_vehicleID flyInHeight NAVY_FLIGHT_HEIGHT_PARADROP;
	[_cargo_group] call Navy_Units_AssignParachute;
	// First: point at which the cargo units will jump out
	// Second: Clean up
	// Third: Cargo Units Waypoint
	DECLARE(_WP1) = [
		_pilot,
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
		_pilot,
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
	[_cargo_group,NAVY_DEFAULT_PARADROP_DELAY] call Navy_Vehicle_EjectCargo;
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
		[["Vehicle: %1 has finished executing the paradrop routine",_vehicleID]] call Navy_Debug_HintRPT;
	};
};

Navy_Routine_CASPatrol =
{
	FUN_ARGS_4(_vehicleID,_first_waypoint_object,_second_waypoint_object,_third_waypoint_object);
	DECLARE(_pilot) = driver _vehicleID;
	_vehicleID flyInHeight NAVY_FLIGHT_HEIGHT_CASPATROL;
	// All waypoints: SAD waypoints, third one sets the first one as the current to continue looping
	DECLARE(_WP1) = [
		_pilot,
		1,
		(getPosATL _first_waypoint_object),
		0,
		"SAD",
		"COMBAT",
		"LIMITED",
		"RED",
		["",""]
	] call Navy_Waypoint_AddFullWaypoint;
	DECLARE(_WP2) = [
		_pilot,
		2,
		(getposATL _second_waypoint_object),
		0,
		"SAD",
		"COMBAT",
		"LIMITED",
		"RED",
		["",""]
	] call Navy_Waypoint_AddFullWaypoint;
	DECLARE(_WP3) = [
		_pilot,
		3,
		(getposATL _third_waypoint_object),
		0,
		"SAD",
		"COMBAT",
		"LIMITED",
		"RED",
		["true","(group this) setCurrentWaypoint [group this,1]"]
	] call Navy_Waypoint_AddFullWaypoint;
	DEBUG
	{
		[["Vehicle: %1 has been given CAS Patrol waypoints",_vehicleID]] call Navy_Debug_HintRPT;
		//[_pilot] spawn Navy_Debug_TrackCurrentWaypoints;
	};
};