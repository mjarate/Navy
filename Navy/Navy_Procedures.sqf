#include "Navy_Macros.h"

Navy_RunParadrop =
{
	FUN_ARGS_7(_unit_template,_vehicle_classname,_cargo_amount,_spawn_position,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	DECLARE(_vehicle_and_cargo_group) = [_unit_template,false,_vehicle_classname,_spawn_position,_cargo_amount,true] call Navy_Vehicle_SpawnFilledAirVehicle;
	[
		(_vehicle_and_cargo_group select 0),
		(_vehicle_and_cargo_group select 1),
		_first_waypoint_object,
		_end_waypoint_object,
		_cargo_waypoint_object
	] call Navy_Routine_Paradrop;
};

Navy_RunHeliInsert =
{
	FUN_ARGS_7(_unit_template,_vehicle_classname,_cargo_amount,_spawn_position,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	DECLARE(_vehicle_and_cargo_group) = [_unit_template,true,_vehicle_classname,_spawn_position,_cargo_amount] call Navy_Vehicle_SpawnFilledAirVehicle;
	[
		(_vehicle_and_cargo_group select 0),
		(_vehicle_and_cargo_group select 1),
		_first_waypoint_object,
		_end_waypoint_object,
		_cargo_waypoint_object
	] call Navy_Routine_HeliInsert;
};

Navy_RunCASPatrol =
{
	FUN_ARGS_6(_unit_template,_vehicle_classname,_spawn_position,_first_waypoint_object,_second_waypoint_object,_third_waypoint_object);
	PVT_1(_vehicleID);
	DECLARE(_vehicle_and_cargo_group) = [_unit_template,true,_vehicle_classname,_spawn_position,0] call Navy_Vehicle_SpawnFilledAirVehicle;
	[
		(_vehicle_and_cargo_group select 0),
		_first_waypoint_object,
		_second_waypoint_object,
		_third_waypoint_object
	] call Navy_Routine_CASPatrol;
};