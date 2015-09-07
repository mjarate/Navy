#include "..\navy_macros.h"

navy_method_fnc_casPatrol = {
    FUN_ARGS_6(_module,_trigger,_vehicleClassname,_unitTemplate,_cargoAmount,_waypoints);

    DECLARE(_reqWaypointCount) = [NAVY_CONFIG_ROUTINES, "CAS_Patrol", "waypoint_count"] call navy_config_fnc_getNumber;
    INC(_reqWaypointCount);  // taking into account waypoint 0 on the logic's position
    if !(count _waypoints == _reqWaypointCount) exitWith {
        [["Waypoint count given: %1 not equal to amount required: %2", count _waypoints, _reqWaypointCount], DEBUG_INFO] call navy_debug_fnc_log;
    };

    PVT_3(_side,_vehicle,_pilot);
    _side = [_unitTemplate] call adm_common_fnc_getUnitTemplateSide;
    _vehicle = [_vehicleClassname, _trigger] call navy_spawn_fnc_airVehicle;
    DECLARE(_pilotClassname) = [_side] call navy_main_fnc_getPilotClassname;
    _pilot = [_pilotClassname, _side, _vehicle] call navy_spawn_fnc_pilot;
    _cargoClassnames = [_unitTemplate, "infantry"] call adm_common_fnc_getUnitTemplateArray;
    _cargoGroup = [_cargoClassnames, _side, _cargoAmount, _vehicle, false] call navy_spawn_fnc_cargoUnits;
    DECLARE(_routineFlightHeight) = [NAVY_CONFIG_ROUTINES, "CAS_Patrol", "flight_height"] call navy_config_fnc_getNumber;
    _vehicle flyInHeight _routineFlightHeight;

    DEBUG {
        [["Spawning helicopter: %1 on side: %2 with pilot: %3 in trigger: %4 for routine: CAS Patrol", _vehicleClassname, _side, _pilot], DEBUG_INFO] call navy_debug_fnc_log;
    };

    DECLARE(_waypoint1) = [_pilot, _waypoints, "CAS_Patrol", 0] call navy_main_fnc_addWaypoint;
    DECLARE(_waypoint2) = [_pilot, _waypoints, "CAS_Patrol", 1] call navy_main_fnc_addWaypoint;
    DECLARE(_waypoint3) = [_pilot, _waypoints, "CAS_Patrol", 2] call navy_main_fnc_addWaypoint;
    waitUntil {
        sleep 15;
        !(alive _vehicle);
    };
    [_vehicle, _reqWaypointCount] call navy_main_fnc_cleanupVehicleMarkers;
};
