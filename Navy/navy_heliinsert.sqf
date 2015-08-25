//#include "..\navy_macros.h" // TODO: Change to this after 1.50 goes live, and put routines back in their folder!
#include "navy_macros.h"

navy_method_fnc_heliInsert = {
    FUN_ARGS_5(_trigger,_vehicleClassname,_unitTemplate,_cargoAmount,_waypoints);

    //DECLARE(_insertDistance) = [NAVY_CONFIG_FILE, "Settings", "paradropDistance"] call navy_config_fnc_getNumber;
    DECLARE(_cleanupDistance) = [NAVY_CONFIG_FILE, "Settings", "cleanupDistance"] call navy_config_fnc_getNumber;
    DECLARE(_reqWaypointCount) = [NAVY_CONFIG_ROUTINES, "Heli_Insert", "waypoint_count"] call navy_config_fnc_getNumber;
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
    DECLARE(_routineFlightHeight) = [NAVY_CONFIG_ROUTINES, "Heli_Insert", "flight_height"] call navy_config_fnc_getNumber;
    DECLARE(_insertHeight) = _routineFlightHeight + 100;
    _vehicle flyInHeight _routineFlightHeight;

    DEBUG {
        [["Spawning helicopter: %1 on side: %2 with pilot: %3 in trigger: %4 for routine: Heli Insert", _vehicleClassname, _side, _pilot], DEBUG_INFO] call navy_debug_fnc_log;
    };

    DECLARE(_insertWP) = [_pilot, _waypoints, "Heli_Insert", 1] call navy_main_fnc_addWaypoint;
    DECLARE(_landingH) = createVehicle ["Land_HelipadEmpty_F", (getWPPos _insertWP), [], 0, "CAN_COLLIDE"];
    waitUntil {
        sleep 2;
        DEBUG {
            [["Vehicle: %1 Distance from insert point: %2 Limit: %3", _vehicle, (_vehicle distance (getWPPos _insertWP)), _insertHeight], DEBUG_INFO] call navy_debug_fnc_log;
        };
        (_vehicle distance (getWPPos _insertWP)) < _insertHeight;
    };

    DEBUG {
        [["Vehicle: %1 is initiating heli insert at object: %2", _vehicle, _landingH], DEBUG_INFO] call navy_debug_fnc_log;
    };

    _vehicle land "GET OUT";
    waitUntil {
        sleep 1;
        DEBUG {
            [["Vehicle: %1 Altitude: %2 Animation Limit: %3", _vehicle, ALTITUDE(_vehicle), NAVY_ANIMATION_ALTITUDE], DEBUG_INFO] call navy_debug_fnc_log;
        };
        ALTITUDE(_vehicle) < NAVY_ANIMATION_ALTITUDE;
    };
    [_vehicle, NAVY_OPEN_DOOR] call navy_main_fnc_animateDoors;
    waitUntil {
        sleep 0.5;
        ((ALTITUDE(_vehicle) < 0.3) || (isTouchingGround _vehicle));
    };
    {
        unassignVehicle _x;
        (_x) action ["GETOUT", vehicle _x];
        sleep 0.1;
    } forEach units _cargoGroup;
    [_cargoGroup, (getWPPos _insertWP), 3] call navy_main_assignPatrolWaypoints;
    waitUntil {
        sleep 1;
        (count (assignedCargo _vehicle) == 0);
    };
    sleep 1;
    [_vehicle, NAVY_CLOSE_DOOR] call navy_main_fnc_animateDoors;
    _vehicle land "NONE";
    DECLARE(_deleteWP) = [_pilot, _waypoints, "Heli_Insert", 2] call navy_main_fnc_addWaypoint;
    deleteVehicle _landingH;  // avoids other helicopters landing on it.
    waitUntil {
        sleep 5;
        DEBUG {
            [["Vehicle: %1 Distance from cleanup point: %2 Limit: %3", _vehicle, (_vehicle distance (getWPPos _deleteWP)), _cleanupDistance], DEBUG_INFO] call navy_debug_fnc_log;
        };
        (_vehicle distance (getWPPos _deleteWP)) < _cleanupDistance;
    };
    [_vehicle, _reqWaypointCount] call navy_main_fnc_cleanupVehicle;
};
