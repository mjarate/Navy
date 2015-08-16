#include "navy_macros.h"

navy_spawn_fnc_spawnAirVehicle = {
    FUN_ARGS_2(_vehicleClassname,_trigger);

    if (isNil "_trigger") exitWith {
        [["No trigger was provided to try and spawn the vehicle with classname: %1", _vehicleClassname], DEBUG_ERROR] call navy_debug_fnc_logToServer;
    };
    PVT_2(_spawnPosition,_vehicle);
    _spawnPosition = [(triggerArea _trigger), (getposATL _trigger), true] call adm_api_fnc_getRandomPositionInArea;
    _spawnPosition set [2, NAVY_DEFAULT_ALTITUDE];
    hint format ["Spawn position chosen: %1", _spawnPosition];
    _vehicle = createVehicle [_vehicleClassname, _spawnPosition, [], 0, "FLY"];
    DEBUG {
        //[["Spawned vehicle: %1 at position: %2", _vehicle, _spawnPosition], DEBUG_INFO] call navy_debug_fnc_log
    };

    _vehicle;
};

navy_spawn_fnc_spawnPilot = {
    FUN_ARGS_1(_pilotClassname);
    
};