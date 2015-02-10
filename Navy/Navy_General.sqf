#include "Navy_Macros.h"

Navy_RunParadrop =
{
	FUN_ARGS_7(_unit_template,_vehicle_classname,_cargo_amount,_spawn_position,_first_waypoint_object,_end_waypoint_object,_cargo_waypoint_object);
	DECLARE(_vehicle_and_cargo_group) = [_unit_template,_vehicle_classname,_spawn_position,_cargo_amount,true] call Navy_Vehicle_SpawnFilledAirVehicle;
	[
		(_vehicle_and_cargo_group select 0),
		(_vehicle_and_cargo_group select 1),
		_first_waypoint_object,
		_end_waypoint_object,
		_cargo_waypoint_object
	] call Navy_Routine_Paradrop;
	DEBUG
	{
		[["Paradrop routine with template %1 and classname %2 has finished executing.",_unit_template,_vehicle_classname]] call Navy_Debug_HintRPT;
	};
};

Navy_General_ReturnPosAndDir =
{
	FUN_ARGS_1(_unit);
	DECLARE(_pos) = getposATL _unit;
	DECLARE(_dir) = direction _unit;
	[_pos,_dir];
};

Navy_General_Log =
{
	FUN_ARGS_1(_message);
	diag_log format ["%1%2",DEBUG_HEADER,format _message];
	DEBUG
	{
		[_message] call Navy_Debug_Hint;
	};
};

Navy_General_NumberBelowLimit =
{
	FUN_ARGS_2(_number,_limit);
	DECLARE(_below) = if (_number < _limit) then {true;} else {false;};
	_below;
};

Navy_General_DistanceBelowLimit =
{
	FUN_ARGS_3(_object1,_object2,_limit);
	DECLARE(_below_limit) = false;
	if (isNil "_limit") then
	{
		_limit = NAVY_DEFAULT_LANDING_DISTANCE;
	};
	_below_limit = [(_object1 distance _object2),_limit] call Navy_General_NumberBelowLimit;
	DEBUG
	{
		[["Distance: %1 Limit: %2 Below Limit: %3",(_object1 distance _object2),_limit,_below_limit]] call Navy_Debug_HintRPT;
	};
	_below_limit;
};

Navy_General_CalculateHypotenuse =
{
	FUN_ARGS_2(_ground_distance,_current_position);
	DECLARE(_altitude) = ALTITUDE(_current_position);
	DECLARE(_hypotenuse) = sqrt((_altitude ^ 2) * (_ground_distance ^ 2));
	_hypotenuse;
};