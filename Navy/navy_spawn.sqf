#include "navy_macros.h"

navy_spawn_fnc_airVehicle = {
    FUN_ARGS_2(_vehicleClassname,_trigger);

    PVT_2(_spawnPosition,_vehicle);
    if (isNil "_trigger") exitWith {
        [["No trigger was provided to try and spawn the vehicle with classname: %1", _vehicleClassname], DEBUG_ERROR] call navy_debug_fnc_logToServer;
    };
    _spawnPosition = [(triggerArea _trigger), (getposATL _trigger), true] call adm_api_fnc_getRandomPositionInArea;
    _spawnPosition set [2, NAVY_DEFAULT_ALTITUDE];
    _vehicle = createVehicle [_vehicleClassname, _spawnPosition, [], 0, "FLY"];
    DEBUG {
        [["Spawned vehicle: %1 at position: %2", _vehicle, _spawnPosition], DEBUG_INFO] call navy_debug_fnc_log
    };

    _vehicle;
};

navy_spawn_fnc_pilot = {
    FUN_ARGS_3(_pilotClassname,_pilotSide,_vehicle);

    DECLARE(_pilotGroup) = createGroup _pilotSide;
    DECLARE(_pilot) = [NAVY_SPAWN_POSITION, _pilotGroup, [_pilotClassname], NAVY_PILOT_SKILL_ARRAY] call adm_common_fnc_placeMan;
    _pilot moveInDriver _vehicle;

    DEBUG {
        [["Spawned pilot: %1 and placed inside vehicle: %2", _pilot, _vehicle], DEBUG_INFO] call navy_debug_fnc_log
    };
    _pilot;
};