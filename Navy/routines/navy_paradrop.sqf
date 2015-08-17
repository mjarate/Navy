#include "navy_macros.h"

navy_method_fnc_paradrop = {
    FUN_ARGS_4(_trigger,_vehicleClassname,_unitTemplate,_waypoints);

    PVT_(_side,_pilotClassname,_vehicle,_pilot);
    _side = [_unitTemplate] call adm_common_fnc_getUnitTemplateSide;
    _pilotClassname = [_side] call navy_main_fnc_getPilotClassname;
    _vehicle = [_vehicleClassname, _trigger] call navy_spawn_fnc_airVehicle;
    _pilot = [_pilotClassname, _side, _vehicle] call navy_spawn_fnc_pilot;
    
    DEBUG {
        [["Spawning helicopter: %1 on side: %2 with pilot: %3 in trigger: %4", _vehicleClassname, _side, _pilotClassname, _trigger], DEBUG_INFO] call navy_debug_fnc_log;
    };
};
