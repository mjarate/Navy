//#include "..\navy_macros.h" // TODO: Change to this after 1.50 goes live, and put routines back in their folder!
#include "navy_macros.h"

navy_method_fnc_paradrop = {
    FUN_ARGS_4(_trigger,_vehicleClassname,_unitTemplate,_waypoints);

    DECLARE(_reqWaypointCount) = [NAVY_CONFIG_ROUTINES, "Paradrop", "waypoint_count"] call navy_config_fnc_getNumber;
    INC(_reqWaypointCount);  // taking into account waypoint 0 on the logic's position
    if !(count _waypoints == _reqWaypointCount) exitWith {
        [["Waypoint count given: %1 not equal to amount required: %2", count _waypoints, _reqWaypointCount], DEBUG_INFO] call navy_debug_fnc_log;
    };
    PVT_4(_side,_pilotClassname,_vehicle,_pilot);
    _side = [_unitTemplate] call adm_common_fnc_getUnitTemplateSide;
    _pilotClassname = [_side] call navy_main_fnc_getPilotClassname;
    _vehicle = [_vehicleClassname, _trigger] call navy_spawn_fnc_airVehicle;
    _pilot = [_pilotClassname, _side, _vehicle] call navy_spawn_fnc_pilot;
    DECLARE(_pilotGroup) = group _pilot;

    DEBUG {
        [["Spawning helicopter: %1 on side: %2 with pilot: %3 in trigger: %4", _vehicleClassname, _side, _pilotClassname, _trigger], DEBUG_INFO] call navy_debug_fnc_log;
    };

    DECLARE(_paradropWP) = [_pilot, _waypoints, "Paradrop", 1] call navy_main_fnc_addWaypoint;
    DECLARE(_deleteWP) = [_pilot, _waypoints, "Paradrop", 2] call navy_main_fnc_addWaypoint;
    waitUntil {
        sleep 2;
        DEBUG {
            [["Vehicle: %1 Distance from paradrop point: %2 Limit: %3", _vehicle, (_vehicle distance (getWPPos _paradropWP)), NAVY_PARADROP_DISTANCE], DEBUG_INFO] call navy_debug_fnc_log;
        };
        (_vehicle distance (getWPPos _paradropWP)) < NAVY_PARADROP_DISTANCE;
    };

    DEBUG {
        [["Vehicle: %1 is initiating paradrop", _vehicle], DEBUG_INFO] call navy_debug_fnc_log;
    };

    
};
