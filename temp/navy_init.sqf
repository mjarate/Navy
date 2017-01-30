#include "navy_macros.h"

navy_init_fnc_initFromModule = {
    FUN_ARGS_3(_module,_units,_activated);

    if !(_activated) exitWith {
        DEBUG {
            [["Module: %1 was not activated!", _module], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };
    waitUntil {
        sleep 2;
        navy_isInitialised;
    };
    [_module, _units] call navy_main_fnc_initFromModule;

    true;
};

