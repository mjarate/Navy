#include "Navy_Macros.h"

Navy_Debug_Init =
{
	Navy_Debug_Markers = [];
	[["Navy Debug successfully initialised."]] call Navy_Debug_SideChatRPT;
};

Navy_Debug_HintRPT =
{
	FUN_ARGS_1(_message);
	[_message] call Navy_Debug_RPT;
	[_message,false] call Navy_Debug_Hint;
};

Navy_Debug_SideChatRPT =
{
	FUN_ARGS_1(_message);
	[_message] call Navy_Debug_RPT;
	[_message] call Navy_Debug_SideChat;
};

Navy_Debug_RPT =
{
	FUN_ARGS_1(_message);
	if (DEBUG_RPT) then
	{
		diag_log format ["%1%2",DEBUG_HEADER,format _message];
	};
};

Navy_Debug_Hint =
{
	FUN_ARGS_2(_message,_silent);
	// _silent parameter: decided whether hint or hintSilent is used. Default is true
	if (DEBUG_HINTS) then
	{
		if (isNil "_silent") then
		{
			_silent = true;
		};
		if (_silent) then
		{
			hintSilent format ["%1%2",DEBUG_HEADER,format _message];
		}
		else
		{
			hint format ["%1%2",DEBUG_HEADER,format _message];
		};
	};
};

Navy_Debug_SideChat =
{
	FUN_ARGS_1(_message);
	if (DEBUG_SIDECHAT) then
	{
		player sideChat format ["%1%2",DEBUG_HEADER,format _message];
	};
};

Navy_Debug_DebugMarker =
{
	FUN_ARGS_2(_position,_text);
	DECLARE(_marker) = [format ["DEBUG_MARKER_%1",random 10000],_position,"ICON","hd_dot","ColorRed",[1,1]] call adm_common_fnc_createLocalMarker;
	_marker setMarkerTextLocal format _text;
};

Navy_Debug_InitMarker =
{
	FUN_ARGS_2(_unit,_vehicle);
	PVT_5(_vehicle_str,_marker_name,_marker_counter,_marker_colour,_marker_size);
	if (_vehicle) then
	{
		_vehicle_str = "Vehi";
		_marker_colour = DEBUG_MARKER_COLOUR_VEHICLE;
		_marker_size = DEBUG_MARKER_SIZE_VEHICLE;
		_marker_counter = Navy_Vehicle_Counter;
		
	}
	else
	{
		_vehicle_str = "Unit";
		_marker_colour = DEBUG_MARKER_COLOUR_UNIT;
		_marker_size = DEBUG_MARKER_SIZE_UNIT;
		_marker_counter = Navy_Unit_Counter;
	};
	_marker_name = format ["Navy_%1_%2",_vehicle_str,_marker_counter];
	[_marker_name,getposATL _unit,"ICON","mil_triangle_noShadow",_marker_colour,_marker_size] call adm_common_fnc_createLocalMarker;
	Navy_Debug_Markers pushBack _marker_name;
	_marker_name;
};

Navy_Debug_DeleteMarker =
{
	FUN_ARGS_1(_marker_name);
	REMOVE_ELEMENT(Navy_Debug_Markers,_marker_name);
	deleteMarkerLocal _marker_name;
};

Navy_Debug_TrackWithMarker =
{
	FUN_ARGS_3(_object,_vehicle,_delay);
	PVT_1(_pos_and_dir);
	if (isNil "_delay") then
	{
		_delay = DEBUG_MARKER_DEFAULT_DELAY;
	};
	if (_vehicle) then
	{
		_delay = DEBUG_MARKER_VEHI_DELAY;
	}
	else
	{
		_delay = DEBUG_MARKER_UNIT_DELAY;
		WAIT_DELAY(1,(_object == (vehicle _object)) || !alive _object);
	};
	DECLARE(_marker_name) = [_object,_vehicle] call Navy_Debug_InitMarker;
	_marker_name setMarkerTextLocal _marker_name;
	while {alive _object} do
	{
		_pos_and_dir = [_object] call Navy_General_ReturnPosAndDir;
		_marker_name setMarkerPosLocal (_pos_and_dir select 0);
		_marker_name setMarkerDirLocal (_pos_and_dir select 1);
		sleep _delay;
	};
	[_marker_name] call Navy_Debug_DeleteMarker;
};

Navy_Debug_TrackVehicle =
{
	FUN_ARGS_1(_vehicle);
	[_vehicle,true] call Navy_Debug_TrackWithMarker;
};

Navy_Debug_TrackUnit =
{
	FUN_ARGS_1(_unit);
	[_unit,false] call Navy_Debug_TrackWithMarker;
};

Navy_Debug_HintCurrentNavyUnits =
{
	while {true} do
	{
		hintSilent format ["TIME: %1\nNavy Units:\n%2\nNavy Vehicles:\n%3\nNavy Cargo Groups:\n%4",time,Navy_Units,Navy_Vehicles,Navy_GroundUnit_Groups];
		sleep 0.2;
	};
};

Navy_Debug_TrackCurrentWaypoints = 
{
	FUN_ARGS_1(_unit);
	PVT_2(_waypoint_list,_current_waypoint);
	while {true} do
	{
		_waypoint_list = waypoints (group _unit);
		_current_waypoint = currentWaypoint (group _unit);
		hintSilent format ["TIME: %1\nUnit: %2\nGroup: %3\nCurrent Waypoint: %4\nWaypoint list;\n%5",time,_unit,(group _unit),_current_waypoint,_waypoint_list];
		sleep 0.2;
	};
};