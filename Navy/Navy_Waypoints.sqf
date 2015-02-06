#include "Navy_Macros.h"

// https://community.bistudio.com/wiki/Category:Command_Group:_Waypoints

Navy_Waypoint_AddFullWaypoint =
{
	FUN_ARGS_8(_unit,_position,_radius,_type,_behaviour,_speed,_mode,_statements);
	//DECLARE(_group) = group _unit;
	DECLARE(_waypoint) = (group _unit) addWaypoint [_position,_radius];
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
	};
	_waypoint;
};

Navy_Waypoint_AddPatrolWaypoints =
{
	FUN_ARGS_4(_unit,_position,_radius,_amount);
	PVT_2(_i,_WP);
	for "_i" from 1 to (_amount - 1) step 1 do 
	{
		_WP = [_unit,_position,_radius,"MOVE","COMBAT",SELECT_RAND(NAVY_PATROL_SPEEDS),"RED"] call Navy_Waypoint_AddFullWaypoint;
		DEBUG
		{
			[_position] call Navy_Debug_DebugMarker;
		};
	};
	_WP setWaypointStatements ["true","(group this) setCurrentWaypoint [group this,0]"];
	DEBUG
	{
		[["Group: %1 given waypoints: %2",(group _unit),(waypoints (group _unit))]] call Navy_Debug_HintRPT;
	};
};	