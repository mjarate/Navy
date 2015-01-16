#include "Navy_Macros.h"

Navy_Vehicle_SpawnFilledAirVehicle =
{
	FUN_ARGS_4(_unit_template,_vehicle_classname,_spawn_position,_flying);
	PVT_2(_driver,_vehicle);
	_driver = [_unit_template] call Navy_Units_SpawnDriver;
	_vehicle = [_vehicle_classname,_spawn_position,_flying] call Navy_Vehicle_SpawnAirVehicle;
	_driver moveinDriver _vehicle;
	DEBUG
	{
		[["Driver %1 placed in vehicle %2 at position %3 flying: %4",_driver,_vehicle,_spawn_position,_flying]] call Navy_Debug_SideChatRPT;
	};
};

Navy_Vehicle_SpawnAirVehicle =
{
	FUN_ARGS_3(_classname,_spawn_position,_flying);
	if (_flying) then
	{
		_flying = "FLY";
	}
	else
	{
		_flying = "NONE";
	};
	DECLARE(_vehicleID) = createVehicle [_classname,_spawn_position,[],0,_flying];
	WAIT(sleep 0.1;!isNull _vehicleID);
	DEBUG
	{
		[_vehicleID] spawn Navy_Debug_TrackWithMarker;
	};
	INC(Navy_Vehicle_Counter);
	_vehicleID;
};

Navy_Vehicle_FillCargo =
{
	
};