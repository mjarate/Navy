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

navy_main_fnc_findLogic = {
    FUN_ARGS_1(_trigger);

    DECLARE(_closestLogic) = nil;
    {
        if ([(getposATL _x), (triggerArea _trigger), (getposATL _trigger)] call adm_api_fnc_isPositionInArea) exitWith {
            _closestLogic = _x;
        };
    } forEach allMissionObjects "Logic";
    /*
    DECLARE(_closestDistance) = 30;
    {
        if ((_x distance (getposATL _trigger)) < _closestDistance) then {
            _closestLogic = _x;
            _closestDistance = (_x distance _trigger);
        };
    } forEach allMissionObjects "Logic";
    */
    if (isNil "_closestLogic") exitWith {
        DEBUG {
            [["No logic found for trigger: %1", _trigger], DEBUG_INFO] call navy_debug_fnc_log;
        };
    };
    _closestLogic;
};

navy_main_fnc_addWaypoint = {
    FUN_ARGS_4(_unit,_waypoints,_routine,_number);

    [["Waypoints passed: %1", _waypoints], DEBUG_INFO] call navy_debug_fnc_log;
    DECLARE(_waypointPositions) = [];
    {
        _waypointPositions pushBack (getWPPos _x);
        [["Waypoint: %1 Position: %2", _x, (getWPPos _x)], DEBUG_INFO] call navy_debug_fnc_log;
    } forEach _waypoints;
    DECLARE(_speedArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_speed"] call navy_config_fnc_getArray;
    DECLARE(_typeArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_type"] call navy_config_fnc_getArray;
    DECLARE(_behaviourArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_behaviour"] call navy_config_fnc_getArray;
    DECLARE(_modeArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_combatmode"] call navy_config_fnc_getArray;
    DECLARE(_statementArray) = [NAVY_CONFIG_ROUTINES, _routine, "waypoint_statements"] call navy_config_fnc_getArray;
    //[["Speed: %1 Type: %2 Beh: %3 Mode: %4 State: %5", _speedArray, _typeArray, _behaviourArray, _modeArray, _statementArray], DEBUG_INFO] call navy_debug_fnc_log;
    DECLARE(_waypoint) = (group _unit) addWaypoint [(group _unit), _number];
    _waypoint setWPPos (_waypointPositions select _number);
    _waypoint setWaypointSpeed (_speedArray select _number);
    _waypoint setWaypointType (_typeArray select _number);
    _waypoint setWaypointBehaviour (_behaviourArray select _number);
    _waypoint setWaypointCombatMode (_modeArray select _number);
    _waypoint setWaypointStatements (_statementArray select _number);

    DEBUG {
        [["Unit: %1 given waypoint: %2 %3 %4 %5 as number: %6 at position: %7", _unit, (_speedArray select _number), (_typeArray select _number), (_behaviourArray select _number), (_modeArray select _number), _number, (_waypointPositions select _number)], DEBUG_INFO] call navy_debug_fnc_log;
    };

    _waypoint;
};

navy_module_paradrop = {
    FUN_ARGS_3(_module,_units,_activated);

    if !(_activated) exitWith {
        DEBUG {
            [["Module: %1 was not activated!", _module], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };
    DECLARE(_syncronisedObjects) = synchronizedObjects _module;
    if (count _syncronisedObjects == 0) exitWith {
        DEBUG {
            [["Logic: %1 had no synchronised objects!", _module], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };
    if (count _syncronisedObjects > 1) exitWith {
        DEBUG {
            [["More than one trigger was synchronised to the module: %1, only one can be synched!", _module], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };
    DECLARE(_trigger) = _syncronisedObjects select 0;
    DECLARE(_navyLogic) = [_trigger] call navy_main_fnc_findLogic;
    if (isNil "_navyLogic") exitWith {
        DEBUG {
            [["No logic found for module: %1 with trigger: %2", _module, _trigger], DEBUG_INFO] call navy_debug_fnc_log;
        };
    };
    DECLARE(_waypoints) = waypoints _navyLogic;
    if (count _waypoints == 0) exitWith {
        DEBUG {
            [["Logic: %1 had no waypoints attached!", _navyLogic], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };
    DECLARE(_vehicleClassname) = _module getVariable "Vehicle_Classname";
    DECLARE(_unitTemplate) = _module getVariable "Unit_Template";
    DEBUG {
        [["Module: %1 initialised with synchronised objects: %2 unit template: %3, classname: %4 taking waypoints: %5 from logic: %6", _module, _syncronisedObjects, _unitTemplate, _vehicleClassname, _waypoints, _navyLogic], DEBUG_INFO] call navy_debug_fnc_log;
    };
    [_trigger, _vehicleClassname, _unitTemplate, _waypoints] spawn navy_method_fnc_paradrop;
};
