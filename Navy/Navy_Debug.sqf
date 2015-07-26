#include "ark_macros.h"

// navy_debug
// Contains debug functions

navy_debug_fnc_logToServer = {
    FUN_ARGS_2(_message,_level);
    
    IF_IS_SERVER;
    if (!navy_debugEnabled || !navy_logToServer) exitWith {};
    [_message, _level] call navy_debug_fnc_rptlog;
};

navy_debug_fnc_log = {
    FUN_ARGS_2(_message,_level);

    hint format [NAVY_SCRIPTS_DEBUG_FORMAT, time, _level, format _message];
    diag_log format [NAVY_SCRIPTS_DEBUG_FORMAT, time, _level, format _message];
};

navy_debug_fnc_rptlog = {
    FUN_ARGS_2(_message,_level);

    diag_log format [NAVY_SCRIPTS_DEBUG_FORMAT, time, _level, format _message];
};