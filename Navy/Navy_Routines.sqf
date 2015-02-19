#include "Navy_Macros.h"

// First: point at which the cargo units will land
// Second: Clean up
// Third: Cargo Units Waypoint
Navy_Routine_HeliInsert =
{
	FUN_ARGS_5(_vehicleID,_cargo_group,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	PVT_3(_WP1,_WP2,_WP3);
	
	DECLARE(_flight_height) = [CONFIG_TYPE_NUMBER,"Routines","Heli_Insert","Flight_Height"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Speeds) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_Speed"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Types) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_Type"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Behaviours) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_Behaviour"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_CombatModes) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_CombatMode"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Statements) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_Statements"] call Navy_Config_GetConfigValue;
	DECLARE(_vehicle_anim) = [CONFIG_TYPE_ARRAY,"Vehicles",(typeOf _vehicleID),"Animation"] call Navy_Config_GetConfigValue;
	
	_vehicleID setposATL [((getposATL _vehicleID) select 0),((getposATL _vehicleID) select 1),_flight_height];
	_vehicleID flyInHeight _flight_height;
	
	DECLARE(_WP1) = [
		(driver _vehicleID),
		1,
		(getPosATL _first_waypoint_object),
		0,
		(_WP_Types select 0),
		(_WP_Behaviours select 0),
		(_WP_Speeds select 0),
		(_WP_CombatModes select 0),
		(_WP_Statements select 0)
	] call Navy_Waypoint_AddFullWaypoint;
	
	DECLARE(_WP3) = [
		(leader _cargo_group),
		(getposATL _cargo_waypoint_object),
		NAVY_DEFAULT_CARGO_UNIT_RADIUS,
		4
	] call Navy_Waypoint_AddPatrolWaypoints;
	waitUntil
	{
		sleep 2;
		[_vehicleID,_first_waypoint_object,NAVY_DEFAULT_INSERT_DISTANCE] call Navy_General_DistanceBelowLimit;
	};
	_vehicleID land "GET OUT";
	waitUntil
	{
		sleep 1;
		[_vehicleID,NAVY_ALTITUDE_FOR_ANIMATION] call Navy_General_AltitudeBelowLimit;
	};
	if ((count _vehicle_anim) > 0) then
	{
		[_vehicleID,_vehicle_anim] call Navy_Vehicle_Animation_OpenDoorArray;
	};
	WAIT_DELAY(1,(isTouchingGround _vehicleID););
	(driver _vehicleID) disableAI "MOVE"; // Stops him from flying away
	[_cargo_group,0.7] call Navy_Vehicle_CargoGetOut;
	WAIT_DELAY(1,(count (assignedCargo _vehicleID) == 0));
	sleep 2;
	if (alive (driver _vehicleID)) then
	{
		_vehicleID land "NONE";
		DECLARE(_WP2) = [
			(driver _vehicleID),
			2,
			(getposATL _end_waypoint_object),
			0,
			(_WP_Types select 1),
			(_WP_Behaviours select 1),
			(_WP_Speeds select 1),
			(_WP_CombatModes select 1),
			(_WP_Statements select 1)
		] call Navy_Waypoint_AddFullWaypoint;
		(driver _vehicleID) enableAI "MOVE";
		if ((count _vehicle_anim) > 0) then
		{
			[_vehicleID,_vehicle_anim] call Navy_Vehicle_Animation_CloseDoorArray;
		};
		waitUntil
		{
			sleep 5;
			[_vehicleID,_end_waypoint_object,NAVY_DEFAULT_CLEANUP_DISTANCE] call Navy_General_DistanceBelowLimit;
		};
		[_vehicleID] call Navy_Vehicle_CleanUp;
	};
	DEBUG
	{
		[["Vehicle: %1 has finished executing the heli insert routine",_vehicleID]] call Navy_Debug_HintRPT;
	};
	
};

