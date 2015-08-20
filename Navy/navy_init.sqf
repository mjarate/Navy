#include "navy_macros.h"

navy_init_module_paradrop = {
    FUN_ARGS_3(_module,_units,_activated);

    if !(_activated) exitWith {
        diag_log format ["NAVY temp debug: module not activated"];
    };
    waitUntil {
        sleep 2;
        diag_log format ["NAVY temp debug: module %1 waiting for navy init", _module];
        navy_isInitialised;
    };
    diag_log format ["NAVY temp debug: module %1 starting now", _module];
    [_module, _units, _activated] call navy_module_paradrop;
};
