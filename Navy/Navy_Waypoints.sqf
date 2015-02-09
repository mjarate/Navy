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
		//_waypoint setWaypointStatements _statements;
	};
	DEBUG
	{
		[["Group: %1 given waypoint: %2",(group _unit),_waypoint]] call Navy_Debug_HintRPT;
		[_position,["WP: %1",_waypoint]] call Navy_Debug_DebugMarker;
	};
	_waypoint;
};

Navy_Waypoint_AddPatrolWaypoints =
{
	FUN_ARGS_4(_unit,_position,_radius,_amount);
	PVT_4(_i,_WP,_random_x,_random_y);
	for "_i" from 1 to (_amount - 1) step 1 do 
	{
		_random_x = (_position select 0) + random _radius;
		_random_y = (_position select 1) + random _radius;
		_WP = [_unit,_i,[_random_x,_random_y],0,"MOVE","COMBAT",SELECT_RAND(NAVY_PATROL_SPEEDS),"RED"] call Navy_Waypoint_AddFullWaypoint;
	};
	_WP setWaypointStatements ["true","(group this) setCurrentWaypoint [group this,0]"];
	DEBUG
	{
		[["Group: %1 given waypoints: %2",(group _unit),(waypoints (group _unit))]] call Navy_Debug_HintRPT;
	};
};	