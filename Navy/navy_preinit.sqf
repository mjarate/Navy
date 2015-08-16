#include "navy_macros.h"

navy_isInitialised = false;

call compile preprocessFileLineNumbers ADDON_PATH(navy_debug.sqf);
call compile preProcessFileLineNumbers ADDON_PATH(navy_config.sqf);

navy_isEnabled = [NAVY_MISSION_CONFIG_FILE, "Settings", "isEnabled"] call navy_config_fnc_getBool;
navy_debugEnabled = if (!isMultiplayer) then {true;} else {false;};
navy_logToServer = true;

if (navy_isEnabled) then {
    [["Navy is enabled. Initialising Navy now."], DEBUG_INFO] call navy_debug_fnc_logToServer;
    call compile preprocessFileLineNumbers ADDON_PATH(navy_spawn.sqf);
    navy_isInitialised = true;
} else {
    [["Navy is disabled in the mission config file."], DEBUG_INFO] call navy_debug_fnc_logToServer;
};