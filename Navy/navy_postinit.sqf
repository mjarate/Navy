#include "navy_macros.h"

if (navy_isEnabled) then {
    [["Navy is enabled, waiting for Admiral to complete initialisation"], DEBUG_INFO] call navy_debug_fnc_logToServer;
    waitUntil {
        sleep 2;
        (!isNil "adm_isInitialized") && adm_isInitialized;
    };
    [["Initialising Navy version %1 now", NAVY_VERSION_STR], DEBUG_INFO] call navy_debug_fnc_logToServer;
    call compile preprocessFileLineNumbers ADDON_PATH(navy_spawn.sqf);
    call compile preprocessFileLineNumbers ADDON_PATH(navy_main.sqf);
    call compile preprocessFileLineNumbers ADDON_PATH(routines\navy_paradrop.sqf);
    call compile preprocessFileLineNumbers ADDON_PATH(routines\navy_heliinsert.sqf);
    navy_isInitialised = true;
    [["Navy version %1 has successfully initialised", NAVY_VERSION_STR], DEBUG_INFO] call navy_debug_fnc_logToServer;
};

