#include "navy_macros.h"

navy_debug_fnc_logToServer = {
    FUN_ARGS_2(_message,_level);

    IF_IS_SERVER;
    if (!navy_debugEnabled || !navy_logToServer) exitWith {};
    [_message, _level] call navy_debug_fnc_rpt;
};

navy_debug_fnc_log = {
    FUN_ARGS_2(_message,_level);

    hint format [NAVY_DEBUG_FORMAT, time, _level, format _message];
    diag_log format [NAVY_DEBUG_FORMAT, time, _level, format _message];
};

navy_debug_fnc_rpt = {
    FUN_ARGS_2(_message,_level);

    diag_log format [NAVY_DEBUG_FORMAT, time, _level, format _message];
};

navy_debug_unitTest = {
    FUN_ARGS_1(_trigger);

    IF_IS_SERVER;
    [["Starting Unit tests"], DEBUG_INFO] call navy_debug_fnc_log;
    [["Spawning a helicopter at the debug trigger: %1 with area: %2", _trigger, triggerArea _trigger], DEBUG_INFO] call navy_debug_fnc_log;
    DECLARE(_testVehicle) = ["B_Heli_Transport_03_black_F", _trigger] call navy_spawn_fnc_airVehicle;
    ["B_Helipilot_F", WEST, _testVehicle] call navy_spawn_fnc_pilot;
};