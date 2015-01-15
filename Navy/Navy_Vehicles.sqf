#include "Navy_Macros.h"

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
	DECLARE(_vehicleID) = createVehicle [_classname,_spawn_position,[],0,_flying]];
	WAIT(sleep 0.1;!isNull _vehicleID;);
	DEBUG
	{
		[_vehicleID] spawn Navy_Debug_TrackWithMarker;
	};
	INC(Navy_Vehicle_Counter);
};

Navy_Vehicle_FillCargo =
{

};