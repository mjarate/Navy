#include "Navy_Macros.h"

Navy_Routine_HeliInsert =
{
	FUN_ARGS_5(_vehicleID,_cargo_group,_first_waypoint_object,_cargo_waypoint_object,_end_waypoint_object);
	DECLARE(_pilot) = driver _vehicleID;
	DECLARE(_WP1_pos) = getPosATL _first_waypoint_object;
	DECLARE(_WP2_pos) = getposATL _end_waypoint_object;
	DECLARE(_WP3_pos) = getposATL _cargo_waypoint_object;
	PVT_3(_WP1,_WP2,_WP3);
	// First: point at which the cargo units will land, Second: Clean up, Third: Cargo Units Waypoint
	_WP1 = [_pilot,[_WP1_pos,0],"MOVE","AWARE","BLUE"] call adm_common_fnc_createWaypoint;
	// Statement Array: [condition,script]. Waypoint is not considered done until the condition is reached, script will run when waypoint is done.
	_WP1 setWaypointStatements 
	[
		"sleep 0.5;[_vehicleID,_first_waypoint_object] call Navy_General_DistanceBelowLimit;",
		"_vehicleID land 'GET OUT';"
	];
	_pilot setCurrentWaypoint _WP1;
	// Add altitude check
	// Get units to get out
	// Delay a bit
	// Give cargo units waypoints
	// Give helicopter pilot waypoint to clean up
	// Setup cleanup statement on pilot's second waypoint.
	
};

Navy_Routine_Paradrop =
{
	FUN_ARGS_5(_vehicleID,_cargo_group,_first_waypoint_object,_cargo_waypoint_object,_end_waypoint_object);
	DECLARE(_pilot) = driver _vehicleID;
	DECLARE(_WP1_pos) = getPosATL _first_waypoint_object;
	DECLARE(_WP2_pos) = getposATL _end_waypoint_object;
	DECLARE(_WP3_pos) = getposATL _cargo_waypoint_object;
	// First: point at which the cargo units will jump out, Second: Clean up, Third: Cargo Units Waypoint
	
	[
		_pilot,
		_WP1_pos,
		0,
		"MOVE",
		"AWARE",
		"NORMAL",
		"BLUE",
		[format ["[%1,%2,%3] call Navy_General_DistanceBelowLimit;",_vehicleID,_first_waypoint_object,150],format ["[%1,%2,%3] spawn Navy_Vehicle_EjectCargo;",_vehicleID,_cargo_group,0.5]]
	] call Navy_Waypoint_AddFullWaypoint;
	/*
	_WP1 = [_pilot,[_WP1_pos,0],"MOVE","AWARE","BLUE"] call adm_common_fnc_createWaypoint;
	_WP1 setWaypointStatements 
	[
		"sleep 0.5;[_vehicleID,_first_waypoint_object,150] call Navy_General_DistanceBelowLimit;",
		"[_vehicleID,_cargo_group,0.4] spawn Navy_Vehicle_EjectCargo;"
	];
	_WP1 setWaypointSpeed "NORMAL";
	*/
	
	[
		_pilot,
		_WP2_pos,
		0,
		"MOVE",
		"AWARE",
		"FULL",
		"BLUE",
		["[_vehicleID,_end_waypoint_object,200] call Navy_General_DistanceBelowLimit;",
		"[_vehicleID] spawn Navy_General_CleanUpVehicle;"]
	] call Navy_Waypoint_AddFullWaypoint;

	/*
	_WP2 = [_pilot,[_WP2_pos,0],"MOVE","AWARE","BLUE"] call adm_common_fnc_createWaypoint;
	_WP2 setWaypointSpeed "FULL";
	_WP2 setWaypointStatements 
	[
		"sleep 0.5;[_vehicleID,_end_waypoint_object,200] call Navy_General_DistanceBelowLimit;",
		"[_vehicleID] spawn Navy_General_CleanUpVehicle;"
	];
	*/
	
	/*
	_WP3 = 
	[
		_cargo_group,
		typeOf (SELECT_RAND(_cargo_group)),
		[_WP3_pos,"patrol",200] call Navy_Units_CreateUnitPatrolZone,
		4
	] call adm_patrol_fnc_createWaypoints;
	*/
	DEBUG
	{
		[["Finished assiging paradrop routine to vehicle with ID: %1",_vehicleID]] call Navy_Debug_HintRPT;
	};
};