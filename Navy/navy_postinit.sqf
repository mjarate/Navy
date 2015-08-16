#include "navy_macros.h"

DEBUG {
    [] spawn {
        waitUntil {
            sleep 2;
            adm_isInitialized;
        };
        hint "Admiral has finished initialising!";
        [navy_debug_trigger] call navy_debug_unitTests;
    };
};