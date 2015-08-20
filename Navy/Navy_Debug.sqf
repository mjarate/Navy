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

navy_debug_trackUnit = {
    FUN_ARGS_1(_unit);

    DECLARE(_type) = if (_unit isKindOf "Man") then {DEBUG_MARKER_UNIT;} else {DEBUG_MARKER_VEHICLE;};
    _trackingMarker = [str(_unit), (getposATL _unit), _type] call navy_debug_placeMarker;
    _trackingMarker setMarkerTextLocal str(_unit);
    while {alive _unit} do {
        _trackingMarker setMarkerPosLocal getposATL _unit;
        _trackingMarker setMarkerDirLocal getDir _unit;
        sleep 0.5;
    };
};

navy_debug_placeMarker = {
    FUN_ARGS_3(_name,_position,_typeIndex);

    DECLARE(_arguments) = DEBUG_MARKER_ARGS_ARRAY select _typeIndex;
    _arguments call adm_common_fnc_createLocalMarker;
};
