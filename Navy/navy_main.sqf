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

navy_main_fnc_checkLogic = {
    FUN_ARGS_1(_trigger);

    DECLARE(_logic) = nil;
    DECLARE(_syncronisedObjects) = synchronizedObjects _trigger;
    DECLARE(_syncronisedLogics) = [];
    {
        // [str(_x), (getposATL _x), DEBUG_MARKER_LOCATION] call navy_debug_placeMarker;
        if (typeOf _x isEqualTo "Logic") then {
            _syncronisedLogics pushBack _x;
        };
    } forEach _syncronisedObjects;
    // [["Trigger: %1 Logics: %2", _trigger, _syncronisedLogics], DEBUG_INFO] call navy_debug_fnc_log;
    if (count _syncronisedLogics > 1) then {
        [["More than one path logic was found for: %1! Only one can be used per trigger and module!", _trigger], DEBUG_INFO] call navy_debug_fnc_log;
    } else {
        _logic = _syncronisedLogics select 0;
    };
    if (isNil "_logic") exitWith {
        DEBUG {
            [["No logic found for trigger: %1", _trigger], DEBUG_INFO] call navy_debug_fnc_log;
        };
    };

    _logic;
};

navy_main_fnc_animateDoors = {
    FUN_ARGS_2(_vehicle,_openOrClose);
    _doorArray = [NAVY_CONFIG_VEHICLES, (typeOf _vehicle), "animations"] call navy_config_fnc_getArray;
    DEBUG {
        [["Vehicle: %1 is opening: %2 this door array: %3", _vehicle, (_openOrClose == 1),_doorArray], DEBUG_INFO] call navy_debug_fnc_log;
    };
    if (count _doorArray > 0) then {
        {
            _vehicle animateDoor [_x, _openOrClose, false];
        } forEach _doorArray;
    };
};

navy_main_fnc_cleanupVehicle = {
    FUN_ARGS_2(_vehicle,_waypointCount);

    DEC(_waypointCount);  // count is increased in method
    DEBUG {
        [["Vehicle: %1 is being deleted with: %2 waypoint markers", _vehicle, _waypointCount], DEBUG_INFO] call navy_debug_fnc_log;
        // remove waypoint debug markers, format ["%1_%2", (vehicle _unit), _number]
        for "_i" from 1 to _waypointCount do {
            deleteMarkerLocal format ["%1_%2", _vehicle, _i];
        };
    };
    {
        deleteVehicle _x;
    } forEach crew _vehicle;
    deleteVehicle _vehicle;
};

navy_main_assignPatrolWaypoints = {
    FUN_ARGS_3(_group,_position,_wpAmount);

    DECLARE(_trigger) = createTrigger ["EmptyDetector", _position, false];
    DECLARE(_radius) = [NAVY_CONFIG_FILE, "Settings", "patrolRadius"] call navy_config_fnc_getNumber;
    _trigger setTriggerArea [_radius, _radius, 0, false];
    [_group, "SoldierWB", (triggerArea _trigger), _position, ["COMBAT", "AWARE"], _wpAmount] call adm_camp_fnc_createPatrolWaypoints;
};

navy_main_fnc_addWaypoint = {
    FUN_ARGS_4(_unit,_waypoints,_routine,_number);

    //[["Waypoints passed: %1", _waypoints], DEBUG_INFO] call navy_debug_fnc_log;
    DECLARE(_waypointPositions) = [];
    {
        _waypointPositions pushBack (getWPPos _x);
        //[["Waypoint: %1 Position: %2", _x, (getWPPos _x)], DEBUG_INFO] call navy_debug_fnc_log;
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
        DECLARE(_waypointMarker) = [
            format ["%1_%2", (vehicle _unit), _number],
            getWPPos _waypoint,
            DEBUG_MARKER_WAYPOINT
        ] call navy_debug_placeMarker;
        _waypointMarker setMarkerTextLocal format ["Waypoint %1 for %2", _number, _unit];
    };

    _waypoint;
};

navy_module_paradrop = {
    FUN_ARGS_2(_module,_units);

    DECLARE(_syncronisedObjects) = synchronizedObjects _module;
    if (count _syncronisedObjects == 0) exitWith {
        DEBUG {
            [["Logic: %1 had no synchronised objects!", _module], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };
    if (count _syncronisedObjects > 1) exitWith {
        DEBUG {
            [["More than one trigger was synchronised to the module: %1, only one can be synced!", _module], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };
    DECLARE(_trigger) = _syncronisedObjects select 0;
    DECLARE(_navyLogic) = [_trigger] call navy_main_fnc_checkLogic;
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
    DECLARE(_cargoAmount) = _module getVariable "Cargo_Amount";

    DEBUG {
        [["Module: %1 initialised with synchronised objects: %2 unit template: %3, classname: %4 taking waypoints: %5 from logic: %6 with cargo amount: %7", _module, _syncronisedObjects, _unitTemplate, _vehicleClassname, _waypoints, _navyLogic, _cargoAmount], DEBUG_INFO] call navy_debug_fnc_log;
    };

    [_trigger, _vehicleClassname, _unitTemplate, _cargoAmount, _waypoints] spawn navy_method_fnc_paradrop;

    true;
};
