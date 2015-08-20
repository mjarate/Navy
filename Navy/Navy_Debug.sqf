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

navy_debug_trackUnit = {
    FUN_ARGS_1(_unit);

    DECLARE(_type) = if (_unit isKindOf "Man") then {DEBUG_MARKER_UNIT;} else {DEBUG_MARKER_VEHICLE;};
    _trackingMarker = [str(_unit), (getposATL _unit), _type] call navy_debug_placeMarker;
    while (alive _unit) do {
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
