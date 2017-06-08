#include "..\navy_macros.h"

navy_method_fnc_barrelbomb = {
    FUN_ARGS_6(_module,_trigger,_vehicleClassname,_unitTemplate,_cargoAmount,_waypoints);
    DECLARE(_bombingDistance) = [NAVY_CONFIG_FILE, "Settings", "bombingDistance"] call navy_config_fnc_getNumber;
    DECLARE(_cleanupDistance) = [NAVY_CONFIG_FILE, "Settings", "cleanupDistance"] call navy_config_fnc_getNumber;
    DECLARE(_reqWaypointCount) = [NAVY_CONFIG_ROUTINES, "Barrel_bomb", "waypoint_count"] call navy_config_fnc_getNumber;
    INC(_reqWaypointCount);  // taking into account waypoint 0 on the logic's position
    if !(count _waypoints == _reqWaypointCount) exitWith {
        [["Waypoint count given: %1 not equal to amount required: %2", count _waypoints, _reqWaypointCount], DEBUG_INFO] call navy_debug_fnc_log;
    };

    PVT_3(_side,_vehicle,_pilot);
    _side = [_unitTemplate] call adm_common_fnc_getUnitTemplateSide;
    _vehicle = [_vehicleClassname, _trigger] call navy_spawn_fnc_airVehicle;
    DECLARE(_pilotClassname) = [_unitTemplate, "pilots"] call adm_common_fnc_getUnitTemplateArray;
    _pilot = [_pilotClassname, _side, _vehicle] call navy_spawn_fnc_pilot;
    [_vehicle, NAVY_OPEN_DOOR] call navy_main_fnc_animateDoors;
    DECLARE(_routineFlightHeight) = [NAVY_CONFIG_ROUTINES, "Barrel_bomb", "flight_height"] call navy_config_fnc_getNumber;
    _vehicle flyInHeight _routineFlightHeight;

    DEBUG {
        [["Spawning helicopter: %1 on side: %2 with pilot: %3 in trigger: %4 for routine: Barrel_bomb", _vehicleClassname, _side, _pilot, _trigger], DEBUG_INFO] call navy_debug_fnc_log;
    };
	DECLARE(_startWP) = [_pilot, _waypoints, "Barrel_bomb", 1] call navy_main_fnc_addWaypoint;
    DECLARE(_bombdropWP) = [_pilot, _waypoints, "Barrel_bomb", 2] call navy_main_fnc_addWaypoint;
    DECLARE(_deleteWP) = [_pilot, _waypoints, "Barrel_bomb", 3] call navy_main_fnc_addWaypoint;
	DECLARE(_pilotGP) = group _pilot;
	waitUntil {
	sleep 2;
	DEBUG {
            [["Vehicle: %1 Distance from attack run start point: %2 Limit: %3", _vehicle, (_vehicle distance (getWPPos _startWP)), 300], DEBUG_INFO] call navy_debug_fnc_log;
        };
	(_vehicle distance (getWPPos _startWP)) < 300;
	};
	_pilotGP setCurrentWaypoint [_pilotGP,2];
    waitUntil {
        sleep 2;
        DEBUG {
            [["Vehicle: %1 Distance from barrelbomb point: %2 Limit: %3", _vehicle, (_vehicle distance (getWPPos _bombdropWP)), _bombingDistance], DEBUG_INFO] call navy_debug_fnc_log;
        };
        (_vehicle distance (getWPPos _bombdropWP)) < _bombingDistance;
    };

    DEBUG {
        [["Vehicle: %1 is initiating bomb drops", _vehicle], DEBUG_INFO] call navy_debug_fnc_log;
    };

	ark_fnc_barrelBombMidAirIntercept = {
    private _barrelInArray = _this select 0;
	private _barrelObject = _barrelInArray select 0;
	
private _bomb1 = createVehicle ["HelicopterExploBig", [getPosATL _barrelObject select 0, getPosATL _barrelObject select 1,(getPosATL _barrelObject select 2)],[], 0, "CAN_COLLIDE"]; 
		deleteVehicle _barrelObject;
};	

ark_fnc_barrelBombImpact = {
		private _bomb2a = createVehicle ["Bo_GBU12_LGB", getPosATL (_this select 0),[], 0, "CAN_COLLIDE"];
		private _bomb2b = createVehicle ["HelicopterExploBig", getPosATL (_this select 0),[], 0, "CAN_COLLIDE"];
		deleteVehicle (_this select 0);
};


for "_i" from 1 to _cargoAmount step 1 do {
    if (alive _vehicle) then {
      //spawn barrel
		
    private _barrel = createVehicle ["Land_WaterBarrel_F", [getPosATL _vehicle select 0, getPosATL _vehicle select 1,(getPosATL _vehicle select 2)-5],[], 0, "FLY"];  

		_barrel setVectorDirAndUp[[getPosATL _vehicle select 0, getPosATL _vehicle select 1,(getPosATL _vehicle select 2)-5],[0,90,0]];
  
		_barrel addEventHandler ["HitPart", ark_fnc_barrelBombMidAirIntercept]; 
  
		_barrel addEventHandler ["EpeContactStart", ark_fnc_barrelBombImpact]; 
		sleep 3;
		};
};

    [_vehicle, NAVY_CLOSE_DOOR] call navy_main_fnc_animateDoors;
	_pilotGP setCurrentWaypoint [_pilotGP,3];
    waitUntil {
        sleep 5;
        DEBUG {
            [["Vehicle: %1 Distance from cleanup point: %2 Limit: %3", _vehicle, (_vehicle distance (getWPPos _deleteWP)), _cleanupDistance], DEBUG_INFO] call navy_debug_fnc_log;
        };
        (_vehicle distance (getWPPos _deleteWP)) < _cleanupDistance;
    };
    [_vehicle, _reqWaypointCount] call navy_main_fnc_cleanupVehicle;
};