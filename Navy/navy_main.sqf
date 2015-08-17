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
        [["Module: %1 initialised with objects: %2 units: %3, waypoints: %4 and classname: %5", _logic, _syncronisedObjects, _units, _waypoints, _vehicleClassname], DEBUG_INFO] call navy_debug_fnc_log;
    };
    {
        [_x, _vehicleClassname, _unitTemplate, _waypoints] call navy_method_fnc_paradrop;
    } forEach _syncronisedObjects;
};
