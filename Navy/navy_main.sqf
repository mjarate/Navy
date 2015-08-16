#include "navy_macros.h"

navy_module_paradrop = {
    FUN_ARGS_3(_logic,_units,_activated);

    DECLARE(_syncronisedObjects) = synchronizedObjects _logic;
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

    DECLARE(_vehicleClassname) = _logic getVariable "Vehicle_Classname";
    {
        _x spawn {
            waitUntil {
                sleep 2;
                adm_isInitialized;
            };
            hint "Admiral has finished initialising!";
            [_this] call navy_debug_unitTests;
        };
    } forEach _syncronisedObjects;
};