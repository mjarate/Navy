#include "Navy_Macros.h"

Navy_InitTrigger =
{
	FUN_ARGS_1(_trigger);
	DECLARE(_area) = triggerArea _trigger; // [a, b, angle, rectangle]
	DECLARE(_position) = getPosATL _trigger; // [x,y,z]
	DEBUG
	{
		[_position,(_area select 0),(_area select 1),(_area select 2),(_area select 3),(_area select 4)] call Navy_Debug_SpawnMarker;
		[["Spawn Trigger found at position %1 with a: %2 b: %3 angle: %4 rectangle: %5",_position,(_area select 0),(_area select 1),(_area select 2),(_area select 3),(_area select 4)]] call Navy_Debug_HintRPT;
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