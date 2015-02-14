#include "Navy_Macros.h"

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

Navy_General_AltitudeBelowLimit =
{
	FUN_ARGS_2(_object,_limit);
	DECLARE(_below_limit) = false;
	if (isNil "_limit") then
	{
		_limit = NAVY_DEFAULT_LANDING_ALTITUDE;
	};
	_below_limit = [(ALTITUDE(_object)),_limit] call Navy_General_NumberBelowLimit;
	DEBUG
	{
		[["Altitude: %1 Limit: %2 Below Limit: %3",ALTITUDE(_object),_limit,_below_limit]] call Navy_Debug_HintRPT;
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