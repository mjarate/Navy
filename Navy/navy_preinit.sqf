#include "navy_macros.h"

navy_isInitialised = false;
navy_logToServer = true;
navy_debugEnabled = if (!isMultiplayer) then {true;} else {false;};

call compile preprocessFileLineNumbers ADDON_PATH(navy_init.sqf);
call compile preprocessFileLineNumbers ADDON_PATH(navy_debug.sqf);
call compile preProcessFileLineNumbers ADDON_PATH(navy_config.sqf);

DECLARE(_admiralEnabled) = [missionConfigFile, "Admiral", "isEnabled"] call navy_config_fnc_getBool;

if !(_admiralEnabled) exitWith {
    [["Admiral is disabled in the mission config file, Navy cannot operate without admiral enabled"], DEBUG_WARN] call navy_debug_fnc_logToServer;
} else {
    [["Navy confirms Admiral is enabled. Navy preinit complete"], DEBUG_INFO] call navy_debug_fnc_logToServer;
};

navy_isEnabled = [NAVY_MISSION_CONFIG_FILE, "Settings", "isEnabled"] call navy_config_fnc_getBool;
if !(navy_isEnabled) then {
    [["Navy is disabled in the mission config file"], DEBUG_WARN] call navy_debug_fnc_logToServer;
};
