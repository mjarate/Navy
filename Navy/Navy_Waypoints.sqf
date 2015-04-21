#include "Navy_Macros.h"

// https://community.bistudio.com/wiki/Category:Command_Group:_Waypoints

Navy_Waypoint_AddFullWaypoint =
{
	FUN_ARGS_9(_unit,_index,_position,_radius,_type,_behaviour,_speed,_mode,_statements);
	DECLARE(_waypoint) = (group _unit) addWaypoint [_position,_radius,_index];
	_waypoint setWaypointType _type;
	_waypoint setWaypointBehaviour _behaviour;
	_waypoint setWaypointSpeed _speed;
	_waypoint setWaypointCombatMode _mode;
	if (!isNil "_statements") then
	{
		_waypoint setWaypointStatements _statements;
	};
	DEBUG
	{
		[["Group: %1 given waypoint: %2",(group _unit),_waypoint]] call Navy_Debug_HintRPT;
		[str(_waypoint),_position,["WP: %1",_waypoint]] call Navy_Debug_WaypointMarker;
	};
	_waypoint;
};

Navy_Waypoint_AddPatrolWaypoints =
{
	FUN_ARGS_5(_unit,_position,_radius,_amount,_water_allowed);
	PVT_3(_i,_WP,_WP_position);
	if (isNil "_water_allowed") then
	{
		_water_allowed = false;
	};
	for "_i" from 1 to (_amount - 1) step 1 do 
	{
		_WP_position = [[_radius,_radius,0,false],_position,(typeOf _unit),_water_allowed] call adm_common_fnc_getRandomEmptyPositionInArea;
		_WP = [_unit,_i,_WP_position,0,"SAD","AWARE","FULL","RED",["",""]] call Navy_Waypoint_AddFullWaypoint;
	};
	_WP setWaypointStatements ["true","(group this) setCurrentWaypoint [group this,1]"];
	DEBUG
	{
		[["Group: %1 given waypoints: %2",(group _unit),(waypoints (group _unit))]] call Navy_Debug_HintRPT;
	};
};	