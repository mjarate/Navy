#include "Navy_Macros.h"

Navy_Vehicle_SpawnFilledAirVehicle =
{
	FUN_ARGS_5(_unit_template,_vehicle_classname,_spawn_position,_cargo_amount,_flying);
	PVT_3(_driver,_vehicleID,_cargo_group);
	_driver = [_unit_template] call Navy_Units_SpawnDriver;
	_vehicleID = [_vehicle_classname,_spawn_position,_flying] call Navy_Vehicle_SpawnAirVehicle;
	_driver assignAsDriver _vehicleID;
	_driver moveinDriver _vehicleID;
	DEBUG
	{
		[_vehicleID] spawn Navy_Debug_TrackVehicle;
		[["Driver %1 placed in vehicle %2 at position %3 flying: %4",_driver,_vehicleID,_spawn_position,_flying]] call Navy_Debug_HintRPT;
	};
	_cargo_group = [_unit_template,_cargo_amount] call Navy_Vehicle_FillCargo;
	{
		_x assignAsCargo _vehicleID;
		_x moveInCargo _vehicleID;
	} forEach units _cargo_group;
	DEBUG
	{
		[["Cargo unit group %1 has been placed in the vehicle %2",_cargo_group,_vehicleID]] call Navy_Debug_HintRPT;
	};
	[_vehicleID,_cargo_group];
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
	WAIT_DELAY(0.1,!isNil "_vehicleID");
	Navy_Vehicles pushBack _vehicleID;
	INC(Navy_Vehicle_Counter);
	_vehicleID;
};

Navy_Vehicle_FillCargo =
{
	FUN_ARGS_2(_unit_template,_amount);
	DECLARE(_group) = createGroup ([_unit_template] call adm_common_fnc_getUnitTemplateSide);
	DECLARE(_cargo_unit_array) = [];
	PVT_2(_i,_cargo_unit);
	for "_i" from 1 to _amount do
	{
		_cargo_unit = [_unit_template,_group] call Navy_Units_SpawnCargoUnit;
		_cargo_unit_array pushBack _cargo_unit;
	};
	Navy_GroundUnit_Groups pushBack _cargo_unit_array;
	DEBUG
	{
		[["Cargo Unit group created with array: %1",_cargo_unit_array]] call Navy_Debug_HintRPT;
	};
	_group;
};

Navy_Vehicle_EjectCargo =
{
	FUN_ARGS_2(_cargo_group,_delay);
	if (isNil "_delay") then
	{
		_delay = NAVY_DEFAULT_PARADROP_DELAY;
	};
	{
		removeBackpack _x;
		_x addBackpackGlobal "B_Parachute";
		//(_x) action ["EJECT", vehicle _x];
		moveOut _x;
		unassignVehicle _x;
		sleep _delay;
	} forEach units _cargo_group;
	DEBUG
	{
		[["Cargo Unit Group: %1 has paradropped successfully.",_cargo_group]] call Navy_Debug_HintRPT;
	};
};