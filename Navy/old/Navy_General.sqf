#include "Navy_Macros.h"

Navy_ReturnPosAndDir =
{
	FUN_ARGS_1(_unit);
	DECLARE(_posATL) = getposATL _unit;
	DECLARE(_dir) = direction _unit;
	[_posATL,_dir];
};

Navy_Log =
{
	FUN_ARGS_1(_message);
	diag_log format ["%1%2",DEBUG_HEADER,format _message];
	DEBUG
	{
		[_message] call Navy_Debug_Hint;
	};
};

Navy_ChooseRandomTriggerPosition =
{
	FUN_ARGS_2(_trigger,_vehicle_classname);
	DECLARE(_random_position) = [triggerArea _trigger,getposATL _trigger,true] call adm_common_fnc_getRandomPositionInArea;
	DEBUG
	{
		[["Random position: %1 chosen from trigger: %2",_random_position,_trigger]] call Navy_Debug_HintRPT;
	};
	_random_position;
};

Navy_CheckNumberBelowLimit =
{
	FUN_ARGS_2(_number,_limit);
	DECLARE(_below) = if (_number < _limit) then {true;} else {false;};
	_below;
};

Navy_CheckDistanceBelowLimit =
{
	FUN_ARGS_3(_object1,_object2,_limit);
	DECLARE(_below_limit) = false;
	if (isNil "_limit") then
	{
		_limit = NAVY_DEFAULT_LANDING_DISTANCE;
	};
	_below_limit = [(_object1 distance _object2),_limit] call Navy_CheckNumberBelowLimit;
	DEBUG
	{
		[["Distance: %1 Limit: %2 Below Limit: %3",(_object1 distance _object2),_limit,_below_limit]] call Navy_Debug_HintRPT;
	};
	_below_limit;
};

Navy_CheckAltitudeBelowLimit =
{
	FUN_ARGS_2(_object,_limit);
	DECLARE(_below_limit) = false;
	if (isNil "_limit") then
	{
		_limit = NAVY_DEFAULT_LANDING_ALTITUDE;
	};
	_below_limit = [(ALTITUDE(_object)),_limit] call Navy_CheckNumberBelowLimit;
	DEBUG
	{
		[["Altitude: %1 Limit: %2 Below Limit: %3",ALTITUDE(_object),_limit,_below_limit]] call Navy_Debug_HintRPT;
	};
	_below_limit;
};

Navy_CalculateHypotenuse =
{
	FUN_ARGS_2(_ground_distance,_current_position);
	DECLARE(_altitude) = ALTITUDE(_current_position);
	DECLARE(_hypotenuse) = sqrt((_altitude ^ 2) * (_ground_distance ^ 2));
	_hypotenuse;
};

Navy_ReturnVehicleCargo =
{
	FUN_ARGS_1(_vehicleID);
	DECLARE(_cargo) = [crew _vehicleID, {_vehicleID getCargoIndex _x >= 0}] call BIS_fnc_conditionalSelect;
	_cargo;
	DEBUG
	{
		[["Vehicle: %1 has %2 cargo units: %3",_vehicleID,(count _cargo),_cargo]] call Navy_Debug_HintRPT;
	};
};