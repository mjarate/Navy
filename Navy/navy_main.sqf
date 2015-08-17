#include "navy_macros.h"

navy_main_fnc_getPilotClassname = {
    FUN_ARGS_1(_side);

    {
        if ((_x select 0) isEqualTo _side) exitWith {
            _pilotClassname = _x select 1;
        };
    } forEach NAVY_PILOT_CLASSNAMES;
    _pilotClassname;
};

navy_main_fnc_addWaypoint = {
    FUN_ARGS_3(_unit,_routine,_number);

    DECLARE(_index) = _number - 1;
    DECLARE(_waypointPositions) = [];
    {
        _waypointPositions pushBack (getWPPos _x);
    } forEach _waypoints;
    DECLARE(_speedArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_speed"] call navy_config_fnc_getArray;
    DECLARE(_typeArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_type"] call navy_config_fnc_getArray;
    DECLARE(_behaviourArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_behaviour"] call navy_config_fnc_getArray;
    DECLARE(_modeArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_combatmode"] call navy_config_fnc_getArray;
    DECLARE(_statementArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_statements"] call navy_config_fnc_getArray;
    //[["Speed: %1 Type: %2 Beh: %3 Mode: %4 State: %5", _speedArray, _typeArray, _behaviourArray, _modeArray, _statementArray], DEBUG_INFO] call navy_debug_fnc_log;
    DECLARE(_waypoint) = (group _unit) addWaypoint [(group _unit), _number];
    _waypoint setWaypointSpeed (_speedArray select _index);
    _waypoint setWaypointType (_typeArray select _index);
    _waypoint setWaypointBehaviour (_behaviourArray select _index);
    _waypoint setWaypointCombatMode (_modeArray select _index);
    _waypoint setWaypointStatements (_statementArray select _index);

    DEBUG {
        [["Unit: %1 given waypoint: %2 %3 %4 %5 as number: %6", _unit, (_speedArray select _index), (_typeArray select _index), (_behaviourArray select _index), (_modeArray select _index), _number], DEBUG_INFO] call navy_debug_fnc_log;
    };
    _waypoint;
};

navy_module_paradrop = {
    FUN_ARGS_3(_logic,_units,_activated);

    DECLARE(_syncronisedObjects) = synchronizedObjects _logic;
    DECLARE(_waypoints) = waypoints _logic;
    if !(_activated) exitWith {
        DEBUG {
            [["Logic: %1 was not activated!", _logic], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };

    if (count _syncronisedObjects == 0) exitWith {
        DEBUG {
            [["Logic: %1 had no synchronised objects!", _logic], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };
    
    if (count _waypoints == 0) exitWith {
        DEBUG {
            [["Logic: %1 had no waypoints attached!", _logic], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };

    DECLARE(_vehicleClassname) = _logic getVariable "Vehicle_Classname";
    DECLARE(_unitTemplate) = _logic getVariable "Unit_Template";
    DEBUG {
        [["Module: %1 initialised with objects: %2 unit template: %3, waypoints: %4 classname: %5", _logic, _syncronisedObjects, _unitTemplate, _waypoints, _vehicleClassname], DEBUG_INFO] call navy_debug_fnc_log;
    };
    {
        [_x, _vehicleClassname, _unitTemplate, _waypoints] spawn navy_method_fnc_paradrop;
    } forEach _syncronisedObjects;
};
