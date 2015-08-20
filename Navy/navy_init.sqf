#include "navy_macros.h"

navy_init_module_paradrop = {
    FUN_ARGS_3(_module,_units,_activated);

    if !(_activated) exitWith {
        diag_log format ["NAVY temp debug: module not activated"];
    };
    waitUntil {
        sleep 2;
        navy_isInitialised;
    };
    [_module, _units] call navy_module_paradrop;
};