// First: point at which the cargo units will jump out
// Second: Clean up
// Third: Cargo Units Waypoint
Navy_Routine_Paradrop =
{
	FUN_ARGS_5(_vehicleID,_cargo_group,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	DECLARE(_flight_height) = [CONFIG_TYPE_NUMBER,"Routines","Paradrop","Flight_Height"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Speeds) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_Speed"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Types) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_Type"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Behaviours) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_Behaviour"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_CombatModes) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_CombatMode"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Statements) = [CONFIG_TYPE_ARRAY,"Routines","Heli_Insert","WP_Statements"] call Navy_Config_GetConfigValue;
	DECLARE(_vehicle_anim) = [CONFIG_TYPE_ARRAY,"Vehicles",(typeOf _vehicleID),"Animation"] call Navy_Config_GetConfigValue;
	
	_vehicleID setposATL [((getposATL _vehicleID) select 0),((getposATL _vehicleID) select 1),_flight_height];
	_vehicleID flyInHeight _flight_height;
	[_cargo_group] call Navy_Units_AssignParachute;
	
	DECLARE(_WP1) = [
		(driver _vehicleID),
		1,
		(getPosATL _first_waypoint_object),
		0,
		(_WP_Types select 0),
		(_WP_Behaviours select 0),
		(_WP_Speeds select 0),
		(_WP_CombatModes select 0),
		(_WP_Statements select 0)
	] call Navy_Waypoint_AddFullWaypoint;
	DECLARE(_WP2) = [
		(driver _vehicleID),
		2,
		(getposATL _end_waypoint_object),
		0,
		(_WP_Types select 1),
		(_WP_Behaviours select 1),
		(_WP_Speeds select 1),
		(_WP_CombatModes select 1),
		(_WP_Statements select 1)
	] call Navy_Waypoint_AddFullWaypoint;
	if ((count _vehicle_anim) > 0) then
	{
		[_vehicleID,_vehicle_anim] call Navy_Vehicle_Animation_OpenDoorArray;
	};
	WAIT_DELAY(0.5,(currentWaypoint (group _pilot)) == 2);
	[_cargo_group,NAVY_DEFAULT_PARADROP_DELAY] call Navy_Vehicle_EjectCargo;
	DECLARE(_WP3) = [
		(leader _cargo_group),
		(getposATL _cargo_waypoint_object),
		NAVY_DEFAULT_CARGO_UNIT_RADIUS,
		4
	] call Navy_Waypoint_AddPatrolWaypoints;
	if ((count _vehicle_anim) > 0) then
	{
		[_vehicleID,_vehicle_anim] call Navy_Vehicle_Animation_CloseDoorArray;
	};
	waitUntil
	{
		sleep 5;
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
	DECLARE(_flight_height) = [CONFIG_TYPE_NUMBER,"Routines","CAS_Patrol","Flight_Height"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Types) = [CONFIG_TYPE_ARRAY,"Routines","CAS_Patrol","WP_Type"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Behaviours) = [CONFIG_TYPE_ARRAY,"Routines","CAS_Patrol","WP_Behaviour"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Speeds) = [CONFIG_TYPE_ARRAY,"Routines","CAS_Patrol","WP_Speed"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_CombatModes) = [CONFIG_TYPE_ARRAY,"Routines","CAS_Patrol","WP_CombatMode"] call Navy_Config_GetConfigValue;
	DECLARE(_WP_Statements) = [CONFIG_TYPE_ARRAY,"Routines","CAS_Patrol","WP_Statements"] call Navy_Config_GetConfigValue;
	
	_vehicleID setposATL [((getposATL _vehicleID) select 0),((getposATL _vehicleID) select 1),_flight_height];
	_vehicleID flyInHeight _flight_height;

	DECLARE(_WP1) = [
		(driver _vehicleID),
		1,
		(getPosATL _first_waypoint_object),
		0,
		(_WP_Types select 0),
		(_WP_Behaviours select 0),
		(_WP_Speeds select 0),
		(_WP_CombatModes select 0),
		(_WP_Statements select 0)
	] call Navy_Waypoint_AddFullWaypoint;
	DECLARE(_WP2) = [
		(driver _vehicleID),
		2,
		(getposATL _second_waypoint_object),
		0,
		(_WP_Types select 1),
		(_WP_Behaviours select 1),
		(_WP_Speeds select 1),
		(_WP_CombatModes select 1),
		(_WP_Statements select 1)
	] call Navy_Waypoint_AddFullWaypoint;
	DECLARE(_WP3) = [
		(driver _vehicleID),
		3,
		(getposATL _third_waypoint_object),
		0,
		(_WP_Types select 2),
		(_WP_Behaviours select 2),
		(_WP_Speeds select 2),
		(_WP_CombatModes select 2),
		(_WP_Statements select 2)
	] call Navy_Waypoint_AddFullWaypoint;
	DEBUG
	{
		[["Vehicle: %1 has been given CAS Patrol waypoints",_vehicleID]] call Navy_Debug_HintRPT;
		//[_pilot] spawn Navy_Debug_TrackCurrentWaypoints;
	};
};